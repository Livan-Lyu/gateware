if {[file isdirectory $local_dir/script_support/components/MSS]} {
    file delete -force $local_dir/script_support/components/MSS
}
file mkdir $local_dir/script_support/components/MSS

set cfg_file [glob -nocomplain $local_dir/../MSS_Configuration/$die/$package/$board/*.cfg]
exec $mss_config_loc -GENERATE -CONFIGURATION_FILE:$cfg_file -OUTPUT_DIR:$local_dir/script_support/components/MSS

set mss_component_file [glob -nocomplain $local_dir/script_support/components/MSS/*.cxz]
set mss_component_name [file rootname [file tail $mss_component_file]]

puts "MSS filename: $mss_component_name"

import_mss_component -file $mss_component_file
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
::safe_source script_support/components/IHC_APB.tcl
::safe_source script_support/components/IHC_SUBSYSTEM.tcl
::safe_source script_support/components/BVF_RISCV_SUBSYSTEM.tcl
::safe_source script_support/components/BVF_GATEWARE.tcl 
set_root -module ${top_level_name}::work