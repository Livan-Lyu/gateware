`timescale 1ns/100ps
// Wrapper: apb_ctrl_status + pixel_proc sharing CoreAPB3 slot 3
// paddr[7]==0 → apb_ctrl_status (0x00-0x7F)
// paddr[7]==1 → pixel_proc      (0x80-0xFF)
module cape_regs(
    input  wire        pclk, presetn,
    // APB slave (shared)
    input  wire        psel, penable, pwrite,
    input  wire [31:0] paddr,
    input  wire [31:0] pwdata,
    output wire [31:0] prdata,
    output wire        pready,
    output wire        pslverr,
    // Status/control external I/O
    output wire [31:0] control,
    input  wire [31:0] status,
    // Interrupt
    output wire        irq,
    // AXI4 master (from pixel_proc)
    input  wire        ACLK, ARESETN,
    output wire [37:0] ARADDR,
    output wire [1:0]  ARBURST,
    output wire [3:0]  ARCACHE,
    output wire [7:0]  ARLEN,
    output wire [0:0]  ARLOCK,
    output wire [2:0]  ARPROT,
    output wire [3:0]  ARQOS,
    output wire [3:0]  ARREGION,
    output wire [2:0]  ARSIZE,
    output wire [0:0]  ARUSER,
    output wire        ARVALID,
    input  wire        ARREADY,
    input  wire [63:0] RDATA,
    input  wire        RLAST,
    input  wire [0:0]  RUSER,
    input  wire        RVALID,
    output wire        RREADY,
    input  wire [1:0]  RRESP,
    output wire [3:0]  ARID,     input wire [3:0] RID,
    output wire [37:0] AWADDR,
    output wire [1:0]  AWBURST,
    output wire [3:0]  AWCACHE,
    output wire [7:0]  AWLEN,
    output wire [0:0]  AWLOCK,
    output wire [2:0]  AWPROT,
    output wire [3:0]  AWQOS,
    output wire [3:0]  AWREGION,
    output wire [2:0]  AWSIZE,
    output wire [0:0]  AWUSER,
    output wire        AWVALID,
    input  wire        AWREADY,
    output wire [63:0] WDATA,
    output wire        WLAST,
    output wire [7:0]  WSTRB,
    output wire [0:0]  WUSER,
    output wire        WVALID,
    input  wire        WREADY,
    output wire [3:0]  AWID,     input wire [3:0] BID,
    input  wire [1:0]  BRESP,
    input  wire [0:0]  BUSER,
    input  wire        BVALID,
    output wire        BREADY,
    input  wire        DBG_FIC0_RESET_N,
    input  wire        DBG_FIC3_RESET_N,
    input  wire        DBG_DEVICE_INIT_DONE,
    input  wire        DBG_XCVR_INIT_DONE,
    input  wire        DBG_MSS_DLL_LOCKS
);

    wire [31:0] ctrl_prdata, pix_prdata;

    apb_ctrl_status u_ctrl (
        .pclk    (pclk),
        .presetn (presetn),
        .penable (penable),
        .psel    (psel && !paddr[7]),
        .paddr   (paddr),
        .pwrite  (pwrite),
        .pwdata  (pwdata),
        .prdata  (ctrl_prdata),
        .control (control),
        .status  (status)
    );

    pixel_proc u_pix (
        .pclk    (pclk),
        .presetn (presetn),
        .penable (penable),
        .psel    (psel && paddr[7]),
        .pwrite  (pwrite),
        .paddr   (paddr),
        .pwdata  (pwdata),
        .prdata  (pix_prdata),
        .irq     (irq),
        .ACLK    (ACLK),
        .ARESETN (ARESETN),
        .ARADDR  (ARADDR),
        .ARBURST (ARBURST),
        .ARCACHE (ARCACHE),
        .ARLEN   (ARLEN),
        .ARLOCK  (ARLOCK),
        .ARPROT  (ARPROT),
        .ARQOS   (ARQOS),
        .ARREGION(ARREGION),
        .ARSIZE  (ARSIZE),
        .ARUSER  (ARUSER),
        .ARVALID (ARVALID),
        .ARREADY (ARREADY),
        .RDATA   (RDATA),
        .RLAST   (RLAST),
        .RUSER   (RUSER),
        .RVALID  (RVALID),
        .RREADY  (RREADY),
        .RRESP   (RRESP),
        .ARID    (ARID),    .RID    (RID),
        .AWADDR  (AWADDR),  .AWBURST(AWBURST), .AWCACHE(AWCACHE), .AWLEN(AWLEN),
        .AWLOCK  (AWLOCK),  .AWPROT (AWPROT),  .AWQOS  (AWQOS),   .AWREGION(AWREGION),
        .AWSIZE  (AWSIZE),  .AWUSER (AWUSER),  .AWVALID(AWVALID), .AWREADY(AWREADY),
        .WDATA   (WDATA),   .WLAST  (WLAST),   .WSTRB  (WSTRB),   .WUSER(WUSER),
        .WVALID  (WVALID),  .WREADY (WREADY),
        .AWID    (AWID),    .BID    (BID),
        .BRESP   (BRESP),   .BUSER  (BUSER),   .BVALID (BVALID),  .BREADY (BREADY),
        .DBG_FIC0_RESET_N     (DBG_FIC0_RESET_N),
        .DBG_FIC3_RESET_N     (DBG_FIC3_RESET_N),
        .DBG_DEVICE_INIT_DONE (DBG_DEVICE_INIT_DONE),
        .DBG_XCVR_INIT_DONE   (DBG_XCVR_INIT_DONE),
        .DBG_MSS_DLL_LOCKS    (DBG_MSS_DLL_LOCKS)
    );

    assign prdata = paddr[7] ? pix_prdata : ctrl_prdata;
    assign pready = 1'b1;
    assign pslverr = 1'b0;

endmodule
