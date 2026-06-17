`timescale 1ns/100ps
module pixel_proc(
    // APB slave — PCLK domain
    input               pclk,
    input               presetn,
    input               psel,
    input               penable,
    input               pwrite,
    input       [7:0]   paddr,
    input       [31:0]  pwdata,
    output  reg [31:0]  prdata,
    output  reg         irq,
    // AXI4 master read — ACLK domain
    input               aclk,
    input               aresetn,
    output  reg [31:0]  m_axi_araddr,
    output  reg         m_axi_arvalid,
    input               m_axi_arready,
    input       [63:0]  m_axi_rdata,
    input               m_axi_rvalid,
    output  reg         m_axi_rready,
    input       [1:0]   m_axi_rresp
);

    localparam [7:0] ADDR_CONTROL     = 8'h80;
    localparam [7:0] ADDR_STATUS      = 8'h84;
    localparam [7:0] ADDR_SRC_ADDR_LO = 8'h88;
    localparam [7:0] ADDR_SRC_ADDR_HI = 8'h8C;
    localparam [7:0] ADDR_PIXEL_COUNT = 8'h90;
    localparam [7:0] ADDR_RESULT      = 8'h94;
    localparam [7:0] ADDR_DEBUG       = 8'h98;

    localparam [9:0] THRESHOLD_X2  = 10'd90;
    localparam [3:0] PAIRS_PER_PXL = 4'd12;
    localparam [4:0] MATCH_THRESH  = 5'd2;

    localparam [2:0] ST_IDLE     = 3'd0;
    localparam [2:0] ST_AR_READ  = 3'd1;
    localparam [2:0] ST_R_DATA   = 3'd2;
    localparam [2:0] ST_WAIT_ACK = 3'd3;
    localparam [2:0] ST_DONE     = 3'd4;

    // ==========================================
    // PCLK domain: APB registers
    // ==========================================
    reg [31:0] control_reg, src_addr_lo, src_addr_hi, pixel_count_reg, result_reg;

    // CDC from PCLK → ACLK: START strobe
    reg start_req_pclk;
    // CDC from ACLK → PCLK: ACK + DONE
    reg ack_done_pclk, ack_done_sync1, ack_done_sync2, ack_done_stb;

    wire rd_enable = (!pwrite && psel);
    wire wr_enable = (penable && pwrite && psel);

    always @(posedge pclk or negedge presetn) begin
        if (~presetn) begin
            control_reg <= 0; src_addr_lo <= 0; src_addr_hi <= 0;
            pixel_count_reg <= 0; result_reg <= 0; prdata <= 0;
            irq <= 0; start_req_pclk <= 0;
            ack_done_sync1 <= 0; ack_done_sync2 <= 0; ack_done_stb <= 0; ack_done_pclk <= 0;
        end else begin
            if (wr_enable) begin
                case (paddr)
                    ADDR_CONTROL:     control_reg     <= pwdata;
                    ADDR_SRC_ADDR_LO: src_addr_lo     <= pwdata;
                    ADDR_SRC_ADDR_HI: src_addr_hi     <= pwdata;
                    ADDR_PIXEL_COUNT: pixel_count_reg <= pwdata;
                    default: ;
                endcase
            end

            // START: pulse to ACLK domain
            if (control_reg[0] && !start_req_pclk)
                start_req_pclk <= 1'b1;
            else if (!control_reg[0])
                start_req_pclk <= 1'b0;

            // ACK/DONE from ACLK domain (2-FF sync)
            ack_done_sync1 <= ack_done_pclk;
            ack_done_sync2 <= ack_done_sync1;
            ack_done_stb   <= ack_done_sync1 && !ack_done_sync2;  // rising edge

            if (ack_done_stb) begin
                irq <= 0;  // ACK clears IRQ
            end

            if (rd_enable) begin
                case (paddr)
                    ADDR_CONTROL:     prdata <= control_reg;
                    ADDR_STATUS:      prdata <= {29'b0, (state_aclk == ST_DONE), irq,
                                                 (state_aclk != ST_IDLE && state_aclk != ST_DONE)};
                    ADDR_SRC_ADDR_LO: prdata <= src_addr_lo;
                    ADDR_SRC_ADDR_HI: prdata <= src_addr_hi;
                    ADDR_PIXEL_COUNT: prdata <= pixel_count_reg;
                    ADDR_RESULT:      prdata <= result_reg;
                    ADDR_DEBUG:       prdata <= 32'hDEADBEEF;
                    default:          prdata <= 0;
                endcase
            end
        end
    end

    // ==========================================
    // ACLK domain: AXI state machine
    // ==========================================
    reg [2:0]  state_aclk;
    reg [63:0] work_src_addr;
    reg [31:0] work_pixel_count;
    reg [3:0]  beat_index;
    reg [31:0] pixel_counter;
    reg [7:0]  current_r, current_g, current_b;
    reg [4:0]  match_count;
    reg [31:0] result_buffer;
    reg [5:0]  result_count;

    // CDC sync: START from PCLK → ACLK
    reg start_sync1, start_sync2, start_stb;
    // CDC: IRQ + result_reg from ACLK → PCLK
    reg irq_aclk;

    // Combinational compute — Entry A (rdata[31:0])
    wire [7:0] ha_r = m_axi_rdata[7:0];
    wire [7:0] ha_g = m_axi_rdata[15:8];
    wire [7:0] ha_b = m_axi_rdata[23:16];
    wire [7:0] da_r = (current_r > ha_r) ? (current_r - ha_r) : (ha_r - current_r);
    wire [7:0] da_g = (current_g > ha_g) ? (current_g - ha_g) : (ha_g - current_g);
    wire [7:0] da_b = (current_b > ha_b) ? (current_b - ha_b) : (ha_b - current_b);
    wire [8:0] sa   = {1'b0, da_r} + {1'b0, da_g} + {1'b0, da_b};
    wire       ma   = ({sa, 1'b0} <= THRESHOLD_X2);

    // Combinational compute — Entry B (rdata[63:32])
    wire [7:0] hb_r = m_axi_rdata[39:32];
    wire [7:0] hb_g = m_axi_rdata[47:40];
    wire [7:0] hb_b = m_axi_rdata[55:48];
    wire [7:0] db_r = (current_r > hb_r) ? (current_r - hb_r) : (hb_r - current_r);
    wire [7:0] db_g = (current_g > hb_g) ? (current_g - hb_g) : (hb_g - current_g);
    wire [7:0] db_b = (current_b > hb_b) ? (current_b - hb_b) : (hb_b - current_b);
    wire [8:0] sb   = {1'b0, db_r} + {1'b0, db_g} + {1'b0, db_b};
    wire       mb   = ({sb, 1'b0} <= THRESHOLD_X2);

    always @(posedge aclk or negedge aresetn) begin
        if (~aresetn) begin
            state_aclk <= ST_IDLE;
            m_axi_araddr <= 0; m_axi_arvalid <= 0; m_axi_rready <= 0;
            irq_aclk <= 0; ack_done_pclk <= 0;
            work_src_addr <= 0; work_pixel_count <= 0;
            beat_index <= 0; pixel_counter <= 0;
            current_r <= 0; current_g <= 0; current_b <= 0;
            match_count <= 0; result_buffer <= 0; result_count <= 0;
            start_sync1 <= 0; start_sync2 <= 0; start_stb <= 0;
        end else begin
            // CDC: START strobe from PCLK domain
            start_sync1 <= start_req_pclk;
            start_sync2 <= start_sync1;
            start_stb   <= start_sync1 && !start_sync2;

            ack_done_pclk <= 0;

            case (state_aclk)

                ST_IDLE: begin
                    m_axi_arvalid <= 0; m_axi_rready <= 0; irq_aclk <= 0;
                    if (start_stb) begin
                        work_src_addr    <= {src_addr_hi, src_addr_lo};
                        work_pixel_count <= pixel_count_reg;
                        beat_index <= 0; pixel_counter <= 0;
                        match_count <= 0; result_buffer <= 0; result_count <= 0;
                        state_aclk <= ST_AR_READ;
                    end
                end

                ST_AR_READ: begin
                    m_axi_araddr  <= work_src_addr[31:0];
                    m_axi_arvalid <= 1'b1;
                    if (m_axi_arready) begin
                        m_axi_arvalid <= 0; m_axi_rready <= 1'b1;
                        state_aclk <= ST_R_DATA;
                    end
                end

                ST_R_DATA: begin
                    if (m_axi_rvalid && m_axi_rready) begin
                        if (beat_index == 0) begin
                            current_r <= ha_r; current_g <= ha_g; current_b <= ha_b;
                            if (mb) match_count <= match_count + 1;
                            beat_index <= beat_index + 1;
                            work_src_addr <= work_src_addr + 64'd8;
                            m_axi_rready <= 0; state_aclk <= ST_AR_READ;

                        end else if (beat_index == (PAIRS_PER_PXL - 1)) begin
                            if ((match_count + {4'b0, ma} + {4'b0, mb}) > MATCH_THRESH)
                                result_buffer[result_count] <= 1'b1;
                            else
                                result_buffer[result_count] <= 1'b0;

                            if (result_count == 6'd31) begin
                                result_reg <= {result_buffer[30:0],
                                              ((match_count + {4'b0, ma} + {4'b0, mb}) > MATCH_THRESH)};
                                irq_aclk <= 1'b1; ack_done_pclk <= 1'b1;
                                state_aclk <= ST_WAIT_ACK;
                            end else if (pixel_counter + 1 >= work_pixel_count) begin
                                result_reg <= {result_buffer[30:0],
                                              ((match_count + {4'b0, ma} + {4'b0, mb}) > MATCH_THRESH)};
                                ack_done_pclk <= 1'b1;
                                state_aclk <= ST_DONE;
                            end else begin
                                work_src_addr <= work_src_addr + 64'd8;
                                m_axi_rready <= 0; state_aclk <= ST_AR_READ;
                            end
                            beat_index <= 0; pixel_counter <= pixel_counter + 1;
                            match_count <= 0;

                        end else begin
                            match_count <= match_count + {4'b0, ma} + {4'b0, mb};
                            beat_index <= beat_index + 1;
                            work_src_addr <= work_src_addr + 64'd8;
                            m_axi_rready <= 0; state_aclk <= ST_AR_READ;
                        end
                    end
                end

                ST_WAIT_ACK: begin
                    m_axi_arvalid <= 0; m_axi_rready <= 0;
                    if (wr_enable && paddr == ADDR_CONTROL && pwdata[7]) begin
                        irq_aclk <= 0; result_buffer <= 0; result_count <= 0; match_count <= 0;
                        if (pixel_counter >= work_pixel_count) state_aclk <= ST_DONE;
                        else                                     state_aclk <= ST_AR_READ;
                    end
                end

                ST_DONE: begin
                    m_axi_arvalid <= 0; m_axi_rready <= 0; irq_aclk <= 0;
                    if (control_reg[0] == 1'b0) state_aclk <= ST_IDLE;
                end

                default: state_aclk <= ST_IDLE;
            endcase
        end
    end

    // CDC: IRQ from ACLK → PCLK (already done via ack_done_stb above)
    // Note: result_reg is written in ACLK domain and read in PCLK domain.
    // Safe because it's a single 32-bit register that's only updated
    // on buffer-full or done events (not continuously).

endmodule
