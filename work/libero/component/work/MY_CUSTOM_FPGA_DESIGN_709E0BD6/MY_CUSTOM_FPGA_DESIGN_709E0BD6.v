//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Sat Jul 11 00:48:41 2026
// Version: 2025.1 2025.1.0.14
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// MY_CUSTOM_FPGA_DESIGN_709E0BD6
module MY_CUSTOM_FPGA_DESIGN_709E0BD6(
    // Inputs
    ADC_IRQn,
    EMMC_STRB,
    PHY_INTn,
    REFCLK,
    REFCLK_N,
    SD_DET,
    SGMII_RX0_N,
    SGMII_RX0_P,
    SGMII_RX1_N,
    SGMII_RX1_P,
    UART0_RXD,
    USB0_CLK,
    USB0_DIR,
    USB0_NXT,
    USB0_OCn,
    USER_BUTTON,
    // Outputs
    ADC_CSn,
    ADC_MCLK,
    ADC_SCK,
    CA,
    CK,
    CKE,
    CK_N,
    CS,
    DM,
    EMMC_CLK,
    EMMC_RSTN,
    M2_W_DISABLE1,
    M2_W_DISABLE2,
    ODT,
    P9_42,
    PHY_MDC,
    PHY_RSTn,
    RESET_N,
    SD_CARD_CS,
    SGMII_TX0_N,
    SGMII_TX0_P,
    SGMII_TX1_N,
    SGMII_TX1_P,
    UART0_TXD,
    USB0_RESETB,
    USB0_STP,
    VIO_ENABLE,
    // Inouts
    ADC_MISO,
    ADC_MOSI,
    DQ,
    DQS,
    DQS_N,
    EMMC_CMD,
    EMMC_DATA,
    I2C_1_SCL,
    I2C_1_SDA,
    P8,
    P9,
    P9_41,
    PHY_MDIO,
    USB0_DATA
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input          ADC_IRQn;
input          EMMC_STRB;
input          PHY_INTn;
input          REFCLK;
input          REFCLK_N;
input          SD_DET;
input          SGMII_RX0_N;
input          SGMII_RX0_P;
input          SGMII_RX1_N;
input          SGMII_RX1_P;
input          UART0_RXD;
input          USB0_CLK;
input          USB0_DIR;
input          USB0_NXT;
input          USB0_OCn;
input          USER_BUTTON;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output         ADC_CSn;
output         ADC_MCLK;
output         ADC_SCK;
output [5:0]   CA;
output         CK;
output         CKE;
output         CK_N;
output         CS;
output [3:0]   DM;
output         EMMC_CLK;
output         EMMC_RSTN;
output         M2_W_DISABLE1;
output         M2_W_DISABLE2;
output         ODT;
output         P9_42;
output         PHY_MDC;
output         PHY_RSTn;
output         RESET_N;
output         SD_CARD_CS;
output         SGMII_TX0_N;
output         SGMII_TX0_P;
output         SGMII_TX1_N;
output         SGMII_TX1_P;
output         UART0_TXD;
output         USB0_RESETB;
output         USB0_STP;
output         VIO_ENABLE;
//--------------------------------------------------------------------
// Inout
//--------------------------------------------------------------------
inout          ADC_MISO;
inout          ADC_MOSI;
inout  [31:0]  DQ;
inout  [3:0]   DQS;
inout  [3:0]   DQS_N;
inout          EMMC_CMD;
inout  [7:0]   EMMC_DATA;
inout          I2C_1_SCL;
inout          I2C_1_SDA;
inout  [46:3]  P8;
inout  [31:11] P9;
inout          P9_41;
inout          PHY_MDIO;
inout  [7:0]   USB0_DATA;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire          ADC_CSn_net_0;
wire          ADC_IRQn;
wire          ADC_MCLK_net_0;
wire          ADC_MISO;
wire          ADC_MOSI;
wire          ADC_SCK_net_0;
wire   [31:0] BVF_RISCV_SUBSYSTEM_CAPE_APB_MTARGET_PADDR;
wire          BVF_RISCV_SUBSYSTEM_CAPE_APB_MTARGET_PENABLE;
wire   [31:0] BVF_RISCV_SUBSYSTEM_CAPE_APB_MTARGET_PRDATA;
wire          BVF_RISCV_SUBSYSTEM_CAPE_APB_MTARGET_PREADY;
wire          BVF_RISCV_SUBSYSTEM_CAPE_APB_MTARGET_PSELx;
wire          BVF_RISCV_SUBSYSTEM_CAPE_APB_MTARGET_PSLVERR;
wire   [31:0] BVF_RISCV_SUBSYSTEM_CAPE_APB_MTARGET_PWDATA;
wire          BVF_RISCV_SUBSYSTEM_CAPE_APB_MTARGET_PWRITE;
wire   [27:0] BVF_RISCV_SUBSYSTEM_GPIO_2_M2F;
wire   [27:0] BVF_RISCV_SUBSYSTEM_GPIO_2_OE_M2F;
wire          BVF_RISCV_SUBSYSTEM_MSS_DLL_LOCKS;
wire          BVF_RISCV_SUBSYSTEM_MSS_RESET_N_M2F;
wire   [5:0]  CA_net_0;
wire          CAPE_AXI4mtarget0_ACLK;
wire   [37:0] CAPE_AXI4mtarget0_ARADDR;
wire          CAPE_AXI4mtarget0_ARESETN;
wire          CAPE_AXI4mtarget0_ARREADY;
wire          CAPE_AXI4mtarget0_ARVALID;
wire   [37:0] CAPE_AXI4mtarget0_AWADDR;
wire          CAPE_AXI4mtarget0_AWREADY;
wire          CAPE_AXI4mtarget0_AWVALID;
wire   [3:0]  CAPE_AXI4mtarget0_BID;
wire          CAPE_AXI4mtarget0_BREADY;
wire   [1:0]  CAPE_AXI4mtarget0_BRESP;
wire          CAPE_AXI4mtarget0_BVALID;
wire   [63:0] CAPE_AXI4mtarget0_RDATA;
wire   [3:0]  CAPE_AXI4mtarget0_RID;
wire          CAPE_AXI4mtarget0_RLAST;
wire          CAPE_AXI4mtarget0_RREADY;
wire   [1:0]  CAPE_AXI4mtarget0_RRESP;
wire          CAPE_AXI4mtarget0_RVALID;
wire   [63:0] CAPE_AXI4mtarget0_WDATA;
wire          CAPE_AXI4mtarget0_WREADY;
wire   [7:0]  CAPE_AXI4mtarget0_WSTRB;
wire          CAPE_AXI4mtarget0_WVALID;
wire   [27:0] CAPE_GPIO_IN;
wire   [39:0] CAPE_INT;
wire          CK_net_0;
wire          CK_N_net_0;
wire          CKE_net_0;
wire          CLOCKS_AND_RESETS_FIC_0_ACLK;
wire          CLOCKS_AND_RESETS_FIC_1_ACLK;
wire          CLOCKS_AND_RESETS_FIC_2_ACLK;
wire          CLOCKS_AND_RESETS_FIC_3_FABRIC_RESET_N;
wire          CLOCKS_AND_RESETS_FIC_3_PCLK;
wire          CS_net_0;
wire   [3:0]  DM_net_0;
wire   [31:0] DQ;
wire   [3:0]  DQS;
wire   [3:0]  DQS_N;
wire          EMMC_CLK_net_0;
wire          EMMC_CMD;
wire   [7:0]  EMMC_DATA;
wire          EMMC_RSTN_net_0;
wire          EMMC_STRB;
wire          I2C_1_SCL;
wire          I2C_1_SDA;
wire          ODT_net_0;
wire   [46:3] P8;
wire          P9_41;
wire          P9_42_net_0;
wire          PHY_INTn;
wire          PHY_MDC_net_0;
wire          PHY_MDIO;
wire          REFCLK;
wire          REFCLK_N;
wire          RESET_N_net_0;
wire          SD_CARD_CS_net_0;
wire          SD_DET;
wire          SGMII_RX0_N;
wire          SGMII_RX0_P;
wire          SGMII_RX1_N;
wire          SGMII_RX1_P;
wire          SGMII_TX0_N_net_0;
wire          SGMII_TX0_P_net_0;
wire          SGMII_TX1_N_net_0;
wire          SGMII_TX1_P_net_0;
wire          UART0_RXD;
wire          UART0_TXD_net_0;
wire          USB0_CLK;
wire   [7:0]  USB0_DATA;
wire          USB0_DIR;
wire          USB0_NXT;
wire          USB0_OCn;
wire          USB0_RESETB_net_0;
wire          USB0_STP_net_0;
wire          USER_BUTTON;
wire          VIO_ENABLE_net_0;
wire          USB0_STP_net_1;
wire          EMMC_CLK_net_1;
wire          EMMC_RSTN_net_1;
wire          UART0_TXD_net_1;
wire          USB0_RESETB_net_1;
wire          SGMII_TX0_P_net_1;
wire          SGMII_TX0_N_net_1;
wire          SGMII_TX1_P_net_1;
wire          SGMII_TX1_N_net_1;
wire          ADC_MCLK_net_1;
wire          USB0_RESETB_net_2;
wire          PHY_MDC_net_1;
wire          SD_CARD_CS_net_1;
wire          ADC_SCK_net_1;
wire          ADC_CSn_net_1;
wire          VIO_ENABLE_net_1;
wire   [5:0]  CA_net_1;
wire   [3:0]  DM_net_1;
wire          RESET_N_net_1;
wire          ODT_net_1;
wire          CKE_net_1;
wire          CS_net_1;
wire          CK_net_1;
wire          CK_N_net_1;
wire          P9_42_net_1;
wire   [58:3] MSS_INT_F2M_net_0;
//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire          GND_net;
wire   [58:48]MSS_INT_F2M_const_net_0;
wire   [7:3]  MSS_INT_F2M_const_net_1;
wire          VCC_net;
wire   [3:0]  FIC_2_AXI4_TARGET_FIC_2_AXI4_S_AWID_const_net_0;
wire   [37:0] FIC_2_AXI4_TARGET_FIC_2_AXI4_S_AWADDR_const_net_0;
wire   [7:0]  FIC_2_AXI4_TARGET_FIC_2_AXI4_S_AWLEN_const_net_0;
wire   [2:0]  FIC_2_AXI4_TARGET_FIC_2_AXI4_S_AWSIZE_const_net_0;
wire   [1:0]  FIC_2_AXI4_TARGET_FIC_2_AXI4_S_AWBURST_const_net_0;
wire   [3:0]  FIC_2_AXI4_TARGET_FIC_2_AXI4_S_AWCACHE_const_net_0;
wire   [2:0]  FIC_2_AXI4_TARGET_FIC_2_AXI4_S_AWPROT_const_net_0;
wire   [3:0]  FIC_2_AXI4_TARGET_FIC_2_AXI4_S_AWQOS_const_net_0;
wire   [63:0] FIC_2_AXI4_TARGET_FIC_2_AXI4_S_WDATA_const_net_0;
wire   [7:0]  FIC_2_AXI4_TARGET_FIC_2_AXI4_S_WSTRB_const_net_0;
wire   [3:0]  FIC_2_AXI4_TARGET_FIC_2_AXI4_S_ARID_const_net_0;
wire   [37:0] FIC_2_AXI4_TARGET_FIC_2_AXI4_S_ARADDR_const_net_0;
wire   [7:0]  FIC_2_AXI4_TARGET_FIC_2_AXI4_S_ARLEN_const_net_0;
wire   [2:0]  FIC_2_AXI4_TARGET_FIC_2_AXI4_S_ARSIZE_const_net_0;
wire   [1:0]  FIC_2_AXI4_TARGET_FIC_2_AXI4_S_ARBURST_const_net_0;
wire   [3:0]  FIC_2_AXI4_TARGET_FIC_2_AXI4_S_ARCACHE_const_net_0;
wire   [2:0]  FIC_2_AXI4_TARGET_FIC_2_AXI4_S_ARPROT_const_net_0;
wire   [3:0]  FIC_2_AXI4_TARGET_FIC_2_AXI4_S_ARQOS_const_net_0;
wire   [3:0]  FIC_1_AXI4_TARGET_FIC_1_AXI4_S_AWID_const_net_0;
wire   [37:0] FIC_1_AXI4_TARGET_FIC_1_AXI4_S_AWADDR_const_net_0;
wire   [7:0]  FIC_1_AXI4_TARGET_FIC_1_AXI4_S_AWLEN_const_net_0;
wire   [2:0]  FIC_1_AXI4_TARGET_FIC_1_AXI4_S_AWSIZE_const_net_0;
wire   [1:0]  FIC_1_AXI4_TARGET_FIC_1_AXI4_S_AWBURST_const_net_0;
wire   [3:0]  FIC_1_AXI4_TARGET_FIC_1_AXI4_S_AWCACHE_const_net_0;
wire   [2:0]  FIC_1_AXI4_TARGET_FIC_1_AXI4_S_AWPROT_const_net_0;
wire   [3:0]  FIC_1_AXI4_TARGET_FIC_1_AXI4_S_AWQOS_const_net_0;
wire   [63:0] FIC_1_AXI4_TARGET_FIC_1_AXI4_S_WDATA_const_net_0;
wire   [7:0]  FIC_1_AXI4_TARGET_FIC_1_AXI4_S_WSTRB_const_net_0;
wire   [3:0]  FIC_1_AXI4_TARGET_FIC_1_AXI4_S_ARID_const_net_0;
wire   [37:0] FIC_1_AXI4_TARGET_FIC_1_AXI4_S_ARADDR_const_net_0;
wire   [7:0]  FIC_1_AXI4_TARGET_FIC_1_AXI4_S_ARLEN_const_net_0;
wire   [2:0]  FIC_1_AXI4_TARGET_FIC_1_AXI4_S_ARSIZE_const_net_0;
wire   [1:0]  FIC_1_AXI4_TARGET_FIC_1_AXI4_S_ARBURST_const_net_0;
wire   [3:0]  FIC_1_AXI4_TARGET_FIC_1_AXI4_S_ARCACHE_const_net_0;
wire   [2:0]  FIC_1_AXI4_TARGET_FIC_1_AXI4_S_ARPROT_const_net_0;
wire   [3:0]  FIC_1_AXI4_TARGET_FIC_1_AXI4_S_ARQOS_const_net_0;
wire   [3:0]  FIC_0_AXI4_TARGET_FIC_0_AXI4_S_AWID_const_net_0;
wire   [7:0]  FIC_0_AXI4_TARGET_FIC_0_AXI4_S_AWLEN_const_net_0;
wire   [2:0]  FIC_0_AXI4_TARGET_FIC_0_AXI4_S_AWSIZE_const_net_0;
wire   [1:0]  FIC_0_AXI4_TARGET_FIC_0_AXI4_S_AWBURST_const_net_0;
wire   [3:0]  FIC_0_AXI4_TARGET_FIC_0_AXI4_S_AWCACHE_const_net_0;
wire   [2:0]  FIC_0_AXI4_TARGET_FIC_0_AXI4_S_AWPROT_const_net_0;
wire   [3:0]  FIC_0_AXI4_TARGET_FIC_0_AXI4_S_AWQOS_const_net_0;
wire   [3:0]  FIC_0_AXI4_TARGET_FIC_0_AXI4_S_ARID_const_net_0;
wire   [7:0]  FIC_0_AXI4_TARGET_FIC_0_AXI4_S_ARLEN_const_net_0;
wire   [2:0]  FIC_0_AXI4_TARGET_FIC_0_AXI4_S_ARSIZE_const_net_0;
wire   [1:0]  FIC_0_AXI4_TARGET_FIC_0_AXI4_S_ARBURST_const_net_0;
wire   [3:0]  FIC_0_AXI4_TARGET_FIC_0_AXI4_S_ARCACHE_const_net_0;
wire   [2:0]  FIC_0_AXI4_TARGET_FIC_0_AXI4_S_ARPROT_const_net_0;
wire   [3:0]  FIC_0_AXI4_TARGET_FIC_0_AXI4_S_ARQOS_const_net_0;
wire   [31:0] M2_APB_MTARGET_PRDATAS16_const_net_0;
wire   [7:0]  FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_BID_const_net_0;
wire   [1:0]  FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_BRESP_const_net_0;
wire   [7:0]  FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_RID_const_net_0;
wire   [63:0] FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_RDATA_const_net_0;
wire   [1:0]  FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_RRESP_const_net_0;
wire   [7:0]  FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_BID_const_net_0;
wire   [1:0]  FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_BRESP_const_net_0;
wire   [7:0]  FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_RID_const_net_0;
wire   [63:0] FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_RDATA_const_net_0;
wire   [1:0]  FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_RRESP_const_net_0;
wire   [3:0]  ms_arid_const_net_0;
wire   [3:0]  ms_awid_const_net_0;
//--------------------------------------------------------------------
// Constant assignments
//--------------------------------------------------------------------
assign GND_net                                             = 1'b0;
assign MSS_INT_F2M_const_net_0                             = 11'h000;
assign MSS_INT_F2M_const_net_1                             = 5'h00;
assign VCC_net                                             = 1'b1;
assign FIC_2_AXI4_TARGET_FIC_2_AXI4_S_AWID_const_net_0     = 4'h0;
assign FIC_2_AXI4_TARGET_FIC_2_AXI4_S_AWADDR_const_net_0   = 38'h0000000000;
assign FIC_2_AXI4_TARGET_FIC_2_AXI4_S_AWLEN_const_net_0    = 8'h00;
assign FIC_2_AXI4_TARGET_FIC_2_AXI4_S_AWSIZE_const_net_0   = 3'h0;
assign FIC_2_AXI4_TARGET_FIC_2_AXI4_S_AWBURST_const_net_0  = 2'h3;
assign FIC_2_AXI4_TARGET_FIC_2_AXI4_S_AWCACHE_const_net_0  = 4'h0;
assign FIC_2_AXI4_TARGET_FIC_2_AXI4_S_AWPROT_const_net_0   = 3'h0;
assign FIC_2_AXI4_TARGET_FIC_2_AXI4_S_AWQOS_const_net_0    = 4'h0;
assign FIC_2_AXI4_TARGET_FIC_2_AXI4_S_WDATA_const_net_0    = 64'h0000000000000000;
assign FIC_2_AXI4_TARGET_FIC_2_AXI4_S_WSTRB_const_net_0    = 8'hFF;
assign FIC_2_AXI4_TARGET_FIC_2_AXI4_S_ARID_const_net_0     = 4'h0;
assign FIC_2_AXI4_TARGET_FIC_2_AXI4_S_ARADDR_const_net_0   = 38'h0000000000;
assign FIC_2_AXI4_TARGET_FIC_2_AXI4_S_ARLEN_const_net_0    = 8'h00;
assign FIC_2_AXI4_TARGET_FIC_2_AXI4_S_ARSIZE_const_net_0   = 3'h0;
assign FIC_2_AXI4_TARGET_FIC_2_AXI4_S_ARBURST_const_net_0  = 2'h3;
assign FIC_2_AXI4_TARGET_FIC_2_AXI4_S_ARCACHE_const_net_0  = 4'h0;
assign FIC_2_AXI4_TARGET_FIC_2_AXI4_S_ARPROT_const_net_0   = 3'h0;
assign FIC_2_AXI4_TARGET_FIC_2_AXI4_S_ARQOS_const_net_0    = 4'h0;
assign FIC_1_AXI4_TARGET_FIC_1_AXI4_S_AWID_const_net_0     = 4'h0;
assign FIC_1_AXI4_TARGET_FIC_1_AXI4_S_AWADDR_const_net_0   = 38'h0000000000;
assign FIC_1_AXI4_TARGET_FIC_1_AXI4_S_AWLEN_const_net_0    = 8'h00;
assign FIC_1_AXI4_TARGET_FIC_1_AXI4_S_AWSIZE_const_net_0   = 3'h0;
assign FIC_1_AXI4_TARGET_FIC_1_AXI4_S_AWBURST_const_net_0  = 2'h3;
assign FIC_1_AXI4_TARGET_FIC_1_AXI4_S_AWCACHE_const_net_0  = 4'h0;
assign FIC_1_AXI4_TARGET_FIC_1_AXI4_S_AWPROT_const_net_0   = 3'h0;
assign FIC_1_AXI4_TARGET_FIC_1_AXI4_S_AWQOS_const_net_0    = 4'h0;
assign FIC_1_AXI4_TARGET_FIC_1_AXI4_S_WDATA_const_net_0    = 64'h0000000000000000;
assign FIC_1_AXI4_TARGET_FIC_1_AXI4_S_WSTRB_const_net_0    = 8'hFF;
assign FIC_1_AXI4_TARGET_FIC_1_AXI4_S_ARID_const_net_0     = 4'h0;
assign FIC_1_AXI4_TARGET_FIC_1_AXI4_S_ARADDR_const_net_0   = 38'h0000000000;
assign FIC_1_AXI4_TARGET_FIC_1_AXI4_S_ARLEN_const_net_0    = 8'h00;
assign FIC_1_AXI4_TARGET_FIC_1_AXI4_S_ARSIZE_const_net_0   = 3'h0;
assign FIC_1_AXI4_TARGET_FIC_1_AXI4_S_ARBURST_const_net_0  = 2'h3;
assign FIC_1_AXI4_TARGET_FIC_1_AXI4_S_ARCACHE_const_net_0  = 4'h0;
assign FIC_1_AXI4_TARGET_FIC_1_AXI4_S_ARPROT_const_net_0   = 3'h0;
assign FIC_1_AXI4_TARGET_FIC_1_AXI4_S_ARQOS_const_net_0    = 4'h0;
assign FIC_0_AXI4_TARGET_FIC_0_AXI4_S_AWID_const_net_0     = 4'h0;
assign FIC_0_AXI4_TARGET_FIC_0_AXI4_S_AWLEN_const_net_0    = 8'h00;
assign FIC_0_AXI4_TARGET_FIC_0_AXI4_S_AWSIZE_const_net_0   = 3'h0;
assign FIC_0_AXI4_TARGET_FIC_0_AXI4_S_AWBURST_const_net_0  = 2'h3;
assign FIC_0_AXI4_TARGET_FIC_0_AXI4_S_AWCACHE_const_net_0  = 4'h0;
assign FIC_0_AXI4_TARGET_FIC_0_AXI4_S_AWPROT_const_net_0   = 3'h0;
assign FIC_0_AXI4_TARGET_FIC_0_AXI4_S_AWQOS_const_net_0    = 4'h0;
assign FIC_0_AXI4_TARGET_FIC_0_AXI4_S_ARID_const_net_0     = 4'h0;
assign FIC_0_AXI4_TARGET_FIC_0_AXI4_S_ARLEN_const_net_0    = 8'h00;
assign FIC_0_AXI4_TARGET_FIC_0_AXI4_S_ARSIZE_const_net_0   = 3'h0;
assign FIC_0_AXI4_TARGET_FIC_0_AXI4_S_ARBURST_const_net_0  = 2'h3;
assign FIC_0_AXI4_TARGET_FIC_0_AXI4_S_ARCACHE_const_net_0  = 4'h0;
assign FIC_0_AXI4_TARGET_FIC_0_AXI4_S_ARPROT_const_net_0   = 3'h0;
assign FIC_0_AXI4_TARGET_FIC_0_AXI4_S_ARQOS_const_net_0    = 4'h0;
assign M2_APB_MTARGET_PRDATAS16_const_net_0                = 32'h00000000;
assign FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_BID_const_net_0   = 8'h00;
assign FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_BRESP_const_net_0 = 2'h0;
assign FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_RID_const_net_0   = 8'h00;
assign FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_RDATA_const_net_0 = 64'h0000000000000000;
assign FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_RRESP_const_net_0 = 2'h0;
assign FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_BID_const_net_0   = 8'h00;
assign FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_BRESP_const_net_0 = 2'h0;
assign FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_RID_const_net_0   = 8'h00;
assign FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_RDATA_const_net_0 = 64'h0000000000000000;
assign FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_RRESP_const_net_0 = 2'h0;
assign ms_arid_const_net_0                                 = 4'h0;
assign ms_awid_const_net_0                                 = 4'h0;
//--------------------------------------------------------------------
// TieOff assignments
//--------------------------------------------------------------------
assign M2_W_DISABLE1     = 1'b0;
assign M2_W_DISABLE2     = 1'b0;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign USB0_STP_net_1    = USB0_STP_net_0;
assign USB0_STP          = USB0_STP_net_1;
assign EMMC_CLK_net_1    = EMMC_CLK_net_0;
assign EMMC_CLK          = EMMC_CLK_net_1;
assign EMMC_RSTN_net_1   = EMMC_RSTN_net_0;
assign EMMC_RSTN         = EMMC_RSTN_net_1;
assign UART0_TXD_net_1   = UART0_TXD_net_0;
assign UART0_TXD         = UART0_TXD_net_1;
assign USB0_RESETB_net_1 = USB0_RESETB_net_0;
assign USB0_RESETB       = USB0_RESETB_net_1;
assign SGMII_TX0_P_net_1 = SGMII_TX0_P_net_0;
assign SGMII_TX0_P       = SGMII_TX0_P_net_1;
assign SGMII_TX0_N_net_1 = SGMII_TX0_N_net_0;
assign SGMII_TX0_N       = SGMII_TX0_N_net_1;
assign SGMII_TX1_P_net_1 = SGMII_TX1_P_net_0;
assign SGMII_TX1_P       = SGMII_TX1_P_net_1;
assign SGMII_TX1_N_net_1 = SGMII_TX1_N_net_0;
assign SGMII_TX1_N       = SGMII_TX1_N_net_1;
assign ADC_MCLK_net_1    = ADC_MCLK_net_0;
assign ADC_MCLK          = ADC_MCLK_net_1;
assign USB0_RESETB_net_2 = USB0_RESETB_net_0;
assign PHY_RSTn          = USB0_RESETB_net_2;
assign PHY_MDC_net_1     = PHY_MDC_net_0;
assign PHY_MDC           = PHY_MDC_net_1;
assign SD_CARD_CS_net_1  = SD_CARD_CS_net_0;
assign SD_CARD_CS        = SD_CARD_CS_net_1;
assign ADC_SCK_net_1     = ADC_SCK_net_0;
assign ADC_SCK           = ADC_SCK_net_1;
assign ADC_CSn_net_1     = ADC_CSn_net_0;
assign ADC_CSn           = ADC_CSn_net_1;
assign VIO_ENABLE_net_1  = VIO_ENABLE_net_0;
assign VIO_ENABLE        = VIO_ENABLE_net_1;
assign CA_net_1          = CA_net_0;
assign CA[5:0]           = CA_net_1;
assign DM_net_1          = DM_net_0;
assign DM[3:0]           = DM_net_1;
assign RESET_N_net_1     = RESET_N_net_0;
assign RESET_N           = RESET_N_net_1;
assign ODT_net_1         = ODT_net_0;
assign ODT               = ODT_net_1;
assign CKE_net_1         = CKE_net_0;
assign CKE               = CKE_net_1;
assign CS_net_1          = CS_net_0;
assign CS                = CS_net_1;
assign CK_net_1          = CK_net_0;
assign CK                = CK_net_1;
assign CK_N_net_1        = CK_N_net_0;
assign CK_N              = CK_N_net_1;
assign P9_42_net_1       = P9_42_net_0;
assign P9_42             = P9_42_net_1;
//--------------------------------------------------------------------
// Concatenation assignments
//--------------------------------------------------------------------
assign MSS_INT_F2M_net_0 = { 11'h000 , CAPE_INT , 5'h00 };
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------BVF_RISCV_SUBSYSTEM
BVF_RISCV_SUBSYSTEM BVF_RISCV_SUBSYSTEM_inst_0(
        // Inputs
        .PRESETN                                   ( CLOCKS_AND_RESETS_FIC_3_FABRIC_RESET_N ),
        .REFCLK                                    ( REFCLK ),
        .REFCLK_N                                  ( REFCLK_N ),
        .USB_CLK                                   ( USB0_CLK ),
        .USB_DIR                                   ( USB0_DIR ),
        .USB_NXT                                   ( USB0_NXT ),
        .USB_OCn                                   ( USB0_OCn ),
        .UART0_RXD                                 ( UART0_RXD ),
        .M2_UART_RXD                               ( GND_net ),
        .M2_UART_CTS                               ( GND_net ),
        .SGMII_RX0_P                               ( SGMII_RX0_P ),
        .SGMII_RX0_N                               ( SGMII_RX0_N ),
        .SGMII_RX1_P                               ( SGMII_RX1_P ),
        .SGMII_RX1_N                               ( SGMII_RX1_N ),
        .FIC_3_PCLK                                ( CLOCKS_AND_RESETS_FIC_3_PCLK ),
        .USER_BUTTON                               ( USER_BUTTON ),
        .SD_DET                                    ( SD_DET ),
        .CAN_0_RXBUS                               ( GND_net ),
        .CAN_1_RXBUS                               ( GND_net ),
        .GPIO_2_F2M                                ( CAPE_GPIO_IN ),
        .ADC_IRQn                                  ( ADC_IRQn ),
        .MMUART_3_RXD                              ( GND_net ),
        .PHY_INTn                                  ( PHY_INTn ),
        .MSS_INT_F2M                               ( MSS_INT_F2M_net_0 ),
        .MAC_1_MDI_F2M                             ( GND_net ),
        .EMMC_STRB                                 ( EMMC_STRB ),
        .PCIE_INT                                  ( GND_net ),
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_AWID       ( FIC_2_AXI4_TARGET_FIC_2_AXI4_S_AWID_const_net_0 ), // tied to 4'h0 from definition
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_AWADDR     ( FIC_2_AXI4_TARGET_FIC_2_AXI4_S_AWADDR_const_net_0 ), // tied to 38'h0000000000 from definition
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_AWLEN      ( FIC_2_AXI4_TARGET_FIC_2_AXI4_S_AWLEN_const_net_0 ), // tied to 8'h00 from definition
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_AWSIZE     ( FIC_2_AXI4_TARGET_FIC_2_AXI4_S_AWSIZE_const_net_0 ), // tied to 3'h0 from definition
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_AWBURST    ( FIC_2_AXI4_TARGET_FIC_2_AXI4_S_AWBURST_const_net_0 ), // tied to 2'h3 from definition
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_AWLOCK     ( GND_net ), // tied to 1'b0 from definition
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_AWCACHE    ( FIC_2_AXI4_TARGET_FIC_2_AXI4_S_AWCACHE_const_net_0 ), // tied to 4'h0 from definition
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_AWQOS      ( FIC_2_AXI4_TARGET_FIC_2_AXI4_S_AWQOS_const_net_0 ), // tied to 4'h0 from definition
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_AWPROT     ( FIC_2_AXI4_TARGET_FIC_2_AXI4_S_AWPROT_const_net_0 ), // tied to 3'h0 from definition
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_AWVALID    ( GND_net ), // tied to 1'b0 from definition
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_WDATA      ( FIC_2_AXI4_TARGET_FIC_2_AXI4_S_WDATA_const_net_0 ), // tied to 64'h0000000000000000 from definition
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_WSTRB      ( FIC_2_AXI4_TARGET_FIC_2_AXI4_S_WSTRB_const_net_0 ), // tied to 8'hFF from definition
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_WLAST      ( GND_net ), // tied to 1'b0 from definition
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_WVALID     ( GND_net ), // tied to 1'b0 from definition
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_BREADY     ( GND_net ), // tied to 1'b0 from definition
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_ARID       ( FIC_2_AXI4_TARGET_FIC_2_AXI4_S_ARID_const_net_0 ), // tied to 4'h0 from definition
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_ARADDR     ( FIC_2_AXI4_TARGET_FIC_2_AXI4_S_ARADDR_const_net_0 ), // tied to 38'h0000000000 from definition
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_ARLEN      ( FIC_2_AXI4_TARGET_FIC_2_AXI4_S_ARLEN_const_net_0 ), // tied to 8'h00 from definition
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_ARSIZE     ( FIC_2_AXI4_TARGET_FIC_2_AXI4_S_ARSIZE_const_net_0 ), // tied to 3'h0 from definition
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_ARBURST    ( FIC_2_AXI4_TARGET_FIC_2_AXI4_S_ARBURST_const_net_0 ), // tied to 2'h3 from definition
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_ARLOCK     ( GND_net ), // tied to 1'b0 from definition
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_ARCACHE    ( FIC_2_AXI4_TARGET_FIC_2_AXI4_S_ARCACHE_const_net_0 ), // tied to 4'h0 from definition
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_ARQOS      ( FIC_2_AXI4_TARGET_FIC_2_AXI4_S_ARQOS_const_net_0 ), // tied to 4'h0 from definition
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_ARPROT     ( FIC_2_AXI4_TARGET_FIC_2_AXI4_S_ARPROT_const_net_0 ), // tied to 3'h0 from definition
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_ARVALID    ( GND_net ), // tied to 1'b0 from definition
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_RREADY     ( GND_net ), // tied to 1'b0 from definition
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_AWID       ( FIC_1_AXI4_TARGET_FIC_1_AXI4_S_AWID_const_net_0 ), // tied to 4'h0 from definition
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_AWADDR     ( FIC_1_AXI4_TARGET_FIC_1_AXI4_S_AWADDR_const_net_0 ), // tied to 38'h0000000000 from definition
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_AWLEN      ( FIC_1_AXI4_TARGET_FIC_1_AXI4_S_AWLEN_const_net_0 ), // tied to 8'h00 from definition
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_AWSIZE     ( FIC_1_AXI4_TARGET_FIC_1_AXI4_S_AWSIZE_const_net_0 ), // tied to 3'h0 from definition
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_AWBURST    ( FIC_1_AXI4_TARGET_FIC_1_AXI4_S_AWBURST_const_net_0 ), // tied to 2'h3 from definition
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_AWLOCK     ( GND_net ), // tied to 1'b0 from definition
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_AWCACHE    ( FIC_1_AXI4_TARGET_FIC_1_AXI4_S_AWCACHE_const_net_0 ), // tied to 4'h0 from definition
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_AWQOS      ( FIC_1_AXI4_TARGET_FIC_1_AXI4_S_AWQOS_const_net_0 ), // tied to 4'h0 from definition
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_AWPROT     ( FIC_1_AXI4_TARGET_FIC_1_AXI4_S_AWPROT_const_net_0 ), // tied to 3'h0 from definition
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_AWVALID    ( GND_net ), // tied to 1'b0 from definition
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_WDATA      ( FIC_1_AXI4_TARGET_FIC_1_AXI4_S_WDATA_const_net_0 ), // tied to 64'h0000000000000000 from definition
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_WSTRB      ( FIC_1_AXI4_TARGET_FIC_1_AXI4_S_WSTRB_const_net_0 ), // tied to 8'hFF from definition
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_WLAST      ( GND_net ), // tied to 1'b0 from definition
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_WVALID     ( GND_net ), // tied to 1'b0 from definition
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_BREADY     ( GND_net ), // tied to 1'b0 from definition
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_ARID       ( FIC_1_AXI4_TARGET_FIC_1_AXI4_S_ARID_const_net_0 ), // tied to 4'h0 from definition
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_ARADDR     ( FIC_1_AXI4_TARGET_FIC_1_AXI4_S_ARADDR_const_net_0 ), // tied to 38'h0000000000 from definition
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_ARLEN      ( FIC_1_AXI4_TARGET_FIC_1_AXI4_S_ARLEN_const_net_0 ), // tied to 8'h00 from definition
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_ARSIZE     ( FIC_1_AXI4_TARGET_FIC_1_AXI4_S_ARSIZE_const_net_0 ), // tied to 3'h0 from definition
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_ARBURST    ( FIC_1_AXI4_TARGET_FIC_1_AXI4_S_ARBURST_const_net_0 ), // tied to 2'h3 from definition
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_ARQOS      ( FIC_1_AXI4_TARGET_FIC_1_AXI4_S_ARQOS_const_net_0 ), // tied to 4'h0 from definition
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_ARLOCK     ( GND_net ), // tied to 1'b0 from definition
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_ARCACHE    ( FIC_1_AXI4_TARGET_FIC_1_AXI4_S_ARCACHE_const_net_0 ), // tied to 4'h0 from definition
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_ARPROT     ( FIC_1_AXI4_TARGET_FIC_1_AXI4_S_ARPROT_const_net_0 ), // tied to 3'h0 from definition
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_ARVALID    ( GND_net ), // tied to 1'b0 from definition
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_RREADY     ( GND_net ), // tied to 1'b0 from definition
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_AWID       ( FIC_0_AXI4_TARGET_FIC_0_AXI4_S_AWID_const_net_0 ), // tied to 4'h0 from definition
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_AWADDR     ( CAPE_AXI4mtarget0_AWADDR ),
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_AWLEN      ( FIC_0_AXI4_TARGET_FIC_0_AXI4_S_AWLEN_const_net_0 ), // tied to 8'h00 from definition
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_AWSIZE     ( FIC_0_AXI4_TARGET_FIC_0_AXI4_S_AWSIZE_const_net_0 ), // tied to 3'h0 from definition
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_AWBURST    ( FIC_0_AXI4_TARGET_FIC_0_AXI4_S_AWBURST_const_net_0 ), // tied to 2'h3 from definition
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_AWQOS      ( FIC_0_AXI4_TARGET_FIC_0_AXI4_S_AWQOS_const_net_0 ), // tied to 4'h0 from definition
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_AWLOCK     ( GND_net ), // tied to 1'b0 from definition
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_AWCACHE    ( FIC_0_AXI4_TARGET_FIC_0_AXI4_S_AWCACHE_const_net_0 ), // tied to 4'h0 from definition
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_AWPROT     ( FIC_0_AXI4_TARGET_FIC_0_AXI4_S_AWPROT_const_net_0 ), // tied to 3'h0 from definition
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_AWVALID    ( CAPE_AXI4mtarget0_AWVALID ),
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_WDATA      ( CAPE_AXI4mtarget0_WDATA ),
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_WSTRB      ( CAPE_AXI4mtarget0_WSTRB ),
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_WLAST      ( GND_net ), // tied to 1'b0 from definition
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_WVALID     ( CAPE_AXI4mtarget0_WVALID ),
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_BREADY     ( CAPE_AXI4mtarget0_BREADY ),
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_ARID       ( FIC_0_AXI4_TARGET_FIC_0_AXI4_S_ARID_const_net_0 ), // tied to 4'h0 from definition
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_ARADDR     ( CAPE_AXI4mtarget0_ARADDR ),
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_ARLEN      ( FIC_0_AXI4_TARGET_FIC_0_AXI4_S_ARLEN_const_net_0 ), // tied to 8'h00 from definition
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_ARSIZE     ( FIC_0_AXI4_TARGET_FIC_0_AXI4_S_ARSIZE_const_net_0 ), // tied to 3'h0 from definition
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_ARBURST    ( FIC_0_AXI4_TARGET_FIC_0_AXI4_S_ARBURST_const_net_0 ), // tied to 2'h3 from definition
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_ARQOS      ( FIC_0_AXI4_TARGET_FIC_0_AXI4_S_ARQOS_const_net_0 ), // tied to 4'h0 from definition
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_ARLOCK     ( GND_net ), // tied to 1'b0 from definition
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_ARCACHE    ( FIC_0_AXI4_TARGET_FIC_0_AXI4_S_ARCACHE_const_net_0 ), // tied to 4'h0 from definition
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_ARPROT     ( FIC_0_AXI4_TARGET_FIC_0_AXI4_S_ARPROT_const_net_0 ), // tied to 3'h0 from definition
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_ARVALID    ( CAPE_AXI4mtarget0_ARVALID ),
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_RREADY     ( CAPE_AXI4mtarget0_RREADY ),
        .CAPE_APB_MTARGET_PRDATAS1                 ( BVF_RISCV_SUBSYSTEM_CAPE_APB_MTARGET_PRDATA ),
        .CAPE_APB_MTARGET_PREADYS1                 ( BVF_RISCV_SUBSYSTEM_CAPE_APB_MTARGET_PREADY ),
        .CAPE_APB_MTARGET_PSLVERRS1                ( BVF_RISCV_SUBSYSTEM_CAPE_APB_MTARGET_PSLVERR ),
        .M2_APB_MTARGET_PRDATAS16                  ( M2_APB_MTARGET_PRDATAS16_const_net_0 ), // tied to 32'h00000000 from definition
        .M2_APB_MTARGET_PREADYS16                  ( VCC_net ), // tied to 1'b1 from definition
        .M2_APB_MTARGET_PSLVERRS16                 ( GND_net ), // tied to 1'b0 from definition
        .FIC_0_ACLK                                ( CLOCKS_AND_RESETS_FIC_0_ACLK ),
        .FIC_1_ACLK                                ( CLOCKS_AND_RESETS_FIC_1_ACLK ),
        .FIC_2_ACLK                                ( CLOCKS_AND_RESETS_FIC_2_ACLK ),
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_AWREADY ( GND_net ), // tied to 1'b0 from definition
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_WREADY  ( GND_net ), // tied to 1'b0 from definition
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_BID     ( FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_BID_const_net_0 ), // tied to 8'h00 from definition
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_BRESP   ( FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_BRESP_const_net_0 ), // tied to 2'h0 from definition
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_BVALID  ( GND_net ), // tied to 1'b0 from definition
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_ARREADY ( GND_net ), // tied to 1'b0 from definition
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_RID     ( FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_RID_const_net_0 ), // tied to 8'h00 from definition
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_RDATA   ( FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_RDATA_const_net_0 ), // tied to 64'h0000000000000000 from definition
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_RRESP   ( FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_RRESP_const_net_0 ), // tied to 2'h0 from definition
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_RLAST   ( GND_net ), // tied to 1'b0 from definition
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_RVALID  ( GND_net ), // tied to 1'b0 from definition
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_AWREADY ( GND_net ), // tied to 1'b0 from definition
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_WREADY  ( GND_net ), // tied to 1'b0 from definition
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_BID     ( FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_BID_const_net_0 ), // tied to 8'h00 from definition
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_BRESP   ( FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_BRESP_const_net_0 ), // tied to 2'h0 from definition
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_BVALID  ( GND_net ), // tied to 1'b0 from definition
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_ARREADY ( GND_net ), // tied to 1'b0 from definition
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_RID     ( FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_RID_const_net_0 ), // tied to 8'h00 from definition
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_RDATA   ( FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_RDATA_const_net_0 ), // tied to 64'h0000000000000000 from definition
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_RRESP   ( FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_RRESP_const_net_0 ), // tied to 2'h0 from definition
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_RLAST   ( GND_net ), // tied to 1'b0 from definition
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_RVALID  ( GND_net ), // tied to 1'b0 from definition
        // Outputs
        .USB_STP                                   ( USB0_STP_net_0 ),
        .EMMC_CLK                                  ( EMMC_CLK_net_0 ),
        .EMMC_RSTN                                 ( EMMC_RSTN_net_0 ),
        .UART0_TXD                                 ( UART0_TXD_net_0 ),
        .M2_UART_TXD                               (  ),
        .M2_UART_RTS                               (  ),
        .MSS_DLL_LOCKS                             ( BVF_RISCV_SUBSYSTEM_MSS_DLL_LOCKS ),
        .SGMII_TX0_P                               ( SGMII_TX0_P_net_0 ),
        .SGMII_TX0_N                               ( SGMII_TX0_N_net_0 ),
        .SGMII_TX1_P                               ( SGMII_TX1_P_net_0 ),
        .SGMII_TX1_N                               ( SGMII_TX1_N_net_0 ),
        .CAN_0_TXBUS                               (  ),
        .CAN_0_TX_EBL                              (  ),
        .CAN_1_TXBUS                               (  ),
        .CAN_1_TX_EBL                              (  ),
        .GPIO_2_M2F                                ( BVF_RISCV_SUBSYSTEM_GPIO_2_M2F ),
        .GPIO_2_OE_M2F                             ( BVF_RISCV_SUBSYSTEM_GPIO_2_OE_M2F ),
        .MMUART_3_TXD                              (  ),
        .PHY_MDC                                   ( PHY_MDC_net_0 ),
        .M2_W_DISABLE1                             (  ),
        .M2_W_DISABLE2                             (  ),
        .MAC_1_MDO_OE_M2F                          (  ),
        .MAC_1_MDC_M2F                             (  ),
        .MAC_1_MDO_M2F                             (  ),
        .VIO_ENABLE                                ( VIO_ENABLE_net_0 ),
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_AWREADY    (  ),
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_WREADY     (  ),
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_BID        (  ),
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_BRESP      (  ),
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_BVALID     (  ),
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_ARREADY    (  ),
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_RID        (  ),
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_RDATA      (  ),
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_RRESP      (  ),
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_RLAST      (  ),
        .FIC_2_AXI4_TARGET_FIC_2_AXI4_S_RVALID     (  ),
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_AWREADY    (  ),
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_WREADY     (  ),
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_BID        (  ),
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_BRESP      (  ),
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_BVALID     (  ),
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_ARREADY    (  ),
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_RID        (  ),
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_RDATA      (  ),
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_RRESP      (  ),
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_RLAST      (  ),
        .FIC_1_AXI4_TARGET_FIC_1_AXI4_S_RVALID     (  ),
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_AWREADY    ( CAPE_AXI4mtarget0_AWREADY ),
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_WREADY     ( CAPE_AXI4mtarget0_WREADY ),
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_BID        ( CAPE_AXI4mtarget0_BID ),
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_BRESP      ( CAPE_AXI4mtarget0_BRESP ),
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_BVALID     ( CAPE_AXI4mtarget0_BVALID ),
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_ARREADY    ( CAPE_AXI4mtarget0_ARREADY ),
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_RID        ( CAPE_AXI4mtarget0_RID ),
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_RDATA      ( CAPE_AXI4mtarget0_RDATA ),
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_RRESP      ( CAPE_AXI4mtarget0_RRESP ),
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_RLAST      ( CAPE_AXI4mtarget0_RLAST ),
        .FIC_0_AXI4_TARGET_FIC_0_AXI4_S_RVALID     ( CAPE_AXI4mtarget0_RVALID ),
        .CAPE_APB_MTARGET_PADDRS                   ( BVF_RISCV_SUBSYSTEM_CAPE_APB_MTARGET_PADDR ),
        .CAPE_APB_MTARGET_PSELS1                   ( BVF_RISCV_SUBSYSTEM_CAPE_APB_MTARGET_PSELx ),
        .CAPE_APB_MTARGET_PENABLES                 ( BVF_RISCV_SUBSYSTEM_CAPE_APB_MTARGET_PENABLE ),
        .CAPE_APB_MTARGET_PWRITES                  ( BVF_RISCV_SUBSYSTEM_CAPE_APB_MTARGET_PWRITE ),
        .CAPE_APB_MTARGET_PWDATAS                  ( BVF_RISCV_SUBSYSTEM_CAPE_APB_MTARGET_PWDATA ),
        .M2_APB_MTARGET_PSELS16                    (  ),
        .MSS_RESET_N_M2F                           ( BVF_RISCV_SUBSYSTEM_MSS_RESET_N_M2F ),
        .FIC_3_APB_M_PSTRB                         (  ),
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_AWID    (  ),
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_AWADDR  (  ),
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_AWLEN   (  ),
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_AWSIZE  (  ),
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_AWBURST (  ),
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_AWLOCK  (  ),
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_AWQOS   (  ),
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_AWCACHE (  ),
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_AWPROT  (  ),
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_AWVALID (  ),
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_WDATA   (  ),
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_WSTRB   (  ),
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_WLAST   (  ),
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_WVALID  (  ),
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_BREADY  (  ),
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_ARID    (  ),
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_ARADDR  (  ),
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_ARLEN   (  ),
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_ARSIZE  (  ),
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_ARBURST (  ),
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_ARLOCK  (  ),
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_ARQOS   (  ),
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_ARCACHE (  ),
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_ARPROT  (  ),
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_ARVALID (  ),
        .FIC_0_AXI4_INITIATOR_FIC_0_AXI4_M_RREADY  (  ),
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_AWID    (  ),
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_AWADDR  (  ),
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_AWLEN   (  ),
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_AWSIZE  (  ),
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_AWBURST (  ),
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_AWLOCK  (  ),
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_AWQOS   (  ),
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_AWCACHE (  ),
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_AWPROT  (  ),
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_AWVALID (  ),
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_WDATA   (  ),
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_WSTRB   (  ),
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_WLAST   (  ),
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_WVALID  (  ),
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_BREADY  (  ),
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_ARID    (  ),
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_ARADDR  (  ),
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_ARLEN   (  ),
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_ARSIZE  (  ),
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_ARBURST (  ),
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_ARLOCK  (  ),
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_ARQOS   (  ),
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_ARCACHE (  ),
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_ARPROT  (  ),
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_ARVALID (  ),
        .FIC_1_AXI4_INITIATOR_FIC_1_AXI4_M_RREADY  (  ),
        .CA                                        ( CA_net_0 ),
        .DM                                        ( DM_net_0 ),
        .RESET_N                                   ( RESET_N_net_0 ),
        .ODT                                       ( ODT_net_0 ),
        .CKE                                       ( CKE_net_0 ),
        .CS                                        ( CS_net_0 ),
        .CK                                        ( CK_net_0 ),
        .CK_N                                      ( CK_N_net_0 ),
        .SD_CARD_CS                                ( SD_CARD_CS_net_0 ),
        .ADC_CSn                                   ( ADC_CSn_net_0 ),
        .ADC_SCK                                   ( ADC_SCK_net_0 ),
        // Inouts
        .USB_DATA                                  ( USB0_DATA ),
        .EMMC_DATA                                 ( EMMC_DATA ),
        .EMMC_CMD                                  ( EMMC_CMD ),
        .I2C_1_SCL                                 ( I2C_1_SCL ),
        .I2C_1_SDA                                 ( I2C_1_SDA ),
        .I2C0_SCL                                  ( P9[19:19] ),
        .I2C0_SDA                                  ( P9[20:20] ),
        .PHY_MDIO                                  ( PHY_MDIO ),
        .DQ                                        ( DQ ),
        .DQS                                       ( DQS ),
        .DQS_N                                     ( DQS_N ),
        .SPI_1_SS1                                 ( P9[28:28] ),
        .SPI_1_CLK                                 ( P9[31:31] ),
        .SPI_1_DI                                  ( P9[29:29] ),
        .ADC_MOSI                                  ( ADC_MOSI ),
        .ADC_MISO                                  ( ADC_MISO ),
        .MMUART_2_TXD                              ( P9[24:24] ),
        .MMUART_2_RXD                              ( P9[26:26] ),
        .MMUART_4_TXD                              ( P9[13:13] ),
        .MMUART_4_RXD                              ( P9[11:11] ),
        .SPI_0_DO                                  ( P9[18:18] ),
        .SPI_0_CLK                                 ( P9[22:22] ),
        .SPI_0_SS1                                 ( P9[17:17] ),
        .SPI_0_DI                                  ( P9[21:21] ) 
        );

//--------CAPE
CAPE CAPE_inst_0(
        // Inputs
        .APB_SLAVE_SLAVE_PENABLE ( BVF_RISCV_SUBSYSTEM_CAPE_APB_MTARGET_PENABLE ),
        .APB_SLAVE_SLAVE_PSEL    ( BVF_RISCV_SUBSYSTEM_CAPE_APB_MTARGET_PSELx ),
        .APB_SLAVE_SLAVE_PWRITE  ( BVF_RISCV_SUBSYSTEM_CAPE_APB_MTARGET_PWRITE ),
        .PCLK                    ( CLOCKS_AND_RESETS_FIC_3_PCLK ),
        .PRESETN                 ( CLOCKS_AND_RESETS_FIC_3_FABRIC_RESET_N ),
        .APB_SLAVE_SLAVE_PADDR   ( BVF_RISCV_SUBSYSTEM_CAPE_APB_MTARGET_PADDR ),
        .APB_SLAVE_SLAVE_PWDATA  ( BVF_RISCV_SUBSYSTEM_CAPE_APB_MTARGET_PWDATA ),
        .GPIO_OE                 ( BVF_RISCV_SUBSYSTEM_GPIO_2_OE_M2F ),
        .GPIO_OUT                ( BVF_RISCV_SUBSYSTEM_GPIO_2_M2F ),
        .AXI_ACLK                ( CAPE_AXI4mtarget0_ACLK ),
        .AXI_ARESETN             ( CAPE_AXI4mtarget0_ARESETN ),
        .ms_arready              ( CAPE_AXI4mtarget0_ARREADY ),
        .ms_rdata                ( CAPE_AXI4mtarget0_RDATA ),
        .ms_rvalid               ( CAPE_AXI4mtarget0_RVALID ),
        .ms_rresp                ( CAPE_AXI4mtarget0_RRESP ),
        .ms_awready              ( CAPE_AXI4mtarget0_AWREADY ),
        .ms_wready               ( CAPE_AXI4mtarget0_WREADY ),
        .ms_bresp                ( CAPE_AXI4mtarget0_BRESP ),
        .ms_bvalid               ( CAPE_AXI4mtarget0_BVALID ),
        .ms_arid                 ( ms_arid_const_net_0 ), // tied to 4'h0 from definition
        .ms_awid                 ( ms_awid_const_net_0 ), // tied to 4'h0 from definition
        // Outputs
        .APB_SLAVE_SLAVE_PREADY  ( BVF_RISCV_SUBSYSTEM_CAPE_APB_MTARGET_PREADY ),
        .APB_SLAVE_SLAVE_PSLVERR ( BVF_RISCV_SUBSYSTEM_CAPE_APB_MTARGET_PSLVERR ),
        .P9_PIN42                ( P9_42_net_0 ),
        .APB_SLAVE_SLAVE_PRDATA  ( BVF_RISCV_SUBSYSTEM_CAPE_APB_MTARGET_PRDATA ),
        .GPIO_IN                 ( CAPE_GPIO_IN ),
        .INT                     ( CAPE_INT ),
        .ms_araddr               ( CAPE_AXI4mtarget0_ARADDR ),
        .ms_arvalid              ( CAPE_AXI4mtarget0_ARVALID ),
        .ms_rready               ( CAPE_AXI4mtarget0_RREADY ),
        .ms_awaddr               ( CAPE_AXI4mtarget0_AWADDR ),
        .ms_awvalid              ( CAPE_AXI4mtarget0_AWVALID ),
        .ms_wdata                ( CAPE_AXI4mtarget0_WDATA ),
        .ms_wstrb                ( CAPE_AXI4mtarget0_WSTRB ),
        .ms_wvalid               ( CAPE_AXI4mtarget0_WVALID ),
        .ms_bready               ( CAPE_AXI4mtarget0_BREADY ),
        .ms_rid                  ( CAPE_AXI4mtarget0_RID ),
        .ms_bid                  ( CAPE_AXI4mtarget0_BID ),
        // Inouts
        .P9_14                   ( P9[14:14] ),
        .P9_16                   ( P9[16:16] ),
        .P9_PIN12                ( P9[12:12] ),
        .P9_PIN15                ( P9[15:15] ),
        .P9_PIN23                ( P9[23:23] ),
        .P9_PIN25                ( P9[25:25] ),
        .P9_PIN27                ( P9[27:27] ),
        .P9_PIN30                ( P9[30:30] ),
        .P9_PIN41                ( P9_41 ),
        .P8                      ( P8 ) 
        );

//--------CLOCKS_AND_RESETS
CLOCKS_AND_RESETS CLOCKS_AND_RESETS_inst_0(
        // Inputs
        .EXT_RST_N            ( BVF_RISCV_SUBSYSTEM_MSS_RESET_N_M2F ),
        .MSS_DLL_LOCKS        ( BVF_RISCV_SUBSYSTEM_MSS_DLL_LOCKS ),
        // Outputs
        .ADC_MCLK_4_915MHz    ( ADC_MCLK_net_0 ),
        .DEVICE_INIT_DONE     (  ),
        .FIC_0_ACLK           ( CLOCKS_AND_RESETS_FIC_0_ACLK ),
        .FIC_0_FABRIC_RESET_N ( USB0_RESETB_net_0 ),
        .FIC_1_ACLK           ( CLOCKS_AND_RESETS_FIC_1_ACLK ),
        .FIC_1_FABRIC_RESET_N (  ),
        .FIC_2_ACLK           ( CLOCKS_AND_RESETS_FIC_2_ACLK ),
        .FIC_2_FABRIC_RESET_N (  ),
        .FIC_3_FABRIC_RESET_N ( CLOCKS_AND_RESETS_FIC_3_FABRIC_RESET_N ),
        .FIC_3_PCLK           ( CLOCKS_AND_RESETS_FIC_3_PCLK ),
        .RCOSC_160MHZ_GL      (  ),
        .XCVR_INIT_DONE       (  ) 
        );


endmodule
