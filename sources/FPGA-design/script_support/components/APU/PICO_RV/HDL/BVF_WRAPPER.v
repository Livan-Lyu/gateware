`ifndef PICORV32_REGS
`define PICORV32_REGS picosoc_regs
`endif

`ifndef PICOSOC_MEM
`define PICOSOC_MEM picosoc_mem
`endif

`ifndef PICOSOC_STACK
`define PICOSOC_STACK picosoc_stack
`endif

`define BVFSOC_V
module BVF_SOC (
// inputs
    CLK,
    RESETN,
	GPIO_IN,
	INSTR_DATA,
// outputs	
	INSTR_ADDR,
	INSTR_VALID,
    GPIO_OE,
    GPIO_OUT 
);
//----------------------------------------------------------------------------------------------------------------
// Inputs
//----------------------------------------------------------------------------------------------------------------
	input             CLK;
    input             RESETN;
    input      [27:0] GPIO_IN;
	input      [31:0] INSTR_DATA;
//-----------------------------------------------------------------------------------------------------------------
//Outputs
//-----------------------------------------------------------------------------------------------------------------	
	output     [14:0] INSTR_ADDR;
	output            INSTR_VALID;
    output     [27:0] GPIO_OE;
    output     [27:0] GPIO_OUT; 
//-----------------------------------------------------------------------------------------------------------------
// Parameters
//-----------------------------------------------------------------------------------------------------------------
    parameter [ 0:0] BARREL_SHIFTER = 1;
	parameter [ 0:0] ENABLE_MUL = 1;
	parameter [ 0:0] ENABLE_DIV = 1;
	parameter [ 0:0] ENABLE_FAST_MUL = 1;
	parameter [ 0:0] ENABLE_COMPRESSED = 1;
	parameter [ 0:0] ENABLE_COUNTERS = 1;

	parameter integer MEM_WORDS = 1024;
	parameter [31:0] RAMADDR = 32'h 0002_0000;
	parameter [31:0] STACKADDR = 32'h 0002_1000;       // end of memory
	parameter integer STACK_SIZE = 1024;
	parameter [31:0] PROGADDR_RESET = 32'h 0000_0000;
	parameter [31:0] IO_ADDR = 32'h 0002_2000;
//-----------------------------------------------------------------------------------------------------------------
// Nets
//-----------------------------------------------------------------------------------------------------------------
    wire [ 0:0] io_valid;
    wire [ 0:0] io_ready;
    wire [31:0] IO_READ_DATA;

    wire [ 0:0] mem_valid;
    wire [ 0:0] mem_instr;
    wire [ 0:0] mem_ready;
    wire [31:0] mem_addr;
    wire [31:0] mem_wdata;  
    wire [ 3:0] mem_wstrb;
    wire [31:0] mem_rdata;

	wire [ 0:0] ram_ready;
	wire [ 9:0] ram_addr;
	wire [ 3:0] ram_valid;
	wire [31:0] ram_rdata;

	wire [ 3:0] stack_valid;
	wire [ 0:0] stack_ready;
	wire [ 9:0] stack_addr;
	wire [31:0] stack_rdata;

	wire [ 0:0] instr_ready;
	wire [19:0] instr_addr;
    
	wire [ 0:0] is_instr_access;
	wire [ 0:0] is_stack_access;
	wire [ 0:0] is_ram_access;

    reg  [ 0:0] seq_ram_ready;
    reg  [ 0:0] seq_stack_ready;
    reg  [ 0:0] seq_instr_ready;
//--------------------------------------------------------------------------------------------------------------------
// Assignments
//--------------------------------------------------------------------------------------------------------------------

always @(posedge CLK) begin
    seq_ram_ready <= ram_ready;
    seq_stack_ready <= stack_ready;
    seq_instr_ready <= instr_ready;
end

assign is_ram_access = (mem_valid && !mem_instr && mem_addr < STACKADDR && mem_addr >= RAMADDR);
assign ram_ready = (is_ram_access) ? 1: 0;
assign ram_valid = (is_ram_access) ? mem_wstrb : 4'b0;
assign ram_addr = mem_addr[11:2];

