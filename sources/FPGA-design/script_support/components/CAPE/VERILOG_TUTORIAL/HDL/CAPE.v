//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Sun Dec  3 10:18:21 2023
// Version: 2022.3 2022.3.0.8
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
    GPIO_OE,
    GPIO_OUT,
    PCLK,
    PRESETN,
    // Outputs
    APB_SLAVE_SLAVE_PRDATA,
    GPIO_IN,
    INT,
    // Inouts
    P8,
    P9_11,
    P9_12,
    P9_13,
    P9_14,
    P9_15,
    P9_16,
    P9_17,
    P9_18,
    P9_21,
    P9_22,
    P9_23,
    P9_24,
    P9_25,
    P9_26,
    P9_27,
    P9_28,
    P9_29,
    P9_30,
    P9_31,
    P9_41,
    P9_42
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input  [31:0] APB_SLAVE_SLAVE_PADDR;
input         APB_SLAVE_SLAVE_PENABLE;
input         APB_SLAVE_SLAVE_PSEL;
input  [31:0] APB_SLAVE_SLAVE_PWDATA;
input         APB_SLAVE_SLAVE_PWRITE;
input  [27:0] GPIO_OE;
input  [27:0] GPIO_OUT;
input         PCLK;
input         PRESETN;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output [31:0] APB_SLAVE_SLAVE_PRDATA;
output [27:0] GPIO_IN;
output [23:0] INT;
//--------------------------------------------------------------------
// Inout
//--------------------------------------------------------------------
inout  [46:3] P8;
inout         P9_11;
inout         P9_12;
inout         P9_13;
inout         P9_14;
inout         P9_15;
inout         P9_16;
inout         P9_17;
inout         P9_18;
inout         P9_21;
inout         P9_22;
inout         P9_23;
inout         P9_24;
inout         P9_25;
inout         P9_26;
inout         P9_27;
inout         P9_28;
inout         P9_29;
inout         P9_30;
inout         P9_31;
inout         P9_41;
inout         P9_42;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire   [31:0]  apb_ctrl_status_0_control;
wire           APB_SLAVE_SLAVE_PENABLE;
wire   [31:0]  APB_SLAVE_PRDATA;
wire           APB_SLAVE_SLAVE_PSEL;
wire   [31:0]  APB_SLAVE_SLAVE_PWDATA;
wire           APB_SLAVE_SLAVE_PWRITE;
wire   [30:3]  GPIO_IN_net_0;
wire   [27:0]  GPIO_OE;
wire   [27:0]  GPIO_OUT;
wire           P9_11;
wire           P9_12;
wire           P9_13;
wire           P9_14;
wire           P9_15;
wire           P9_16;
wire           P9_17;
wire           P9_18;
wire           P9_21;
wire           P9_22;
wire           P9_23;
wire           P9_24;
wire           P9_25;
wire           P9_26;
wire           P9_27;
wire           P9_28;
wire           P9_29;
wire           P9_30;
wire           P9_31;
wire           P9_41;
wire           P9_42;
wire           PCLK;
wire           PRESETN;
wire           BLINK;
wire   [31:0]  APB_SLAVE_PRDATA_net_0;
wire   [27:0]  GPIO_IN_net_1;
wire   [46:31] GPIO_IN_slice_0;
wire   [46:3]  GPIO_OE_net_0;
wire   [46:3]  GPIO_OUT_net_0;
wire   [46:3]  GPIO_IN_net_2;
//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire   [46:31] GPIO_OE_const_net_0;
wire   [46:31] GPIO_OUT_const_net_0;
wire   [18:11] GPIO_OE_const_net_1;
wire   [18:11] GPIO_OUT_const_net_1;
wire   [31:21] GPIO_OE_const_net_2;
wire   [31:21] GPIO_OUT_const_net_2;
wire   [42:41] GPIO_OE_const_net_3;
wire   [42:41] GPIO_OUT_const_net_3;
//--------------------------------------------------------------------
// Bus Interface Nets Declarations - Unequal Pin Widths
//--------------------------------------------------------------------
wire   [31:0]  APB_SLAVE_SLAVE_PADDR;
wire   [7:0]   APB_SLAVE_SLAVE_PADDR_0;
wire   [7:0]   APB_SLAVE_SLAVE_PADDR_0_7to0;
//--------------------------------------------------------------------
// Constant assignments
//--------------------------------------------------------------------
assign GPIO_OE_const_net_0  = 16'h0000;
assign GPIO_OUT_const_net_0 = 16'h0000;
assign GPIO_OE_const_net_1  = 8'h00;
assign GPIO_OUT_const_net_1 = 8'h00;
assign GPIO_OE_const_net_2  = 11'h000;
assign GPIO_OUT_const_net_2 = 11'h000;
assign GPIO_OE_const_net_3  = 2'h0;
assign GPIO_OUT_const_net_3 = 2'h0;
//--------------------------------------------------------------------
// TieOff assignments
//--------------------------------------------------------------------
assign INT[23:0]                    = 24'h0;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign APB_SLAVE_PRDATA_net_0       = APB_SLAVE_PRDATA;
assign APB_SLAVE_SLAVE_PRDATA[31:0] = APB_SLAVE_PRDATA_net_0;
assign GPIO_IN_net_1                = GPIO_IN_net_0;
assign GPIO_IN[27:0]                = GPIO_IN_net_1;
//--------------------------------------------------------------------
// Slices assignments
//--------------------------------------------------------------------
assign GPIO_IN_net_0   = GPIO_IN_net_2[30:3];
assign GPIO_IN_slice_0 = GPIO_IN_net_2[46:31];
//--------------------------------------------------------------------
// Concatenation assignments
//--------------------------------------------------------------------
assign GPIO_OE_net_0 = { 16'h0000, GPIO_OE[27:6], 1'b1, GPIO_OE[4:0] };
assign GPIO_OUT_net_0 = { 16'h0000 , GPIO_OUT[27:6], BLINK, GPIO_OUT[4:0] };
//--------------------------------------------------------------------
// Bus Interface Nets Assignments - Unequal Pin Widths
//--------------------------------------------------------------------
assign APB_SLAVE_SLAVE_PADDR_0 = { APB_SLAVE_SLAVE_PADDR_0_7to0 };
assign APB_SLAVE_SLAVE_PADDR_0_7to0 = APB_SLAVE_SLAVE_PADDR[7:0];

//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------apb_ctrl_status
apb_ctrl_status apb_ctrl_status_0(
        // Inputs
        .presetn ( PRESETN ),
        .pclk    ( PCLK ),
        .psel    ( APB_SLAVE_SLAVE_PSEL ),
        .penable ( APB_SLAVE_SLAVE_PENABLE ),
        .pwrite  ( APB_SLAVE_SLAVE_PWRITE ),
        .paddr   ( APB_SLAVE_SLAVE_PADDR_0 ),
        .pwdata  ( APB_SLAVE_SLAVE_PWDATA ),
        .status  ( apb_ctrl_status_0_control ),
        // Outputs
        .prdata  ( APB_SLAVE_PRDATA ),
        .control ( apb_ctrl_status_0_control ) 
        );

//--------P8_IOPADS
P8_IOPADS P8_IOPADS_0(
        // Inputs
        .GPIO_OE  ( GPIO_OE_net_0 ),
        .GPIO_OUT ( GPIO_OUT_net_0 ),
        // Outputs
        .GPIO_IN  ( GPIO_IN_net_2 ),
        // Inouts
        .P8_3     ( P8[3] ),
        .P8_4     ( P8[4] ),
        .P8_5     ( P8[5] ),
        .P8_6     ( P8[6] ),
        .P8_7     ( P8[7] ),
        .P8_8     ( P8[8] ),
        .P8_9     ( P8[9] ),
        .P8_10    ( P8[10] ),
        .P8_11    ( P8[11] ),
        .P8_12    ( P8[12] ),
        .P8_13    ( P8[13] ),
        .P8_14    ( P8[14] ),
        .P8_15    ( P8[15] ),
        .P8_16    ( P8[16] ),
        .P8_17    ( P8[17] ),
        .P8_18    ( P8[18] ),
        .P8_19    ( P8[19] ),
        .P8_20    ( P8[20] ),
        .P8_21    ( P8[21] ),
        .P8_22    ( P8[22] ),
        .P8_23    ( P8[23] ),
        .P8_24    ( P8[24] ),
        .P8_25    ( P8[25] ),
        .P8_26    ( P8[26] ),
        .P8_27    ( P8[27] ),
        .P8_28    ( P8[28] ),
        .P8_29    ( P8[29] ),
        .P8_30    ( P8[30] ),
        .P8_31    ( P8[31] ),
        .P8_32    ( P8[32] ),
        .P8_33    ( P8[33] ),
        .P8_34    ( P8[34] ),
        .P8_35    ( P8[35] ),
        .P8_36    ( P8[36] ),
        .P8_37    ( P8[37] ),
        .P8_38    ( P8[38] ),
        .P8_39    ( P8[39] ),
        .P8_40    ( P8[40] ),
        .P8_41    ( P8[41] ),
        .P8_42    ( P8[42] ),
        .P8_43    ( P8[43] ),
        .P8_44    ( P8[44] ),
        .P8_45    ( P8[45] ),
        .P8_46    ( P8[46] )
        );

//--------P9_11_18_IOPADS
P9_11_18_IOPADS P9_11_18_IOPADS_0(
        // Inputs
        .GPIO_OE  ( GPIO_OE_const_net_1 ),
        .GPIO_OUT ( GPIO_OUT_const_net_1 ),
        // Outputs
        .GPIO_IN  (  ),
        // Inouts
        .P9_11    ( P9_11 ),
        .P9_12    ( P9_12 ),
        .P9_13    ( P9_13 ),
        .P9_14    ( P9_14 ),
        .P9_15    ( P9_15 ),
        .P9_16    ( P9_16 ),
        .P9_17    ( P9_17 ),
        .P9_18    ( P9_18 ) 
        );

//--------P9_21_31_IOPADS
P9_21_31_IOPADS P9_21_31_IOPADS_0(
        // Inputs
        .GPIO_OE  ( GPIO_OE_const_net_2 ),
        .GPIO_OUT ( GPIO_OUT_const_net_2 ),
        // Outputs
        .GPIO_IN  (  ),
        // Inouts
        .P9_21    ( P9_21 ),
        .P9_22    ( P9_22 ),
        .P9_23    ( P9_23 ),
        .P9_24    ( P9_24 ),
        .P9_25    ( P9_25 ),
        .P9_26    ( P9_26 ),
        .P9_27    ( P9_27 ),
        .P9_28    ( P9_28 ),
        .P9_29    ( P9_29 ),
        .P9_30    ( P9_30 ),
        .P9_31    ( P9_31 ) 
        );

//--------P9_41_42_IOPADS
P9_41_42_IOPADS P9_41_42_IOPADS_0(
        // Inputs
        .GPIO_OE  ( GPIO_OE_const_net_3 ),
        .GPIO_OUT ( GPIO_OUT_const_net_3 ),
        // Outputs
        .GPIO_IN  (  ),
        // Inouts
        .P9_41    ( P9_41 ),
        .P9_42    ( P9_42 ) 
        );

//--------blinky
blinky blinky_0(
        .clk     ( PCLK ),
        .resetn  ( PRESETN ),
        .blink   ( BLINK )
        );
   
endmodule
