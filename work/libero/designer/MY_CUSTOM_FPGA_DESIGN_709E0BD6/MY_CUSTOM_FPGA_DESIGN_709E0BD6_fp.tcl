new_project \
         -name {MY_CUSTOM_FPGA_DESIGN_709E0BD6} \
         -location {/home/livan/gateware/gateware/work/libero/designer/MY_CUSTOM_FPGA_DESIGN_709E0BD6/MY_CUSTOM_FPGA_DESIGN_709E0BD6_fp} \
         -mode {chain} \
         -connect_programmers {FALSE}
add_actel_device \
         -device {MPFS025T} \
         -name {MPFS025T}
enable_device \
         -name {MPFS025T} \
         -enable {TRUE}
save_project
close_project
