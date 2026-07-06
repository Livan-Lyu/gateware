// Minimal APB slave terminator — responds to all APB transactions with
// PREADY=1, PSLVERR=0, PRDATA=0. Used when a FIC3 CoreAPB3 slot is
// enabled but no real peripheral is connected, preventing APB bus hang
// during HSS boot-time slot enumeration.
`timescale 1ns/100ps
module apb_terminator (
    input  wire        PCLK,
    input  wire        PRESETN,
    input  wire        PSEL,
    input  wire        PENABLE,
    input  wire        PWRITE,
    input  wire [31:0] PADDR,
    input  wire [31:0] PWDATA,
    output reg  [31:0] PRDATA,
    output wire        PREADY,
    output wire        PSLVERR
);
    assign PREADY  = 1'b1;
    assign PSLVERR = 1'b0;

    always @(posedge PCLK or negedge PRESETN) begin
        if (!PRESETN)
            PRDATA <= 32'h00000000;
        else if (PSEL && !PWRITE)
            PRDATA <= 32'h00000000;
    end
endmodule
