`timescale 1ns/100ps
module pixel_proc(
    input               pclk, presetn,
    input               psel, penable, pwrite,
    input       [7:0]   paddr,
    input       [31:0]  pwdata,
    output  reg [31:0]  prdata,
    output  reg         irq,
    // AXI4 master — AMBA standard naming
    input               ACLK, ARESETN,
    output  reg [37:0]  ARADDR,
    output      [1:0]   ARBURST,
    output      [3:0]   ARCACHE,
    output      [7:0]   ARLEN,
    output      [0:0]   ARLOCK,
    output      [2:0]   ARPROT,
    output      [3:0]   ARQOS,
    output      [3:0]   ARREGION,
    output      [2:0]   ARSIZE,
    output      [0:0]   ARUSER,
    output  reg         ARVALID,
    input               ARREADY,
    input       [63:0]  RDATA,
    input               RLAST,
    input       [0:0]   RUSER,
    input               RVALID,
    output  reg         RREADY,
    input       [1:0]   RRESP,
    output      [3:0]   ARID,       input [3:0] RID,
    output      [37:0]  AWADDR,
    output      [1:0]   AWBURST,
    output      [3:0]   AWCACHE,
    output      [7:0]   AWLEN,
    output      [0:0]   AWLOCK,
    output      [2:0]   AWPROT,
    output      [3:0]   AWQOS,
    output      [3:0]   AWREGION,
    output      [2:0]   AWSIZE,
    output      [0:0]   AWUSER,
    output              AWVALID,
    input               AWREADY,
    output      [63:0]  WDATA,
    output              WLAST,
    output      [7:0]   WSTRB,
    output      [0:0]   WUSER,
    output              WVALID,
    input               WREADY,
    output      [3:0]   AWID,       input [3:0] BID,
    input       [1:0]   BRESP,
    input       [0:0]   BUSER,
    input               BVALID,
    output              BREADY,
    input               DBG_FIC0_RESET_N,
    input               DBG_FIC3_RESET_N,
    input               DBG_DEVICE_INIT_DONE,
    input               DBG_XCVR_INIT_DONE,
    input               DBG_MSS_DLL_LOCKS
);

    localparam [7:0] A_CTRL=8'h80, A_STAT=8'h84, A_SRC_LO=8'h88, A_SRC_HI=8'h8C, A_CNT=8'h90, A_RES=8'h94, A_DBG=8'h98;
    localparam [9:0] THR=10'd90;
    localparam [3:0] PPR=4'd12;
    localparam [4:0] MTH=5'd2;
    localparam [2:0] S_IDLE=0, S_AR=1, S_RD=2, S_ACK=3, S_DONE=4;
    localparam [2:0] AXI_SIZE_8_BYTES = 3'b011;
    localparam [1:0] AXI_BURST_INCR   = 2'b01;
    localparam [3:0] AXI_CACHE_NORMAL = 4'b0011;
    localparam [2:0] AXI_PROT_DATA    = 3'b000;

    // ======== PCLK domain ========
    reg [31:0] ctrl, src_lo, src_hi, pxl_cnt;
    reg        start_pclk, ack_req;
    reg        irq_s1, irq_s2, irq_pclk;
    wire rd_en = (!pwrite && psel);
    wire wr_en = (penable && pwrite && psel);

    always @(posedge pclk or negedge presetn) begin
        if (~presetn) begin
            ctrl<=0; src_lo<=0; src_hi<=0; pxl_cnt<=0; prdata<=0;
            irq<=0; irq_pclk<=0; irq_s1<=0; irq_s2<=0;
            start_pclk<=0; ack_req<=0;
        end else begin
            start_pclk <= 0;
            ack_req <= 0;

            if (wr_en) case (paddr)
                A_CTRL: begin
                    ctrl <= pwdata;
                    start_pclk <= pwdata[0];
                    ack_req <= pwdata[7];
                end
                A_SRC_LO: src_lo <= pwdata;
                A_SRC_HI: src_hi <= pwdata;
                A_CNT:    pxl_cnt<= pwdata;
                default: ;
            endcase

            irq_s1 <= irq_aclk_s;
            irq_s2 <= irq_s1;
            irq_pclk <= irq_s2;
            irq <= irq_pclk;

            if (rd_en) case (paddr)
                A_CTRL: prdata <= ctrl;
                A_STAT: prdata <= {29'b0, done_s, irq_pclk, busy_s};
                A_SRC_LO: prdata <= src_lo;
                A_SRC_HI: prdata <= src_hi;
                A_CNT:   prdata <= pxl_cnt;
                A_RES:   prdata <= result_s;
                A_DBG:   prdata <= debug_s;
                default: prdata <= 0;
            endcase
        end
    end

    // ======== ACLK domain ========
    reg [2:0]  state;
    reg [63:0] src_addr;
    reg [31:0] total;
    reg [3:0]  beat;
    reg [31:0] pxl_done;
    reg [7:0]  cr,cg,cb;
    reg [4:0]  mc;
    reg [31:0] rbuf;
    reg [5:0]  rcnt;
    reg [31:0] result;
    reg        irq_aclk_s, busy_s, done_s;
    reg        start_s1, start_s2, start_stb;
    reg        ack_s1, ack_s2, ack_stb;
    wire [31:0] debug_s;

    wire [7:0] ha_r=RDATA[7:0],   ha_g=RDATA[15:8],  ha_b=RDATA[23:16];
    wire [7:0] hb_r=RDATA[39:32], hb_g=RDATA[47:40], hb_b=RDATA[55:48];
    wire [7:0] da_r=(cr>ha_r)?(cr-ha_r):(ha_r-cr), da_g=(cg>ha_g)?(cg-ha_g):(ha_g-cg), da_b=(cb>ha_b)?(cb-ha_b):(ha_b-cb);
    wire [7:0] db_r=(cr>hb_r)?(cr-hb_r):(hb_r-cr), db_g=(cg>hb_g)?(cg-hb_g):(hb_g-cg), db_b=(cb>hb_b)?(cb-hb_b):(hb_b-cb);
    wire [8:0] sa={1'b0,da_r}+{1'b0,da_g}+{1'b0,da_b}, sb={1'b0,db_r}+{1'b0,db_g}+{1'b0,db_b};
    wire ma=({sa,1'b0}<=THR), mb=({sb,1'b0}<=THR);

    always @(posedge ACLK or negedge ARESETN) begin
        if (~ARESETN) begin
            state<=S_IDLE; src_addr<=0; total<=0;
            ARADDR<=0; ARVALID<=0; RREADY<=0;
            beat<=0; pxl_done<=0; cr<=0;cg<=0;cb<=0; mc<=0;
            rbuf<=0; rcnt<=0; result<=0;
            irq_aclk_s<=0; busy_s<=0; done_s<=0;
            start_s1<=0; start_s2<=0; start_stb<=0;
            ack_s1<=0; ack_s2<=0; ack_stb<=0;
        end else begin
            start_s1 <= start_pclk;
            start_s2 <= start_s1;
            start_stb <= start_s1 && !start_s2;
            ack_s1 <= ack_req;
            ack_s2 <= ack_s1;
            ack_stb <= ack_s1 && !ack_s2;

            case (state)
                S_IDLE: begin
                    ARVALID<=0; RREADY<=0; irq_aclk_s<=0; busy_s<=0; done_s<=0;
                    if (start_stb) begin
                        src_addr<={src_hi,src_lo}; total<=pxl_cnt;
                        beat<=0; pxl_done<=0; mc<=0; rbuf<=0; rcnt<=0; result<=0;
                        busy_s<=1; state<=S_AR;
                    end
                end
                S_AR: begin
                    ARADDR<=src_addr[37:0]; ARVALID<=1;
                    if (ARREADY) begin ARVALID<=0; RREADY<=1; state<=S_RD; end
                end
                S_RD: begin
                    if (RVALID && RREADY) begin
                        if (beat==0) begin
                            cr<=ha_r; cg<=ha_g; cb<=ha_b;
                            if (mb) mc<=mc+1;
                            beat<=beat+1; src_addr<=src_addr+64'd8;
                            RREADY<=0; state<=S_AR;
                        end else if (beat==PPR-1) begin
                            rbuf[rcnt] <= ((mc+{4'b0,ma}+{4'b0,mb}) <= MTH);
                            if (rcnt==31) begin
                                result <= rbuf | ({31'b0, ((mc+{4'b0,ma}+{4'b0,mb}) <= MTH)} << rcnt);
                                irq_aclk_s<=1;
                                rcnt<=0;
                                state<=S_ACK;
                            end else if (pxl_done+1>=total) begin
                                result <= rbuf | ({31'b0, ((mc+{4'b0,ma}+{4'b0,mb}) <= MTH)} << rcnt);
                                busy_s<=0;
                                done_s<=1;
                                rcnt<=0;
                                state<=S_DONE;
                            end else begin
                                rcnt<=rcnt+1;
                                src_addr<=src_addr+64'd8;
                                RREADY<=0;
                                state<=S_AR;
                            end
                            beat<=0; pxl_done<=pxl_done+1; mc<=0;
                        end else begin
                            mc<=mc+{4'b0,ma}+{4'b0,mb};
                            beat<=beat+1; src_addr<=src_addr+64'd8;
                            RREADY<=0; state<=S_AR;
                        end
                    end
                end
                S_ACK: begin
                    ARVALID<=0; RREADY<=0;
                    if (ack_stb) begin
                        irq_aclk_s<=0; rbuf<=0; rcnt<=0; mc<=0;
                        state<=(pxl_done>=total)?S_DONE:S_AR;
                    end
                end
                S_DONE: begin
                    ARVALID<=0; RREADY<=0; irq_aclk_s<=0;
                    if (ctrl[0]==0) state<=S_IDLE;
                end
                default: state<=S_IDLE;
            endcase
        end
    end

    assign ARID     = 4'd0;
    assign ARLEN    = 8'd0;
    assign ARSIZE   = AXI_SIZE_8_BYTES;
    assign ARBURST  = AXI_BURST_INCR;
    assign ARLOCK   = 1'b0;
    assign ARCACHE  = AXI_CACHE_NORMAL;
    assign ARPROT   = AXI_PROT_DATA;
    assign ARQOS    = 4'd0;
    assign ARREGION = 4'd0;
    assign ARUSER   = 1'b0;

    assign AWID     = 4'd0;
    assign AWADDR   = 38'd0;
    assign AWLEN    = 8'd0;
    assign AWSIZE   = AXI_SIZE_8_BYTES;
    assign AWBURST  = AXI_BURST_INCR;
    assign AWLOCK   = 1'b0;
    assign AWCACHE  = AXI_CACHE_NORMAL;
    assign AWPROT   = AXI_PROT_DATA;
    assign AWQOS    = 4'd0;
    assign AWREGION = 4'd0;
    assign AWUSER   = 1'b0;
    assign AWVALID  = 1'b0;

    assign WDATA    = 64'd0;
    assign WLAST    = 1'b1;
    assign WSTRB    = 8'd0;
    assign WUSER    = 1'b0;
    assign WVALID   = 1'b0;
    assign BREADY   = 1'b0;
    wire [31:0] result_s = result;
    assign debug_s = {
        8'hDB,                // [31:24] signature
        3'b0,                 // [23:21] reserved
        DBG_MSS_DLL_LOCKS,    // [20]
        DBG_XCVR_INIT_DONE,   // [19]
        DBG_DEVICE_INIT_DONE, // [18]
        DBG_FIC3_RESET_N,     // [17]
        DBG_FIC0_RESET_N,     // [16]
        1'b0,                 // [15] reserved
        RVALID,               // [14]
        RREADY,               // [13]
        ARREADY,              // [12]
        ARVALID,              // [11]
        state,                // [10:8]
        irq_aclk_s,           // [7]
        done_s,               // [6]
        busy_s,               // [5]
        start_stb,            // [4]
        start_s2,             // [3]
        start_s1,             // [2]
        ARESETN,              // [1]
        start_pclk            // [0]
    };

endmodule
