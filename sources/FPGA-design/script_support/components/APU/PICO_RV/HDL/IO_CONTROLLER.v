module IO_controller_mem #(
    parameter integer ADDR_WIDTH = 32, 
    parameter integer IO_WIDTH = 28, 
    parameter integer DATA_WIDTH = 32, 
    parameter [31:0]  IO_ADDR = 32'h 0300_0000
)(
    input                       clk,
    input                       io_valid,
    input      [ADDR_WIDTH-1:0] io_addr, 
    input      [DATA_WIDTH-1:0] IO_WRITE_DATA,
    input      [IO_WIDTH-1:0]   GPIO_IN,
    output reg                  io_ready,
    output reg [IO_WIDTH-1:0]   GPIO_OE,
    output reg [IO_WIDTH-1:0]   GPIO_OUT,
    output reg [DATA_WIDTH-1:0] IO_READ_DATA
);
wire [31:0] IO_read;

assign IO_read = {4'b0, GPIO_IN};
always @ (posedge clk) begin                                           //sync
// always @(*) begin                                                      //combinational
    io_ready <= 0;
    if (io_valid) begin
        io_ready <= 1;
        if (io_addr == IO_ADDR + 32'h4) GPIO_OE  <= IO_WRITE_DATA[27:0] ;
        if (io_addr == IO_ADDR + 32'h8) GPIO_OUT <= GPIO_OE & IO_WRITE_DATA[27:0] ;
        if (io_addr == IO_ADDR) IO_READ_DATA <= IO_read;
        else IO_READ_DATA <= 0;
    end
end
endmodule

module IO_controller_reg(
    input             CLK,
    input             WEN,   
    input      [31:0] WDATA,
	input      [ 4:0] RADDR,
	input      [ 4:0] WADDR,
    input      [27:0] GPIO_IN,
    output     [31:0] RDATA,
    output reg [27:0] GPIO_OE,
    output reg [27:0] GPIO_OUT
);

localparam [4:0] GPIO_EN_ADDR = 5'd30;
localparam [4:0] GPIO_ADDR = 5'd31;

always @(posedge CLK) begin 
    if ( WEN ) begin
        case (WADDR[4:0])
            GPIO_ADDR: GPIO_OUT <= WDATA[27:0];
            GPIO_EN_ADDR: GPIO_OE <= WDATA[27:0]; 
        endcase
    end
end 
assign RDATA = ( RADDR[4:0] == GPIO_ADDR ) ? {4'h0, GPIO_IN} : 32'bx; 

endmodule