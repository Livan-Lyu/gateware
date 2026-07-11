//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Sun Jul 12 05:04:55 2026
// Version: 2025.1 2025.1.0.14
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

//////////////////////////////////////////////////////////////////////
// Component Description (Tcl) 
//////////////////////////////////////////////////////////////////////
/*
# Exporting Component Description of FIC3_INITIATOR to TCL
# Family: PolarFireSoC
# Part Number: MPFS025T-FCVG484E
# Create and Configure the core component FIC3_INITIATOR
create_and_configure_core -core_vlnv {Actel:DirectCore:CoreAPB3:4.2.100} -component_name {FIC3_INITIATOR} -params {\
"APB_DWIDTH:32"  \
"APBSLOT0ENABLE:false"  \
"APBSLOT1ENABLE:true"  \
"APBSLOT2ENABLE:false"  \
"APBSLOT3ENABLE:false"  \
"APBSLOT4ENABLE:false"  \
"APBSLOT5ENABLE:false"  \
"APBSLOT6ENABLE:false"  \
"APBSLOT7ENABLE:false"  \
"APBSLOT8ENABLE:false"  \
"APBSLOT9ENABLE:false"  \
"APBSLOT10ENABLE:false"  \
"APBSLOT11ENABLE:false"  \
"APBSLOT12ENABLE:false"  \
"APBSLOT13ENABLE:false"  \
"APBSLOT14ENABLE:false"  \
"APBSLOT15ENABLE:false"  \
"IADDR_OPTION:0"  \
"MADDR_BITS:28"  \
"SC_0:false"  \
"SC_1:false"  \
"SC_2:false"  \
"SC_3:true"  \
"SC_4:false"  \
"SC_5:false"  \
"SC_6:false"  \
"SC_7:false"  \
"SC_8:true"  \
"SC_9:false"  \
"SC_10:false"  \
"SC_11:false"  \
"SC_12:false"  \
"SC_13:false"  \
"SC_14:false"  \
"SC_15:false"  \
"UPR_NIBBLE_POSN:6"   }
# Exporting Component Description of FIC3_INITIATOR to TCL done
*/

