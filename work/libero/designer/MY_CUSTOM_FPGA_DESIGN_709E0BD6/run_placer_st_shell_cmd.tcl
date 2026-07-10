read_sdc -scenario "place_and_route" -netlist "optimized" -pin_separator "/" -ignore_errors {/home/livan/gateware/gateware/work/libero/designer/MY_CUSTOM_FPGA_DESIGN_709E0BD6/place_route.sdc}
set_options -tdpr_scenario "place_and_route" 
save
set_options -analysis_scenario "place_and_route"
report -type combinational_loops -format xml {/home/livan/gateware/gateware/work/libero/designer/MY_CUSTOM_FPGA_DESIGN_709E0BD6/MY_CUSTOM_FPGA_DESIGN_709E0BD6_layout_combinational_loops.xml}
report -type slack {/home/livan/gateware/gateware/work/libero/designer/MY_CUSTOM_FPGA_DESIGN_709E0BD6/pinslacks.txt}
set coverage [report \
    -type     constraints_coverage \
    -format   xml \
    -slacks   no \
    {/home/livan/gateware/gateware/work/libero/designer/MY_CUSTOM_FPGA_DESIGN_709E0BD6/MY_CUSTOM_FPGA_DESIGN_709E0BD6_place_and_route_constraint_coverage.xml}]
set reportfile {/home/livan/gateware/gateware/work/libero/designer/MY_CUSTOM_FPGA_DESIGN_709E0BD6/coverage_placeandroute}
set fp [open $reportfile w]
puts $fp $coverage
close $fp