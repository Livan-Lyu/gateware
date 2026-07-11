//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Sun Jul 12 04:42:25 2026
// Version: 2025.1 2025.1.0.14
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// CAPE
module CAPE(
    // Inputs
    APB_SLAVE_SLAVE_PADDR,
    APB_SLAVE_SLAVE_PENABLE,
    APB_SLAVE_SLAVE_PSEL,
    APB_SLAVE_SLAVE_PWDATA,
    APB_SLAVE_SLAVE_PWRITE,
    AXI_ACLK,
    AXI_ARESETN,
    DBG_DEVICE_INIT_DONE,
    DBG_FIC0_RESET_N,
    DBG_FIC3_RESET_N,
    DBG_MSS_DLL_LOCKS,
    DBG_XCVR_INIT_DONE,
    GPIO_OE,
    GPIO_OUT,
    PCLK,
    PRESETN,
    ms_arid,
    ms_arready,
    ms_awid,
    ms_awready,
    ms_bresp,
    ms_bvalid,
    ms_rdata,
    ms_rresp,
    ms_rvalid,
    ms_wready,
    // Outputs
    APB_SLAVE_SLAVE_PRDATA,
    APB_SLAVE_SLAVE_PREADY,
    APB_SLAVE_SLAVE_PSLVERR,
    GPIO_IN,
    INT,
    P9_PIN42,
    ms_araddr,
    ms_arvalid,
    ms_awaddr,
    ms_awvalid,
    ms_bid,
    ms_bready,
    ms_rid,
    ms_rready,
    ms_wdata,
    ms_wstrb,
    ms_wvalid,
    // Inouts
    P8,
    P9_14,
    P9_16,
    P9_PIN12,
    P9_PIN15,
    P9_PIN23,
    P9_PIN25,
    P9_PIN27,
    P9_PIN30,
    P9_PIN41
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input  [31:0] APB_SLAVE_SLAVE_PADDR;
input         APB_SLAVE_SLAVE_PENABLE;
input         APB_SLAVE_SLAVE_PSEL;
input  [31:0] APB_SLAVE_SLAVE_PWDATA;
input         APB_SLAVE_SLAVE_PWRITE;
input         AXI_ACLK;
input         AXI_ARESETN;
input         DBG_DEVICE_INIT_DONE;
input         DBG_FIC0_RESET_N;
input         DBG_FIC3_RESET_N;
input         DBG_MSS_DLL_LOCKS;
input         DBG_XCVR_INIT_DONE;
input  [27:0] GPIO_OE;
input  [27:0] GPIO_OUT;
input         PCLK;
input         PRESETN;
input  [3:0]  ms_arid;
input         ms_arready;
input  [3:0]  ms_awid;
input         ms_awready;
input  [1:0]  ms_bresp;
input         ms_bvalid;
input  [63:0] ms_rdata;
input  [1:0]  ms_rresp;
input         ms_rvalid;
input         ms_wready;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output [31:0] APB_SLAVE_SLAVE_PRDATA;
output        APB_SLAVE_SLAVE_PREADY;
output        APB_SLAVE_SLAVE_PSLVERR;
output [27:0] GPIO_IN;
output [39:0] INT;
output        P9_PIN42;
output [37:0] ms_araddr;
output        ms_arvalid;
output [37:0] ms_awaddr;
output        ms_awvalid;
output [3:0]  ms_bid;
output        ms_bready;
output [3:0]  ms_rid;
output        ms_rready;
output [63:0] ms_wdata;
output [7:0]  ms_wstrb;
output        ms_wvalid;
//--------------------------------------------------------------------
// Inout
//--------------------------------------------------------------------
inout  [46:3] P8;
inout         P9_14;
inout         P9_16;
inout         P9_PIN12;
inout         P9_PIN15;
inout         P9_PIN23;
inout         P9_PIN25;
inout         P9_PIN27;
inout         P9_PIN30;
inout         P9_PIN41;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire   [31:0]  APB_BUS_CONVERTER_0_APB_MASTER_PADDR;
wire           APB_BUS_CONVERTER_0_APB_MASTER_PENABLE;
wire   [31:0]  APB_BUS_CONVERTER_0_APB_MASTER_PRDATA;
wire           APB_BUS_CONVERTER_0_APB_MASTER_PREADY;
wire           APB_BUS_CONVERTER_0_APB_MASTER_PSELx;
wire           APB_BUS_CONVERTER_0_APB_MASTER_PSLVERR;
wire   [31:0]  APB_BUS_CONVERTER_0_APB_MASTER_PWDATA;
wire           APB_BUS_CONVERTER_0_APB_MASTER_PWRITE;
wire   [31:0]  APB_SLAVE_SLAVE_PADDR;
wire           APB_SLAVE_SLAVE_PENABLE;
wire   [31:0]  APB_SLAVE_PRDATA;
wire           APB_SLAVE_PREADY;
wire           APB_SLAVE_SLAVE_PSEL;
wire           APB_SLAVE_PSLVERR;
wire   [31:0]  APB_SLAVE_SLAVE_PWDATA;
wire           APB_SLAVE_SLAVE_PWRITE;
wire           AXI_ACLK;
wire   [31:0]  AXI4mtarget0_ARADDR;
wire   [1:0]   AXI4mtarget0_ARBURST;
wire   [3:0]   AXI4mtarget0_ARCACHE;
wire           AXI_ARESETN;
wire   [7:0]   AXI4mtarget0_ARLEN;
wire   [0:0]   AXI4mtarget0_ARLOCK;
wire   [2:0]   AXI4mtarget0_ARPROT;
wire   [3:0]   AXI4mtarget0_ARQOS;
wire           ms_arready;
wire   [3:0]   AXI4mtarget0_ARREGION;
wire   [2:0]   AXI4mtarget0_ARSIZE;
wire   [0:0]   AXI4mtarget0_ARUSER;
wire           AXI4mtarget0_ARVALID;
wire   [31:0]  AXI4mtarget0_AWADDR;
wire   [1:0]   AXI4mtarget0_AWBURST;
wire   [3:0]   AXI4mtarget0_AWCACHE;
wire   [7:0]   AXI4mtarget0_AWLEN;
wire   [0:0]   AXI4mtarget0_AWLOCK;
wire   [2:0]   AXI4mtarget0_AWPROT;
wire   [3:0]   AXI4mtarget0_AWQOS;
wire           ms_awready;
wire   [3:0]   AXI4mtarget0_AWREGION;
wire   [2:0]   AXI4mtarget0_AWSIZE;
wire   [0:0]   AXI4mtarget0_AWUSER;
wire           AXI4mtarget0_AWVALID;
wire           AXI4mtarget0_BID;
wire           AXI4mtarget0_BREADY;
wire   [1:0]   ms_bresp;
wire           ms_bvalid;
wire   [63:0]  ms_rdata;
wire           AXI4mtarget0_RID;
wire           AXI4mtarget0_RREADY;
wire   [1:0]   ms_rresp;
wire           ms_rvalid;
wire   [63:0]  AXI4mtarget0_WDATA;
wire           AXI4mtarget0_WLAST;
wire           ms_wready;
wire   [7:0]   AXI4mtarget0_WSTRB;
wire   [0:0]   AXI4mtarget0_WUSER;
wire           AXI4mtarget0_WVALID;
wire           cape_regs_0_AXI4_INITIATOR_ARREADY;
wire           cape_regs_0_AXI4_INITIATOR_ARVALID;
wire           cape_regs_0_AXI4_INITIATOR_AWREADY;
wire           cape_regs_0_AXI4_INITIATOR_AWVALID;
wire           cape_regs_0_AXI4_INITIATOR_BREADY;
wire   [1:0]   cape_regs_0_AXI4_INITIATOR_BRESP;
wire   [0:0]   cape_regs_0_AXI4_INITIATOR_BUSER;
wire           cape_regs_0_AXI4_INITIATOR_BVALID;
wire   [63:0]  cape_regs_0_AXI4_INITIATOR_RDATA;
wire           cape_regs_0_AXI4_INITIATOR_RLAST;
wire           cape_regs_0_AXI4_INITIATOR_RREADY;
wire   [1:0]   cape_regs_0_AXI4_INITIATOR_RRESP;
wire   [0:0]   cape_regs_0_AXI4_INITIATOR_RUSER;
wire           cape_regs_0_AXI4_INITIATOR_RVALID;
wire   [63:0]  cape_regs_0_AXI4_INITIATOR_WDATA;
wire           cape_regs_0_AXI4_INITIATOR_WREADY;
wire   [7:0]   cape_regs_0_AXI4_INITIATOR_WSTRB;
wire           cape_regs_0_AXI4_INITIATOR_WVALID;
wire           CoreAPB3_CAPE_0_APBmslave0_PENABLE;
wire   [31:0]  CoreAPB3_CAPE_0_APBmslave0_PRDATA;
wire           CoreAPB3_CAPE_0_APBmslave0_PREADY;
wire           CoreAPB3_CAPE_0_APBmslave0_PSELx;
wire           CoreAPB3_CAPE_0_APBmslave0_PSLVERR;
wire   [31:0]  CoreAPB3_CAPE_0_APBmslave0_PWDATA;
wire           CoreAPB3_CAPE_0_APBmslave0_PWRITE;
wire   [31:0]  CoreAPB3_CAPE_0_APBmslave1_PRDATA;
wire           CoreAPB3_CAPE_0_APBmslave1_PREADY;
wire           CoreAPB3_CAPE_0_APBmslave1_PSELx;
wire           CoreAPB3_CAPE_0_APBmslave1_PSLVERR;
wire   [31:0]  CoreAPB3_CAPE_0_APBmslave2_PRDATA;
wire           CoreAPB3_CAPE_0_APBmslave2_PREADY;
wire           CoreAPB3_CAPE_0_APBmslave2_PSELx;
wire           CoreAPB3_CAPE_0_APBmslave2_PSLVERR;
wire   [31:0]  CoreAPB3_CAPE_0_APBmslave3_PRDATA;
wire           CoreAPB3_CAPE_0_APBmslave3_PREADY;
wire           CoreAPB3_CAPE_0_APBmslave3_PSELx;
wire           CoreAPB3_CAPE_0_APBmslave3_PSLVERR;
wire   [31:0]  CoreAPB3_CAPE_0_APBmslave4_PRDATA;
wire           CoreAPB3_CAPE_0_APBmslave4_PREADY;
wire           CoreAPB3_CAPE_0_APBmslave4_PSELx;
wire           CoreAPB3_CAPE_0_APBmslave4_PSLVERR;
wire   [31:0]  CoreAPB3_CAPE_0_APBmslave5_PRDATA;
wire           CoreAPB3_CAPE_0_APBmslave5_PREADY;
wire           CoreAPB3_CAPE_0_APBmslave5_PSELx;
wire           CoreAPB3_CAPE_0_APBmslave5_PSLVERR;
wire           DBG_DEVICE_INIT_DONE;
wire           DBG_FIC0_RESET_N;
wire           DBG_FIC3_RESET_N;
wire           DBG_MSS_DLL_LOCKS;
wire           DBG_XCVR_INIT_DONE;
wire   [27:0]  GPIO_IN_net_0;
wire   [27:0]  GPIO_OE;
wire   [27:0]  GPIO_OUT;
wire   [15:0]  INT_net_0;
wire   [20:0]  INT_0;
wire           INT_1;
wire           P9_14;
wire           P9_16;
wire           P9_PIN12;
wire           P9_PIN15;
wire           P9_PIN23;
wire           P9_PIN25;
wire           P9_PIN27;
wire           P9_PIN30;
wire           P9_PIN41;
wire           P9_PIN42_net_0;
wire           PCLK;
wire           PRESETN;
wire           PWM_1_PWM_0;
wire           PWM_1_PWM_1;
wire           PWM_2_PWM_0;
wire           PWM_2_PWM_1;
wire           APB_SLAVE_PREADY_net_0;
wire           APB_SLAVE_PSLVERR_net_0;
wire           P9_PIN42_net_1;
wire   [31:0]  APB_SLAVE_PRDATA_net_0;
wire   [27:0]  GPIO_IN_net_1;
wire   [15:0]  INT_net_1;
wire   [36:16] INT_0_net_0;
wire   [37:37] INT_1_net_0;
wire   [37:0]  AXI4mtarget0_ARADDR_net_0;
wire           AXI4mtarget0_ARVALID_net_0;
wire           AXI4mtarget0_RREADY_net_0;
wire   [37:0]  AXI4mtarget0_AWADDR_net_0;
wire           AXI4mtarget0_AWVALID_net_0;
wire   [63:0]  AXI4mtarget0_WDATA_net_0;
wire   [7:0]   AXI4mtarget0_WSTRB_net_0;
wire           AXI4mtarget0_WVALID_net_0;
wire           AXI4mtarget0_BREADY_net_0;
//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire   [39:38] INT_const_net_0;
wire   [31:0]  status_const_net_0;
wire           VCC_net;
wire   [1:0]   TARGET0_BID_const_net_0;
wire   [1:0]   TARGET0_RID_const_net_0;
wire           GND_net;
wire   [1:0]   TARGET1_BID_const_net_0;
wire   [1:0]   TARGET1_BRESP_const_net_0;
wire   [1:0]   TARGET1_RID_const_net_0;
wire   [63:0]  TARGET1_RDATA_const_net_0;
wire   [1:0]   TARGET1_RRESP_const_net_0;
wire   [7:0]   INITIATOR0_AWLEN_const_net_0;
wire   [2:0]   INITIATOR0_AWSIZE_const_net_0;
wire   [1:0]   INITIATOR0_AWBURST_const_net_0;
wire   [3:0]   INITIATOR0_AWCACHE_const_net_0;
wire   [2:0]   INITIATOR0_AWPROT_const_net_0;
wire   [3:0]   INITIATOR0_AWQOS_const_net_0;
wire   [3:0]   INITIATOR0_AWREGION_const_net_0;
wire   [7:0]   INITIATOR0_ARLEN_const_net_0;
wire   [2:0]   INITIATOR0_ARSIZE_const_net_0;
wire   [1:0]   INITIATOR0_ARBURST_const_net_0;
wire   [3:0]   INITIATOR0_ARCACHE_const_net_0;
wire   [2:0]   INITIATOR0_ARPROT_const_net_0;
wire   [3:0]   INITIATOR0_ARQOS_const_net_0;
wire   [3:0]   INITIATOR0_ARREGION_const_net_0;
wire   [31:0]  INITIATOR1_AWADDR_const_net_0;
wire   [7:0]   INITIATOR1_AWLEN_const_net_0;
wire   [2:0]   INITIATOR1_AWSIZE_const_net_0;
wire   [1:0]   INITIATOR1_AWBURST_const_net_0;
wire   [3:0]   INITIATOR1_AWCACHE_const_net_0;
wire   [2:0]   INITIATOR1_AWPROT_const_net_0;
wire   [3:0]   INITIATOR1_AWQOS_const_net_0;
wire   [3:0]   INITIATOR1_AWREGION_const_net_0;
wire   [63:0]  INITIATOR1_WDATA_const_net_0;
wire   [7:0]   INITIATOR1_WSTRB_const_net_0;
wire   [31:0]  INITIATOR1_ARADDR_const_net_0;
wire   [7:0]   INITIATOR1_ARLEN_const_net_0;
wire   [2:0]   INITIATOR1_ARSIZE_const_net_0;
wire   [1:0]   INITIATOR1_ARBURST_const_net_0;
wire   [3:0]   INITIATOR1_ARCACHE_const_net_0;
wire   [2:0]   INITIATOR1_ARPROT_const_net_0;
wire   [3:0]   INITIATOR1_ARQOS_const_net_0;
wire   [3:0]   INITIATOR1_ARREGION_const_net_0;
//--------------------------------------------------------------------
// Bus Interface Nets Declarations - Unequal Pin Widths
//--------------------------------------------------------------------
wire   [1:0]   ms_arid;
wire   [3:0]   ms_arid_0;
wire   [1:0]   ms_arid_0_1to0;
wire   [3:2]   ms_arid_0_3to2;
wire   [1:0]   ms_awid;
wire   [3:0]   ms_awid_0;
wire   [1:0]   ms_awid_0_1to0;
wire   [3:2]   ms_awid_0_3to2;
wire   [37:0]  cape_regs_0_AXI4_INITIATOR_ARADDR;
wire   [31:0]  cape_regs_0_AXI4_INITIATOR_ARADDR_0;
wire   [31:0]  cape_regs_0_AXI4_INITIATOR_ARADDR_0_31to0;
wire   [3:0]   cape_regs_0_AXI4_INITIATOR_ARID;
wire   [0:0]   cape_regs_0_AXI4_INITIATOR_ARID_0;
wire   [0:0]   cape_regs_0_AXI4_INITIATOR_ARID_0_0to0;
wire   [37:0]  cape_regs_0_AXI4_INITIATOR_AWADDR;
wire   [31:0]  cape_regs_0_AXI4_INITIATOR_AWADDR_0;
wire   [31:0]  cape_regs_0_AXI4_INITIATOR_AWADDR_0_31to0;
wire   [3:0]   cape_regs_0_AXI4_INITIATOR_AWID;
wire   [0:0]   cape_regs_0_AXI4_INITIATOR_AWID_0;
wire   [0:0]   cape_regs_0_AXI4_INITIATOR_AWID_0_0to0;
wire   [0:0]   cape_regs_0_AXI4_INITIATOR_BID;
wire   [3:0]   cape_regs_0_AXI4_INITIATOR_BID_0;
wire   [0:0]   cape_regs_0_AXI4_INITIATOR_BID_0_0to0;
wire   [3:1]   cape_regs_0_AXI4_INITIATOR_BID_0_3to1;
wire   [0:0]   cape_regs_0_AXI4_INITIATOR_RID;
wire   [3:0]   cape_regs_0_AXI4_INITIATOR_RID_0;
wire   [0:0]   cape_regs_0_AXI4_INITIATOR_RID_0_0to0;
wire   [3:1]   cape_regs_0_AXI4_INITIATOR_RID_0_3to1;
wire   [31:0]  CoreAPB3_CAPE_0_APBmslave0_PADDR;
wire   [7:0]   CoreAPB3_CAPE_0_APBmslave0_PADDR_0;
wire   [7:0]   CoreAPB3_CAPE_0_APBmslave0_PADDR_0_7to0;
wire   [7:0]   CoreAPB3_CAPE_0_APBmslave0_PADDR_1;
wire   [7:0]   CoreAPB3_CAPE_0_APBmslave0_PADDR_1_7to0;
wire   [7:0]   CoreAPB3_CAPE_0_APBmslave0_PADDR_2;
wire   [7:0]   CoreAPB3_CAPE_0_APBmslave0_PADDR_2_7to0;
wire   [7:0]   CoreAPB3_CAPE_0_APBmslave0_PADDR_3;
wire   [7:0]   CoreAPB3_CAPE_0_APBmslave0_PADDR_3_7to0;
wire   [7:0]   CoreAPB3_CAPE_0_APBmslave0_PADDR_4;
wire   [7:0]   CoreAPB3_CAPE_0_APBmslave0_PADDR_4_7to0;
//--------------------------------------------------------------------
// Constant assignments
//--------------------------------------------------------------------
assign INT_const_net_0                 = 2'h0;
assign status_const_net_0              = 32'h00000000;
assign VCC_net                         = 1'b1;
assign TARGET0_BID_const_net_0         = 2'h0;
assign TARGET0_RID_const_net_0         = 2'h0;
assign GND_net                         = 1'b0;
assign TARGET1_BID_const_net_0         = 2'h0;
assign TARGET1_BRESP_const_net_0       = 2'h0;
assign TARGET1_RID_const_net_0         = 2'h0;
assign TARGET1_RDATA_const_net_0       = 64'h0000000000000000;
assign TARGET1_RRESP_const_net_0       = 2'h0;
assign INITIATOR0_AWLEN_const_net_0    = 8'h00;
assign INITIATOR0_AWSIZE_const_net_0   = 3'h0;
assign INITIATOR0_AWBURST_const_net_0  = 2'h3;
assign INITIATOR0_AWCACHE_const_net_0  = 4'h0;
assign INITIATOR0_AWPROT_const_net_0   = 3'h0;
assign INITIATOR0_AWQOS_const_net_0    = 4'h0;
assign INITIATOR0_AWREGION_const_net_0 = 4'h0;
assign INITIATOR0_ARLEN_const_net_0    = 8'h00;
assign INITIATOR0_ARSIZE_const_net_0   = 3'h0;
assign INITIATOR0_ARBURST_const_net_0  = 2'h3;
assign INITIATOR0_ARCACHE_const_net_0  = 4'h0;
assign INITIATOR0_ARPROT_const_net_0   = 3'h0;
assign INITIATOR0_ARQOS_const_net_0    = 4'h0;
assign INITIATOR0_ARREGION_const_net_0 = 4'h0;
assign INITIATOR1_AWADDR_const_net_0   = 32'h00000000;
assign INITIATOR1_AWLEN_const_net_0    = 8'h00;
assign INITIATOR1_AWSIZE_const_net_0   = 3'h0;
assign INITIATOR1_AWBURST_const_net_0  = 2'h3;
assign INITIATOR1_AWCACHE_const_net_0  = 4'h0;
assign INITIATOR1_AWPROT_const_net_0   = 3'h0;
assign INITIATOR1_AWQOS_const_net_0    = 4'h0;
assign INITIATOR1_AWREGION_const_net_0 = 4'h0;
assign INITIATOR1_WDATA_const_net_0    = 64'h0000000000000000;
assign INITIATOR1_WSTRB_const_net_0    = 8'hFF;
assign INITIATOR1_ARADDR_const_net_0   = 32'h00000000;
assign INITIATOR1_ARLEN_const_net_0    = 8'h00;
assign INITIATOR1_ARSIZE_const_net_0   = 3'h0;
assign INITIATOR1_ARBURST_const_net_0  = 2'h3;
assign INITIATOR1_ARCACHE_const_net_0  = 4'h0;
assign INITIATOR1_ARPROT_const_net_0   = 3'h0;
assign INITIATOR1_ARQOS_const_net_0    = 4'h0;
assign INITIATOR1_ARREGION_const_net_0 = 4'h0;
//--------------------------------------------------------------------
// TieOff assignments
//--------------------------------------------------------------------
assign INT[39:38]                   = 2'h0;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign APB_SLAVE_PREADY_net_0       = APB_SLAVE_PREADY;
assign APB_SLAVE_SLAVE_PREADY       = APB_SLAVE_PREADY_net_0;
assign APB_SLAVE_PSLVERR_net_0      = APB_SLAVE_PSLVERR;
assign APB_SLAVE_SLAVE_PSLVERR      = APB_SLAVE_PSLVERR_net_0;
assign P9_PIN42_net_1               = P9_PIN42_net_0;
assign P9_PIN42                     = P9_PIN42_net_1;
assign APB_SLAVE_PRDATA_net_0       = APB_SLAVE_PRDATA;
assign APB_SLAVE_SLAVE_PRDATA[31:0] = APB_SLAVE_PRDATA_net_0;
assign GPIO_IN_net_1                = GPIO_IN_net_0;
assign GPIO_IN[27:0]                = GPIO_IN_net_1;
assign INT_net_1                    = INT_net_0;
assign INT[15:0]                    = INT_net_1;
assign INT_0_net_0                  = INT_0;
assign INT[36:16]                   = INT_0_net_0;
assign INT_1_net_0[37]              = INT_1;
assign INT[37:37]                   = INT_1_net_0[37];
assign AXI4mtarget0_ARADDR_net_0    = AXI4mtarget0_ARADDR;
assign ms_araddr[37:0]              = AXI4mtarget0_ARADDR_net_0;
assign AXI4mtarget0_ARVALID_net_0   = AXI4mtarget0_ARVALID;
assign ms_arvalid                   = AXI4mtarget0_ARVALID_net_0;
assign AXI4mtarget0_RREADY_net_0    = AXI4mtarget0_RREADY;
assign ms_rready                    = AXI4mtarget0_RREADY_net_0;
assign AXI4mtarget0_AWADDR_net_0    = AXI4mtarget0_AWADDR;
assign ms_awaddr[37:0]              = AXI4mtarget0_AWADDR_net_0;
assign AXI4mtarget0_AWVALID_net_0   = AXI4mtarget0_AWVALID;
assign ms_awvalid                   = AXI4mtarget0_AWVALID_net_0;
assign AXI4mtarget0_WDATA_net_0     = AXI4mtarget0_WDATA;
assign ms_wdata[63:0]               = AXI4mtarget0_WDATA_net_0;
assign AXI4mtarget0_WSTRB_net_0     = AXI4mtarget0_WSTRB;
assign ms_wstrb[7:0]                = AXI4mtarget0_WSTRB_net_0;
assign AXI4mtarget0_WVALID_net_0    = AXI4mtarget0_WVALID;
assign ms_wvalid                    = AXI4mtarget0_WVALID_net_0;
assign AXI4mtarget0_BREADY_net_0    = AXI4mtarget0_BREADY;
assign ms_bready                    = AXI4mtarget0_BREADY_net_0;
//--------------------------------------------------------------------
// Bus Interface Nets Assignments - Unequal Pin Widths
//--------------------------------------------------------------------
assign ms_arid_0 = { ms_arid_0_3to2, ms_arid_0_1to0 };
assign ms_arid_0_1to0 = ms_arid[1:0];
assign ms_arid_0_3to2 = 2'h0;

assign ms_awid_0 = { ms_awid_0_3to2, ms_awid_0_1to0 };
assign ms_awid_0_1to0 = ms_awid[1:0];
assign ms_awid_0_3to2 = 2'h0;

assign cape_regs_0_AXI4_INITIATOR_ARADDR_0 = { cape_regs_0_AXI4_INITIATOR_ARADDR_0_31to0 };
assign cape_regs_0_AXI4_INITIATOR_ARADDR_0_31to0 = cape_regs_0_AXI4_INITIATOR_ARADDR[31:0];

assign cape_regs_0_AXI4_INITIATOR_ARID_0 = { cape_regs_0_AXI4_INITIATOR_ARID_0_0to0 };
assign cape_regs_0_AXI4_INITIATOR_ARID_0_0to0 = cape_regs_0_AXI4_INITIATOR_ARID[0:0];

assign cape_regs_0_AXI4_INITIATOR_AWADDR_0 = { cape_regs_0_AXI4_INITIATOR_AWADDR_0_31to0 };
assign cape_regs_0_AXI4_INITIATOR_AWADDR_0_31to0 = cape_regs_0_AXI4_INITIATOR_AWADDR[31:0];

assign cape_regs_0_AXI4_INITIATOR_AWID_0 = { cape_regs_0_AXI4_INITIATOR_AWID_0_0to0 };
assign cape_regs_0_AXI4_INITIATOR_AWID_0_0to0 = cape_regs_0_AXI4_INITIATOR_AWID[0:0];

assign cape_regs_0_AXI4_INITIATOR_BID_0 = { cape_regs_0_AXI4_INITIATOR_BID_0_3to1, cape_regs_0_AXI4_INITIATOR_BID_0_0to0 };
assign cape_regs_0_AXI4_INITIATOR_BID_0_0to0 = cape_regs_0_AXI4_INITIATOR_BID[0:0];
assign cape_regs_0_AXI4_INITIATOR_BID_0_3to1 = 3'h0;

assign cape_regs_0_AXI4_INITIATOR_RID_0 = { cape_regs_0_AXI4_INITIATOR_RID_0_3to1, cape_regs_0_AXI4_INITIATOR_RID_0_0to0 };
assign cape_regs_0_AXI4_INITIATOR_RID_0_0to0 = cape_regs_0_AXI4_INITIATOR_RID[0:0];
assign cape_regs_0_AXI4_INITIATOR_RID_0_3to1 = 3'h0;

assign CoreAPB3_CAPE_0_APBmslave0_PADDR_0 = { CoreAPB3_CAPE_0_APBmslave0_PADDR_0_7to0 };
assign CoreAPB3_CAPE_0_APBmslave0_PADDR_0_7to0 = CoreAPB3_CAPE_0_APBmslave0_PADDR[7:0];
assign CoreAPB3_CAPE_0_APBmslave0_PADDR_1 = { CoreAPB3_CAPE_0_APBmslave0_PADDR_1_7to0 };
assign CoreAPB3_CAPE_0_APBmslave0_PADDR_1_7to0 = CoreAPB3_CAPE_0_APBmslave0_PADDR[7:0];
assign CoreAPB3_CAPE_0_APBmslave0_PADDR_2 = { CoreAPB3_CAPE_0_APBmslave0_PADDR_2_7to0 };
assign CoreAPB3_CAPE_0_APBmslave0_PADDR_2_7to0 = CoreAPB3_CAPE_0_APBmslave0_PADDR[7:0];
assign CoreAPB3_CAPE_0_APBmslave0_PADDR_3 = { CoreAPB3_CAPE_0_APBmslave0_PADDR_3_7to0 };
assign CoreAPB3_CAPE_0_APBmslave0_PADDR_3_7to0 = CoreAPB3_CAPE_0_APBmslave0_PADDR[7:0];
assign CoreAPB3_CAPE_0_APBmslave0_PADDR_4 = { CoreAPB3_CAPE_0_APBmslave0_PADDR_4_7to0 };
assign CoreAPB3_CAPE_0_APBmslave0_PADDR_4_7to0 = CoreAPB3_CAPE_0_APBmslave0_PADDR[7:0];

//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------APB_BUS_CONVERTER
APB_BUS_CONVERTER APB_BUS_CONVERTER_0(
        // Inputs
        .SLAVE_PADDR    ( APB_SLAVE_SLAVE_PADDR ),
        .SLAVE_PENABLE  ( APB_SLAVE_SLAVE_PENABLE ),
        .SLAVE_PSEL     ( APB_SLAVE_SLAVE_PSEL ),
        .SLAVE_PWDATA   ( APB_SLAVE_SLAVE_PWDATA ),
        .SLAVE_PWRITE   ( APB_SLAVE_SLAVE_PWRITE ),
        .MASTER_PSLVERR ( APB_BUS_CONVERTER_0_APB_MASTER_PSLVERR ),
        .MASTER_PRDATA  ( APB_BUS_CONVERTER_0_APB_MASTER_PRDATA ),
        .MASTER_PREADY  ( APB_BUS_CONVERTER_0_APB_MASTER_PREADY ),
        // Outputs
        .SLAVE_PRDATA   ( APB_SLAVE_PRDATA ),
        .SLAVE_PSLVERR  ( APB_SLAVE_PSLVERR ),
        .SLAVE_PREADY   ( APB_SLAVE_PREADY ),
        .MASTER_PADDR   ( APB_BUS_CONVERTER_0_APB_MASTER_PADDR ),
        .MASTER_PENABLE ( APB_BUS_CONVERTER_0_APB_MASTER_PENABLE ),
        .MASTER_PWRITE  ( APB_BUS_CONVERTER_0_APB_MASTER_PWRITE ),
        .MASTER_PSEL    ( APB_BUS_CONVERTER_0_APB_MASTER_PSELx ),
        .MASTER_PWDATA  ( APB_BUS_CONVERTER_0_APB_MASTER_PWDATA ) 
        );

//--------CAPE_DEFAULT_GPIOS
CAPE_DEFAULT_GPIOS CAPE_DEFAULT_GPIOS_inst_0(
        // Inputs
        .GPIO_OUT    ( GPIO_OUT ),
        .GPIO_OE     ( GPIO_OE ),
        // Outputs
        .GPIO_IN     ( GPIO_IN_net_0 ),
        // Inouts
        .GPIO_0_PAD  ( P8[3:3] ),
        .GPIO_1_PAD  ( P8[4:4] ),
        .GPIO_2_PAD  ( P8[5:5] ),
        .GPIO_3_PAD  ( P8[6:6] ),
        .GPIO_4_PAD  ( P8[7:7] ),
        .GPIO_5_PAD  ( P8[8:8] ),
        .GPIO_6_PAD  ( P8[9:9] ),
        .GPIO_7_PAD  ( P8[10:10] ),
        .GPIO_8_PAD  ( P8[11:11] ),
        .GPIO_9_PAD  ( P8[12:12] ),
        .GPIO_11_PAD ( P8[14:14] ),
        .GPIO_12_PAD ( P8[15:15] ),
        .GPIO_13_PAD ( P8[16:16] ),
        .GPIO_14_PAD ( P8[17:17] ),
        .GPIO_15_PAD ( P8[18:18] ),
        .GPIO_17_PAD ( P8[20:20] ),
        .GPIO_18_PAD ( P8[21:21] ),
        .GPIO_19_PAD ( P8[22:22] ),
        .GPIO_20_PAD ( P8[23:23] ),
        .GPIO_21_PAD ( P8[24:24] ),
        .GPIO_22_PAD ( P8[25:25] ),
        .GPIO_23_PAD ( P8[26:26] ),
        .GPIO_24_PAD ( P8[27:27] ),
        .GPIO_25_PAD ( P8[28:28] ),
        .GPIO_26_PAD ( P8[29:29] ),
        .GPIO_27_PAD ( P8[30:30] ) 
        );

//--------cape_regs
cape_regs cape_regs_0(
        // Inputs
        .pclk                 ( PCLK ),
        .presetn              ( PRESETN ),
        .psel                 ( CoreAPB3_CAPE_0_APBmslave3_PSELx ),
        .penable              ( CoreAPB3_CAPE_0_APBmslave0_PENABLE ),
        .pwrite               ( CoreAPB3_CAPE_0_APBmslave0_PWRITE ),
        .paddr                ( CoreAPB3_CAPE_0_APBmslave0_PADDR ),
        .pwdata               ( CoreAPB3_CAPE_0_APBmslave0_PWDATA ),
        .status               ( status_const_net_0 ),
        .ACLK                 ( AXI_ACLK ),
        .ARESETN              ( DBG_FIC0_RESET_N ),
        .ARREADY              ( cape_regs_0_AXI4_INITIATOR_ARREADY ),
        .RDATA                ( cape_regs_0_AXI4_INITIATOR_RDATA ),
        .RVALID               ( cape_regs_0_AXI4_INITIATOR_RVALID ),
        .RRESP                ( cape_regs_0_AXI4_INITIATOR_RRESP ),
        .RID                  ( cape_regs_0_AXI4_INITIATOR_RID_0 ),
        .AWREADY              ( cape_regs_0_AXI4_INITIATOR_AWREADY ),
        .WREADY               ( cape_regs_0_AXI4_INITIATOR_WREADY ),
        .BID                  ( cape_regs_0_AXI4_INITIATOR_BID_0 ),
        .BRESP                ( cape_regs_0_AXI4_INITIATOR_BRESP ),
        .BVALID               ( cape_regs_0_AXI4_INITIATOR_BVALID ),
        .DBG_FIC0_RESET_N     ( DBG_FIC0_RESET_N ),
        .DBG_FIC3_RESET_N     ( DBG_FIC3_RESET_N ),
        .DBG_DEVICE_INIT_DONE ( DBG_DEVICE_INIT_DONE ),
        .DBG_XCVR_INIT_DONE   ( DBG_XCVR_INIT_DONE ),
        .DBG_MSS_DLL_LOCKS    ( DBG_MSS_DLL_LOCKS ),
        // Outputs
        .prdata               ( CoreAPB3_CAPE_0_APBmslave3_PRDATA ),
        .pready               ( CoreAPB3_CAPE_0_APBmslave3_PREADY ),
        .pslverr              ( CoreAPB3_CAPE_0_APBmslave3_PSLVERR ),
        .control              (  ),
        .irq                  ( INT_1 ),
        .ARADDR               ( cape_regs_0_AXI4_INITIATOR_ARADDR ),
        .ARVALID              ( cape_regs_0_AXI4_INITIATOR_ARVALID ),
        .RREADY               ( cape_regs_0_AXI4_INITIATOR_RREADY ),
        .ARID                 ( cape_regs_0_AXI4_INITIATOR_ARID ),
        .AWADDR               ( cape_regs_0_AXI4_INITIATOR_AWADDR ),
        .AWVALID              ( cape_regs_0_AXI4_INITIATOR_AWVALID ),
        .WDATA                ( cape_regs_0_AXI4_INITIATOR_WDATA ),
        .WSTRB                ( cape_regs_0_AXI4_INITIATOR_WSTRB ),
        .WVALID               ( cape_regs_0_AXI4_INITIATOR_WVALID ),
        .AWID                 ( cape_regs_0_AXI4_INITIATOR_AWID ),
        .BREADY               ( cape_regs_0_AXI4_INITIATOR_BREADY ) 
        );

//--------CoreAPB3_CAPE
CoreAPB3_CAPE CoreAPB3_CAPE_0(
        // Inputs
        .PADDR     ( APB_BUS_CONVERTER_0_APB_MASTER_PADDR ),
        .PSEL      ( APB_BUS_CONVERTER_0_APB_MASTER_PSELx ),
        .PENABLE   ( APB_BUS_CONVERTER_0_APB_MASTER_PENABLE ),
        .PWRITE    ( APB_BUS_CONVERTER_0_APB_MASTER_PWRITE ),
        .PWDATA    ( APB_BUS_CONVERTER_0_APB_MASTER_PWDATA ),
        .PRDATAS0  ( CoreAPB3_CAPE_0_APBmslave0_PRDATA ),
        .PREADYS0  ( CoreAPB3_CAPE_0_APBmslave0_PREADY ),
        .PSLVERRS0 ( CoreAPB3_CAPE_0_APBmslave0_PSLVERR ),
        .PRDATAS1  ( CoreAPB3_CAPE_0_APBmslave1_PRDATA ),
        .PREADYS1  ( CoreAPB3_CAPE_0_APBmslave1_PREADY ),
        .PSLVERRS1 ( CoreAPB3_CAPE_0_APBmslave1_PSLVERR ),
        .PRDATAS2  ( CoreAPB3_CAPE_0_APBmslave2_PRDATA ),
        .PREADYS2  ( CoreAPB3_CAPE_0_APBmslave2_PREADY ),
        .PSLVERRS2 ( CoreAPB3_CAPE_0_APBmslave2_PSLVERR ),
        .PRDATAS3  ( CoreAPB3_CAPE_0_APBmslave3_PRDATA ),
        .PREADYS3  ( CoreAPB3_CAPE_0_APBmslave3_PREADY ),
        .PSLVERRS3 ( CoreAPB3_CAPE_0_APBmslave3_PSLVERR ),
        .PRDATAS4  ( CoreAPB3_CAPE_0_APBmslave4_PRDATA ),
        .PREADYS4  ( CoreAPB3_CAPE_0_APBmslave4_PREADY ),
        .PSLVERRS4 ( CoreAPB3_CAPE_0_APBmslave4_PSLVERR ),
        .PRDATAS5  ( CoreAPB3_CAPE_0_APBmslave5_PRDATA ),
        .PREADYS5  ( CoreAPB3_CAPE_0_APBmslave5_PREADY ),
        .PSLVERRS5 ( CoreAPB3_CAPE_0_APBmslave5_PSLVERR ),
        // Outputs
        .PRDATA    ( APB_BUS_CONVERTER_0_APB_MASTER_PRDATA ),
        .PREADY    ( APB_BUS_CONVERTER_0_APB_MASTER_PREADY ),
        .PSLVERR   ( APB_BUS_CONVERTER_0_APB_MASTER_PSLVERR ),
        .PADDRS    ( CoreAPB3_CAPE_0_APBmslave0_PADDR ),
        .PSELS0    ( CoreAPB3_CAPE_0_APBmslave0_PSELx ),
        .PENABLES  ( CoreAPB3_CAPE_0_APBmslave0_PENABLE ),
        .PWRITES   ( CoreAPB3_CAPE_0_APBmslave0_PWRITE ),
        .PWDATAS   ( CoreAPB3_CAPE_0_APBmslave0_PWDATA ),
        .PSELS1    ( CoreAPB3_CAPE_0_APBmslave1_PSELx ),
        .PSELS2    ( CoreAPB3_CAPE_0_APBmslave2_PSELx ),
        .PSELS3    ( CoreAPB3_CAPE_0_APBmslave3_PSELx ),
        .PSELS4    ( CoreAPB3_CAPE_0_APBmslave4_PSELx ),
        .PSELS5    ( CoreAPB3_CAPE_0_APBmslave5_PSELx ) 
        );

//--------BIBUF
BIBUF GPIO_13_BIBUF(
        // Inputs
        .D   ( PWM_2_PWM_1 ),
        .E   ( VCC_net ),
        // Outputs
        .Y   (  ),
        // Inouts
        .PAD ( P8[13:13] ) 
        );

//--------BIBUF
BIBUF GPIO_19_BIBUF(
        // Inputs
        .D   ( PWM_2_PWM_0 ),
        .E   ( VCC_net ),
        // Outputs
        .Y   (  ),
        // Inouts
        .PAD ( P8[19:19] ) 
        );

//--------P8_GPIO_UPPER
P8_GPIO_UPPER P8_GPIO_UPPER_0(
        // Inputs
        .APB_bif_PENABLE ( CoreAPB3_CAPE_0_APBmslave0_PENABLE ),
        .APB_bif_PSEL    ( CoreAPB3_CAPE_0_APBmslave1_PSELx ),
        .APB_bif_PWRITE  ( CoreAPB3_CAPE_0_APBmslave0_PWRITE ),
        .PCLK            ( PCLK ),
        .PRESETN         ( PRESETN ),
        .APB_bif_PADDR   ( CoreAPB3_CAPE_0_APBmslave0_PADDR_1 ),
        .APB_bif_PWDATA  ( CoreAPB3_CAPE_0_APBmslave0_PWDATA ),
        // Outputs
        .APB_bif_PREADY  ( CoreAPB3_CAPE_0_APBmslave1_PREADY ),
        .APB_bif_PSLVERR ( CoreAPB3_CAPE_0_APBmslave1_PSLVERR ),
        .APB_bif_PRDATA  ( CoreAPB3_CAPE_0_APBmslave1_PRDATA ),
        .INT             ( INT_net_0 ),
        // Inouts
        .GPIO_0_PAD      ( P8[31:31] ),
        .GPIO_10_PAD     ( P8[41:41] ),
        .GPIO_11_PAD     ( P8[42:42] ),
        .GPIO_12_PAD     ( P8[43:43] ),
        .GPIO_13_PAD     ( P8[44:44] ),
        .GPIO_14_PAD     ( P8[45:45] ),
        .GPIO_15_PAD     ( P8[46:46] ),
        .GPIO_1_PAD      ( P8[32:32] ),
        .GPIO_2_PAD      ( P8[33:33] ),
        .GPIO_3_PAD      ( P8[34:34] ),
        .GPIO_4_PAD      ( P8[35:35] ),
        .GPIO_5_PAD      ( P8[36:36] ),
        .GPIO_6_PAD      ( P8[37:37] ),
        .GPIO_7_PAD      ( P8[38:38] ),
        .GPIO_8_PAD      ( P8[39:39] ),
        .GPIO_9_PAD      ( P8[40:40] ) 
        );

//--------BIBUF
BIBUF P9_14_BIBUF(
        // Inputs
        .D   ( PWM_1_PWM_0 ),
        .E   ( VCC_net ),
        // Outputs
        .Y   (  ),
        // Inouts
        .PAD ( P9_14 ) 
        );

//--------BIBUF
BIBUF P9_16_BIBUF(
        // Inputs
        .D   ( PWM_1_PWM_1 ),
        .E   ( VCC_net ),
        // Outputs
        .Y   (  ),
        // Inouts
        .PAD ( P9_16 ) 
        );

//--------P9_GPIO
P9_GPIO P9_GPIO_0(
        // Inputs
        .APB_bif_PENABLE ( CoreAPB3_CAPE_0_APBmslave0_PENABLE ),
        .APB_bif_PSEL    ( CoreAPB3_CAPE_0_APBmslave2_PSELx ),
        .APB_bif_PWRITE  ( CoreAPB3_CAPE_0_APBmslave0_PWRITE ),
        .PCLK            ( PCLK ),
        .PRESETN         ( PRESETN ),
        .APB_bif_PADDR   ( CoreAPB3_CAPE_0_APBmslave0_PADDR_2 ),
        .APB_bif_PWDATA  ( CoreAPB3_CAPE_0_APBmslave0_PWDATA ),
        // Outputs
        .APB_bif_PREADY  ( CoreAPB3_CAPE_0_APBmslave2_PREADY ),
        .APB_bif_PSLVERR ( CoreAPB3_CAPE_0_APBmslave2_PSLVERR ),
        .APB_bif_PRDATA  ( CoreAPB3_CAPE_0_APBmslave2_PRDATA ),
        .INT             ( INT_0 ),
        // Inouts
        .GPIO_10_PAD     ( P9_PIN23 ),
        .GPIO_12_PAD     ( P9_PIN25 ),
        .GPIO_14_PAD     ( P9_PIN27 ),
        .GPIO_17_PAD     ( P9_PIN30 ),
        .GPIO_19_PAD     ( P9_PIN41 ),
        .GPIO_1_PAD      ( P9_PIN12 ),
        .GPIO_4_PAD      ( P9_PIN15 ) 
        );

//--------CAPE_PWM
CAPE_PWM PWM_0(
        // Inputs
        .APBslave_PENABLE ( CoreAPB3_CAPE_0_APBmslave0_PENABLE ),
        .APBslave_PSEL    ( CoreAPB3_CAPE_0_APBmslave0_PSELx ),
        .APBslave_PWRITE  ( CoreAPB3_CAPE_0_APBmslave0_PWRITE ),
        .PCLK             ( PCLK ),
        .PRESETN          ( PRESETN ),
        .APBslave_PADDR   ( CoreAPB3_CAPE_0_APBmslave0_PADDR_0 ),
        .APBslave_PWDATA  ( CoreAPB3_CAPE_0_APBmslave0_PWDATA ),
        // Outputs
        .APBslave_PREADY  ( CoreAPB3_CAPE_0_APBmslave0_PREADY ),
        .APBslave_PSLVERR ( CoreAPB3_CAPE_0_APBmslave0_PSLVERR ),
        .PWM_0            ( P9_PIN42_net_0 ),
        .PWM_1            (  ),
        .APBslave_PRDATA  ( CoreAPB3_CAPE_0_APBmslave0_PRDATA ) 
        );

//--------CAPE_PWM
CAPE_PWM PWM_1(
        // Inputs
        .APBslave_PENABLE ( CoreAPB3_CAPE_0_APBmslave0_PENABLE ),
        .APBslave_PSEL    ( CoreAPB3_CAPE_0_APBmslave4_PSELx ),
        .APBslave_PWRITE  ( CoreAPB3_CAPE_0_APBmslave0_PWRITE ),
        .PCLK             ( PCLK ),
        .PRESETN          ( PRESETN ),
        .APBslave_PADDR   ( CoreAPB3_CAPE_0_APBmslave0_PADDR_3 ),
        .APBslave_PWDATA  ( CoreAPB3_CAPE_0_APBmslave0_PWDATA ),
        // Outputs
        .APBslave_PREADY  ( CoreAPB3_CAPE_0_APBmslave4_PREADY ),
        .APBslave_PSLVERR ( CoreAPB3_CAPE_0_APBmslave4_PSLVERR ),
        .PWM_0            ( PWM_1_PWM_0 ),
        .PWM_1            ( PWM_1_PWM_1 ),
        .APBslave_PRDATA  ( CoreAPB3_CAPE_0_APBmslave4_PRDATA ) 
        );

//--------CAPE_PWM
CAPE_PWM PWM_2(
        // Inputs
        .APBslave_PENABLE ( CoreAPB3_CAPE_0_APBmslave0_PENABLE ),
        .APBslave_PSEL    ( CoreAPB3_CAPE_0_APBmslave5_PSELx ),
        .APBslave_PWRITE  ( CoreAPB3_CAPE_0_APBmslave0_PWRITE ),
        .PCLK             ( PCLK ),
        .PRESETN          ( PRESETN ),
        .APBslave_PADDR   ( CoreAPB3_CAPE_0_APBmslave0_PADDR_4 ),
        .APBslave_PWDATA  ( CoreAPB3_CAPE_0_APBmslave0_PWDATA ),
        // Outputs
        .APBslave_PREADY  ( CoreAPB3_CAPE_0_APBmslave5_PREADY ),
        .APBslave_PSLVERR ( CoreAPB3_CAPE_0_APBmslave5_PSLVERR ),
        .PWM_0            ( PWM_2_PWM_0 ),
        .PWM_1            ( PWM_2_PWM_1 ),
        .APBslave_PRDATA  ( CoreAPB3_CAPE_0_APBmslave5_PRDATA ) 
        );

//--------CAPE_AXI_XBAR
CAPE_AXI_XBAR XBAR_0(
        // Inputs
        .ACLK                ( AXI_ACLK ),
        .ARESETN             ( AXI_ARESETN ),
        .TARGET0_AWREADY     ( ms_awready ),
        .TARGET0_WREADY      ( ms_wready ),
        .TARGET0_BID         ( TARGET0_BID_const_net_0 ), // tied to 2'h0 from definition
        .TARGET0_BRESP       ( ms_bresp ),
        .TARGET0_BVALID      ( ms_bvalid ),
        .TARGET0_ARREADY     ( ms_arready ),
        .TARGET0_RID         ( TARGET0_RID_const_net_0 ), // tied to 2'h0 from definition
        .TARGET0_RDATA       ( ms_rdata ),
        .TARGET0_RRESP       ( ms_rresp ),
        .TARGET0_RLAST       ( GND_net ), // tied to 1'b0 from definition
        .TARGET0_RVALID      ( ms_rvalid ),
        .TARGET0_BUSER       ( GND_net ), // tied to 1'b0 from definition
        .TARGET0_RUSER       ( GND_net ), // tied to 1'b0 from definition
        .TARGET1_AWREADY     ( GND_net ), // tied to 1'b0 from definition
        .TARGET1_WREADY      ( GND_net ), // tied to 1'b0 from definition
        .TARGET1_BID         ( TARGET1_BID_const_net_0 ), // tied to 2'h0 from definition
        .TARGET1_BRESP       ( TARGET1_BRESP_const_net_0 ), // tied to 2'h0 from definition
        .TARGET1_BVALID      ( GND_net ), // tied to 1'b0 from definition
        .TARGET1_ARREADY     ( GND_net ), // tied to 1'b0 from definition
        .TARGET1_RID         ( TARGET1_RID_const_net_0 ), // tied to 2'h0 from definition
        .TARGET1_RDATA       ( TARGET1_RDATA_const_net_0 ), // tied to 64'h0000000000000000 from definition
        .TARGET1_RRESP       ( TARGET1_RRESP_const_net_0 ), // tied to 2'h0 from definition
        .TARGET1_RLAST       ( GND_net ), // tied to 1'b0 from definition
        .TARGET1_RVALID      ( GND_net ), // tied to 1'b0 from definition
        .TARGET1_BUSER       ( GND_net ), // tied to 1'b0 from definition
        .TARGET1_RUSER       ( GND_net ), // tied to 1'b0 from definition
        .INITIATOR0_AWID     ( cape_regs_0_AXI4_INITIATOR_AWID_0 ),
        .INITIATOR0_AWADDR   ( cape_regs_0_AXI4_INITIATOR_AWADDR_0 ),
        .INITIATOR0_AWLEN    ( INITIATOR0_AWLEN_const_net_0 ), // tied to 8'h00 from definition
        .INITIATOR0_AWSIZE   ( INITIATOR0_AWSIZE_const_net_0 ), // tied to 3'h0 from definition
        .INITIATOR0_AWBURST  ( INITIATOR0_AWBURST_const_net_0 ), // tied to 2'h3 from definition
        .INITIATOR0_AWLOCK   ( GND_net ), // tied to 1'b0 from definition
        .INITIATOR0_AWCACHE  ( INITIATOR0_AWCACHE_const_net_0 ), // tied to 4'h0 from definition
        .INITIATOR0_AWPROT   ( INITIATOR0_AWPROT_const_net_0 ), // tied to 3'h0 from definition
        .INITIATOR0_AWQOS    ( INITIATOR0_AWQOS_const_net_0 ), // tied to 4'h0 from definition
        .INITIATOR0_AWREGION ( INITIATOR0_AWREGION_const_net_0 ), // tied to 4'h0 from definition
        .INITIATOR0_AWVALID  ( cape_regs_0_AXI4_INITIATOR_AWVALID ),
        .INITIATOR0_WDATA    ( cape_regs_0_AXI4_INITIATOR_WDATA ),
        .INITIATOR0_WSTRB    ( cape_regs_0_AXI4_INITIATOR_WSTRB ),
        .INITIATOR0_WLAST    ( GND_net ), // tied to 1'b0 from definition
        .INITIATOR0_WVALID   ( cape_regs_0_AXI4_INITIATOR_WVALID ),
        .INITIATOR0_BREADY   ( cape_regs_0_AXI4_INITIATOR_BREADY ),
        .INITIATOR0_ARID     ( cape_regs_0_AXI4_INITIATOR_ARID_0 ),
        .INITIATOR0_ARADDR   ( cape_regs_0_AXI4_INITIATOR_ARADDR_0 ),
        .INITIATOR0_ARLEN    ( INITIATOR0_ARLEN_const_net_0 ), // tied to 8'h00 from definition
        .INITIATOR0_ARSIZE   ( INITIATOR0_ARSIZE_const_net_0 ), // tied to 3'h0 from definition
        .INITIATOR0_ARBURST  ( INITIATOR0_ARBURST_const_net_0 ), // tied to 2'h3 from definition
        .INITIATOR0_ARLOCK   ( GND_net ), // tied to 1'b0 from definition
        .INITIATOR0_ARCACHE  ( INITIATOR0_ARCACHE_const_net_0 ), // tied to 4'h0 from definition
        .INITIATOR0_ARPROT   ( INITIATOR0_ARPROT_const_net_0 ), // tied to 3'h0 from definition
        .INITIATOR0_ARQOS    ( INITIATOR0_ARQOS_const_net_0 ), // tied to 4'h0 from definition
        .INITIATOR0_ARREGION ( INITIATOR0_ARREGION_const_net_0 ), // tied to 4'h0 from definition
        .INITIATOR0_ARVALID  ( cape_regs_0_AXI4_INITIATOR_ARVALID ),
        .INITIATOR0_RREADY   ( cape_regs_0_AXI4_INITIATOR_RREADY ),
        .INITIATOR0_AWUSER   ( GND_net ), // tied to 1'b0 from definition
        .INITIATOR0_WUSER    ( GND_net ), // tied to 1'b0 from definition
        .INITIATOR0_ARUSER   ( GND_net ), // tied to 1'b0 from definition
        .INITIATOR1_AWID     ( GND_net ), // tied to 1'b0 from definition
        .INITIATOR1_AWADDR   ( INITIATOR1_AWADDR_const_net_0 ), // tied to 32'h00000000 from definition
        .INITIATOR1_AWLEN    ( INITIATOR1_AWLEN_const_net_0 ), // tied to 8'h00 from definition
        .INITIATOR1_AWSIZE   ( INITIATOR1_AWSIZE_const_net_0 ), // tied to 3'h0 from definition
        .INITIATOR1_AWBURST  ( INITIATOR1_AWBURST_const_net_0 ), // tied to 2'h3 from definition
        .INITIATOR1_AWLOCK   ( GND_net ), // tied to 1'b0 from definition
        .INITIATOR1_AWCACHE  ( INITIATOR1_AWCACHE_const_net_0 ), // tied to 4'h0 from definition
        .INITIATOR1_AWPROT   ( INITIATOR1_AWPROT_const_net_0 ), // tied to 3'h0 from definition
        .INITIATOR1_AWQOS    ( INITIATOR1_AWQOS_const_net_0 ), // tied to 4'h0 from definition
        .INITIATOR1_AWREGION ( INITIATOR1_AWREGION_const_net_0 ), // tied to 4'h0 from definition
        .INITIATOR1_AWVALID  ( GND_net ), // tied to 1'b0 from definition
        .INITIATOR1_WDATA    ( INITIATOR1_WDATA_const_net_0 ), // tied to 64'h0000000000000000 from definition
        .INITIATOR1_WSTRB    ( INITIATOR1_WSTRB_const_net_0 ), // tied to 8'hFF from definition
        .INITIATOR1_WLAST    ( GND_net ), // tied to 1'b0 from definition
        .INITIATOR1_WVALID   ( GND_net ), // tied to 1'b0 from definition
        .INITIATOR1_BREADY   ( GND_net ), // tied to 1'b0 from definition
        .INITIATOR1_ARID     ( GND_net ), // tied to 1'b0 from definition
        .INITIATOR1_ARADDR   ( INITIATOR1_ARADDR_const_net_0 ), // tied to 32'h00000000 from definition
        .INITIATOR1_ARLEN    ( INITIATOR1_ARLEN_const_net_0 ), // tied to 8'h00 from definition
        .INITIATOR1_ARSIZE   ( INITIATOR1_ARSIZE_const_net_0 ), // tied to 3'h0 from definition
        .INITIATOR1_ARBURST  ( INITIATOR1_ARBURST_const_net_0 ), // tied to 2'h3 from definition
        .INITIATOR1_ARLOCK   ( GND_net ), // tied to 1'b0 from definition
        .INITIATOR1_ARCACHE  ( INITIATOR1_ARCACHE_const_net_0 ), // tied to 4'h0 from definition
        .INITIATOR1_ARPROT   ( INITIATOR1_ARPROT_const_net_0 ), // tied to 3'h0 from definition
        .INITIATOR1_ARQOS    ( INITIATOR1_ARQOS_const_net_0 ), // tied to 4'h0 from definition
        .INITIATOR1_ARREGION ( INITIATOR1_ARREGION_const_net_0 ), // tied to 4'h0 from definition
        .INITIATOR1_ARVALID  ( GND_net ), // tied to 1'b0 from definition
        .INITIATOR1_RREADY   ( GND_net ), // tied to 1'b0 from definition
        .INITIATOR1_AWUSER   ( GND_net ), // tied to 1'b0 from definition
        .INITIATOR1_WUSER    ( GND_net ), // tied to 1'b0 from definition
        .INITIATOR1_ARUSER   ( GND_net ), // tied to 1'b0 from definition
        // Outputs
        .TARGET0_AWID        ( ms_awid ),
        .TARGET0_AWADDR      ( AXI4mtarget0_AWADDR ),
        .TARGET0_AWLEN       ( AXI4mtarget0_AWLEN ),
        .TARGET0_AWSIZE      ( AXI4mtarget0_AWSIZE ),
        .TARGET0_AWBURST     ( AXI4mtarget0_AWBURST ),
        .TARGET0_AWLOCK      ( AXI4mtarget0_AWLOCK ),
        .TARGET0_AWCACHE     ( AXI4mtarget0_AWCACHE ),
        .TARGET0_AWPROT      ( AXI4mtarget0_AWPROT ),
        .TARGET0_AWQOS       ( AXI4mtarget0_AWQOS ),
        .TARGET0_AWREGION    ( AXI4mtarget0_AWREGION ),
        .TARGET0_AWVALID     ( AXI4mtarget0_AWVALID ),
        .TARGET0_WDATA       ( AXI4mtarget0_WDATA ),
        .TARGET0_WSTRB       ( AXI4mtarget0_WSTRB ),
        .TARGET0_WLAST       ( AXI4mtarget0_WLAST ),
        .TARGET0_WVALID      ( AXI4mtarget0_WVALID ),
        .TARGET0_BREADY      ( AXI4mtarget0_BREADY ),
        .TARGET0_ARID        ( ms_arid ),
        .TARGET0_ARADDR      ( AXI4mtarget0_ARADDR ),
        .TARGET0_ARLEN       ( AXI4mtarget0_ARLEN ),
        .TARGET0_ARSIZE      ( AXI4mtarget0_ARSIZE ),
        .TARGET0_ARBURST     ( AXI4mtarget0_ARBURST ),
        .TARGET0_ARLOCK      ( AXI4mtarget0_ARLOCK ),
        .TARGET0_ARCACHE     ( AXI4mtarget0_ARCACHE ),
        .TARGET0_ARPROT      ( AXI4mtarget0_ARPROT ),
        .TARGET0_ARQOS       ( AXI4mtarget0_ARQOS ),
        .TARGET0_ARREGION    ( AXI4mtarget0_ARREGION ),
        .TARGET0_ARVALID     ( AXI4mtarget0_ARVALID ),
        .TARGET0_RREADY      ( AXI4mtarget0_RREADY ),
        .TARGET0_AWUSER      ( AXI4mtarget0_AWUSER ),
        .TARGET0_WUSER       ( AXI4mtarget0_WUSER ),
        .TARGET0_ARUSER      ( AXI4mtarget0_ARUSER ),
        .TARGET1_AWID        (  ),
        .TARGET1_AWADDR      (  ),
        .TARGET1_AWLEN       (  ),
        .TARGET1_AWSIZE      (  ),
        .TARGET1_AWBURST     (  ),
        .TARGET1_AWLOCK      (  ),
        .TARGET1_AWCACHE     (  ),
        .TARGET1_AWPROT      (  ),
        .TARGET1_AWQOS       (  ),
        .TARGET1_AWREGION    (  ),
        .TARGET1_AWVALID     (  ),
        .TARGET1_WDATA       (  ),
        .TARGET1_WSTRB       (  ),
        .TARGET1_WLAST       (  ),
        .TARGET1_WVALID      (  ),
        .TARGET1_BREADY      (  ),
        .TARGET1_ARID        (  ),
        .TARGET1_ARADDR      (  ),
        .TARGET1_ARLEN       (  ),
        .TARGET1_ARSIZE      (  ),
        .TARGET1_ARBURST     (  ),
        .TARGET1_ARLOCK      (  ),
        .TARGET1_ARCACHE     (  ),
        .TARGET1_ARPROT      (  ),
        .TARGET1_ARQOS       (  ),
        .TARGET1_ARREGION    (  ),
        .TARGET1_ARVALID     (  ),
        .TARGET1_RREADY      (  ),
        .TARGET1_AWUSER      (  ),
        .TARGET1_WUSER       (  ),
        .TARGET1_ARUSER      (  ),
        .INITIATOR0_AWREADY  ( cape_regs_0_AXI4_INITIATOR_AWREADY ),
        .INITIATOR0_WREADY   ( cape_regs_0_AXI4_INITIATOR_WREADY ),
        .INITIATOR0_BID      ( cape_regs_0_AXI4_INITIATOR_BID ),
        .INITIATOR0_BRESP    ( cape_regs_0_AXI4_INITIATOR_BRESP ),
        .INITIATOR0_BVALID   ( cape_regs_0_AXI4_INITIATOR_BVALID ),
        .INITIATOR0_ARREADY  ( cape_regs_0_AXI4_INITIATOR_ARREADY ),
        .INITIATOR0_RID      ( cape_regs_0_AXI4_INITIATOR_RID ),
        .INITIATOR0_RDATA    ( cape_regs_0_AXI4_INITIATOR_RDATA ),
        .INITIATOR0_RRESP    ( cape_regs_0_AXI4_INITIATOR_RRESP ),
        .INITIATOR0_RLAST    ( cape_regs_0_AXI4_INITIATOR_RLAST ),
        .INITIATOR0_RVALID   ( cape_regs_0_AXI4_INITIATOR_RVALID ),
        .INITIATOR0_BUSER    ( cape_regs_0_AXI4_INITIATOR_BUSER ),
        .INITIATOR0_RUSER    ( cape_regs_0_AXI4_INITIATOR_RUSER ),
        .INITIATOR1_AWREADY  (  ),
        .INITIATOR1_WREADY   (  ),
        .INITIATOR1_BID      (  ),
        .INITIATOR1_BRESP    (  ),
        .INITIATOR1_BVALID   (  ),
        .INITIATOR1_ARREADY  (  ),
        .INITIATOR1_RID      (  ),
        .INITIATOR1_RDATA    (  ),
        .INITIATOR1_RRESP    (  ),
        .INITIATOR1_RLAST    (  ),
        .INITIATOR1_RVALID   (  ),
        .INITIATOR1_BUSER    (  ),
        .INITIATOR1_RUSER    (  ) 
        );


endmodule
