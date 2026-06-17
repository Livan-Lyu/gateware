`timescale 1ns/100ps
module pixel_proc(
    // APB slave (control/status registers + data input)
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

    // ==========================================
    // Register addresses (paddr[7]=1 space, offsets 0x80-0xFF)
    // ==========================================
    localparam [7:0] ADDR_CONTROL     = 8'h80;
    localparam [7:0] ADDR_STATUS      = 8'h84;
    localparam [7:0] ADDR_THRESHOLD   = 8'h88;   // optional, currently fixed
    localparam [7:0] ADDR_PIXEL_DATA  = 8'h8C;   // WO: write one 24-bit RGB entry
    localparam [7:0] ADDR_PIXEL_COUNT = 8'h90;
    localparam [7:0] ADDR_RESULT      = 8'h94;
    localparam [7:0] ADDR_DEBUG       = 8'h98;

    // ==========================================
    // Fixed parameters
    // ==========================================
    localparam [9:0]  THRESHOLD_X2  = 10'd90;   // 4.5 * 20 = 90
    localparam [4:0]  PIXEL_ENTRIES = 5'd24;     // 1 current + 23 history
    localparam [4:0]  MATCH_THRESH  = 5'd2;      // >2 => foreground

    // ==========================================
    // APB-accessible registers
    // ==========================================
    reg [31:0] control_reg;
    reg [31:0] pixel_count_reg;
    reg [31:0] result_reg;

    // ==========================================
    // Internal state
    // ==========================================
    reg [4:0]  entry_index;         // 0..23 within current pixel
    reg [31:0] pixel_counter;       // how many pixels fully processed
    reg [7:0]  current_r, current_g, current_b;  // latched at entry 0
    reg [4:0]  match_count;         // accumulated matches (0..23)
    reg [31:0] result_buffer;       // packed foreground bits
    reg [5:0]  result_count;        // valid bits in result_buffer (0..32)
    reg        busy;

    // ==========================================
    // APB read/write strobes
    // ==========================================
    wire rd_enable = (!pwrite && psel);
    wire wr_enable = (penable && pwrite && psel);

    // ==========================================
    // Combinational computation
    // ==========================================
    wire [7:0] hist_r = pwdata[7:0];
    wire [7:0] hist_g = pwdata[15:8];
    wire [7:0] hist_b = pwdata[23:16];

    wire [7:0] diff_r = (current_r > hist_r) ? (current_r - hist_r) : (hist_r - current_r);
    wire [7:0] diff_g = (current_g > hist_g) ? (current_g - hist_g) : (hist_g - current_g);
    wire [7:0] diff_b = (current_b > hist_b) ? (current_b - hist_b) : (hist_b - current_b);

    wire [8:0] diff_sum = {1'b0, diff_r} + {1'b0, diff_g} + {1'b0, diff_b};
    wire [9:0] diff_x2  = {diff_sum, 1'b0};
    wire       match    = (diff_x2 <= THRESHOLD_X2);

    // ==========================================
    // APB Register Read/Write + Pixel Data Processing
    // ==========================================
    always @(posedge pclk or negedge presetn) begin
        if (~presetn) begin
            control_reg     <= 32'h00000000;
            pixel_count_reg <= 32'h00000000;
            result_reg      <= 32'h00000000;
            prdata          <= 32'b0;

            busy            <= 1'b0;
            irq             <= 1'b0;
            entry_index     <= 5'd0;
            pixel_counter   <= 32'd0;
            current_r       <= 8'd0;
            current_g       <= 8'd0;
            current_b       <= 8'd0;
            match_count     <= 5'd0;
            result_buffer   <= 32'h00000000;
            result_count    <= 6'd0;
        end else begin

            // ---- Handle APB Write ----
            if (wr_enable) begin
                case (paddr)
                    ADDR_CONTROL: begin
                        control_reg <= pwdata;
                        // ACK pulse handling
                        if (pwdata[7] && busy && result_count > 6'd0) begin
                            // ACK: CPU consumed the results
                            irq           <= 1'b0;
                            result_buffer <= 32'h00000000;
                            result_count  <= 6'd0;
                        end
                        // START: begin processing
                        if (pwdata[0] && !busy) begin
                            busy          <= 1'b1;
                            entry_index   <= 5'd0;
                            pixel_counter <= 32'd0;
                            match_count   <= 5'd0;
                            result_buffer <= 32'h00000000;
                            result_count  <= 6'd0;
                        end
                        // Clear START returns to idle
                        if (!pwdata[0] && busy && pixel_counter >= pixel_count_reg) begin
                            busy <= 1'b0;
                            irq  <= 1'b0;
                        end
                    end

                    ADDR_PIXEL_COUNT: begin
                        pixel_count_reg <= pwdata;
                    end

                    ADDR_PIXEL_DATA: begin
                        if (busy && pixel_counter < pixel_count_reg) begin

                            if (entry_index == 5'd0) begin
                                // Current pixel: latch RGB
                                current_r  <= hist_r;
                                current_g  <= hist_g;
                                current_b  <= hist_b;
                                entry_index <= entry_index + 5'd1;

                            end else if (entry_index == (PIXEL_ENTRIES - 1)) begin
                                // Last history entry: finalize pixel
                                if ((match_count + {4'b0, match}) > MATCH_THRESH) begin
                                    result_buffer[result_count] <= 1'b1;
                                end else begin
                                    result_buffer[result_count] <= 1'b0;
                                end

                                // Check if buffer is full
                                if (result_count == 6'd31) begin
                                    result_reg <= {result_buffer[30:0],
                                                  ((match_count + {4'b0, match}) > MATCH_THRESH)};
                                    irq <= 1'b1;
                                end else if (pixel_counter + 32'd1 >= pixel_count_reg) begin
                                    // All done, partial buffer
                                    result_reg <= {result_buffer[30:0],
                                                  ((match_count + {4'b0, match}) > MATCH_THRESH)};
                                end

                                entry_index   <= 5'd0;
                                pixel_counter <= pixel_counter + 32'd1;
                                match_count   <= 5'd0;

                            end else begin
                                // Middle history entry
                                if (match)
                                    match_count <= match_count + 5'd1;
                                entry_index <= entry_index + 5'd1;
                            end
                        end
                    end

                    default: ;
                endcase
            end

            // ---- Handle APB Read ----
            if (rd_enable) begin
                case (paddr)
                    ADDR_CONTROL:     prdata <= control_reg;
                    ADDR_STATUS:      prdata <= {29'b0,
                                                 (busy && pixel_counter >= pixel_count_reg && result_count == 6'd0),  // [2] DONE
                                                 (irq),   // [1] READY
                                                 (busy)}; // [0] BUSY
                    ADDR_PIXEL_COUNT: prdata <= pixel_count_reg;
                    ADDR_RESULT:      prdata <= result_reg;
                    ADDR_DEBUG:       prdata <= 32'hDEADBEEF;
                    default:          prdata <= 32'b0;
                endcase
            end
        end
    end

endmodule
