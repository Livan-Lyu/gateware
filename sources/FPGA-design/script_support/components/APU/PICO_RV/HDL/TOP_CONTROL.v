/*
This is the top Wrapper module used to setup CSR mounted at 0x0000 address in LSRAM.
This module will reset the APU and th address bus back to 0x0000 address and reading the CSR.
If a program is to be halted the CSR must be written to for SOFT reset as well as a hardware reset must be given
*/

module PICO_RV (
    //Control Interface 
    // Inputs
    CLK,
    RESETN,
    LSRAM_DATA,
    CAPE_GPIO_IN,
    BVF_GPIO_OE,
    BVF_GPIO_OUT,
    // Outputs
    LSRAM_ADDR,
    LSRAM_REN,
    CAPE_GPIO_OE,
    CAPE_GPIO_OUT,
    BVF_GPIO_IN,

    //APB Slave Interface
    pclk,
    presetn,
    penable,
    pslverr,
    pready,
    psel,
    paddr,
    pwrite,
    pwdata,
    prdata
);
//----------------------------------------------------------------------------------------------------------------
// Inputs
//----------------------------------------------------------------------------------------------------------------
input  [ 0:0] CLK;
input  [ 0:0] RESETN;
input  [31:0] LSRAM_DATA;
input  [27:0] CAPE_GPIO_IN;
input  [27:0] BVF_GPIO_OE;
input  [27:0] BVF_GPIO_OUT;
input  [ 0:0] pclk;
input  [ 0:0] presetn;
input  [ 0:0] penable;
input  [ 0:0] psel;
input  [31:0] paddr;
input  [ 0:0] pwrite;
input  [31:0] pwdata;
//----------------------------------------------------------------------------------------------------------------
// Outputs
//----------------------------------------------------------------------------------------------------------------
output [14:0] LSRAM_ADDR;
output [ 0:0] LSRAM_REN;
output [27:0] CAPE_GPIO_OE;
output [27:0] CAPE_GPIO_OUT;
output [27:0] BVF_GPIO_IN;
output [ 0:0] pslverr;
output [ 0:0] pready;

output  reg [31:0]  prdata;
//----------------------------------------------------------------------------------------------------------------
// Registers
//---------------------------------------------------------------------------------------------------------------- 
reg  [31:0] CONTROL_STATUS;
reg  [ 0:0] SOFT_RESETN;
reg  [ 0:0] BVF_GPIO_EN;
//----------------------------------------------------------------------------------------------------------------
// Nets
//---------------------------------------------------------------------------------------------------------------- 
wire [ 0:0] PICO_RESETN;
wire [31:0] INSTR_DATA;
wire [14:0] INSTR_ADDR;
wire [ 0:0] INSTR_VALID;
wire [27:0] PICO_GPIO_IN;
wire [27:0] PICO_GPIO_OE;
wire [27:0] PICO_GPIO_OUT;
//----------------------------------------------------------------------------------------------------------------
// Assignments
//----------------------------------------------------------------------------------------------------------------
assign LSRAM_ADDR = (SOFT_RESETN && RESETN) ? INSTR_ADDR : 15'h0;
assign LSRAM_REN = (SOFT_RESETN) ? INSTR_VALID : 1'b0;
assign CAPE_GPIO_OE = (BVF_GPIO_EN) ? BVF_GPIO_OE : PICO_GPIO_OE;
assign CAPE_GPIO_OUT = (BVF_GPIO_EN) ? BVF_GPIO_OUT :PICO_GPIO_OUT;

assign BVF_GPIO_IN = (BVF_GPIO_EN) ? CAPE_GPIO_IN : 28'b0;
assign PICO_GPIO_IN = (!BVF_GPIO_EN) ? CAPE_GPIO_IN : 28'b0; 
assign PICO_RESETN = SOFT_RESETN & RESETN;
assign INSTR_DATA = (SOFT_RESETN && INSTR_VALID) ? LSRAM_DATA : 32'b0;
//----------------------------------------------------------------------------------------------------------------
// Instantiations
//----------------------------------------------------------------------------------------------------------------
BVF_SOC bvf_soc(
    .CLK         (CLK           ),
    .RESETN      (PICO_RESETN   ),
	.GPIO_IN     (PICO_GPIO_IN  ),
	.INSTR_DATA  (INSTR_DATA    ),	
	.INSTR_ADDR  (INSTR_ADDR    ),
	.INSTR_VALID (INSTR_VALID   ),
    .GPIO_OE     (PICO_GPIO_OE  ),
    .GPIO_OUT    (PICO_GPIO_OUT ) 
);
APB_slave APB_slave(
    .SOFT_RESETN (SOFT_RESETN ),
    .BVF_GPIO_EN (BVF_GPIO_EN ),
    .pclk        (pclk        ),
    .presetn     (presetn     ),
    .penable     (penable     ),
    .pslverr     (pslverr     ),
    .pready      (pready      ),
    .psel        (psel        ),
    .paddr       (paddr       ),
    .pwrite      (pwrite      ),
    .pwdata      (pwdata      ),
    .prdata      (prdata      )
);
endmodule