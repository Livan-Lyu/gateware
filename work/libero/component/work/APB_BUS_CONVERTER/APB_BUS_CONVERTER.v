//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Sun Jul 12 07:17:46 2026
// Version: 2025.1 2025.1.0.14
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// APB_BUS_CONVERTER
module APB_BUS_CONVERTER(
    // Inputs
    MASTER_PRDATA,
    MASTER_PREADY,
    MASTER_PSLVERR,
    SLAVE_PADDR,
    SLAVE_PENABLE,
    SLAVE_PSEL,
    SLAVE_PWDATA,
    SLAVE_PWRITE,
    // Outputs
    MASTER_PADDR,
    MASTER_PENABLE,
    MASTER_PSEL,
    MASTER_PWDATA,
    MASTER_PWRITE,
    SLAVE_PRDATA,
    SLAVE_PREADY,
    SLAVE_PSLVERR
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input  [31:0] MASTER_PRDATA;
input         MASTER_PREADY;
input         MASTER_PSLVERR;
input  [31:0] SLAVE_PADDR;
input         SLAVE_PENABLE;
input         SLAVE_PSEL;
input  [31:0] SLAVE_PWDATA;
input         SLAVE_PWRITE;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output [31:0] MASTER_PADDR;
output        MASTER_PENABLE;
output        MASTER_PSEL;
output [31:0] MASTER_PWDATA;
output        MASTER_PWRITE;
output [31:0] SLAVE_PRDATA;
output        SLAVE_PREADY;
output        SLAVE_PSLVERR;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire          SLAVE_PENABLE;
wire   [31:0] SLAVE_PADDR;
wire   [31:0] MASTER_PRDATA;
wire          MASTER_PREADY;
wire          SLAVE_PSEL;
wire          MASTER_PSLVERR;
wire   [31:0] SLAVE_PWDATA;
wire          SLAVE_PWRITE;
wire   [31:0] SLAVE_PRDATA_net_0;
wire          SLAVE_PSLVERR_net_0;
wire          SLAVE_PREADY_net_0;
wire   [31:0] SLAVE_PADDR_net_0;
wire          MASTER_PENABLE_net_0;
wire          SLAVE_PWRITE_net_0;
wire          SLAVE_PSEL_net_0;
wire   [31:0] SLAVE_PWDATA_net_0;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign SLAVE_PRDATA_net_0   = MASTER_PRDATA;
assign SLAVE_PRDATA[31:0]   = SLAVE_PRDATA_net_0;
assign SLAVE_PSLVERR_net_0  = MASTER_PSLVERR;
assign SLAVE_PSLVERR        = SLAVE_PSLVERR_net_0;
assign SLAVE_PREADY_net_0   = MASTER_PREADY;
assign SLAVE_PREADY         = SLAVE_PREADY_net_0;
assign SLAVE_PADDR_net_0    = SLAVE_PADDR;
assign MASTER_PADDR[31:0]   = SLAVE_PADDR_net_0;
assign MASTER_PENABLE_net_0 = SLAVE_PENABLE;
assign MASTER_PENABLE       = MASTER_PENABLE_net_0;
assign SLAVE_PWRITE_net_0   = SLAVE_PWRITE;
assign MASTER_PWRITE        = SLAVE_PWRITE_net_0;
assign SLAVE_PSEL_net_0     = SLAVE_PSEL;
assign MASTER_PSEL          = SLAVE_PSEL_net_0;
assign SLAVE_PWDATA_net_0   = SLAVE_PWDATA;
assign MASTER_PWDATA[31:0]  = SLAVE_PWDATA_net_0;

endmodule
