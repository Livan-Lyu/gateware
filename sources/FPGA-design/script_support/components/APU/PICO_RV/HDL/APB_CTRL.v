module APB_slave(
    //Control Signals
    output  reg         SOFT_RESETN,
    output  reg         BVF_GPIO_EN,
    //APB Interface
    input               pclk,
    input               presetn,
    input               penable,
    output              pslverr,
    output              pready,
    input               psel,
    input       [31:0]  paddr,
    input               pwrite,
    input       [31:0]  pwdata,
    output  reg [31:0]  prdata
    );

    assign pready = 1'b1;
    assign pslverr = 1'b0;

    localparam [7:0] REG0 = 8'h10; //READ-ONLY REGISTER
    localparam [7:0] CONTROL_STATUS = 8'h20; // READ-WRITE REGISTER

    wire rd_enable;
    wire wr_enable;  

    assign wr_enable = (penable && pwrite && psel);
    assign rd_enable = (!pwrite && psel);

    always@(posedge pclk or negedge presetn) begin
        if(~presetn) begin
            prdata <= 'b0;
            SOFT_RESETN <= 1'h1;
            BVF_GPIO_EN <= 1'h0;
        end else begin
            case(paddr[7:0])
                CONTROL_STATUS: begin
                    if (rd_enable) begin
                        prdata <= {30'h0,BVF_GPIO_EN, SOFT_RESETN};
                    end else if (wr_enable) begin
                        SOFT_RESETN <= pwdata[0];
                        BVF_GPIO_EN <= pwdata[1];
                    end
                end
                REG0: begin
                    if (rd_enable) prdata <= 32'hDEAD0000;
                end
                default: begin
                    prdata <= 32'hDEADBEEF;
                end
            endcase
        end
    end
endmodule