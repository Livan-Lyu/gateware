//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Sun Jul 12 19:45:09 2026
// Version: 2025.1 2025.1.0.14
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// CLOCKS_AND_RESETS
module CLOCKS_AND_RESETS(
    // Inputs
    EXT_RST_N,
    MSS_DLL_LOCKS,
    // Outputs
    ADC_MCLK_4_915MHz,
    DEVICE_INIT_DONE,
    FIC_0_ACLK,
    FIC_0_FABRIC_RESET_N,
    FIC_1_ACLK,
    FIC_1_FABRIC_RESET_N,
    FIC_2_ACLK,
    FIC_2_FABRIC_RESET_N,
    FIC_3_FABRIC_RESET_N,
    FIC_3_PCLK,
    RCOSC_160MHZ_GL,
    XCVR_INIT_DONE
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input  EXT_RST_N;
input  MSS_DLL_LOCKS;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output ADC_MCLK_4_915MHz;
output DEVICE_INIT_DONE;
output FIC_0_ACLK;
output FIC_0_FABRIC_RESET_N;
output FIC_1_ACLK;
output FIC_1_FABRIC_RESET_N;
output FIC_2_ACLK;
output FIC_2_FABRIC_RESET_N;
output FIC_3_FABRIC_RESET_N;
output FIC_3_PCLK;
output RCOSC_160MHZ_GL;
output XCVR_INIT_DONE;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire   ADC_MCLK_4_915MHz_net_0;
wire   DEVICE_INIT_DONE_net_0;
wire   EXT_RST_N;
wire   FIC_0_ACLK_net_0;
wire   FIC_0_FABRIC_RESET_N_net_0;
wire   FIC_0_RESET_PLL_POWERDOWN_B;
wire   FIC_1_ACLK_net_0;
wire   FIC_1_FABRIC_RESET_N_net_0;
wire   FIC_2_ACLK_net_0;
wire   FIC_2_FABRIC_RESET_N_net_0;
wire   FIC_3_FABRIC_RESET_N_net_0;
wire   FIC_3_PCLK_net_0;
wire   FIC_PLL_LOCKs_Y;
wire   FPGA_CCC_C0_0_PLL_LOCK_0;
wire   INIT_MONITOR_0_FABRIC_POR_N;
wire   MSS_DLL_LOCKS;
wire   RCOSC_160MHZ_GL_net_0;
wire   XCVR_INIT_DONE_net_0;
wire   ADC_MCLK_4_915MHz_net_1;
wire   DEVICE_INIT_DONE_net_1;
wire   FIC_0_ACLK_net_1;
wire   FIC_0_FABRIC_RESET_N_net_1;
wire   FIC_1_ACLK_net_1;
wire   FIC_1_FABRIC_RESET_N_net_1;
wire   FIC_2_ACLK_net_1;
wire   FIC_2_FABRIC_RESET_N_net_1;
wire   FIC_3_FABRIC_RESET_N_net_1;
wire   FIC_3_PCLK_net_1;
wire   RCOSC_160MHZ_GL_net_1;
wire   XCVR_INIT_DONE_net_1;
//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire   VCC_net;
wire   GND_net;
//--------------------------------------------------------------------
// Constant assignments
//--------------------------------------------------------------------
assign VCC_net = 1'b1;
assign GND_net = 1'b0;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign ADC_MCLK_4_915MHz_net_1    = ADC_MCLK_4_915MHz_net_0;
assign ADC_MCLK_4_915MHz          = ADC_MCLK_4_915MHz_net_1;
assign DEVICE_INIT_DONE_net_1     = DEVICE_INIT_DONE_net_0;
assign DEVICE_INIT_DONE           = DEVICE_INIT_DONE_net_1;
assign FIC_0_ACLK_net_1           = FIC_0_ACLK_net_0;
assign FIC_0_ACLK                 = FIC_0_ACLK_net_1;
assign FIC_0_FABRIC_RESET_N_net_1 = FIC_0_FABRIC_RESET_N_net_0;
assign FIC_0_FABRIC_RESET_N       = FIC_0_FABRIC_RESET_N_net_1;
assign FIC_1_ACLK_net_1           = FIC_1_ACLK_net_0;
assign FIC_1_ACLK                 = FIC_1_ACLK_net_1;
assign FIC_1_FABRIC_RESET_N_net_1 = FIC_1_FABRIC_RESET_N_net_0;
assign FIC_1_FABRIC_RESET_N       = FIC_1_FABRIC_RESET_N_net_1;
assign FIC_2_ACLK_net_1           = FIC_2_ACLK_net_0;
assign FIC_2_ACLK                 = FIC_2_ACLK_net_1;
assign FIC_2_FABRIC_RESET_N_net_1 = FIC_2_FABRIC_RESET_N_net_0;
assign FIC_2_FABRIC_RESET_N       = FIC_2_FABRIC_RESET_N_net_1;
assign FIC_3_FABRIC_RESET_N_net_1 = FIC_3_FABRIC_RESET_N_net_0;
assign FIC_3_FABRIC_RESET_N       = FIC_3_FABRIC_RESET_N_net_1;
assign FIC_3_PCLK_net_1           = FIC_3_PCLK_net_0;
assign FIC_3_PCLK                 = FIC_3_PCLK_net_1;
assign RCOSC_160MHZ_GL_net_1      = RCOSC_160MHZ_GL_net_0;
assign RCOSC_160MHZ_GL            = RCOSC_160MHZ_GL_net_1;
assign XCVR_INIT_DONE_net_1       = XCVR_INIT_DONE_net_0;
assign XCVR_INIT_DONE             = XCVR_INIT_DONE_net_1;
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------CORERESET
CORERESET FIC_0_RESET(
        // Inputs
        .CLK                ( FIC_0_ACLK_net_0 ),
        .EXT_RST_N          ( EXT_RST_N ),
        .BANK_x_VDDI_STATUS ( VCC_net ),
        .BANK_y_VDDI_STATUS ( VCC_net ),
        .PLL_LOCK           ( FIC_PLL_LOCKs_Y ),
        .SS_BUSY            ( GND_net ),
        .INIT_DONE          ( DEVICE_INIT_DONE_net_0 ),
        .FF_US_RESTORE      ( GND_net ),
        .FPGA_POR_N         ( INIT_MONITOR_0_FABRIC_POR_N ),
        // Outputs
        .PLL_POWERDOWN_B    ( FIC_0_RESET_PLL_POWERDOWN_B ),
        .FABRIC_RESET_N     ( FIC_0_FABRIC_RESET_N_net_0 ) 
        );

//--------CORERESET
CORERESET FIC_1_RESET(
        // Inputs
        .CLK                ( FIC_1_ACLK_net_0 ),
        .EXT_RST_N          ( EXT_RST_N ),
        .BANK_x_VDDI_STATUS ( VCC_net ),
        .BANK_y_VDDI_STATUS ( VCC_net ),
        .PLL_LOCK           ( FIC_PLL_LOCKs_Y ),
        .SS_BUSY            ( GND_net ),
        .INIT_DONE          ( DEVICE_INIT_DONE_net_0 ),
        .FF_US_RESTORE      ( GND_net ),
        .FPGA_POR_N         ( INIT_MONITOR_0_FABRIC_POR_N ),
        // Outputs
        .PLL_POWERDOWN_B    (  ),
        .FABRIC_RESET_N     ( FIC_1_FABRIC_RESET_N_net_0 ) 
        );

//--------CORERESET
CORERESET FIC_2_RESET_0(
        // Inputs
        .CLK                ( FIC_2_ACLK_net_0 ),
        .EXT_RST_N          ( EXT_RST_N ),
        .BANK_x_VDDI_STATUS ( VCC_net ),
        .BANK_y_VDDI_STATUS ( VCC_net ),
        .PLL_LOCK           ( FIC_PLL_LOCKs_Y ),
        .SS_BUSY            ( GND_net ),
        .INIT_DONE          ( DEVICE_INIT_DONE_net_0 ),
        .FF_US_RESTORE      ( GND_net ),
        .FPGA_POR_N         ( INIT_MONITOR_0_FABRIC_POR_N ),
        // Outputs
        .PLL_POWERDOWN_B    (  ),
        .FABRIC_RESET_N     ( FIC_2_FABRIC_RESET_N_net_0 ) 
        );

//--------CORERESET
CORERESET FIC_3_RESET_0(
        // Inputs
        .CLK                ( FIC_3_PCLK_net_0 ),
        .EXT_RST_N          ( EXT_RST_N ),
        .BANK_x_VDDI_STATUS ( VCC_net ),
        .BANK_y_VDDI_STATUS ( VCC_net ),
        .PLL_LOCK           ( FIC_PLL_LOCKs_Y ),
        .SS_BUSY            ( GND_net ),
        .INIT_DONE          ( DEVICE_INIT_DONE_net_0 ),
        .FF_US_RESTORE      ( GND_net ),
        .FPGA_POR_N         ( INIT_MONITOR_0_FABRIC_POR_N ),
        // Outputs
        .PLL_POWERDOWN_B    (  ),
        .FABRIC_RESET_N     ( FIC_3_FABRIC_RESET_N_net_0 ) 
        );

//--------AND2
AND2 FIC_PLL_LOCKs(
        // Inputs
        .A ( FPGA_CCC_C0_0_PLL_LOCK_0 ),
        .B ( MSS_DLL_LOCKS ),
        // Outputs
        .Y ( FIC_PLL_LOCKs_Y ) 
        );

//--------FPGA_CCC_C0
FPGA_CCC_C0 FPGA_CCC_C0_0(
        // Inputs
        .REF_CLK_0         ( RCOSC_160MHZ_GL_net_0 ),
        .PLL_POWERDOWN_N_0 ( FIC_0_RESET_PLL_POWERDOWN_B ),
        // Outputs
        .OUT0_FABCLK_0     ( FIC_0_ACLK_net_0 ),
        .OUT1_FABCLK_0     ( FIC_1_ACLK_net_0 ),
        .OUT2_FABCLK_0     ( FIC_2_ACLK_net_0 ),
        .OUT3_FABCLK_0     ( FIC_3_PCLK_net_0 ),
        .PLL_LOCK_0        ( FPGA_CCC_C0_0_PLL_LOCK_0 ) 
        );

//--------INIT_MONITOR
INIT_MONITOR INIT_MONITOR_0(
        // Outputs
        .FABRIC_POR_N               ( INIT_MONITOR_0_FABRIC_POR_N ),
        .PCIE_INIT_DONE             (  ),
        .USRAM_INIT_DONE            (  ),
        .SRAM_INIT_DONE             (  ),
        .DEVICE_INIT_DONE           ( DEVICE_INIT_DONE_net_0 ),
        .XCVR_INIT_DONE             ( XCVR_INIT_DONE_net_0 ),
        .USRAM_INIT_FROM_SNVM_DONE  (  ),
        .USRAM_INIT_FROM_UPROM_DONE (  ),
        .USRAM_INIT_FROM_SPI_DONE   (  ),
        .SRAM_INIT_FROM_SNVM_DONE   (  ),
        .SRAM_INIT_FROM_UPROM_DONE  (  ),
        .SRAM_INIT_FROM_SPI_DONE    (  ),
        .AUTOCALIB_DONE             (  ) 
        );

//--------OSCILLATOR_160MHz
OSCILLATOR_160MHz OSCILLATOR_160MHz_inst_0(
        // Outputs
        .RCOSC_160MHZ_GL      ( RCOSC_160MHZ_GL_net_0 ),
        .RCOSC_160MHZ_CLK_DIV (  ) 
        );

//--------PF_CCC_ADC
PF_CCC_ADC PF_CCC_ADC_0(
        // Inputs
        .REF_CLK_0         ( RCOSC_160MHZ_GL_net_0 ),
        .PLL_POWERDOWN_N_0 ( VCC_net ),
        // Outputs
        .OUT0_FABCLK_0     ( ADC_MCLK_4_915MHz_net_0 ),
        .PLL_LOCK_0        (  ) 
        );


endmodule