assign is_stack_access = (mem_valid && !mem_instr && mem_addr >= STACKADDR && mem_addr < IO_ADDR);
assign stack_ready = (is_stack_access) ? 1 :0;
assign stack_valid = (is_stack_access) ? mem_wstrb : 4'b0;
assign stack_addr = mem_addr[11:2];

assign is_instr_access = (mem_valid && mem_instr && mem_addr < RAMADDR && mem_wstrb == 0);
assign INSTR_VALID = is_instr_access ? 1 : 0;
assign instr_ready = (is_instr_access) ? 1 : 0;
assign INSTR_ADDR = mem_addr[16:2];


assign mem_ready = (seq_ram_ready || seq_stack_ready || seq_instr_ready);
assign mem_rdata = (seq_ram_ready) ? ram_rdata : (seq_stack_ready) ? stack_rdata : (seq_instr_ready) ? INSTR_DATA : 0;

assign GPIO_OUT = cpu.cpuregs.io.GPIO_OUT;
assign GPIO_OE = cpu.cpuregs.io.GPIO_OE;
assign cpu.cpuregs.io.GPIO_IN = GPIO_IN;
//-----------------------------------------------------------------------------------------------------------------------
// Instantiations
//-----------------------------------------------------------------------------------------------------------------------

// Mem-mapped IO controller for BeagleV-Fire
// IO_controller_mem #(
//     .IO_ADDR(IO_ADDR)
// ) 
// io(
//     .clk           (CLK           ), 
//     .io_valid      (io_valid      ),
//     .io_addr       (mem_addr      ), 
//     .IO_WRITE_DATA (mem_wdata     ),
//     .io_ready      (io_ready      ),
//     .GPIO_IN       (GPIO_IN       ),
//     .GPIO_OE       (GPIO_OE       ),
//     .GPIO_OUT      (GPIO_OUT      ),
//     .IO_READ_DATA  (IO_READ_DATA  )
// );

// PicoRV CPU instantiation
picorv32 #(
		.STACKADDR(STACKADDR),
		.PROGADDR_RESET(PROGADDR_RESET),
		.BARREL_SHIFTER(BARREL_SHIFTER),
		.COMPRESSED_ISA(ENABLE_COMPRESSED),
		.ENABLE_COUNTERS(ENABLE_COUNTERS),
		.ENABLE_MUL(ENABLE_MUL),
		.ENABLE_DIV(ENABLE_DIV),
		.ENABLE_FAST_MUL(ENABLE_FAST_MUL),
		.ENABLE_IRQ(0)
	) cpu (
		.clk         (CLK        ),
		.resetn      (RESETN     ),
		.mem_valid   (mem_valid  ),
		.mem_instr   (mem_instr  ),
		.mem_ready   (mem_ready  ),
		.mem_addr    (mem_addr   ),
		.mem_wdata   (mem_wdata  ),
		.mem_wstrb   (mem_wstrb  ),
		.mem_rdata   (mem_rdata  )
	);

//Data Memory instantiation
`PICOSOC_MEM #(
	.MEM_WORDS(MEM_WORDS)
) soc_mem (
	.clk   (CLK            ),
	.wen   (ram_valid      ),
	.addr  (ram_addr       ),
	.wdata (mem_wdata      ),
	.rdata (ram_rdata      ) 
);

//Stack Memory instantiation
`PICOSOC_STACK #(
	.STACK_SIZE(STACK_SIZE)
) soc_stack (
	.clk   (CLK            ),
	.wen   (stack_valid    ),
	.addr  (stack_addr     ),
	.wdata (mem_wdata      ),
	.rdata (stack_rdata    ) 
);

// This Block can be used to instantiate program memory instead of LSRAM.
// program_mem inst_mem(
// 	.instr_addr  (instr_addr ),
// 	.instr       (INSTR_DATA ),
// 	.instr_valid (instr_valid)
// );

endmodule