// FIC3_INITIATOR
module FIC3_INITIATOR(
    // Inputs
    PADDR,
    PENABLE,
    PRDATAS1,
    PRDATAS16,
    PREADYS1,
    PREADYS16,
    PSEL,
    PSLVERRS1,
    PSLVERRS16,
    PWDATA,
    PWRITE,
    // Outputs
    PADDRS,
    PENABLES,
    PRDATA,
    PREADY,
    PSELS1,
    PSELS16,
    PSLVERR,
    PWDATAS,
    PWRITES
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input  [31:0] PADDR;
input         PENABLE;
input  [31:0] PRDATAS1;
input  [31:0] PRDATAS16;
input         PREADYS1;
input         PREADYS16;
input         PSEL;
input         PSLVERRS1;
input         PSLVERRS16;
input  [31:0] PWDATA;
input         PWRITE;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output [31:0] PADDRS;
output        PENABLES;
output [31:0] PRDATA;
output        PREADY;
output        PSELS1;
output        PSELS16;
output        PSLVERR;
output [31:0] PWDATAS;
output        PWRITES;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire   [31:0] PADDR;
wire          PENABLE;
wire   [31:0] APB3mmaster_PRDATA;
wire          APB3mmaster_PREADY;
wire          PSEL;
wire          APB3mmaster_PSLVERR;
wire   [31:0] PWDATA;
wire          PWRITE;
wire   [31:0] APBmslave1_PADDR;
wire          APBmslave1_PENABLE;
wire   [31:0] PRDATAS1;
wire          PREADYS1;
wire          APBmslave1_PSELx;
wire          PSLVERRS1;
wire   [31:0] APBmslave1_PWDATA;
wire          APBmslave1_PWRITE;
wire   [31:0] PRDATAS16;
wire          PREADYS16;
wire          APBmslave16_PSELx;
wire          PSLVERRS16;
wire   [31:0] APB3mmaster_PRDATA_net_0;
wire          APB3mmaster_PREADY_net_0;
wire          APB3mmaster_PSLVERR_net_0;
wire   [31:0] APBmslave1_PADDR_net_0;
wire          APBmslave1_PSELx_net_0;
wire          APBmslave1_PENABLE_net_0;
wire          APBmslave1_PWRITE_net_0;
wire   [31:0] APBmslave1_PWDATA_net_0;
wire          APBmslave16_PSELx_net_0;
//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire          GND_net;
wire          VCC_net;
wire   [31:0] IADDR_const_net_0;
wire   [31:0] PRDATAS0_const_net_0;
wire   [31:0] PRDATAS2_const_net_0;
wire   [31:0] PRDATAS3_const_net_0;
wire   [31:0] PRDATAS4_const_net_0;
wire   [31:0] PRDATAS5_const_net_0;
wire   [31:0] PRDATAS6_const_net_0;
wire   [31:0] PRDATAS7_const_net_0;
wire   [31:0] PRDATAS8_const_net_0;
wire   [31:0] PRDATAS9_const_net_0;
wire   [31:0] PRDATAS10_const_net_0;
wire   [31:0] PRDATAS11_const_net_0;
wire   [31:0] PRDATAS12_const_net_0;
wire   [31:0] PRDATAS13_const_net_0;
wire   [31:0] PRDATAS14_const_net_0;
wire   [31:0] PRDATAS15_const_net_0;
//--------------------------------------------------------------------
// Constant assignments
//--------------------------------------------------------------------
assign GND_net               = 1'b0;
assign VCC_net               = 1'b1;
assign IADDR_const_net_0     = 32'h00000000;
assign PRDATAS0_const_net_0  = 32'h00000000;
assign PRDATAS2_const_net_0  = 32'h00000000;
assign PRDATAS3_const_net_0  = 32'h00000000;
assign PRDATAS4_const_net_0  = 32'h00000000;
assign PRDATAS5_const_net_0  = 32'h00000000;
assign PRDATAS6_const_net_0  = 32'h00000000;
assign PRDATAS7_const_net_0  = 32'h00000000;
assign PRDATAS8_const_net_0  = 32'h00000000;
assign PRDATAS9_const_net_0  = 32'h00000000;
assign PRDATAS10_const_net_0 = 32'h00000000;
assign PRDATAS11_const_net_0 = 32'h00000000;
assign PRDATAS12_const_net_0 = 32'h00000000;
assign PRDATAS13_const_net_0 = 32'h00000000;
assign PRDATAS14_const_net_0 = 32'h00000000;
assign PRDATAS15_const_net_0 = 32'h00000000;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign APB3mmaster_PRDATA_net_0  = APB3mmaster_PRDATA;
assign PRDATA[31:0]              = APB3mmaster_PRDATA_net_0;
assign APB3mmaster_PREADY_net_0  = APB3mmaster_PREADY;
assign PREADY                    = APB3mmaster_PREADY_net_0;
assign APB3mmaster_PSLVERR_net_0 = APB3mmaster_PSLVERR;
assign PSLVERR                   = APB3mmaster_PSLVERR_net_0;
assign APBmslave1_PADDR_net_0    = APBmslave1_PADDR;
assign PADDRS[31:0]              = APBmslave1_PADDR_net_0;
assign APBmslave1_PSELx_net_0    = APBmslave1_PSELx;
assign PSELS1                    = APBmslave1_PSELx_net_0;
assign APBmslave1_PENABLE_net_0  = APBmslave1_PENABLE;
assign PENABLES                  = APBmslave1_PENABLE_net_0;
assign APBmslave1_PWRITE_net_0   = APBmslave1_PWRITE;
assign PWRITES                   = APBmslave1_PWRITE_net_0;
assign APBmslave1_PWDATA_net_0   = APBmslave1_PWDATA;
assign PWDATAS[31:0]             = APBmslave1_PWDATA_net_0;
assign APBmslave16_PSELx_net_0   = APBmslave16_PSELx;
assign PSELS16                   = APBmslave16_PSELx_net_0;
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------CoreAPB3   -   Actel:DirectCore:CoreAPB3:4.2.100
CoreAPB3 #( 
        .APB_DWIDTH      ( 32 ),
        .APBSLOT0ENABLE  ( 0 ),
        .APBSLOT1ENABLE  ( 1 ),
        .APBSLOT2ENABLE  ( 0 ),
        .APBSLOT3ENABLE  ( 0 ),
        .APBSLOT4ENABLE  ( 0 ),
        .APBSLOT5ENABLE  ( 0 ),
        .APBSLOT6ENABLE  ( 0 ),
        .APBSLOT7ENABLE  ( 0 ),
        .APBSLOT8ENABLE  ( 0 ),
        .APBSLOT9ENABLE  ( 0 ),
        .APBSLOT10ENABLE ( 0 ),
        .APBSLOT11ENABLE ( 0 ),
        .APBSLOT12ENABLE ( 0 ),
        .APBSLOT13ENABLE ( 0 ),
        .APBSLOT14ENABLE ( 0 ),
        .APBSLOT15ENABLE ( 0 ),
        .FAMILY          ( 27 ),
        .IADDR_OPTION    ( 0 ),
        .MADDR_BITS      ( 28 ),
        .SC_0            ( 0 ),
        .SC_1            ( 0 ),
        .SC_2            ( 0 ),
        .SC_3            ( 1 ),
        .SC_4            ( 0 ),
        .SC_5            ( 0 ),
        .SC_6            ( 0 ),
        .SC_7            ( 0 ),
        .SC_8            ( 1 ),
        .SC_9            ( 0 ),
        .SC_10           ( 0 ),
        .SC_11           ( 0 ),
        .SC_12           ( 0 ),
        .SC_13           ( 0 ),
        .SC_14           ( 0 ),
        .SC_15           ( 0 ),
        .UPR_NIBBLE_POSN ( 6 ) )
