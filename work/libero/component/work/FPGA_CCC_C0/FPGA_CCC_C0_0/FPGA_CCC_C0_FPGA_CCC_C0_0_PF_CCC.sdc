set_component FPGA_CCC_C0_FPGA_CCC_C0_0_PF_CCC
# Microchip Technology Inc.
# Date: 2026-Jul-12 05:04:50
#

# Base clock for PLL #0
create_clock -period 6.25 [ get_pins { pll_inst_0/REF_CLK_0 } ]
create_generated_clock -multiply_by 25 -divide_by 32 -source [ get_pins { pll_inst_0/REF_CLK_0 } ] -phase 0 [ get_pins { pll_inst_0/OUT0 } ]
create_generated_clock -multiply_by 25 -divide_by 32 -source [ get_pins { pll_inst_0/REF_CLK_0 } ] -phase 0 [ get_pins { pll_inst_0/OUT1 } ]
create_generated_clock -multiply_by 25 -divide_by 32 -source [ get_pins { pll_inst_0/REF_CLK_0 } ] -phase 0 [ get_pins { pll_inst_0/OUT2 } ]
create_generated_clock -multiply_by 5 -divide_by 16 -source [ get_pins { pll_inst_0/REF_CLK_0 } ] -phase 0 [ get_pins { pll_inst_0/OUT3 } ]