//--------------------------------------------------------------------------------------------------------------------------------------
// Secondary module Definitions
//--------------------------------------------------------------------------------------------------------------------------------------

// This module can be updated if the register file needs to be used from SRAM and commenting definition line in picorv32.v
// The format used for SRAM wrapper must be same as below module.
module picosoc_regs (
	input clk, 
	input wen,
	input [5:0] waddr,
	input [5:0] raddr1,
	input [5:0] raddr2,
	input [31:0] wdata,
	output [31:0] rdata1,
	output [31:0] rdata2
);
	reg  [31:0] regs [0:31];
	wire [ 4:0] IO_raddr, IO_waddr; 
	wire [31:0] IO_wdata,IO_rdata;
	wire        IO_wen;
	wire [27:0] GPIO_IN;
	wire [27:0] GPIO_OE;
	wire [27:0] GPIO_OUT;

	// IO and registers sequential Write logic
    always @(posedge clk) if (waddr != 5'd30 && waddr != 5'd31 && wen) regs[waddr[4:0]] <= wdata;
	//IO address assignments
    assign IO_wen = ( waddr == 5'd30 || waddr == 5'd31  ) ? wen : 0;
    assign IO_wdata = ( waddr == 5'd30 || waddr == 5'd31 ) ? wdata :0;
	assign IO_raddr = ( raddr1 == 5'd30 || raddr1 == 5'd31 ) ? raddr1[4:0] : 
                      ( raddr2 == 5'd30 || raddr2 == 5'd31 ) ? raddr2[4:0] : 0;
	assign IO_waddr = ( waddr == 5'd30 || waddr == 5'd31 ) ? waddr[4:0] : 0;
	//IO and registers combinational Read logic
	assign rdata1 = (raddr1 == 5'd30 || raddr1 == 5'd31) ? IO_rdata : regs[raddr1[4:0]];
	assign rdata2 = (raddr1 == 5'd30 || raddr1 == 5'd31) ? IO_rdata : regs[raddr2[4:0]];

	IO_controller_reg io(
		.CLK      (clk      ),
		.WEN      (IO_wen   ),
		.RDATA    (IO_rdata ),
		.WDATA    (IO_wdata ),
		.RADDR    (IO_raddr ),
		.WADDR    (IO_waddr ),
		.GPIO_IN  (GPIO_IN  ),
		.GPIO_OE  (GPIO_OE  ),
		.GPIO_OUT (GPIO_OUT )
	);
endmodule

// This module will be updated by SRAM wrapper to use on-board memory as scratchpad memory(RAM)
module picosoc_mem #(
	parameter integer MEM_WORDS = 1024
) (
	input clk,
	input [3:0] wen,
	input [9:0] addr,
	input [31:0] wdata,
	output reg [31:0] rdata
);
	reg [31:0] mem [0:MEM_WORDS-1];

	always @(posedge clk) begin
		rdata <= mem[addr];
		if (wen[0]) mem[addr][ 7: 0] <= wdata[ 7: 0];
		if (wen[1]) mem[addr][15: 8] <= wdata[15: 8];
		if (wen[2]) mem[addr][23:16] <= wdata[23:16];
		if (wen[3]) mem[addr][31:24] <= wdata[31:24];
	end
endmodule

//This module can be replaced by SRAM wrapper to use on-board memory as stack
module picosoc_stack #(
	parameter integer STACK_SIZE = 1024
) (
	input clk,
	input [3:0] wen,
	input [9:0] addr,
	input [31:0] wdata,
	output reg [31:0] rdata
);
	reg [31:0] mem [0:STACK_SIZE-1];

	always @(posedge clk) begin
		rdata <= mem[addr];
		if (wen[0]) mem[addr][ 7: 0] <= wdata[ 7: 0];
		if (wen[1]) mem[addr][15: 8] <= wdata[15: 8];
		if (wen[2]) mem[addr][23:16] <= wdata[23:16];
		if (wen[3]) mem[addr][31:24] <= wdata[31:24];
	end
endmodule
