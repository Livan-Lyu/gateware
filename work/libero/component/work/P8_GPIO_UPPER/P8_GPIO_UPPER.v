//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Sun Jul 12 07:17:46 2026
// Version: 2025.1 2025.1.0.14
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// P8_GPIO_UPPER
module P8_GPIO_UPPER(
    // Inputs
    APB_bif_PADDR,
    APB_bif_PENABLE,
    APB_bif_PSEL,
    APB_bif_PWDATA,
    APB_bif_PWRITE,
    PCLK,
    PRESETN,
    // Outputs
    APB_bif_PRDATA,
    APB_bif_PREADY,
    APB_bif_PSLVERR,
    INT,
    // Inouts
    GPIO_0_PAD,
    GPIO_10_PAD,
    GPIO_11_PAD,
    GPIO_12_PAD,
    GPIO_13_PAD,
    GPIO_14_PAD,
    GPIO_15_PAD,
    GPIO_1_PAD,
    GPIO_2_PAD,
    GPIO_3_PAD,
    GPIO_4_PAD,
    GPIO_5_PAD,
    GPIO_6_PAD,
    GPIO_7_PAD,
    GPIO_8_PAD,
    GPIO_9_PAD
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input  [7:0]  APB_bif_PADDR;
input         APB_bif_PENABLE;
input         APB_bif_PSEL;
input  [31:0] APB_bif_PWDATA;
input         APB_bif_PWRITE;
input         PCLK;
input         PRESETN;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output [31:0] APB_bif_PRDATA;
output        APB_bif_PREADY;
output        APB_bif_PSLVERR;
output [15:0] INT;
//--------------------------------------------------------------------
// Inout
//--------------------------------------------------------------------
inout         GPIO_0_PAD;
inout         GPIO_10_PAD;
inout         GPIO_11_PAD;
inout         GPIO_12_PAD;
inout         GPIO_13_PAD;
inout         GPIO_14_PAD;
inout         GPIO_15_PAD;
inout         GPIO_1_PAD;
inout         GPIO_2_PAD;
inout         GPIO_3_PAD;
inout         GPIO_4_PAD;
inout         GPIO_5_PAD;
inout         GPIO_6_PAD;
inout         GPIO_7_PAD;
inout         GPIO_8_PAD;
inout         GPIO_9_PAD;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire   [7:0]   APB_bif_PADDR;
wire           APB_bif_PENABLE;
wire   [31:0]  APB_bif_PRDATA_net_0;
wire           APB_bif_PREADY_net_0;
wire           APB_bif_PSEL;
wire           APB_bif_PSLVERR_net_0;
wire   [31:0]  APB_bif_PWDATA;
wire           APB_bif_PWRITE;
wire   [0:0]   CoreGPIO_P8_UPPER_0_GPIO_OE0to0;
wire   [1:1]   CoreGPIO_P8_UPPER_0_GPIO_OE1to1;
wire   [2:2]   CoreGPIO_P8_UPPER_0_GPIO_OE2to2;
wire   [3:3]   CoreGPIO_P8_UPPER_0_GPIO_OE3to3;
wire   [4:4]   CoreGPIO_P8_UPPER_0_GPIO_OE4to4;
wire   [5:5]   CoreGPIO_P8_UPPER_0_GPIO_OE5to5;
wire   [6:6]   CoreGPIO_P8_UPPER_0_GPIO_OE6to6;
wire   [7:7]   CoreGPIO_P8_UPPER_0_GPIO_OE7to7;
wire   [8:8]   CoreGPIO_P8_UPPER_0_GPIO_OE8to8;
wire   [9:9]   CoreGPIO_P8_UPPER_0_GPIO_OE9to9;
wire   [10:10] CoreGPIO_P8_UPPER_0_GPIO_OE10to10;
wire   [11:11] CoreGPIO_P8_UPPER_0_GPIO_OE11to11;
wire   [12:12] CoreGPIO_P8_UPPER_0_GPIO_OE12to12;
wire   [13:13] CoreGPIO_P8_UPPER_0_GPIO_OE13to13;
wire   [14:14] CoreGPIO_P8_UPPER_0_GPIO_OE14to14;
wire   [15:15] CoreGPIO_P8_UPPER_0_GPIO_OE15to15;
wire   [0:0]   CoreGPIO_P8_UPPER_0_GPIO_OUT0to0;
wire   [1:1]   CoreGPIO_P8_UPPER_0_GPIO_OUT1to1;
wire   [2:2]   CoreGPIO_P8_UPPER_0_GPIO_OUT2to2;
wire   [3:3]   CoreGPIO_P8_UPPER_0_GPIO_OUT3to3;
wire   [4:4]   CoreGPIO_P8_UPPER_0_GPIO_OUT4to4;
wire   [5:5]   CoreGPIO_P8_UPPER_0_GPIO_OUT5to5;
wire   [6:6]   CoreGPIO_P8_UPPER_0_GPIO_OUT6to6;
wire   [7:7]   CoreGPIO_P8_UPPER_0_GPIO_OUT7to7;
wire   [8:8]   CoreGPIO_P8_UPPER_0_GPIO_OUT8to8;
wire   [9:9]   CoreGPIO_P8_UPPER_0_GPIO_OUT9to9;
wire   [10:10] CoreGPIO_P8_UPPER_0_GPIO_OUT10to10;
wire   [11:11] CoreGPIO_P8_UPPER_0_GPIO_OUT11to11;
wire   [12:12] CoreGPIO_P8_UPPER_0_GPIO_OUT12to12;
wire   [13:13] CoreGPIO_P8_UPPER_0_GPIO_OUT13to13;
wire   [14:14] CoreGPIO_P8_UPPER_0_GPIO_OUT14to14;
wire   [15:15] CoreGPIO_P8_UPPER_0_GPIO_OUT15to15;
wire           GPIO_0_BIBUF_Y;
wire           GPIO_0_PAD;
wire           GPIO_1_BIBUF_Y;
wire           GPIO_1_PAD;
wire           GPIO_2_BIBUF_Y;
wire           GPIO_2_PAD;
wire           GPIO_3_BIBUF_Y;
wire           GPIO_3_PAD;
wire           GPIO_4_BIBUF_Y;
wire           GPIO_4_PAD;
wire           GPIO_5_BIBUF_Y;
wire           GPIO_5_PAD;
wire           GPIO_6_BIBUF_Y;
wire           GPIO_6_PAD;
wire           GPIO_7_BIBUF_Y;
wire           GPIO_7_PAD;
wire           GPIO_8_BIBUF_Y;
wire           GPIO_8_PAD;
wire           GPIO_9_BIBUF_Y;
wire           GPIO_9_PAD;
wire           GPIO_10_BIBUF_Y;
wire           GPIO_10_PAD;
wire           GPIO_11_BIBUF_Y;
wire           GPIO_11_PAD;
wire           GPIO_12_BIBUF_Y;
wire           GPIO_12_PAD;
wire           GPIO_13_BIBUF_Y;
wire           GPIO_13_PAD;
wire           GPIO_14_BIBUF_Y;
wire           GPIO_14_PAD;
wire           GPIO_15_BIBUF_Y;
wire           GPIO_15_PAD;
wire   [15:0]  INT_net_0;
wire           PCLK;
wire           PRESETN;
wire           APB_bif_PREADY_net_1;
wire           APB_bif_PSLVERR_net_1;
wire   [31:0]  APB_bif_PRDATA_net_1;
wire   [15:0]  INT_net_1;
wire   [15:0]  GPIO_IN_net_0;
wire   [15:0]  GPIO_OUT_net_0;
wire   [15:0]  GPIO_OE_net_0;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign APB_bif_PREADY_net_1  = APB_bif_PREADY_net_0;
assign APB_bif_PREADY        = APB_bif_PREADY_net_1;
assign APB_bif_PSLVERR_net_1 = APB_bif_PSLVERR_net_0;
assign APB_bif_PSLVERR       = APB_bif_PSLVERR_net_1;
assign APB_bif_PRDATA_net_1  = APB_bif_PRDATA_net_0;
assign APB_bif_PRDATA[31:0]  = APB_bif_PRDATA_net_1;
assign INT_net_1             = INT_net_0;
assign INT[15:0]             = INT_net_1;
//--------------------------------------------------------------------
// Slices assignments
//--------------------------------------------------------------------
assign CoreGPIO_P8_UPPER_0_GPIO_OE0to0[0]     = GPIO_OE_net_0[0:0];
assign CoreGPIO_P8_UPPER_0_GPIO_OE1to1[1]     = GPIO_OE_net_0[1:1];
assign CoreGPIO_P8_UPPER_0_GPIO_OE2to2[2]     = GPIO_OE_net_0[2:2];
assign CoreGPIO_P8_UPPER_0_GPIO_OE3to3[3]     = GPIO_OE_net_0[3:3];
assign CoreGPIO_P8_UPPER_0_GPIO_OE4to4[4]     = GPIO_OE_net_0[4:4];
assign CoreGPIO_P8_UPPER_0_GPIO_OE5to5[5]     = GPIO_OE_net_0[5:5];
assign CoreGPIO_P8_UPPER_0_GPIO_OE6to6[6]     = GPIO_OE_net_0[6:6];
assign CoreGPIO_P8_UPPER_0_GPIO_OE7to7[7]     = GPIO_OE_net_0[7:7];
assign CoreGPIO_P8_UPPER_0_GPIO_OE8to8[8]     = GPIO_OE_net_0[8:8];
assign CoreGPIO_P8_UPPER_0_GPIO_OE9to9[9]     = GPIO_OE_net_0[9:9];
assign CoreGPIO_P8_UPPER_0_GPIO_OE10to10[10]  = GPIO_OE_net_0[10:10];
assign CoreGPIO_P8_UPPER_0_GPIO_OE11to11[11]  = GPIO_OE_net_0[11:11];
assign CoreGPIO_P8_UPPER_0_GPIO_OE12to12[12]  = GPIO_OE_net_0[12:12];
assign CoreGPIO_P8_UPPER_0_GPIO_OE13to13[13]  = GPIO_OE_net_0[13:13];
assign CoreGPIO_P8_UPPER_0_GPIO_OE14to14[14]  = GPIO_OE_net_0[14:14];
assign CoreGPIO_P8_UPPER_0_GPIO_OE15to15[15]  = GPIO_OE_net_0[15:15];
assign CoreGPIO_P8_UPPER_0_GPIO_OUT0to0[0]    = GPIO_OUT_net_0[0:0];
assign CoreGPIO_P8_UPPER_0_GPIO_OUT1to1[1]    = GPIO_OUT_net_0[1:1];
assign CoreGPIO_P8_UPPER_0_GPIO_OUT2to2[2]    = GPIO_OUT_net_0[2:2];
assign CoreGPIO_P8_UPPER_0_GPIO_OUT3to3[3]    = GPIO_OUT_net_0[3:3];
assign CoreGPIO_P8_UPPER_0_GPIO_OUT4to4[4]    = GPIO_OUT_net_0[4:4];
assign CoreGPIO_P8_UPPER_0_GPIO_OUT5to5[5]    = GPIO_OUT_net_0[5:5];
assign CoreGPIO_P8_UPPER_0_GPIO_OUT6to6[6]    = GPIO_OUT_net_0[6:6];
assign CoreGPIO_P8_UPPER_0_GPIO_OUT7to7[7]    = GPIO_OUT_net_0[7:7];
assign CoreGPIO_P8_UPPER_0_GPIO_OUT8to8[8]    = GPIO_OUT_net_0[8:8];
assign CoreGPIO_P8_UPPER_0_GPIO_OUT9to9[9]    = GPIO_OUT_net_0[9:9];
assign CoreGPIO_P8_UPPER_0_GPIO_OUT10to10[10] = GPIO_OUT_net_0[10:10];
assign CoreGPIO_P8_UPPER_0_GPIO_OUT11to11[11] = GPIO_OUT_net_0[11:11];
assign CoreGPIO_P8_UPPER_0_GPIO_OUT12to12[12] = GPIO_OUT_net_0[12:12];
assign CoreGPIO_P8_UPPER_0_GPIO_OUT13to13[13] = GPIO_OUT_net_0[13:13];
assign CoreGPIO_P8_UPPER_0_GPIO_OUT14to14[14] = GPIO_OUT_net_0[14:14];
assign CoreGPIO_P8_UPPER_0_GPIO_OUT15to15[15] = GPIO_OUT_net_0[15:15];
//--------------------------------------------------------------------
// Concatenation assignments
//--------------------------------------------------------------------
assign GPIO_IN_net_0 = { GPIO_15_BIBUF_Y , GPIO_14_BIBUF_Y , GPIO_13_BIBUF_Y , GPIO_12_BIBUF_Y , GPIO_11_BIBUF_Y , GPIO_10_BIBUF_Y , GPIO_9_BIBUF_Y , GPIO_8_BIBUF_Y , GPIO_7_BIBUF_Y , GPIO_6_BIBUF_Y , GPIO_5_BIBUF_Y , GPIO_4_BIBUF_Y , GPIO_3_BIBUF_Y , GPIO_2_BIBUF_Y , GPIO_1_BIBUF_Y , GPIO_0_BIBUF_Y };
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------CoreGPIO_P8_UPPER
CoreGPIO_P8_UPPER CoreGPIO_P8_UPPER_0(
        // Inputs
        .PRESETN  ( PRESETN ),
        .PCLK     ( PCLK ),
        .GPIO_IN  ( GPIO_IN_net_0 ),
        .PADDR    ( APB_bif_PADDR ),
        .PSEL     ( APB_bif_PSEL ),
        .PENABLE  ( APB_bif_PENABLE ),
        .PWRITE   ( APB_bif_PWRITE ),
        .PWDATA   ( APB_bif_PWDATA ),
        // Outputs
        .INT      ( INT_net_0 ),
        .GPIO_OUT ( GPIO_OUT_net_0 ),
        .GPIO_OE  ( GPIO_OE_net_0 ),
        .PRDATA   ( APB_bif_PRDATA_net_0 ),
        .PREADY   ( APB_bif_PREADY_net_0 ),
        .PSLVERR  ( APB_bif_PSLVERR_net_0 ) 
        );

//--------BIBUF
BIBUF GPIO_0_BIBUF(
        // Inputs
        .D   ( CoreGPIO_P8_UPPER_0_GPIO_OUT0to0 ),
        .E   ( CoreGPIO_P8_UPPER_0_GPIO_OE0to0 ),
        // Outputs
        .Y   ( GPIO_0_BIBUF_Y ),
        // Inouts
        .PAD ( GPIO_0_PAD ) 
        );

//--------BIBUF
BIBUF GPIO_1_BIBUF(
        // Inputs
        .D   ( CoreGPIO_P8_UPPER_0_GPIO_OUT1to1 ),
        .E   ( CoreGPIO_P8_UPPER_0_GPIO_OE1to1 ),
        // Outputs
        .Y   ( GPIO_1_BIBUF_Y ),
        // Inouts
        .PAD ( GPIO_1_PAD ) 
        );

//--------BIBUF
BIBUF GPIO_2_BIBUF(
        // Inputs
        .D   ( CoreGPIO_P8_UPPER_0_GPIO_OUT2to2 ),
        .E   ( CoreGPIO_P8_UPPER_0_GPIO_OE2to2 ),
        // Outputs
        .Y   ( GPIO_2_BIBUF_Y ),
        // Inouts
        .PAD ( GPIO_2_PAD ) 
        );

//--------BIBUF
BIBUF GPIO_3_BIBUF(
        // Inputs
        .D   ( CoreGPIO_P8_UPPER_0_GPIO_OUT3to3 ),
        .E   ( CoreGPIO_P8_UPPER_0_GPIO_OE3to3 ),
        // Outputs
        .Y   ( GPIO_3_BIBUF_Y ),
        // Inouts
        .PAD ( GPIO_3_PAD ) 
        );

//--------BIBUF
BIBUF GPIO_4_BIBUF(
        // Inputs
        .D   ( CoreGPIO_P8_UPPER_0_GPIO_OUT4to4 ),
        .E   ( CoreGPIO_P8_UPPER_0_GPIO_OE4to4 ),
        // Outputs
        .Y   ( GPIO_4_BIBUF_Y ),
        // Inouts
        .PAD ( GPIO_4_PAD ) 
        );

//--------BIBUF
BIBUF GPIO_5_BIBUF(
        // Inputs
        .D   ( CoreGPIO_P8_UPPER_0_GPIO_OUT5to5 ),
        .E   ( CoreGPIO_P8_UPPER_0_GPIO_OE5to5 ),
        // Outputs
        .Y   ( GPIO_5_BIBUF_Y ),
        // Inouts
        .PAD ( GPIO_5_PAD ) 
        );

//--------BIBUF
BIBUF GPIO_6_BIBUF(
        // Inputs
        .D   ( CoreGPIO_P8_UPPER_0_GPIO_OUT6to6 ),
        .E   ( CoreGPIO_P8_UPPER_0_GPIO_OE6to6 ),
        // Outputs
        .Y   ( GPIO_6_BIBUF_Y ),
        // Inouts
        .PAD ( GPIO_6_PAD ) 
        );

//--------BIBUF
BIBUF GPIO_7_BIBUF(
        // Inputs
        .D   ( CoreGPIO_P8_UPPER_0_GPIO_OUT7to7 ),
        .E   ( CoreGPIO_P8_UPPER_0_GPIO_OE7to7 ),
        // Outputs
        .Y   ( GPIO_7_BIBUF_Y ),
        // Inouts
        .PAD ( GPIO_7_PAD ) 
        );

//--------BIBUF
BIBUF GPIO_8_BIBUF(
        // Inputs
        .D   ( CoreGPIO_P8_UPPER_0_GPIO_OUT8to8 ),
        .E   ( CoreGPIO_P8_UPPER_0_GPIO_OE8to8 ),
        // Outputs
        .Y   ( GPIO_8_BIBUF_Y ),
        // Inouts
        .PAD ( GPIO_8_PAD ) 
        );

//--------BIBUF
BIBUF GPIO_9_BIBUF(
        // Inputs
        .D   ( CoreGPIO_P8_UPPER_0_GPIO_OUT9to9 ),
        .E   ( CoreGPIO_P8_UPPER_0_GPIO_OE9to9 ),
        // Outputs
        .Y   ( GPIO_9_BIBUF_Y ),
        // Inouts
        .PAD ( GPIO_9_PAD ) 
        );

//--------BIBUF
BIBUF GPIO_10_BIBUF(
        // Inputs
        .D   ( CoreGPIO_P8_UPPER_0_GPIO_OUT10to10 ),
        .E   ( CoreGPIO_P8_UPPER_0_GPIO_OE10to10 ),
        // Outputs
        .Y   ( GPIO_10_BIBUF_Y ),
        // Inouts
        .PAD ( GPIO_10_PAD ) 
        );

//--------BIBUF
BIBUF GPIO_11_BIBUF(
        // Inputs
        .D   ( CoreGPIO_P8_UPPER_0_GPIO_OUT11to11 ),
        .E   ( CoreGPIO_P8_UPPER_0_GPIO_OE11to11 ),
        // Outputs
        .Y   ( GPIO_11_BIBUF_Y ),
        // Inouts
        .PAD ( GPIO_11_PAD ) 
        );

//--------BIBUF
BIBUF GPIO_12_BIBUF(
        // Inputs
        .D   ( CoreGPIO_P8_UPPER_0_GPIO_OUT12to12 ),
        .E   ( CoreGPIO_P8_UPPER_0_GPIO_OE12to12 ),
        // Outputs
        .Y   ( GPIO_12_BIBUF_Y ),
        // Inouts
        .PAD ( GPIO_12_PAD ) 
        );

//--------BIBUF
BIBUF GPIO_13_BIBUF(
        // Inputs
        .D   ( CoreGPIO_P8_UPPER_0_GPIO_OUT13to13 ),
        .E   ( CoreGPIO_P8_UPPER_0_GPIO_OE13to13 ),
        // Outputs
        .Y   ( GPIO_13_BIBUF_Y ),
        // Inouts
        .PAD ( GPIO_13_PAD ) 
        );

//--------BIBUF
BIBUF GPIO_14_BIBUF(
        // Inputs
        .D   ( CoreGPIO_P8_UPPER_0_GPIO_OUT14to14 ),
        .E   ( CoreGPIO_P8_UPPER_0_GPIO_OE14to14 ),
        // Outputs
        .Y   ( GPIO_14_BIBUF_Y ),
        // Inouts
        .PAD ( GPIO_14_PAD ) 
        );

//--------BIBUF
BIBUF GPIO_15_BIBUF(
        // Inputs
        .D   ( CoreGPIO_P8_UPPER_0_GPIO_OUT15to15 ),
        .E   ( CoreGPIO_P8_UPPER_0_GPIO_OE15to15 ),
        // Outputs
        .Y   ( GPIO_15_BIBUF_Y ),
        // Inouts
        .PAD ( GPIO_15_PAD ) 
        );


endmodule
