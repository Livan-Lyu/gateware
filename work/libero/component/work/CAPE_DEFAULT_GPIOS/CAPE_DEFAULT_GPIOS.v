//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Sun Jul 12 19:45:12 2026
// Version: 2025.1 2025.1.0.14
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// CAPE_DEFAULT_GPIOS
module CAPE_DEFAULT_GPIOS(
    // Inputs
    GPIO_OE,
    GPIO_OUT,
    // Outputs
    GPIO_IN,
    // Inouts
    GPIO_0_PAD,
    GPIO_11_PAD,
    GPIO_12_PAD,
    GPIO_13_PAD,
    GPIO_14_PAD,
    GPIO_15_PAD,
    GPIO_17_PAD,
    GPIO_18_PAD,
    GPIO_19_PAD,
    GPIO_1_PAD,
    GPIO_20_PAD,
    GPIO_21_PAD,
    GPIO_22_PAD,
    GPIO_23_PAD,
    GPIO_24_PAD,
    GPIO_25_PAD,
    GPIO_26_PAD,
    GPIO_27_PAD,
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
input  [27:0] GPIO_OE;
input  [27:0] GPIO_OUT;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output [27:0] GPIO_IN;
//--------------------------------------------------------------------
// Inout
//--------------------------------------------------------------------
inout         GPIO_0_PAD;
inout         GPIO_11_PAD;
inout         GPIO_12_PAD;
inout         GPIO_13_PAD;
inout         GPIO_14_PAD;
inout         GPIO_15_PAD;
inout         GPIO_17_PAD;
inout         GPIO_18_PAD;
inout         GPIO_19_PAD;
inout         GPIO_1_PAD;
inout         GPIO_20_PAD;
inout         GPIO_21_PAD;
inout         GPIO_22_PAD;
inout         GPIO_23_PAD;
inout         GPIO_24_PAD;
inout         GPIO_25_PAD;
inout         GPIO_26_PAD;
inout         GPIO_27_PAD;
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
wire           GPIO_0_PAD;
wire           GPIO_1_PAD;
wire           GPIO_2_PAD;
wire           GPIO_3_PAD;
wire           GPIO_4_PAD;
wire           GPIO_5_PAD;
wire           GPIO_6_PAD;
wire           GPIO_7_PAD;
wire           GPIO_8_PAD;
wire           GPIO_9_PAD;
wire           GPIO_11_PAD;
wire           GPIO_12_PAD;
wire           GPIO_13_PAD;
wire           GPIO_14_PAD;
wire           GPIO_15_PAD;
wire           GPIO_17_PAD;
wire           GPIO_18_PAD;
wire           GPIO_19_PAD;
wire           GPIO_20_PAD;
wire           GPIO_21_PAD;
wire           GPIO_22_PAD;
wire           GPIO_23_PAD;
wire           GPIO_24_PAD;
wire           GPIO_25_PAD;
wire           GPIO_26_PAD;
wire           GPIO_27_PAD;
wire           GPIO_IN_net_0;
wire           GPIO_IN_0;
wire           GPIO_IN_1;
wire           GPIO_IN_2;
wire           GPIO_IN_3;
wire           GPIO_IN_4;
wire           GPIO_IN_5;
wire           GPIO_IN_6;
wire           GPIO_IN_7;
wire           GPIO_IN_8;
wire           GPIO_IN_9;
wire           GPIO_IN_10;
wire           GPIO_IN_11;
wire           GPIO_IN_12;
wire           GPIO_IN_13;
wire           GPIO_IN_14;
wire           GPIO_IN_15;
wire           GPIO_IN_16;
wire           GPIO_IN_17;
wire           GPIO_IN_18;
wire           GPIO_IN_19;
wire           GPIO_IN_20;
wire           GPIO_IN_21;
wire           GPIO_IN_22;
wire           GPIO_IN_23;
wire           GPIO_IN_24;
wire   [0:0]   GPIO_OE_slice_0;
wire   [1:1]   GPIO_OE_slice_1;
wire   [2:2]   GPIO_OE_slice_2;
wire   [3:3]   GPIO_OE_slice_3;
wire   [4:4]   GPIO_OE_slice_4;
wire   [5:5]   GPIO_OE_slice_5;
wire   [6:6]   GPIO_OE_slice_6;
wire   [7:7]   GPIO_OE_slice_7;
wire   [8:8]   GPIO_OE_slice_8;
wire   [9:9]   GPIO_OE_slice_9;
wire   [11:11] GPIO_OE_slice_10;
wire   [12:12] GPIO_OE_slice_11;
wire   [13:13] GPIO_OE_slice_12;
wire   [14:14] GPIO_OE_slice_13;
wire   [15:15] GPIO_OE_slice_14;
wire   [17:17] GPIO_OE_slice_15;
wire   [18:18] GPIO_OE_slice_16;
wire   [19:19] GPIO_OE_slice_17;
wire   [20:20] GPIO_OE_slice_18;
wire   [21:21] GPIO_OE_slice_19;
wire   [22:22] GPIO_OE_slice_20;
wire   [23:23] GPIO_OE_slice_21;
wire   [24:24] GPIO_OE_slice_22;
wire   [25:25] GPIO_OE_slice_23;
wire   [26:26] GPIO_OE_slice_24;
wire   [27:27] GPIO_OE_slice_25;
wire   [0:0]   GPIO_OUT_slice_0;
wire   [1:1]   GPIO_OUT_slice_1;
wire   [2:2]   GPIO_OUT_slice_2;
wire   [3:3]   GPIO_OUT_slice_3;
wire   [4:4]   GPIO_OUT_slice_4;
wire   [5:5]   GPIO_OUT_slice_5;
wire   [6:6]   GPIO_OUT_slice_6;
wire   [7:7]   GPIO_OUT_slice_7;
wire   [8:8]   GPIO_OUT_slice_8;
wire   [9:9]   GPIO_OUT_slice_9;
wire   [11:11] GPIO_OUT_slice_10;
wire   [12:12] GPIO_OUT_slice_11;
wire   [13:13] GPIO_OUT_slice_12;
wire   [14:14] GPIO_OUT_slice_13;
wire   [15:15] GPIO_OUT_slice_14;
wire   [17:17] GPIO_OUT_slice_15;
wire   [18:18] GPIO_OUT_slice_16;
wire   [19:19] GPIO_OUT_slice_17;
wire   [20:20] GPIO_OUT_slice_18;
wire   [21:21] GPIO_OUT_slice_19;
wire   [22:22] GPIO_OUT_slice_20;
wire   [23:23] GPIO_OUT_slice_21;
wire   [24:24] GPIO_OUT_slice_22;
wire   [25:25] GPIO_OUT_slice_23;
wire   [26:26] GPIO_OUT_slice_24;
wire   [27:27] GPIO_OUT_slice_25;
wire   [0:0]   GPIO_IN_net_1;
wire   [11:11] GPIO_IN_9_net_0;
wire   [12:12] GPIO_IN_10_net_0;
wire   [13:13] GPIO_IN_11_net_0;
wire   [14:14] GPIO_IN_12_net_0;
wire   [15:15] GPIO_IN_13_net_0;
wire   [17:17] GPIO_IN_14_net_0;
wire   [18:18] GPIO_IN_15_net_0;
wire   [19:19] GPIO_IN_16_net_0;
wire   [1:1]   GPIO_IN_0_net_0;
wire   [20:20] GPIO_IN_17_net_0;
wire   [21:21] GPIO_IN_18_net_0;
wire   [22:22] GPIO_IN_19_net_0;
wire   [23:23] GPIO_IN_20_net_0;
wire   [24:24] GPIO_IN_21_net_0;
wire   [25:25] GPIO_IN_22_net_0;
wire   [26:26] GPIO_IN_23_net_0;
wire   [27:27] GPIO_IN_24_net_0;
wire   [2:2]   GPIO_IN_1_net_0;
wire   [3:3]   GPIO_IN_2_net_0;
wire   [4:4]   GPIO_IN_3_net_0;
wire   [5:5]   GPIO_IN_4_net_0;
wire   [6:6]   GPIO_IN_5_net_0;
wire   [7:7]   GPIO_IN_6_net_0;
wire   [8:8]   GPIO_IN_7_net_0;
wire   [9:9]   GPIO_IN_8_net_0;
wire   [27:0]  GPIO_OUT;
wire   [27:0]  GPIO_OE;
//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire           GND_net;
//--------------------------------------------------------------------
// Constant assignments
//--------------------------------------------------------------------
assign GND_net     = 1'b0;
//--------------------------------------------------------------------
// TieOff assignments
//--------------------------------------------------------------------
assign GPIO_IN[10:10]       = 1'b0;
assign GPIO_IN[16:16]       = 1'b0;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign GPIO_IN_net_1[0]     = GPIO_IN_net_0;
assign GPIO_IN[0:0]         = GPIO_IN_net_1[0];
assign GPIO_IN_9_net_0[11]  = GPIO_IN_9;
assign GPIO_IN[11:11]       = GPIO_IN_9_net_0[11];
assign GPIO_IN_10_net_0[12] = GPIO_IN_10;
assign GPIO_IN[12:12]       = GPIO_IN_10_net_0[12];
assign GPIO_IN_11_net_0[13] = GPIO_IN_11;
assign GPIO_IN[13:13]       = GPIO_IN_11_net_0[13];
assign GPIO_IN_12_net_0[14] = GPIO_IN_12;
assign GPIO_IN[14:14]       = GPIO_IN_12_net_0[14];
assign GPIO_IN_13_net_0[15] = GPIO_IN_13;
assign GPIO_IN[15:15]       = GPIO_IN_13_net_0[15];
assign GPIO_IN_14_net_0[17] = GPIO_IN_14;
assign GPIO_IN[17:17]       = GPIO_IN_14_net_0[17];
assign GPIO_IN_15_net_0[18] = GPIO_IN_15;
assign GPIO_IN[18:18]       = GPIO_IN_15_net_0[18];
assign GPIO_IN_16_net_0[19] = GPIO_IN_16;
assign GPIO_IN[19:19]       = GPIO_IN_16_net_0[19];
assign GPIO_IN_0_net_0[1]   = GPIO_IN_0;
assign GPIO_IN[1:1]         = GPIO_IN_0_net_0[1];
assign GPIO_IN_17_net_0[20] = GPIO_IN_17;
assign GPIO_IN[20:20]       = GPIO_IN_17_net_0[20];
assign GPIO_IN_18_net_0[21] = GPIO_IN_18;
assign GPIO_IN[21:21]       = GPIO_IN_18_net_0[21];
assign GPIO_IN_19_net_0[22] = GPIO_IN_19;
assign GPIO_IN[22:22]       = GPIO_IN_19_net_0[22];
assign GPIO_IN_20_net_0[23] = GPIO_IN_20;
assign GPIO_IN[23:23]       = GPIO_IN_20_net_0[23];
assign GPIO_IN_21_net_0[24] = GPIO_IN_21;
assign GPIO_IN[24:24]       = GPIO_IN_21_net_0[24];
assign GPIO_IN_22_net_0[25] = GPIO_IN_22;
assign GPIO_IN[25:25]       = GPIO_IN_22_net_0[25];
assign GPIO_IN_23_net_0[26] = GPIO_IN_23;
assign GPIO_IN[26:26]       = GPIO_IN_23_net_0[26];
assign GPIO_IN_24_net_0[27] = GPIO_IN_24;
assign GPIO_IN[27:27]       = GPIO_IN_24_net_0[27];
assign GPIO_IN_1_net_0[2]   = GPIO_IN_1;
assign GPIO_IN[2:2]         = GPIO_IN_1_net_0[2];
assign GPIO_IN_2_net_0[3]   = GPIO_IN_2;
assign GPIO_IN[3:3]         = GPIO_IN_2_net_0[3];
assign GPIO_IN_3_net_0[4]   = GPIO_IN_3;
assign GPIO_IN[4:4]         = GPIO_IN_3_net_0[4];
assign GPIO_IN_4_net_0[5]   = GPIO_IN_4;
assign GPIO_IN[5:5]         = GPIO_IN_4_net_0[5];
assign GPIO_IN_5_net_0[6]   = GPIO_IN_5;
assign GPIO_IN[6:6]         = GPIO_IN_5_net_0[6];
assign GPIO_IN_6_net_0[7]   = GPIO_IN_6;
assign GPIO_IN[7:7]         = GPIO_IN_6_net_0[7];
assign GPIO_IN_7_net_0[8]   = GPIO_IN_7;
assign GPIO_IN[8:8]         = GPIO_IN_7_net_0[8];
assign GPIO_IN_8_net_0[9]   = GPIO_IN_8;
assign GPIO_IN[9:9]         = GPIO_IN_8_net_0[9];
//--------------------------------------------------------------------
// Slices assignments
//--------------------------------------------------------------------
assign GPIO_OE_slice_0[0]    = GPIO_OE[0:0];
assign GPIO_OE_slice_1[1]    = GPIO_OE[1:1];
assign GPIO_OE_slice_2[2]    = GPIO_OE[2:2];
assign GPIO_OE_slice_3[3]    = GPIO_OE[3:3];
assign GPIO_OE_slice_4[4]    = GPIO_OE[4:4];
assign GPIO_OE_slice_5[5]    = GPIO_OE[5:5];
assign GPIO_OE_slice_6[6]    = GPIO_OE[6:6];
assign GPIO_OE_slice_7[7]    = GPIO_OE[7:7];
assign GPIO_OE_slice_8[8]    = GPIO_OE[8:8];
assign GPIO_OE_slice_9[9]    = GPIO_OE[9:9];
assign GPIO_OE_slice_10[11]  = GPIO_OE[11:11];
assign GPIO_OE_slice_11[12]  = GPIO_OE[12:12];
assign GPIO_OE_slice_12[13]  = GPIO_OE[13:13];
assign GPIO_OE_slice_13[14]  = GPIO_OE[14:14];
assign GPIO_OE_slice_14[15]  = GPIO_OE[15:15];
assign GPIO_OE_slice_15[17]  = GPIO_OE[17:17];
assign GPIO_OE_slice_16[18]  = GPIO_OE[18:18];
assign GPIO_OE_slice_17[19]  = GPIO_OE[19:19];
assign GPIO_OE_slice_18[20]  = GPIO_OE[20:20];
assign GPIO_OE_slice_19[21]  = GPIO_OE[21:21];
assign GPIO_OE_slice_20[22]  = GPIO_OE[22:22];
assign GPIO_OE_slice_21[23]  = GPIO_OE[23:23];
assign GPIO_OE_slice_22[24]  = GPIO_OE[24:24];
assign GPIO_OE_slice_23[25]  = GPIO_OE[25:25];
assign GPIO_OE_slice_24[26]  = GPIO_OE[26:26];
assign GPIO_OE_slice_25[27]  = GPIO_OE[27:27];
assign GPIO_OUT_slice_0[0]   = GPIO_OUT[0:0];
assign GPIO_OUT_slice_1[1]   = GPIO_OUT[1:1];
assign GPIO_OUT_slice_2[2]   = GPIO_OUT[2:2];
assign GPIO_OUT_slice_3[3]   = GPIO_OUT[3:3];
assign GPIO_OUT_slice_4[4]   = GPIO_OUT[4:4];
assign GPIO_OUT_slice_5[5]   = GPIO_OUT[5:5];
assign GPIO_OUT_slice_6[6]   = GPIO_OUT[6:6];
assign GPIO_OUT_slice_7[7]   = GPIO_OUT[7:7];
assign GPIO_OUT_slice_8[8]   = GPIO_OUT[8:8];
assign GPIO_OUT_slice_9[9]   = GPIO_OUT[9:9];
assign GPIO_OUT_slice_10[11] = GPIO_OUT[11:11];
assign GPIO_OUT_slice_11[12] = GPIO_OUT[12:12];
assign GPIO_OUT_slice_12[13] = GPIO_OUT[13:13];
assign GPIO_OUT_slice_13[14] = GPIO_OUT[14:14];
assign GPIO_OUT_slice_14[15] = GPIO_OUT[15:15];
assign GPIO_OUT_slice_15[17] = GPIO_OUT[17:17];
assign GPIO_OUT_slice_16[18] = GPIO_OUT[18:18];
assign GPIO_OUT_slice_17[19] = GPIO_OUT[19:19];
assign GPIO_OUT_slice_18[20] = GPIO_OUT[20:20];
assign GPIO_OUT_slice_19[21] = GPIO_OUT[21:21];
assign GPIO_OUT_slice_20[22] = GPIO_OUT[22:22];
assign GPIO_OUT_slice_21[23] = GPIO_OUT[23:23];
assign GPIO_OUT_slice_22[24] = GPIO_OUT[24:24];
assign GPIO_OUT_slice_23[25] = GPIO_OUT[25:25];
assign GPIO_OUT_slice_24[26] = GPIO_OUT[26:26];
assign GPIO_OUT_slice_25[27] = GPIO_OUT[27:27];
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------BIBUF
BIBUF GPIO_0_BIBUF(
        // Inputs
        .D   ( GPIO_OUT_slice_0 ),
        .E   ( GPIO_OE_slice_0 ),
        // Outputs
        .Y   ( GPIO_IN_net_0 ),
        // Inouts
        .PAD ( GPIO_0_PAD ) 
        );

//--------BIBUF
BIBUF GPIO_1_BIBUF(
        // Inputs
        .D   ( GPIO_OUT_slice_1 ),
        .E   ( GPIO_OE_slice_1 ),
        // Outputs
        .Y   ( GPIO_IN_0 ),
        // Inouts
        .PAD ( GPIO_1_PAD ) 
        );

//--------BIBUF
BIBUF GPIO_2_BIBUF(
        // Inputs
        .D   ( GPIO_OUT_slice_2 ),
        .E   ( GPIO_OE_slice_2 ),
        // Outputs
        .Y   ( GPIO_IN_1 ),
        // Inouts
        .PAD ( GPIO_2_PAD ) 
        );

//--------BIBUF
BIBUF GPIO_3_BIBUF(
        // Inputs
        .D   ( GPIO_OUT_slice_3 ),
        .E   ( GPIO_OE_slice_3 ),
        // Outputs
        .Y   ( GPIO_IN_2 ),
        // Inouts
        .PAD ( GPIO_3_PAD ) 
        );

//--------BIBUF
BIBUF GPIO_4_BIBUF(
        // Inputs
        .D   ( GPIO_OUT_slice_4 ),
        .E   ( GPIO_OE_slice_4 ),
        // Outputs
        .Y   ( GPIO_IN_3 ),
        // Inouts
        .PAD ( GPIO_4_PAD ) 
        );

//--------BIBUF
BIBUF GPIO_5_BIBUF(
        // Inputs
        .D   ( GPIO_OUT_slice_5 ),
        .E   ( GPIO_OE_slice_5 ),
        // Outputs
        .Y   ( GPIO_IN_4 ),
        // Inouts
        .PAD ( GPIO_5_PAD ) 
        );

//--------BIBUF
BIBUF GPIO_6_BIBUF(
        // Inputs
        .D   ( GPIO_OUT_slice_6 ),
        .E   ( GPIO_OE_slice_6 ),
        // Outputs
        .Y   ( GPIO_IN_5 ),
        // Inouts
        .PAD ( GPIO_6_PAD ) 
        );

//--------BIBUF
BIBUF GPIO_7_BIBUF(
        // Inputs
        .D   ( GPIO_OUT_slice_7 ),
        .E   ( GPIO_OE_slice_7 ),
        // Outputs
        .Y   ( GPIO_IN_6 ),
        // Inouts
        .PAD ( GPIO_7_PAD ) 
        );

//--------BIBUF
BIBUF GPIO_8_BIBUF(
        // Inputs
        .D   ( GPIO_OUT_slice_8 ),
        .E   ( GPIO_OE_slice_8 ),
        // Outputs
        .Y   ( GPIO_IN_7 ),
        // Inouts
        .PAD ( GPIO_8_PAD ) 
        );

//--------BIBUF
BIBUF GPIO_9_BIBUF(
        // Inputs
        .D   ( GPIO_OUT_slice_9 ),
        .E   ( GPIO_OE_slice_9 ),
        // Outputs
        .Y   ( GPIO_IN_8 ),
        // Inouts
        .PAD ( GPIO_9_PAD ) 
        );

//--------BIBUF
BIBUF GPIO_11_BIBUF(
        // Inputs
        .D   ( GPIO_OUT_slice_10 ),
        .E   ( GPIO_OE_slice_10 ),
        // Outputs
        .Y   ( GPIO_IN_9 ),
        // Inouts
        .PAD ( GPIO_11_PAD ) 
        );

//--------BIBUF
BIBUF GPIO_12_BIBUF(
        // Inputs
        .D   ( GPIO_OUT_slice_11 ),
        .E   ( GPIO_OE_slice_11 ),
        // Outputs
        .Y   ( GPIO_IN_10 ),
        // Inouts
        .PAD ( GPIO_12_PAD ) 
        );

//--------BIBUF
BIBUF GPIO_13_BIBUF(
        // Inputs
        .D   ( GPIO_OUT_slice_12 ),
        .E   ( GPIO_OE_slice_12 ),
        // Outputs
        .Y   ( GPIO_IN_11 ),
        // Inouts
        .PAD ( GPIO_13_PAD ) 
        );

//--------BIBUF
BIBUF GPIO_14_BIBUF(
        // Inputs
        .D   ( GPIO_OUT_slice_13 ),
        .E   ( GPIO_OE_slice_13 ),
        // Outputs
        .Y   ( GPIO_IN_12 ),
        // Inouts
        .PAD ( GPIO_14_PAD ) 
        );

//--------BIBUF
BIBUF GPIO_15_BIBUF(
        // Inputs
        .D   ( GPIO_OUT_slice_14 ),
        .E   ( GPIO_OE_slice_14 ),
        // Outputs
        .Y   ( GPIO_IN_13 ),
        // Inouts
        .PAD ( GPIO_15_PAD ) 
        );

//--------BIBUF
BIBUF GPIO_17_BIBUF(
        // Inputs
        .D   ( GPIO_OUT_slice_15 ),
        .E   ( GPIO_OE_slice_15 ),
        // Outputs
        .Y   ( GPIO_IN_14 ),
        // Inouts
        .PAD ( GPIO_17_PAD ) 
        );

//--------BIBUF
BIBUF GPIO_18_BIBUF(
        // Inputs
        .D   ( GPIO_OUT_slice_16 ),
        .E   ( GPIO_OE_slice_16 ),
        // Outputs
        .Y   ( GPIO_IN_15 ),
        // Inouts
        .PAD ( GPIO_18_PAD ) 
        );

//--------BIBUF
BIBUF GPIO_19_BIBUF(
        // Inputs
        .D   ( GPIO_OUT_slice_17 ),
        .E   ( GPIO_OE_slice_17 ),
        // Outputs
        .Y   ( GPIO_IN_16 ),
        // Inouts
        .PAD ( GPIO_19_PAD ) 
        );

//--------BIBUF
BIBUF GPIO_20_BIBUF(
        // Inputs
        .D   ( GPIO_OUT_slice_18 ),
        .E   ( GPIO_OE_slice_18 ),
        // Outputs
        .Y   ( GPIO_IN_17 ),
        // Inouts
        .PAD ( GPIO_20_PAD ) 
        );

//--------BIBUF
BIBUF GPIO_21_BIBUF(
        // Inputs
        .D   ( GPIO_OUT_slice_19 ),
        .E   ( GPIO_OE_slice_19 ),
        // Outputs
        .Y   ( GPIO_IN_18 ),
        // Inouts
        .PAD ( GPIO_21_PAD ) 
        );

//--------BIBUF
BIBUF GPIO_22_BIBUF(
        // Inputs
        .D   ( GPIO_OUT_slice_20 ),
        .E   ( GPIO_OE_slice_20 ),
        // Outputs
        .Y   ( GPIO_IN_19 ),
        // Inouts
        .PAD ( GPIO_22_PAD ) 
        );

//--------BIBUF
BIBUF GPIO_23_BIBUF(
        // Inputs
        .D   ( GPIO_OUT_slice_21 ),
        .E   ( GPIO_OE_slice_21 ),
        // Outputs
        .Y   ( GPIO_IN_20 ),
        // Inouts
        .PAD ( GPIO_23_PAD ) 
        );

//--------BIBUF
BIBUF GPIO_24_BIBUF(
        // Inputs
        .D   ( GPIO_OUT_slice_22 ),
        .E   ( GPIO_OE_slice_22 ),
        // Outputs
        .Y   ( GPIO_IN_21 ),
        // Inouts
        .PAD ( GPIO_24_PAD ) 
        );

//--------BIBUF
BIBUF GPIO_25_BIBUF(
        // Inputs
        .D   ( GPIO_OUT_slice_23 ),
        .E   ( GPIO_OE_slice_23 ),
        // Outputs
        .Y   ( GPIO_IN_22 ),
        // Inouts
        .PAD ( GPIO_25_PAD ) 
        );

//--------BIBUF
BIBUF GPIO_26_BIBUF(
        // Inputs
        .D   ( GPIO_OUT_slice_24 ),
        .E   ( GPIO_OE_slice_24 ),
        // Outputs
        .Y   ( GPIO_IN_23 ),
        // Inouts
        .PAD ( GPIO_26_PAD ) 
        );

//--------BIBUF
BIBUF GPIO_27_BIBUF(
        // Inputs
        .D   ( GPIO_OUT_slice_25 ),
        .E   ( GPIO_OE_slice_25 ),
        // Outputs
        .Y   ( GPIO_IN_24 ),
        // Inouts
        .PAD ( GPIO_27_PAD ) 
        );


endmodule