FIC3_INITIATOR_0(
        // Inputs
        .PRESETN    ( GND_net ), // tied to 1'b0 from definition
        .PCLK       ( GND_net ), // tied to 1'b0 from definition
        .PADDR      ( PADDR ),
        .PWRITE     ( PWRITE ),
        .PENABLE    ( PENABLE ),
        .PWDATA     ( PWDATA ),
        .PSEL       ( PSEL ),
        .PRDATAS0   ( PRDATAS0_const_net_0 ), // tied to 32'h00000000 from definition
        .PREADYS0   ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS0  ( GND_net ), // tied to 1'b0 from definition
        .PRDATAS1   ( PRDATAS1 ),
        .PREADYS1   ( PREADYS1 ),
        .PSLVERRS1  ( PSLVERRS1 ),
        .PRDATAS2   ( PRDATAS2_const_net_0 ), // tied to 32'h00000000 from definition
        .PREADYS2   ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS2  ( GND_net ), // tied to 1'b0 from definition
        .PRDATAS3   ( PRDATAS3_const_net_0 ), // tied to 32'h00000000 from definition
        .PREADYS3   ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS3  ( GND_net ), // tied to 1'b0 from definition
        .PRDATAS4   ( PRDATAS4_const_net_0 ), // tied to 32'h00000000 from definition
        .PREADYS4   ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS4  ( GND_net ), // tied to 1'b0 from definition
        .PRDATAS5   ( PRDATAS5_const_net_0 ), // tied to 32'h00000000 from definition
        .PREADYS5   ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS5  ( GND_net ), // tied to 1'b0 from definition
        .PRDATAS6   ( PRDATAS6_const_net_0 ), // tied to 32'h00000000 from definition
        .PREADYS6   ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS6  ( GND_net ), // tied to 1'b0 from definition
        .PRDATAS7   ( PRDATAS7_const_net_0 ), // tied to 32'h00000000 from definition
        .PREADYS7   ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS7  ( GND_net ), // tied to 1'b0 from definition
        .PRDATAS8   ( PRDATAS8_const_net_0 ), // tied to 32'h00000000 from definition
        .PREADYS8   ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS8  ( GND_net ), // tied to 1'b0 from definition
        .PRDATAS9   ( PRDATAS9_const_net_0 ), // tied to 32'h00000000 from definition
        .PREADYS9   ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS9  ( GND_net ), // tied to 1'b0 from definition
        .PRDATAS10  ( PRDATAS10_const_net_0 ), // tied to 32'h00000000 from definition
        .PREADYS10  ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS10 ( GND_net ), // tied to 1'b0 from definition
        .PRDATAS11  ( PRDATAS11_const_net_0 ), // tied to 32'h00000000 from definition
        .PREADYS11  ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS11 ( GND_net ), // tied to 1'b0 from definition
        .PRDATAS12  ( PRDATAS12_const_net_0 ), // tied to 32'h00000000 from definition
        .PREADYS12  ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS12 ( GND_net ), // tied to 1'b0 from definition
        .PRDATAS13  ( PRDATAS13_const_net_0 ), // tied to 32'h00000000 from definition
        .PREADYS13  ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS13 ( GND_net ), // tied to 1'b0 from definition
        .PRDATAS14  ( PRDATAS14_const_net_0 ), // tied to 32'h00000000 from definition
        .PREADYS14  ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS14 ( GND_net ), // tied to 1'b0 from definition
        .PRDATAS15  ( PRDATAS15_const_net_0 ), // tied to 32'h00000000 from definition
        .PREADYS15  ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS15 ( GND_net ), // tied to 1'b0 from definition
        .PRDATAS16  ( PRDATAS16 ),
        .PREADYS16  ( PREADYS16 ),
        .PSLVERRS16 ( PSLVERRS16 ),
        .IADDR      ( IADDR_const_net_0 ), // tied to 32'h00000000 from definition
        // Outputs
        .PRDATA     ( APB3mmaster_PRDATA ),
        .PREADY     ( APB3mmaster_PREADY ),
        .PSLVERR    ( APB3mmaster_PSLVERR ),
        .PADDRS     ( APBmslave1_PADDR ),
        .PWRITES    ( APBmslave1_PWRITE ),
        .PENABLES   ( APBmslave1_PENABLE ),
        .PWDATAS    ( APBmslave1_PWDATA ),
        .PSELS0     (  ),
        .PSELS1     ( APBmslave1_PSELx ),
        .PSELS2     (  ),
        .PSELS3     (  ),
        .PSELS4     (  ),
        .PSELS5     (  ),
        .PSELS6     (  ),
        .PSELS7     (  ),
        .PSELS8     (  ),
        .PSELS9     (  ),
        .PSELS10    (  ),
        .PSELS11    (  ),
        .PSELS12    (  ),
        .PSELS13    (  ),
        .PSELS14    (  ),
        .PSELS15    (  ),
        .PSELS16    ( APBmslave16_PSELx ) 
        );


endmodule
