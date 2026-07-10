# Written by Synplify Pro version map202309act, Build 395R. Synopsys Run ID: sid1783702151 
# Top Level Design Parameters 

# Clocks 
create_clock -period 5.869 -waveform {0.000 2.934} -name {osc_rc160mhz} [get_pins {CLOCKS_AND_RESETS_inst_0/OSCILLATOR_160MHz_inst_0/OSCILLATOR_160MHz_0/I_OSC_160/CLK}] 

# Virtual Clocks 

# Generated Clocks 
create_generated_clock -name {CLOCKS_AND_RESETS_inst_0/FPGA_CCC_C0_0/FPGA_CCC_C0_0/pll_inst_0/OUT0} -multiply_by {25} -divide_by {32} -source [get_pins {CLOCKS_AND_RESETS_inst_0/FPGA_CCC_C0_0/FPGA_CCC_C0_0/pll_inst_0/REF_CLK_0}]  [get_pins {CLOCKS_AND_RESETS_inst_0/FPGA_CCC_C0_0/FPGA_CCC_C0_0/pll_inst_0/OUT0}] 
create_generated_clock -name {CLOCKS_AND_RESETS_inst_0/FPGA_CCC_C0_0/FPGA_CCC_C0_0/pll_inst_0/OUT1} -multiply_by {25} -divide_by {32} -source [get_pins {CLOCKS_AND_RESETS_inst_0/FPGA_CCC_C0_0/FPGA_CCC_C0_0/pll_inst_0/REF_CLK_0}]  [get_pins {CLOCKS_AND_RESETS_inst_0/FPGA_CCC_C0_0/FPGA_CCC_C0_0/pll_inst_0/OUT1}] 
create_generated_clock -name {CLOCKS_AND_RESETS_inst_0/FPGA_CCC_C0_0/FPGA_CCC_C0_0/pll_inst_0/OUT2} -multiply_by {25} -divide_by {32} -source [get_pins {CLOCKS_AND_RESETS_inst_0/FPGA_CCC_C0_0/FPGA_CCC_C0_0/pll_inst_0/REF_CLK_0}]  [get_pins {CLOCKS_AND_RESETS_inst_0/FPGA_CCC_C0_0/FPGA_CCC_C0_0/pll_inst_0/OUT2}] 
create_generated_clock -name {CLOCKS_AND_RESETS_inst_0/FPGA_CCC_C0_0/FPGA_CCC_C0_0/pll_inst_0/OUT3} -multiply_by {5} -divide_by {16} -source [get_pins {CLOCKS_AND_RESETS_inst_0/FPGA_CCC_C0_0/FPGA_CCC_C0_0/pll_inst_0/REF_CLK_0}]  [get_pins {CLOCKS_AND_RESETS_inst_0/FPGA_CCC_C0_0/FPGA_CCC_C0_0/pll_inst_0/OUT3}] 
create_generated_clock -name {CLOCKS_AND_RESETS_inst_0/PF_CCC_ADC_0/PF_CCC_ADC_0/pll_inst_0/OUT0} -multiply_by {1560513} -divide_by {50800000} -source [get_pins {CLOCKS_AND_RESETS_inst_0/PF_CCC_ADC_0/PF_CCC_ADC_0/pll_inst_0/REF_CLK_0}]  [get_pins {CLOCKS_AND_RESETS_inst_0/PF_CCC_ADC_0/PF_CCC_ADC_0/pll_inst_0/OUT0}] 

# Paths Between Clocks 

# Multicycle Constraints 

# Point-to-point Delay Constraints 

# False Path Constraints 

# Output Load Constraints 

# Driving Cell Constraints 

# Input Delay Constraints 

# Output Delay Constraints 

# Wire Loads 

# Other Constraints 

# syn_hier Attributes 

# set_case Attributes 

# Clock Delay Constraints 
set_clock_groups -asynchronous -group [get_clocks {CLOCKS_AND_RESETS_inst_0/FPGA_CCC_C0_0/FPGA_CCC_C0_0/pll_inst_0/OUT0}]
set_clock_groups -asynchronous -group [get_clocks {CLOCKS_AND_RESETS_inst_0/FPGA_CCC_C0_0/FPGA_CCC_C0_0/pll_inst_0/OUT1}]
set_clock_groups -asynchronous -group [get_clocks {CLOCKS_AND_RESETS_inst_0/FPGA_CCC_C0_0/FPGA_CCC_C0_0/pll_inst_0/OUT2}]
set_clock_groups -asynchronous -group [get_clocks {CLOCKS_AND_RESETS_inst_0/FPGA_CCC_C0_0/FPGA_CCC_C0_0/pll_inst_0/OUT3}]

# syn_mode Attributes 

# Cells 

# Port DRC Rules 

# Input Transition Constraints 

# Unused constraints (intentionally commented out) 


# Non-forward-annotatable constraints (intentionally commented out) 

# Block Path constraints 

