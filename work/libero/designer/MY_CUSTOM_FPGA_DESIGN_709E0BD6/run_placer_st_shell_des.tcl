set_device \
    -family  PolarFireSoC \
    -die     PA5SOC025T \
    -package fcvg484 \
    -speed   STD \
    -tempr   {EXT} \
    -voltr   {EXT}
set_def {VOLTAGE} {1.0}
set_def {VCCI_1.2_VOLTR} {EXT}
set_def {VCCI_1.5_VOLTR} {EXT}
set_def {VCCI_1.8_VOLTR} {EXT}
set_def {VCCI_2.5_VOLTR} {EXT}
set_def {VCCI_3.3_VOLTR} {EXT}
set_def {RTG4_MITIGATION_ON} {0}
set_def USE_CONSTRAINTS_FLOW 1
set_def NETLIST_TYPE EDIF
set_name MY_CUSTOM_FPGA_DESIGN_709E0BD6
set_workdir {/home/livan/gateware/gateware/work/libero/designer/MY_CUSTOM_FPGA_DESIGN_709E0BD6}
set_log     {/home/livan/gateware/gateware/work/libero/designer/MY_CUSTOM_FPGA_DESIGN_709E0BD6/MY_CUSTOM_FPGA_DESIGN_709E0BD6_sdc.log}
set_design_state pre_layout
