import_mss_component -file $MSS_COMPONENT_PATH
set mss_component_name [file rootname [file tail $MSS_COMPONENT_PATH]]
puts "MSS filename: $mss_component_name"


::safe_source script_support/hdl_source.tcl
::safe_source script_support/components/CLOCKS_AND_RESETS/CORERESET_0.tcl
::safe_source script_support/components/CLOCKS_AND_RESETS/INIT_MONITOR.tcl 
::safe_source script_support/components/CLOCKS_AND_RESETS/FPGA_CCC_C0.tcl
::safe_source script_support/components/FIC0_INITIATOR.tcl 
::safe_source script_support/components/CLOCKS_AND_RESETS/CLK_DIV.tcl 
::safe_source script_support/components/CLOCKS_AND_RESETS/GLITCHLESS_MUX.tcl 
::safe_source script_support/components/CLOCKS_AND_RESETS/TRANSMIT_PLL.tcl 
::safe_source script_support/components/CLOCKS_AND_RESETS/PCIE_REF_CLK.tcl 
::safe_source script_support/components/FIC3_INITIATOR.tcl
::safe_source script_support/components/CLOCKS_AND_RESETS/OSCILLATOR_160MHz.tcl
::safe_source script_support/components/CLOCKS_AND_RESETS/ADC_MCLK_CCC.tcl 
::safe_source script_support/components/CLOCKS_AND_RESETS/CLOCKS_AND_RESETS.tcl 
::safe_source script_support/components/MIV_IHC_C0.tcl
::safe_source script_support/components/BVF_RISCV_SUBSYSTEM.tcl
::safe_source script_support/components/BVF_GATEWARE.tcl 
set_root -module ${top_level_name}::work