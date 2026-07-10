open_project -project {/home/livan/gateware/gateware/work/libero/designer/MY_CUSTOM_FPGA_DESIGN_709E0BD6/MY_CUSTOM_FPGA_DESIGN_709E0BD6_fp/MY_CUSTOM_FPGA_DESIGN_709E0BD6.pro}\
         -connect_programmers {FALSE}
load_programming_data \
    -name {MPFS025T} \
    -fpga {/home/livan/gateware/gateware/work/libero/designer/MY_CUSTOM_FPGA_DESIGN_709E0BD6/MY_CUSTOM_FPGA_DESIGN_709E0BD6.map} \
    -header {/home/livan/gateware/gateware/work/libero/designer/MY_CUSTOM_FPGA_DESIGN_709E0BD6/MY_CUSTOM_FPGA_DESIGN_709E0BD6.hdr} \
    -envm {/home/livan/gateware/gateware/work/libero/designer/MY_CUSTOM_FPGA_DESIGN_709E0BD6/MY_CUSTOM_FPGA_DESIGN_709E0BD6_envm.efc} \
    -snvm {/home/livan/gateware/gateware/work/libero/designer/MY_CUSTOM_FPGA_DESIGN_709E0BD6/MY_CUSTOM_FPGA_DESIGN_709E0BD6_snvm.efc} \
    -spm {/home/livan/gateware/gateware/work/libero/designer/MY_CUSTOM_FPGA_DESIGN_709E0BD6/MY_CUSTOM_FPGA_DESIGN_709E0BD6.spm} \
    -dca {/home/livan/gateware/gateware/work/libero/designer/MY_CUSTOM_FPGA_DESIGN_709E0BD6/MY_CUSTOM_FPGA_DESIGN_709E0BD6.dca}
export_single_dat \
    -name {MPFS025T} \
    -file {/home/livan/gateware/gateware/bitstream/DirectC/MY_CUSTOM_FPGA_DESIGN_709E0BD6.dat} \
    -secured

save_project
close_project
