`timescale 1ns/100ps
module pixel_proc(
    // APB — PCLK domain (control/status/results)
    input               pclk,
    input               presetn,
    input               psel,
    input               penable,
    input               pwrite,
    input       [7:0]   paddr,
    input       [31:0]  pwdata,
    output  reg [31:0]  prdata,
    output  reg         irq,
    // AXI4 master — ACLK domain (read DDR)
    input               aclk,
    input               aresetn,
    // Read address
    output  reg [31:0]  m_axi_araddr,
    output  reg         m_axi_arvalid,
    input               m_axi_arready,
    // Read data (64-bit)
    input       [63:0]  m_axi_rdata,
    input               m_axi_rvalid,
    output  reg         m_axi_rready,
    input       [1:0]   m_axi_rresp,
    // Write channel (unused, tied off)
    output      [31:0]  m_axi_awaddr,
    output              m_axi_awvalid,
    input               m_axi_awready,
    output      [63:0]  m_axi_wdata,
    output      [7:0]   m_axi_wstrb,
    output              m_axi_wvalid,
    input               m_axi_wready,
    input       [1:0]   m_axi_bresp,
    input               m_axi_bvalid,
    output              m_axi_bready
);

    localparam [7:0] A_CONTROL     = 8'h80;
    localparam [7:0] A_STATUS      = 8'h84;
    localparam [7:0] A_SRC_ADDR_LO = 8'h88;
    localparam [7:0] A_SRC_ADDR_HI = 8'h8C;
    localparam [7:0] A_PIXEL_COUNT = 8'h90;
    localparam [7:0] A_RESULT      = 8'h94;
    localparam [7:0] A_DEBUG       = 8'h98;

    localparam [9:0] THR_X2     = 10'd90;
    localparam [3:0] PAIRS_PXL  = 4'd12;
    localparam [4:0] MATCH_THR  = 5'd2;

    localparam [2:0] S_IDLE = 0, S_AR = 1, S_RD = 2, S_ACK = 3, S_DONE = 4;

    // ======== PCLK domain ========
    reg [31:0] ctrl, src_lo, src_hi, pxl_cnt, result;
    reg        start_stb_pclk, ack_sync1, ack_sync2, ack_stb;

    wire rd_en = (!pwrite && psel);
    wire wr_en = (penable && pwrite && psel);

    always @(posedge pclk or negedge presetn) begin
        if (~presetn) begin
            ctrl <= 0; src_lo <= 0; src_hi <= 0; pxl_cnt <= 0; result <= 0; prdata <= 0;
            irq <= 0; start_stb_pclk <= 0; ack_sync1 <= 0; ack_sync2 <= 0; ack_stb <= 0;
        end else begin
            if (wr_en) case (paddr)
                A_CONTROL:     ctrl    <= pwdata;
                A_SRC_ADDR_LO: src_lo  <= pwdata;
                A_SRC_ADDR_HI: src_hi  <= pwdata;
                A_PIXEL_COUNT: pxl_cnt <= pwdata;
                default: ;
            endcase

            start_stb_pclk <= ctrl[0];

            ack_sync1 <= ack_stb_aclk;
            ack_sync2 <= ack_sync1;
            ack_stb   <= ack_sync1 && !ack_sync2;
            if (ack_stb) irq <= 0;

            if (rd_en) case (paddr)
                A_CONTROL:     prdata <= ctrl;
                A_STATUS:      prdata <= {29'b0, (state == S_DONE), irq,
                                          (state != S_IDLE && state != S_DONE)};
                A_SRC_ADDR_LO: prdata <= src_lo;
                A_SRC_ADDR_HI: prdata <= src_hi;
                A_PIXEL_COUNT: prdata <= pxl_cnt;
                A_RESULT:      prdata <= result;
                A_DEBUG:       prdata <= 32'hDEADBEEF;
                default:       prdata <= 0;
            endcase
        end
    end

    // ======== ACLK domain ========
    reg [2:0]  state;
    reg [63:0] src_addr;
    reg [31:0] total;
    reg [3:0]  beat;
    reg [31:0] pxl_done;
    reg [7:0]  cr, cg, cb;
    reg [4:0]  mc;
    reg [31:0] rbuf;
    reg [5:0]  rcnt;
    reg        irq_aclk, ack_stb_aclk;
    reg        start_s1, start_s2, start_pulse;

    wire [7:0] ha_r = m_axi_rdata[7:0];
    wire [7:0] ha_g = m_axi_rdata[15:8];
    wire [7:0] ha_b = m_axi_rdata[23:16];
    wire [7:0] da_r = (cr > ha_r) ? (cr - ha_r) : (ha_r - cr);
    wire [7:0] da_g = (cg > ha_g) ? (cg - ha_g) : (ha_g - cg);
    wire [7:0] da_b = (cb > ha_b) ? (cb - ha_b) : (ha_b - cb);
    wire       ma   = ({({1'b0,da_r}+{1'b0,da_g}+{1'b0,da_b}), 1'b0} <= THR_X2);

    wire [7:0] hb_r = m_axi_rdata[39:32];
    wire [7:0] hb_g = m_axi_rdata[47:40];
    wire [7:0] hb_b = m_axi_rdata[55:48];
    wire [7:0] db_r = (cr > hb_r) ? (cr - hb_r) : (hb_r - cr);
    wire [7:0] db_g = (cg > hb_g) ? (cg - hb_g) : (hb_g - cg);
    wire [7:0] db_b = (cb > hb_b) ? (cb - hb_b) : (hb_b - cb);
    wire       mb   = ({({1'b0,db_r}+{1'b0,db_g}+{1'b0,db_b}), 1'b0} <= THR_X2);

    always @(posedge aclk or negedge aresetn) begin
        if (~aresetn) begin
            state <= S_IDLE; src_addr <= 0; total <= 0;
            m_axi_araddr <= 0; m_axi_arvalid <= 0; m_axi_rready <= 0;
            beat <= 0; pxl_done <= 0; cr <= 0; cg <= 0; cb <= 0; mc <= 0;
            rbuf <= 0; rcnt <= 0; irq_aclk <= 0; ack_stb_aclk <= 0;
            start_s1 <= 0; start_s2 <= 0; start_pulse <= 0;
        end else begin
            start_s1 <= start_stb_pclk;
            start_s2 <= start_s1;
            start_pulse <= start_s1 && !start_s2;
            ack_stb_aclk <= 0;

            case (state)
                S_IDLE: begin
                    m_axi_arvalid <= 0; m_axi_rready <= 0; irq_aclk <= 0;
                    if (start_pulse) begin
                        src_addr <= {src_hi, src_lo}; total <= pxl_cnt;
                        beat <= 0; pxl_done <= 0; mc <= 0; rbuf <= 0; rcnt <= 0;
                        state <= S_AR;
                    end
                end
                S_AR: begin
                    m_axi_araddr <= src_addr[31:0]; m_axi_arvalid <= 1;
                    if (m_axi_arready) begin
                        m_axi_arvalid <= 0; m_axi_rready <= 1; state <= S_RD;
                    end
                end
                S_RD: begin
                    if (m_axi_rvalid && m_axi_rready) begin
                        if (beat == 0) begin
                            cr <= ha_r; cg <= ha_g; cb <= ha_b;
                            if (mb) mc <= mc + 1;
                            beat <= beat + 1; src_addr <= src_addr + 64'd8;
                            m_axi_rready <= 0; state <= S_AR;
                        end else if (beat == PAIRS_PXL - 1) begin
                            if ((mc + {4'b0,ma} + {4'b0,mb}) > MATCH_THR) rbuf[rcnt] <= 1; else rbuf[rcnt] <= 0;
                            if (rcnt == 31) begin
                                result <= {rbuf[30:0], ((mc+{4'b0,ma}+{4'b0,mb}) > MATCH_THR)};
                                irq_aclk <= 1; ack_stb_aclk <= 1; state <= S_ACK;
                            end else if (pxl_done + 1 >= total) begin
                                result <= {rbuf[30:0], ((mc+{4'b0,ma}+{4'b0,mb}) > MATCH_THR)};
                                ack_stb_aclk <= 1; state <= S_DONE;
                            end else begin
                                src_addr <= src_addr + 64'd8; m_axi_rready <= 0; state <= S_AR;
                            end
                            beat <= 0; pxl_done <= pxl_done + 1; mc <= 0;
                        end else begin
                            mc <= mc + {4'b0,ma} + {4'b0,mb};
                            beat <= beat + 1; src_addr <= src_addr + 64'd8;
                            m_axi_rready <= 0; state <= S_AR;
                        end
                    end
                end
                S_ACK: begin
                    m_axi_arvalid <= 0; m_axi_rready <= 0;
                    if (wr_en && paddr == A_CONTROL && pwdata[7]) begin
                        irq_aclk <= 0; rbuf <= 0; rcnt <= 0; mc <= 0;
                        state <= (pxl_done >= total) ? S_DONE : S_AR;
                    end
                end
                S_DONE: begin
                    m_axi_arvalid <= 0; m_axi_rready <= 0; irq_aclk <= 0;
                    if (ctrl[0] == 0) state <= S_IDLE;
                end
                default: state <= S_IDLE;
            endcase
        end
    end

    // Tie off write channel
    assign m_axi_awaddr  = 0;
    assign m_axi_awvalid = 0;
    assign m_axi_wdata   = 0;
    assign m_axi_wstrb   = 0;
    assign m_axi_wvalid  = 0;
    assign m_axi_bready  = 0;

endmodule
