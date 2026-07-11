//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Sun Jul 12 03:52:38 2026
// Version: 2025.1 2025.1.0.14
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// CAPE_PWM
module CAPE_PWM(
    // Inputs
    APBslave_PADDR,
    APBslave_PENABLE,
    APBslave_PSEL,
    APBslave_PWDATA,
    APBslave_PWRITE,
    PCLK,
    PRESETN,
    // Outputs
    APBslave_PRDATA,
    APBslave_PREADY,
    APBslave_PSLVERR,
    PWM_0,
    PWM_1
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input  [7:0]  APBslave_PADDR;
input         APBslave_PENABLE;
input         APBslave_PSEL;
input  [31:0] APBslave_PWDATA;
input         APBslave_PWRITE;
input         PCLK;
input         PRESETN;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output [31:0] APBslave_PRDATA;
output        APBslave_PREADY;
output        APBslave_PSLVERR;
output        PWM_0;
output        PWM_1;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire   [7:0]  APBslave_PADDR;
wire          APBslave_PENABLE;
wire   [31:0] APBslave_PRDATA_net_0;
wire          APBslave_PREADY_net_0;
wire          APBslave_PSEL;
wire          APBslave_PSLVERR_net_0;
wire   [31:0] APBslave_PWDATA;
wire          APBslave_PWRITE;
wire          PCLK;
wire          PRESETN;
wire   [0:0]  PWM_0_net_0;
wire   [1:1]  PWM_1_net_0;
wire          APBslave_PREADY_net_1;
wire          APBslave_PSLVERR_net_1;
wire          PWM_0_net_1;
wire          PWM_1_net_1;
wire   [31:0] APBslave_PRDATA_net_1;
wire   [1:0]  PWM_net_0;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign APBslave_PREADY_net_1  = APBslave_PREADY_net_0;
assign APBslave_PREADY        = APBslave_PREADY_net_1;
assign APBslave_PSLVERR_net_1 = APBslave_PSLVERR_net_0;
assign APBslave_PSLVERR       = APBslave_PSLVERR_net_1;
assign PWM_0_net_1            = PWM_0_net_0[0];
assign PWM_0                  = PWM_0_net_1;
assign PWM_1_net_1            = PWM_1_net_0[1];
assign PWM_1                  = PWM_1_net_1;
assign APBslave_PRDATA_net_1  = APBslave_PRDATA_net_0;
assign APBslave_PRDATA[31:0]  = APBslave_PRDATA_net_1;
//--------------------------------------------------------------------
// Slices assignments
//--------------------------------------------------------------------
assign PWM_0_net_0[0] = PWM_net_0[0:0];
assign PWM_1_net_0[1] = PWM_net_0[1:1];
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------corepwm_C1
corepwm_C1 corepwm_C1_0(
        // Inputs
        .PCLK    ( PCLK ),
        .PRESETN ( PRESETN ),
        .PADDR   ( APBslave_PADDR ),
        .PENABLE ( APBslave_PENABLE ),
        .PSEL    ( APBslave_PSEL ),
        .PWDATA  ( APBslave_PWDATA ),
        .PWRITE  ( APBslave_PWRITE ),
        // Outputs
        .PWM     ( PWM_net_0 ),
        .PRDATA  ( APBslave_PRDATA_net_0 ),
        .PREADY  ( APBslave_PREADY_net_0 ),
        .PSLVERR ( APBslave_PSLVERR_net_0 ) 
        );


endmodule
