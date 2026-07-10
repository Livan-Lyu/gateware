//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Sat Jul 11 00:48:36 2026
// Version: 2025.1 2025.1.0.14
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// P9_GPIO
module P9_GPIO(
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
    GPIO_10_PAD,
    GPIO_12_PAD,
    GPIO_14_PAD,
    GPIO_17_PAD,
    GPIO_19_PAD,
    GPIO_1_PAD,
    GPIO_4_PAD
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
output [20:0] INT;
//--------------------------------------------------------------------
// Inout
//--------------------------------------------------------------------
inout         GPIO_10_PAD;
inout         GPIO_12_PAD;
inout         GPIO_14_PAD;
inout         GPIO_17_PAD;
inout         GPIO_19_PAD;
inout         GPIO_1_PAD;
inout         GPIO_4_PAD;
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
wire   [1:1]   CoreGPIO_P9_0_GPIO_OE1to1;
wire   [4:4]   CoreGPIO_P9_0_GPIO_OE4to4;
wire   [10:10] CoreGPIO_P9_0_GPIO_OE10to10;
wire   [12:12] CoreGPIO_P9_0_GPIO_OE12to12;
wire   [14:14] CoreGPIO_P9_0_GPIO_OE14to14;
wire   [17:17] CoreGPIO_P9_0_GPIO_OE17to17;
wire   [19:19] CoreGPIO_P9_0_GPIO_OE19to19;
wire   [1:1]   CoreGPIO_P9_0_GPIO_OUT1to1;
wire   [4:4]   CoreGPIO_P9_0_GPIO_OUT4to4;
wire   [10:10] CoreGPIO_P9_0_GPIO_OUT10to10;
wire   [12:12] CoreGPIO_P9_0_GPIO_OUT12to12;
wire   [14:14] CoreGPIO_P9_0_GPIO_OUT14to14;
wire   [17:17] CoreGPIO_P9_0_GPIO_OUT17to17;
wire   [19:19] CoreGPIO_P9_0_GPIO_OUT19to19;
wire           GPIO_1_BIBUF_Y;
wire           GPIO_1_PAD;
wire           GPIO_4_BIBUF_Y;
wire           GPIO_4_PAD;
wire           GPIO_10_BIBUF_Y;
wire           GPIO_10_PAD;
wire           GPIO_12_BIBUF_Y;
wire           GPIO_12_PAD;
wire           GPIO_14_BIBUF_Y;
wire           GPIO_14_PAD;
wire           GPIO_17_BIBUF_Y;
wire           GPIO_17_PAD;
wire           GPIO_19_BIBUF_Y;
wire           GPIO_19_PAD;
wire   [20:0]  INT_net_0;
wire           PCLK;
wire           PRESETN;
wire           APB_bif_PREADY_net_1;
wire           APB_bif_PSLVERR_net_1;
wire   [31:0]  APB_bif_PRDATA_net_1;
wire   [20:0]  INT_net_1;
wire   [0:0]   GPIO_OUT_slice_0;
wire   [11:11] GPIO_OUT_slice_1;
wire   [13:13] GPIO_OUT_slice_2;
wire   [15:15] GPIO_OUT_slice_3;
wire   [16:16] GPIO_OUT_slice_4;
wire   [18:18] GPIO_OUT_slice_5;
wire   [20:20] GPIO_OUT_slice_6;
wire   [2:2]   GPIO_OUT_slice_7;
wire   [3:3]   GPIO_OUT_slice_8;
wire   [5:5]   GPIO_OUT_slice_9;
wire   [6:6]   GPIO_OUT_slice_10;
wire   [7:7]   GPIO_OUT_slice_11;
wire   [8:8]   GPIO_OUT_slice_12;
wire   [9:9]   GPIO_OUT_slice_13;
wire   [0:0]   GPIO_OE_slice_0;
wire   [11:11] GPIO_OE_slice_1;
wire   [13:13] GPIO_OE_slice_2;
wire   [15:15] GPIO_OE_slice_3;
wire   [16:16] GPIO_OE_slice_4;
wire   [18:18] GPIO_OE_slice_5;
wire   [20:20] GPIO_OE_slice_6;
wire   [2:2]   GPIO_OE_slice_7;
wire   [3:3]   GPIO_OE_slice_8;
wire   [5:5]   GPIO_OE_slice_9;
wire   [6:6]   GPIO_OE_slice_10;
wire   [7:7]   GPIO_OE_slice_11;
wire   [8:8]   GPIO_OE_slice_12;
wire   [9:9]   GPIO_OE_slice_13;
wire   [20:0]  GPIO_IN_net_0;
wire   [20:0]  GPIO_OUT_net_0;
wire   [20:0]  GPIO_OE_net_0;
//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire           GND_net;
//--------------------------------------------------------------------
// Constant assignments
//--------------------------------------------------------------------
assign GND_net     = 1'b0;
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
assign INT[20:0]             = INT_net_1;
//--------------------------------------------------------------------
// Slices assignments
//--------------------------------------------------------------------
assign CoreGPIO_P9_0_GPIO_OE1to1[1]     = GPIO_OE_net_0[1:1];
assign CoreGPIO_P9_0_GPIO_OE4to4[4]     = GPIO_OE_net_0[4:4];
assign CoreGPIO_P9_0_GPIO_OE10to10[10]  = GPIO_OE_net_0[10:10];
assign CoreGPIO_P9_0_GPIO_OE12to12[12]  = GPIO_OE_net_0[12:12];
assign CoreGPIO_P9_0_GPIO_OE14to14[14]  = GPIO_OE_net_0[14:14];
assign CoreGPIO_P9_0_GPIO_OE17to17[17]  = GPIO_OE_net_0[17:17];
assign CoreGPIO_P9_0_GPIO_OE19to19[19]  = GPIO_OE_net_0[19:19];
assign CoreGPIO_P9_0_GPIO_OUT1to1[1]    = GPIO_OUT_net_0[1:1];
assign CoreGPIO_P9_0_GPIO_OUT4to4[4]    = GPIO_OUT_net_0[4:4];
assign CoreGPIO_P9_0_GPIO_OUT10to10[10] = GPIO_OUT_net_0[10:10];
assign CoreGPIO_P9_0_GPIO_OUT12to12[12] = GPIO_OUT_net_0[12:12];
assign CoreGPIO_P9_0_GPIO_OUT14to14[14] = GPIO_OUT_net_0[14:14];
assign CoreGPIO_P9_0_GPIO_OUT17to17[17] = GPIO_OUT_net_0[17:17];
assign CoreGPIO_P9_0_GPIO_OUT19to19[19] = GPIO_OUT_net_0[19:19];
assign GPIO_OUT_slice_0[0]              = GPIO_OUT_net_0[0:0];
assign GPIO_OUT_slice_1[11]             = GPIO_OUT_net_0[11:11];
assign GPIO_OUT_slice_2[13]             = GPIO_OUT_net_0[13:13];
assign GPIO_OUT_slice_3[15]             = GPIO_OUT_net_0[15:15];
assign GPIO_OUT_slice_4[16]             = GPIO_OUT_net_0[16:16];
assign GPIO_OUT_slice_5[18]             = GPIO_OUT_net_0[18:18];
assign GPIO_OUT_slice_6[20]             = GPIO_OUT_net_0[20:20];
assign GPIO_OUT_slice_7[2]              = GPIO_OUT_net_0[2:2];
assign GPIO_OUT_slice_8[3]              = GPIO_OUT_net_0[3:3];
assign GPIO_OUT_slice_9[5]              = GPIO_OUT_net_0[5:5];
assign GPIO_OUT_slice_10[6]             = GPIO_OUT_net_0[6:6];
assign GPIO_OUT_slice_11[7]             = GPIO_OUT_net_0[7:7];
assign GPIO_OUT_slice_12[8]             = GPIO_OUT_net_0[8:8];
assign GPIO_OUT_slice_13[9]             = GPIO_OUT_net_0[9:9];
assign GPIO_OE_slice_0[0]               = GPIO_OE_net_0[0:0];
assign GPIO_OE_slice_1[11]              = GPIO_OE_net_0[11:11];
assign GPIO_OE_slice_2[13]              = GPIO_OE_net_0[13:13];
assign GPIO_OE_slice_3[15]              = GPIO_OE_net_0[15:15];
assign GPIO_OE_slice_4[16]              = GPIO_OE_net_0[16:16];
assign GPIO_OE_slice_5[18]              = GPIO_OE_net_0[18:18];
assign GPIO_OE_slice_6[20]              = GPIO_OE_net_0[20:20];
assign GPIO_OE_slice_7[2]               = GPIO_OE_net_0[2:2];
assign GPIO_OE_slice_8[3]               = GPIO_OE_net_0[3:3];
assign GPIO_OE_slice_9[5]               = GPIO_OE_net_0[5:5];
assign GPIO_OE_slice_10[6]              = GPIO_OE_net_0[6:6];
assign GPIO_OE_slice_11[7]              = GPIO_OE_net_0[7:7];
assign GPIO_OE_slice_12[8]              = GPIO_OE_net_0[8:8];
assign GPIO_OE_slice_13[9]              = GPIO_OE_net_0[9:9];
//--------------------------------------------------------------------
// Concatenation assignments
//--------------------------------------------------------------------
assign GPIO_IN_net_0 = { 1'b0 , GPIO_19_BIBUF_Y , 1'b0 , GPIO_17_BIBUF_Y , 1'b0 , 1'b0 , GPIO_14_BIBUF_Y , 1'b0 , GPIO_12_BIBUF_Y , 1'b0 , GPIO_10_BIBUF_Y , 1'b0 , 1'b0 , 1'b0 , 1'b0 , 1'b0 , GPIO_4_BIBUF_Y , 1'b0 , 1'b0 , GPIO_1_BIBUF_Y , 1'b0 };
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------CoreGPIO_P9
CoreGPIO_P9 CoreGPIO_P9_0(
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
BIBUF GPIO_1_BIBUF(
        // Inputs
        .D   ( CoreGPIO_P9_0_GPIO_OUT1to1 ),
        .E   ( CoreGPIO_P9_0_GPIO_OE1to1 ),
        // Outputs
        .Y   ( GPIO_1_BIBUF_Y ),
        // Inouts
        .PAD ( GPIO_1_PAD ) 
        );

//--------BIBUF
BIBUF GPIO_4_BIBUF(
        // Inputs
        .D   ( CoreGPIO_P9_0_GPIO_OUT4to4 ),
        .E   ( CoreGPIO_P9_0_GPIO_OE4to4 ),
        // Outputs
        .Y   ( GPIO_4_BIBUF_Y ),
        // Inouts
        .PAD ( GPIO_4_PAD ) 
        );

//--------BIBUF
BIBUF GPIO_10_BIBUF(
        // Inputs
        .D   ( CoreGPIO_P9_0_GPIO_OUT10to10 ),
        .E   ( CoreGPIO_P9_0_GPIO_OE10to10 ),
        // Outputs
        .Y   ( GPIO_10_BIBUF_Y ),
        // Inouts
        .PAD ( GPIO_10_PAD ) 
        );

//--------BIBUF
BIBUF GPIO_12_BIBUF(
        // Inputs
        .D   ( CoreGPIO_P9_0_GPIO_OUT12to12 ),
        .E   ( CoreGPIO_P9_0_GPIO_OE12to12 ),
        // Outputs
        .Y   ( GPIO_12_BIBUF_Y ),
        // Inouts
        .PAD ( GPIO_12_PAD ) 
        );

//--------BIBUF
BIBUF GPIO_14_BIBUF(
        // Inputs
        .D   ( CoreGPIO_P9_0_GPIO_OUT14to14 ),
        .E   ( CoreGPIO_P9_0_GPIO_OE14to14 ),
        // Outputs
        .Y   ( GPIO_14_BIBUF_Y ),
        // Inouts
        .PAD ( GPIO_14_PAD ) 
        );

//--------BIBUF
BIBUF GPIO_17_BIBUF(
        // Inputs
        .D   ( CoreGPIO_P9_0_GPIO_OUT17to17 ),
        .E   ( CoreGPIO_P9_0_GPIO_OE17to17 ),
        // Outputs
        .Y   ( GPIO_17_BIBUF_Y ),
        // Inouts
        .PAD ( GPIO_17_PAD ) 
        );

//--------BIBUF
BIBUF GPIO_19_BIBUF(
        // Inputs
        .D   ( CoreGPIO_P9_0_GPIO_OUT19to19 ),
        .E   ( CoreGPIO_P9_0_GPIO_OE19to19 ),
        // Outputs
        .Y   ( GPIO_19_BIBUF_Y ),
        // Inouts
        .PAD ( GPIO_19_PAD ) 
        );


endmodule
