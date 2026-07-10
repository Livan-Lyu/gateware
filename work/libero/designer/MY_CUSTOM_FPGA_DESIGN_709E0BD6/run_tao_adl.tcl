set_device -family {PolarFireSoC} -die {MPFS025T} -speed {STD}
read_adl {/home/livan/gateware/gateware/work/libero/designer/MY_CUSTOM_FPGA_DESIGN_709E0BD6/MY_CUSTOM_FPGA_DESIGN_709E0BD6.adl}
read_afl {/home/livan/gateware/gateware/work/libero/designer/MY_CUSTOM_FPGA_DESIGN_709E0BD6/MY_CUSTOM_FPGA_DESIGN_709E0BD6.afl}
map_netlist
read_sdc {/home/livan/gateware/gateware/work/libero/constraint/MY_CUSTOM_FPGA_DESIGN_709E0BD6_derived_constraints.sdc}
read_sdc {/home/livan/gateware/gateware/work/libero/constraint/fic_clocks.sdc}
check_constraints {/home/livan/gateware/gateware/work/libero/constraint/placer_sdc_errors.log}
estimate_jitter -report {/home/livan/gateware/gateware/work/libero/designer/MY_CUSTOM_FPGA_DESIGN_709E0BD6/place_and_route_jitter_report.txt}
write_sdc -mode layout {/home/livan/gateware/gateware/work/libero/designer/MY_CUSTOM_FPGA_DESIGN_709E0BD6/place_route.sdc}
