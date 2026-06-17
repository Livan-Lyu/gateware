`timescale 1ns/100ps
module pixel_proc(
    input               pclk,
    input               presetn,
    input               psel,
    input               penable,
    input               pwrite,
    input       [7:0]   paddr,
    input       [31:0]  pwdata,
    output  reg [31:0]  prdata,
    output  reg         irq
);

    localparam [7:0] ADDR_CONTROL     = 8'h80;
    localparam [7:0] ADDR_STATUS      = 8'h84;
    localparam [7:0] ADDR_PIXEL_DATA  = 8'h8C;   // WO: write one 24-bit RGB entry
    localparam [7:0] ADDR_PIXEL_COUNT = 8'h90;
    localparam [7:0] ADDR_RESULT      = 8'h94;
    localparam [7:0] ADDR_DEBUG       = 8'h98;

    localparam [9:0] THRESHOLD_X2  = 10'd90;
    localparam [4:0] PIXEL_ENTRIES = 5'd24;
    localparam [4:0] MATCH_THRESH  = 5'd2;

    reg [31:0] control_reg, pixel_count_reg, result_reg;
    reg        busy;
    reg [4:0]  entry_index;
    reg [31:0] pixel_counter;
    reg [7:0]  current_r, current_g, current_b;
    reg [4:0]  match_count;
    reg [31:0] result_buffer;
    reg [5:0]  result_count;

    wire rd_enable = (!pwrite && psel);
    wire wr_enable = (penable && pwrite && psel);

    wire [7:0] hist_r = pwdata[7:0];
    wire [7:0] hist_g = pwdata[15:8];
    wire [7:0] hist_b = pwdata[23:16];
    wire [7:0] diff_r = (current_r > hist_r) ? (current_r - hist_r) : (hist_r - current_r);
    wire [7:0] diff_g = (current_g > hist_g) ? (current_g - hist_g) : (hist_g - current_g);
    wire [7:0] diff_b = (current_b > hist_b) ? (current_b - hist_b) : (hist_b - current_b);
    wire [8:0] diff_sum = {1'b0, diff_r} + {1'b0, diff_g} + {1'b0, diff_b};
    wire       match    = ({diff_sum, 1'b0} <= THRESHOLD_X2);

    always @(posedge pclk or negedge presetn) begin
        if (~presetn) begin
            control_reg <= 0; pixel_count_reg <= 0; result_reg <= 0; prdata <= 0;
            irq <= 0; busy <= 0;
            entry_index <= 0; pixel_counter <= 0;
            current_r <= 0; current_g <= 0; current_b <= 0;
            match_count <= 0; result_buffer <= 0; result_count <= 0;
        end else begin
            if (wr_enable) begin
                case (paddr)
                    ADDR_CONTROL: begin
                        control_reg <= pwdata;
                        if (pwdata[7] && busy && result_count > 0) begin
                            irq <= 0; result_buffer <= 0; result_count <= 0;
                        end
                        if (pwdata[0] && !busy) begin
                            busy <= 1; entry_index <= 0; pixel_counter <= 0;
                            match_count <= 0; result_buffer <= 0; result_count <= 0;
                        end
                        if (!pwdata[0] && busy && pixel_counter >= pixel_count_reg)
                            busy <= 0;
                    end
                    ADDR_PIXEL_COUNT: pixel_count_reg <= pwdata;
                    ADDR_PIXEL_DATA: begin
                        if (busy && pixel_counter < pixel_count_reg) begin
                            if (entry_index == 0) begin
                                current_r <= hist_r; current_g <= hist_g; current_b <= hist_b;
                                entry_index <= entry_index + 1;
                            end else if (entry_index == (PIXEL_ENTRIES - 1)) begin
                                if ((match_count + {4'b0, match}) > MATCH_THRESH)
                                    result_buffer[result_count] <= 1'b1;
                                else
                                    result_buffer[result_count] <= 1'b0;
                                if (result_count == 6'd31) begin
                                    result_reg <= {result_buffer[30:0],
                                                  ((match_count + {4'b0, match}) > MATCH_THRESH)};
                                    irq <= 1;
                                end else if (pixel_counter + 1 >= pixel_count_reg) begin
                                    result_reg <= {result_buffer[30:0],
                                                  ((match_count + {4'b0, match}) > MATCH_THRESH)};
                                end
                                entry_index <= 0; pixel_counter <= pixel_counter + 1;
                                match_count <= 0;
                            end else begin
                                if (match) match_count <= match_count + 1;
                                entry_index <= entry_index + 1;
                            end
                        end
                    end
                    default: ;
                endcase
            end
            if (rd_enable) begin
                case (paddr)
                    ADDR_CONTROL:     prdata <= control_reg;
                    ADDR_STATUS:      prdata <= {29'b0, (busy && pixel_counter >= pixel_count_reg && result_count == 0), irq, busy};
                    ADDR_PIXEL_COUNT: prdata <= pixel_count_reg;
                    ADDR_RESULT:      prdata <= result_reg;
                    ADDR_DEBUG:       prdata <= 32'hDEADBEEF;
                    default:          prdata <= 0;
                endcase
            end
        end
    end

endmodule
