`timescale 1ns/100ps
module pixel_proc(
    // APB slave (control/status registers)
    input               pclk,
    input               presetn,
    input               psel,
    input               penable,
    input               pwrite,
    input       [7:0]   paddr,
    input       [31:0]  pwdata,
    output  reg [31:0]  prdata,
    output  reg         irq,
    // AXI4 master read (read DDR)
    output  reg [31:0]  m_axi_araddr,
    output  reg         m_axi_arvalid,
    input               m_axi_arready,
    input       [31:0]  m_axi_rdata,
    input               m_axi_rvalid,
    output  reg         m_axi_rready,
    input       [1:0]   m_axi_rresp
);

    // ==========================================
    // Register addresses (paddr[7]=1 space, offsets 0x80-0xFF)
    // ==========================================
    localparam [7:0] ADDR_CONTROL     = 8'h80;
    localparam [7:0] ADDR_STATUS      = 8'h84;
    localparam [7:0] ADDR_SRC_ADDR_LO = 8'h88;
    localparam [7:0] ADDR_SRC_ADDR_HI = 8'h8C;
    localparam [7:0] ADDR_PIXEL_COUNT = 8'h90;
    localparam [7:0] ADDR_RESULT      = 8'h94;
    localparam [7:0] ADDR_DEBUG       = 8'h98;

    // ==========================================
    // Fixed parameters
    // ==========================================
    localparam [9:0]  THRESHOLD_X2  = 10'd90;   // 4.5 * 20 = 90, diff_sum*2 <= 90
    localparam [4:0]  PIXEL_ENTRIES = 5'd24;     // 1 current + 23 history per pixel
    localparam [4:0]  MATCH_THRESH  = 5'd2;      // >2 history matches => foreground

    // ==========================================
    // State machine encoding
    // ==========================================
    localparam [2:0] ST_IDLE     = 3'd0;
    localparam [2:0] ST_AR_READ  = 3'd1;
    localparam [2:0] ST_R_DATA   = 3'd2;
    localparam [2:0] ST_WAIT_ACK = 3'd3;
    localparam [2:0] ST_DONE     = 3'd4;

    // ==========================================
    // APB-accessible registers
    // ==========================================
    reg [31:0] control_reg;
    reg [31:0] src_addr_lo;
    reg [31:0] src_addr_hi;
    reg [31:0] pixel_count_reg;
    reg [31:0] result_reg;

    // ==========================================
    // Internal state
    // ==========================================
    reg [2:0]  state;
    reg [63:0] work_src_addr;       // latched on START, incremented per beat
    reg [31:0] work_pixel_count;    // latched on START
    reg [4:0]  entry_index;         // 0..23 within current pixel
    reg [31:0] pixel_counter;       // how many pixels fully processed
    reg [7:0]  current_r, current_g, current_b;  // current pixel RGB (latched at entry 0)
    reg [4:0]  match_count;         // accumulated matches for current pixel (0..23)
    reg [31:0] result_buffer;       // packed foreground bits
    reg [5:0]  result_count;        // valid bits in result_buffer (0..32)

    // ==========================================
    // APB read/write strobes
    // ==========================================
    wire rd_enable = (!pwrite && psel);
    wire wr_enable = (penable && pwrite && psel);

    // ==========================================
    // Combinational computation
    // ==========================================
    wire [7:0] hist_r = m_axi_rdata[7:0];
    wire [7:0] hist_g = m_axi_rdata[15:8];
    wire [7:0] hist_b = m_axi_rdata[23:16];

    wire [7:0] diff_r = (current_r > hist_r) ? (current_r - hist_r) : (hist_r - current_r);
    wire [7:0] diff_g = (current_g > hist_g) ? (current_g - hist_g) : (hist_g - current_g);
    wire [7:0] diff_b = (current_b > hist_b) ? (current_b - hist_b) : (hist_b - current_b);

    wire [8:0] diff_sum = {1'b0, diff_r} + {1'b0, diff_g} + {1'b0, diff_b};
    wire [9:0] diff_x2  = {diff_sum, 1'b0};        // diff_sum * 2, 10-bit
    wire       match    = (diff_x2 <= THRESHOLD_X2);

    // ==========================================
    // APB Register Read/Write
    // ==========================================
    always @(posedge pclk or negedge presetn) begin
        if (~presetn) begin
            control_reg     <= 32'h00000000;
            src_addr_lo     <= 32'h00000000;
            src_addr_hi     <= 32'h00000000;
            pixel_count_reg <= 32'h00000000;
            result_reg      <= 32'h00000000;
            prdata          <= 32'b0;
        end else begin
            // ---- Write ----
            if (wr_enable) begin
                case (paddr)
                    ADDR_CONTROL:     control_reg     <= pwdata;
                    ADDR_SRC_ADDR_LO: src_addr_lo     <= pwdata;
                    ADDR_SRC_ADDR_HI: src_addr_hi     <= pwdata;
                    ADDR_PIXEL_COUNT: pixel_count_reg <= pwdata;
                    default: ;
                endcase
            end

            // ---- Read ----
            if (rd_enable) begin
                case (paddr)
                    ADDR_CONTROL:     prdata <= control_reg;
                    ADDR_STATUS:      prdata <= {29'b0,
                                                 (state == ST_DONE),              // [2] DONE
                                                 (state == ST_WAIT_ACK),          // [1] READY
                                                 (state != ST_IDLE && state != ST_DONE)}; // [0] BUSY
                    ADDR_SRC_ADDR_LO: prdata <= src_addr_lo;
                    ADDR_SRC_ADDR_HI: prdata <= src_addr_hi;
                    ADDR_PIXEL_COUNT: prdata <= pixel_count_reg;
                    ADDR_RESULT:      prdata <= result_reg;
                    ADDR_DEBUG:       prdata <= 32'hDEADBEEF;
                    default:          prdata <= 32'b0;
                endcase
            end
        end
    end

    // ==========================================
    // Main FSM: AXI reads + computation + handshake
    // ==========================================
    always @(posedge pclk or negedge presetn) begin
        if (~presetn) begin
            state           <= ST_IDLE;
            m_axi_araddr    <= 32'h00000000;
            m_axi_arvalid   <= 1'b0;
            m_axi_rready    <= 1'b0;
            irq             <= 1'b0;
            work_src_addr   <= 64'h00000000;
            work_pixel_count<= 32'h00000000;
            entry_index     <= 5'd0;
            pixel_counter   <= 32'd0;
            current_r       <= 8'd0;
            current_g       <= 8'd0;
            current_b       <= 8'd0;
            match_count     <= 5'd0;
            result_buffer   <= 32'h00000000;
            result_count    <= 6'd0;
            result_reg      <= 32'h00000000;
        end else begin
            case (state)

                // ==================================
                ST_IDLE: begin
                    m_axi_arvalid <= 1'b0;
                    m_axi_rready  <= 1'b0;
                    irq           <= 1'b0;
                    if (control_reg[0]) begin
                        // Latch working copies on START
                        work_src_addr    <= {src_addr_hi, src_addr_lo};
                        work_pixel_count <= pixel_count_reg;
                        entry_index      <= 5'd0;
                        pixel_counter    <= 32'd0;
                        match_count      <= 5'd0;
                        result_buffer    <= 32'h00000000;
                        result_count     <= 6'd0;
                        result_reg       <= 32'h00000000;
                        state <= ST_AR_READ;
                    end
                end

                // ==================================
                ST_AR_READ: begin
                    m_axi_araddr  <= work_src_addr[31:0];
                    m_axi_arvalid <= 1'b1;
                    if (m_axi_arready) begin
                        m_axi_arvalid <= 1'b0;
                        m_axi_rready  <= 1'b1;
                        state <= ST_R_DATA;
                    end
                end

                // ==================================
                ST_R_DATA: begin
                    if (m_axi_rvalid && m_axi_rready) begin

                        if (entry_index == 5'd0) begin
                            // ---- Current pixel: latch RGB ----
                            current_r  <= hist_r;
                            current_g  <= hist_g;
                            current_b  <= hist_b;
                            entry_index    <= entry_index + 5'd1;
                            work_src_addr  <= work_src_addr + 64'd4;
                            m_axi_rready   <= 1'b0;
                            state          <= ST_AR_READ;

                        end else if (entry_index == (PIXEL_ENTRIES - 1)) begin
                            // ---- Last history entry (23): finalize pixel ----
                            // Total matches = previous count + current comparison
                            // (match_count = old value from entries 1..22, match = combinational)
                            if ((match_count + {4'b0, match}) > MATCH_THRESH) begin
                                result_buffer[result_count] <= 1'b1;
                            end else begin
                                result_buffer[result_count] <= 1'b0;
                            end

                            // Check if result buffer is full after this pixel
                            if (result_count == 6'd31) begin
                                result_reg <= {result_buffer[30:0],
                                              ((match_count + {4'b0, match}) > MATCH_THRESH)};
                                irq        <= 1'b1;
                                state      <= ST_WAIT_ACK;
                            end else if (pixel_counter + 32'd1 >= work_pixel_count) begin
                                // All pixels done, buffer partially full
                                result_reg <= {result_buffer[30:0],
                                              ((match_count + {4'b0, match}) > MATCH_THRESH)};
                                state      <= ST_DONE;
                            end else begin
                                // Continue to next pixel
                                work_src_addr <= work_src_addr + 64'd4;
                                m_axi_rready  <= 1'b0;
                                state         <= ST_AR_READ;
                            end

                            entry_index    <= 5'd0;
                            pixel_counter  <= pixel_counter + 32'd1;
                            match_count    <= 5'd0;   // NB: overwrites any increment below

                        end else begin
                            // ---- Middle history entry (1..22): accumulate ----
                            if (match)
                                match_count <= match_count + 5'd1;

                            entry_index    <= entry_index + 5'd1;
                            work_src_addr  <= work_src_addr + 64'd4;
                            m_axi_rready   <= 1'b0;
                            state          <= ST_AR_READ;
                        end
                    end
                end

                // ==================================
                ST_WAIT_ACK: begin
                    m_axi_arvalid <= 1'b0;
                    m_axi_rready  <= 1'b0;
                    // CPU writes CONTROL[7]=1 to acknowledge results consumed
                    if (wr_enable && paddr == ADDR_CONTROL && pwdata[7]) begin
                        irq           <= 1'b0;
                        result_buffer <= 32'h00000000;
                        result_count  <= 6'd0;
                        match_count   <= 5'd0;
                        if (pixel_counter >= work_pixel_count) begin
                            state <= ST_DONE;
                        end else begin
                            state <= ST_AR_READ;
                        end
                    end
                end

                // ==================================
                ST_DONE: begin
                    m_axi_arvalid <= 1'b0;
                    m_axi_rready  <= 1'b0;
                    irq           <= 1'b0;
                    // Wait for CPU to clear START before returning to IDLE
                    if (control_reg[0] == 1'b0) begin
                        state <= ST_IDLE;
                    end
                end

                default: begin
                    state <= ST_IDLE;
                end
            endcase
        end
    end

endmodule
