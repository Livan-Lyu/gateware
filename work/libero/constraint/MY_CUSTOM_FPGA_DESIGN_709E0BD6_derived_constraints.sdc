# Microchip Technology Inc.
# Date: 2026-Jul-11 00:48:50
# This file was generated based on the following SDC source files:
#   /home/livan/gateware/gateware/work/libero/component/work/PF_SOC_MSS/PF_SOC_MSS.sdc
#   /home/livan/gateware/gateware/work/libero/component/work/CAPE_AXI_XBAR/CAPE_AXI_XBAR_0/CAPE_AXI_XBAR.sdc
#   /home/livan/gateware/gateware/work/libero/component/work/FPGA_CCC_C0/FPGA_CCC_C0_0/FPGA_CCC_C0_FPGA_CCC_C0_0_PF_CCC.sdc
#   /home/livan/gateware/gateware/work/libero/component/work/PF_CCC_ADC/PF_CCC_ADC_0/PF_CCC_ADC_PF_CCC_ADC_0_PF_CCC.sdc
#   /home/livan/Microchip/Libero_SoC_2025.1/Libero_SoC/Designer/data/aPA5M/cores/constraints/EXT/osc_rc160mhz.sdc
# *** Any modifications to this file will be lost if derived constraints is re-run. ***
#

create_clock -name {CLOCKS_AND_RESETS_inst_0/OSCILLATOR_160MHz_inst_0/OSCILLATOR_160MHz_0/I_OSC_160/CLK} -period 6.25 [ get_pins { CLOCKS_AND_RESETS_inst_0/OSCILLATOR_160MHz_inst_0/OSCILLATOR_160MHz_0/I_OSC_160/CLK } ]
create_clock -name {osc_rc160mhz} -period 5.86854 [ get_pins { CLOCKS_AND_RESETS_inst_0/OSCILLATOR_160MHz_inst_0/OSCILLATOR_160MHz_0/I_OSC_160/CLK } ]
create_generated_clock -name {CLOCKS_AND_RESETS_inst_0/FPGA_CCC_C0_0/FPGA_CCC_C0_0/pll_inst_0/OUT0} -multiply_by 25 -divide_by 32 -source [ get_pins { CLOCKS_AND_RESETS_inst_0/FPGA_CCC_C0_0/FPGA_CCC_C0_0/pll_inst_0/REF_CLK_0 } ] -phase 0 [ get_pins { CLOCKS_AND_RESETS_inst_0/FPGA_CCC_C0_0/FPGA_CCC_C0_0/pll_inst_0/OUT0 } ]
create_generated_clock -name {CLOCKS_AND_RESETS_inst_0/FPGA_CCC_C0_0/FPGA_CCC_C0_0/pll_inst_0/OUT1} -multiply_by 25 -divide_by 32 -source [ get_pins { CLOCKS_AND_RESETS_inst_0/FPGA_CCC_C0_0/FPGA_CCC_C0_0/pll_inst_0/REF_CLK_0 } ] -phase 0 [ get_pins { CLOCKS_AND_RESETS_inst_0/FPGA_CCC_C0_0/FPGA_CCC_C0_0/pll_inst_0/OUT1 } ]
create_generated_clock -name {CLOCKS_AND_RESETS_inst_0/FPGA_CCC_C0_0/FPGA_CCC_C0_0/pll_inst_0/OUT2} -multiply_by 25 -divide_by 32 -source [ get_pins { CLOCKS_AND_RESETS_inst_0/FPGA_CCC_C0_0/FPGA_CCC_C0_0/pll_inst_0/REF_CLK_0 } ] -phase 0 [ get_pins { CLOCKS_AND_RESETS_inst_0/FPGA_CCC_C0_0/FPGA_CCC_C0_0/pll_inst_0/OUT2 } ]
create_generated_clock -name {CLOCKS_AND_RESETS_inst_0/FPGA_CCC_C0_0/FPGA_CCC_C0_0/pll_inst_0/OUT3} -multiply_by 5 -divide_by 16 -source [ get_pins { CLOCKS_AND_RESETS_inst_0/FPGA_CCC_C0_0/FPGA_CCC_C0_0/pll_inst_0/REF_CLK_0 } ] -phase 0 [ get_pins { CLOCKS_AND_RESETS_inst_0/FPGA_CCC_C0_0/FPGA_CCC_C0_0/pll_inst_0/OUT3 } ]
create_generated_clock -name {CLOCKS_AND_RESETS_inst_0/PF_CCC_ADC_0/PF_CCC_ADC_0/pll_inst_0/OUT0} -multiply_by 1560513 -divide_by 50800000 -source [ get_pins { CLOCKS_AND_RESETS_inst_0/PF_CCC_ADC_0/PF_CCC_ADC_0/pll_inst_0/REF_CLK_0 } ] -phase 0 [ get_pins { CLOCKS_AND_RESETS_inst_0/PF_CCC_ADC_0/PF_CCC_ADC_0/pll_inst_0/OUT0 } ]
