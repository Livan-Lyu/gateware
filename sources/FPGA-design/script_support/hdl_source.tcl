#Importing and Linking all the HDL source files used in the design
import_files \
         -convert_EDN_to_HDL 0 \
         -library {work} \
         -hdl_source {script_support/HDL/APB_arbiter/apb_arbiter.v} \
         -hdl_source {script_support/HDL/AXI4_address_shim/AXI4_address_shim.v} 

set currentDir [pwd]

foreach file [glob -nocomplain -type f "$currentDir/script_support/components/CAPE/$cape_option/HDL/*.v"] {
    import_files -convert_EDN_to_HDL 0 -library {work} -hdl_source $file
}

build_design_hierarchy 

create_hdl_core -file $project_dir/hdl/apb_arbiter.v -module {APB_ARBITER} -library {work} -package {} 
hdl_core_add_bif -hdl_core_name {APB_ARBITER} -bif_definition {APB:AMBA:AMBA2:mirroredMaster} -bif_name {APB_MMASTER} -signal_map {} 
hdl_core_assign_bif_signal -hdl_core_name {APB_ARBITER} -bif_name {APB_MMASTER} -bif_signal_name {PADDR} -core_signal_name {in_paddr} 
hdl_core_assign_bif_signal -hdl_core_name {APB_ARBITER} -bif_name {APB_MMASTER} -bif_signal_name {PENABLE} -core_signal_name {in_penable} 
hdl_core_assign_bif_signal -hdl_core_name {APB_ARBITER} -bif_name {APB_MMASTER} -bif_signal_name {PWRITE} -core_signal_name {in_pwrite} 
hdl_core_assign_bif_signal -hdl_core_name {APB_ARBITER} -bif_name {APB_MMASTER} -bif_signal_name {PRDATA} -core_signal_name {in_prdata} 
hdl_core_assign_bif_signal -hdl_core_name {APB_ARBITER} -bif_name {APB_MMASTER} -bif_signal_name {PWDATA} -core_signal_name {in_pwdata} 
hdl_core_assign_bif_signal -hdl_core_name {APB_ARBITER} -bif_name {APB_MMASTER} -bif_signal_name {PREADY} -core_signal_name {in_pready} 
hdl_core_assign_bif_signal -hdl_core_name {APB_ARBITER} -bif_name {APB_MMASTER} -bif_signal_name {PSLVERR} -core_signal_name {in_pslverr} 
hdl_core_assign_bif_signal -hdl_core_name {APB_ARBITER} -bif_name {APB_MMASTER} -bif_signal_name {PSELx} -core_signal_name {in_psel} 
hdl_core_add_bif -hdl_core_name {APB_ARBITER} -bif_definition {APB:AMBA:AMBA2:master} -bif_name {APB_MASTER_low} -signal_map {} 
hdl_core_assign_bif_signal -hdl_core_name {APB_ARBITER} -bif_name {APB_MASTER_low} -bif_signal_name {PADDR} -core_signal_name {out_low_paddr} 
hdl_core_assign_bif_signal -hdl_core_name {APB_ARBITER} -bif_name {APB_MASTER_low} -bif_signal_name {PENABLE} -core_signal_name {out_low_penable} 
hdl_core_assign_bif_signal -hdl_core_name {APB_ARBITER} -bif_name {APB_MASTER_low} -bif_signal_name {PWRITE} -core_signal_name {out_low_pwrite} 
hdl_core_assign_bif_signal -hdl_core_name {APB_ARBITER} -bif_name {APB_MASTER_low} -bif_signal_name {PRDATA} -core_signal_name {out_low_prdata} 
hdl_core_assign_bif_signal -hdl_core_name {APB_ARBITER} -bif_name {APB_MASTER_low} -bif_signal_name {PWDATA} -core_signal_name {out_low_pwdata} 
hdl_core_assign_bif_signal -hdl_core_name {APB_ARBITER} -bif_name {APB_MASTER_low} -bif_signal_name {PREADY} -core_signal_name {out_low_pready} 
hdl_core_assign_bif_signal -hdl_core_name {APB_ARBITER} -bif_name {APB_MASTER_low} -bif_signal_name {PSLVERR} -core_signal_name {out_low_pslverr} 
hdl_core_assign_bif_signal -hdl_core_name {APB_ARBITER} -bif_name {APB_MASTER_low} -bif_signal_name {PSELx} -core_signal_name {out_high_psel} 
hdl_core_assign_bif_signal -hdl_core_name {APB_ARBITER} -bif_name {APB_MASTER_low} -bif_signal_name {PSELx} -core_signal_name {out_low_psel} 
hdl_core_add_bif -hdl_core_name {APB_ARBITER} -bif_definition {APB:AMBA:AMBA2:master} -bif_name {APB_MASTER_high} -signal_map {} 
hdl_core_assign_bif_signal -hdl_core_name {APB_ARBITER} -bif_name {APB_MASTER_high} -bif_signal_name {PADDR} -core_signal_name {out_high_paddr} 
hdl_core_assign_bif_signal -hdl_core_name {APB_ARBITER} -bif_name {APB_MASTER_high} -bif_signal_name {PENABLE} -core_signal_name {out_high_penable} 
hdl_core_assign_bif_signal -hdl_core_name {APB_ARBITER} -bif_name {APB_MASTER_high} -bif_signal_name {PWRITE} -core_signal_name {out_high_pwrite} 
hdl_core_assign_bif_signal -hdl_core_name {APB_ARBITER} -bif_name {APB_MASTER_high} -bif_signal_name {PRDATA} -core_signal_name {out_high_prdata} 
hdl_core_assign_bif_signal -hdl_core_name {APB_ARBITER} -bif_name {APB_MASTER_high} -bif_signal_name {PWDATA} -core_signal_name {out_high_pwdata} 
hdl_core_assign_bif_signal -hdl_core_name {APB_ARBITER} -bif_name {APB_MASTER_high} -bif_signal_name {PREADY} -core_signal_name {out_high_pready} 
hdl_core_assign_bif_signal -hdl_core_name {APB_ARBITER} -bif_name {APB_MASTER_high} -bif_signal_name {PSLVERR} -core_signal_name {out_high_pslverr} 
hdl_core_assign_bif_signal -hdl_core_name {APB_ARBITER} -bif_name {APB_MASTER_high} -bif_signal_name {PSELx} -core_signal_name {out_high_psel} 



create_hdl_core -file $project_dir/hdl/AXI4_address_shim.v -module {AXI_ADDRESS_SHIM} -library {work} -package {} 
hdl_core_add_bif -hdl_core_name {AXI_ADDRESS_SHIM} -bif_definition {AXI4:AMBA:AMBA4:mirroredMaster} -bif_name {AXI4_TARGET} -signal_map {} 
hdl_core_assign_bif_signal -hdl_core_name {AXI_ADDRESS_SHIM} -bif_name {AXI4_TARGET} -bif_signal_name {AWREADY} -core_signal_name {TARGET_OUT_AWREADY} 
hdl_core_assign_bif_signal -hdl_core_name {AXI_ADDRESS_SHIM} -bif_name {AXI4_TARGET} -bif_signal_name {WREADY} -core_signal_name {TARGET_OUT_WREADY} 
hdl_core_assign_bif_signal -hdl_core_name {AXI_ADDRESS_SHIM} -bif_name {AXI4_TARGET} -bif_signal_name {BID} -core_signal_name {TARGET_OUT_BID} 
hdl_core_assign_bif_signal -hdl_core_name {AXI_ADDRESS_SHIM} -bif_name {AXI4_TARGET} -bif_signal_name {BRESP} -core_signal_name {TARGET_OUT_BRESP} 
hdl_core_assign_bif_signal -hdl_core_name {AXI_ADDRESS_SHIM} -bif_name {AXI4_TARGET} -bif_signal_name {BVALID} -core_signal_name {TARGET_OUT_BVALID} 
hdl_core_assign_bif_signal -hdl_core_name {AXI_ADDRESS_SHIM} -bif_name {AXI4_TARGET} -bif_signal_name {ARREADY} -core_signal_name {TARGET_OUT_ARREADY} 
hdl_core_assign_bif_signal -hdl_core_name {AXI_ADDRESS_SHIM} -bif_name {AXI4_TARGET} -bif_signal_name {RID} -core_signal_name {TARGET_OUT_RID} 
hdl_core_assign_bif_signal -hdl_core_name {AXI_ADDRESS_SHIM} -bif_name {AXI4_TARGET} -bif_signal_name {RDATA} -core_signal_name {TARGET_OUT_RDATA} 
hdl_core_assign_bif_signal -hdl_core_name {AXI_ADDRESS_SHIM} -bif_name {AXI4_TARGET} -bif_signal_name {RRESP} -core_signal_name {TARGET_OUT_RRESP} 
hdl_core_assign_bif_signal -hdl_core_name {AXI_ADDRESS_SHIM} -bif_name {AXI4_TARGET} -bif_signal_name {RLAST} -core_signal_name {TARGET_OUT_RLAST} 
hdl_core_assign_bif_signal -hdl_core_name {AXI_ADDRESS_SHIM} -bif_name {AXI4_TARGET} -bif_signal_name {RVALID} -core_signal_name {TARGET_OUT_RVALID} 
hdl_core_assign_bif_signal -hdl_core_name {AXI_ADDRESS_SHIM} -bif_name {AXI4_TARGET} -bif_signal_name {AWREADY} -core_signal_name {TARGET_OUT_AWREADY} 
hdl_core_assign_bif_signal -hdl_core_name {AXI_ADDRESS_SHIM} -bif_name {AXI4_TARGET} -bif_signal_name {WREADY} -core_signal_name {TARGET_OUT_WREADY} 
hdl_core_assign_bif_signal -hdl_core_name {AXI_ADDRESS_SHIM} -bif_name {AXI4_TARGET} -bif_signal_name {BID} -core_signal_name {TARGET_OUT_BID} 
hdl_core_assign_bif_signal -hdl_core_name {AXI_ADDRESS_SHIM} -bif_name {AXI4_TARGET} -bif_signal_name {BRESP} -core_signal_name {TARGET_OUT_BRESP} 
hdl_core_assign_bif_signal -hdl_core_name {AXI_ADDRESS_SHIM} -bif_name {AXI4_TARGET} -bif_signal_name {BVALID} -core_signal_name {TARGET_OUT_BVALID} 
hdl_core_assign_bif_signal -hdl_core_name {AXI_ADDRESS_SHIM} -bif_name {AXI4_TARGET} -bif_signal_name {ARREADY} -core_signal_name {TARGET_OUT_ARREADY} 
hdl_core_assign_bif_signal -hdl_core_name {AXI_ADDRESS_SHIM} -bif_name {AXI4_TARGET} -bif_signal_name {RID} -core_signal_name {TARGET_OUT_RID} 
hdl_core_assign_bif_signal -hdl_core_name {AXI_ADDRESS_SHIM} -bif_name {AXI4_TARGET} -bif_signal_name {RDATA} -core_signal_name {TARGET_OUT_RDATA} 
hdl_core_assign_bif_signal -hdl_core_name {AXI_ADDRESS_SHIM} -bif_name {AXI4_TARGET} -bif_signal_name {RRESP} -core_signal_name {TARGET_OUT_RRESP} 
hdl_core_assign_bif_signal -hdl_core_name {AXI_ADDRESS_SHIM} -bif_name {AXI4_TARGET} -bif_signal_name {RLAST} -core_signal_name {TARGET_OUT_RLAST} 
hdl_core_assign_bif_signal -hdl_core_name {AXI_ADDRESS_SHIM} -bif_name {AXI4_TARGET} -bif_signal_name {RVALID} -core_signal_name {TARGET_OUT_RVALID} 
hdl_core_assign_bif_signal -hdl_core_name {AXI_ADDRESS_SHIM} -bif_name {AXI4_TARGET} -bif_signal_name {AWID} -core_signal_name {TARGET_IN_AWID} 
hdl_core_assign_bif_signal -hdl_core_name {AXI_ADDRESS_SHIM} -bif_name {AXI4_TARGET} -bif_signal_name {AWADDR} -core_signal_name {TARGET_IN_AWADDR} 
hdl_core_assign_bif_signal -hdl_core_name {AXI_ADDRESS_SHIM} -bif_name {AXI4_TARGET} -bif_signal_name {AWLEN} -core_signal_name {TARGET_IN_AWLEN} 
hdl_core_assign_bif_signal -hdl_core_name {AXI_ADDRESS_SHIM} -bif_name {AXI4_TARGET} -bif_signal_name {AWSIZE} -core_signal_name {TARGET_IN_AWSIZE} 
hdl_core_assign_bif_signal -hdl_core_name {AXI_ADDRESS_SHIM} -bif_name {AXI4_TARGET} -bif_signal_name {AWBURST} -core_signal_name {TARGET_IN_AWBURST} 
hdl_core_assign_bif_signal -hdl_core_name {AXI_ADDRESS_SHIM} -bif_name {AXI4_TARGET} -bif_signal_name {AWVALID} -core_signal_name {TARGET_IN_AWVALID} 
hdl_core_assign_bif_signal -hdl_core_name {AXI_ADDRESS_SHIM} -bif_name {AXI4_TARGET} -bif_signal_name {WDATA} -core_signal_name {TARGET_IN_WDATA} 
hdl_core_assign_bif_signal -hdl_core_name {AXI_ADDRESS_SHIM} -bif_name {AXI4_TARGET} -bif_signal_name {WSTRB} -core_signal_name {TARGET_IN_WSTRB} 
hdl_core_assign_bif_signal -hdl_core_name {AXI_ADDRESS_SHIM} -bif_name {AXI4_TARGET} -bif_signal_name {WLAST} -core_signal_name {TARGET_IN_WLAST} 
hdl_core_assign_bif_signal -hdl_core_name {AXI_ADDRESS_SHIM} -bif_name {AXI4_TARGET} -bif_signal_name {WVALID} -core_signal_name {TARGET_IN_WVALID} 
hdl_core_assign_bif_signal -hdl_core_name {AXI_ADDRESS_SHIM} -bif_name {AXI4_TARGET} -bif_signal_name {BREADY} -core_signal_name {TARGET_IN_BREADY} 
hdl_core_assign_bif_signal -hdl_core_name {AXI_ADDRESS_SHIM} -bif_name {AXI4_TARGET} -bif_signal_name {ARID} -core_signal_name {TARGET_IN_ARID} 
hdl_core_assign_bif_signal -hdl_core_name {AXI_ADDRESS_SHIM} -bif_name {AXI4_TARGET} -bif_signal_name {ARADDR} -core_signal_name {TARGET_IN_ARADDR} 
hdl_core_assign_bif_signal -hdl_core_name {AXI_ADDRESS_SHIM} -bif_name {AXI4_TARGET} -bif_signal_name {ARLEN} -core_signal_name {TARGET_IN_ARLEN} 
hdl_core_assign_bif_signal -hdl_core_name {AXI_ADDRESS_SHIM} -bif_name {AXI4_TARGET} -bif_signal_name {ARSIZE} -core_signal_name {TARGET_IN_ARSIZE} 
hdl_core_assign_bif_signal -hdl_core_name {AXI_ADDRESS_SHIM} -bif_name {AXI4_TARGET} -bif_signal_name {ARBURST} -core_signal_name {TARGET_IN_ARBURST} 
hdl_core_assign_bif_signal -hdl_core_name {AXI_ADDRESS_SHIM} -bif_name {AXI4_TARGET} -bif_signal_name {ARVALID} -core_signal_name {TARGET_IN_ARVALID} 
hdl_core_assign_bif_signal -hdl_core_name {AXI_ADDRESS_SHIM} -bif_name {AXI4_TARGET} -bif_signal_name {RREADY} -core_signal_name {TARGET_IN_RREADY} 

hdl_core_add_bif -hdl_core_name {AXI_ADDRESS_SHIM} -bif_definition {AXI4:AMBA:AMBA4:master} -bif_name {AXI4_INITIATOR} -signal_map {} 
hdl_core_assign_bif_signal -hdl_core_name {AXI_ADDRESS_SHIM} -bif_name {AXI4_INITIATOR} -bif_signal_name {AWREADY} -core_signal_name {INITIATOR_IN_AWREADY} 
hdl_core_assign_bif_signal -hdl_core_name {AXI_ADDRESS_SHIM} -bif_name {AXI4_INITIATOR} -bif_signal_name {WREADY} -core_signal_name {INITIATOR_IN_WREADY} 
hdl_core_assign_bif_signal -hdl_core_name {AXI_ADDRESS_SHIM} -bif_name {AXI4_INITIATOR} -bif_signal_name {BID} -core_signal_name {INITIATOR_IN_BID} 
hdl_core_assign_bif_signal -hdl_core_name {AXI_ADDRESS_SHIM} -bif_name {AXI4_INITIATOR} -bif_signal_name {BRESP} -core_signal_name {INITIATOR_IN_BRESP} 
hdl_core_assign_bif_signal -hdl_core_name {AXI_ADDRESS_SHIM} -bif_name {AXI4_INITIATOR} -bif_signal_name {BVALID} -core_signal_name {INITIATOR_IN_BVALID} 
hdl_core_assign_bif_signal -hdl_core_name {AXI_ADDRESS_SHIM} -bif_name {AXI4_INITIATOR} -bif_signal_name {ARREADY} -core_signal_name {INITIATOR_IN_ARREADY} 
hdl_core_assign_bif_signal -hdl_core_name {AXI_ADDRESS_SHIM} -bif_name {AXI4_INITIATOR} -bif_signal_name {RID} -core_signal_name {INITIATOR_IN_RID} 
hdl_core_assign_bif_signal -hdl_core_name {AXI_ADDRESS_SHIM} -bif_name {AXI4_INITIATOR} -bif_signal_name {RDATA} -core_signal_name {INITIATOR_IN_RDATA} 
hdl_core_assign_bif_signal -hdl_core_name {AXI_ADDRESS_SHIM} -bif_name {AXI4_INITIATOR} -bif_signal_name {RRESP} -core_signal_name {INITIATOR_IN_RRESP} 
hdl_core_assign_bif_signal -hdl_core_name {AXI_ADDRESS_SHIM} -bif_name {AXI4_INITIATOR} -bif_signal_name {RLAST} -core_signal_name {INITIATOR_IN_RLAST} 
hdl_core_assign_bif_signal -hdl_core_name {AXI_ADDRESS_SHIM} -bif_name {AXI4_INITIATOR} -bif_signal_name {RVALID} -core_signal_name {INITIATOR_IN_RVALID} 
hdl_core_assign_bif_signal -hdl_core_name {AXI_ADDRESS_SHIM} -bif_name {AXI4_INITIATOR} -bif_signal_name {AWID} -core_signal_name {INITIATOR_OUT_AWID} 
hdl_core_assign_bif_signal -hdl_core_name {AXI_ADDRESS_SHIM} -bif_name {AXI4_INITIATOR} -bif_signal_name {AWADDR} -core_signal_name {INITIATOR_OUT_AWADDR} 
hdl_core_assign_bif_signal -hdl_core_name {AXI_ADDRESS_SHIM} -bif_name {AXI4_INITIATOR} -bif_signal_name {AWLEN} -core_signal_name {INITIATOR_OUT_AWLEN} 
hdl_core_assign_bif_signal -hdl_core_name {AXI_ADDRESS_SHIM} -bif_name {AXI4_INITIATOR} -bif_signal_name {AWSIZE} -core_signal_name {INITIATOR_OUT_AWSIZE} 
hdl_core_assign_bif_signal -hdl_core_name {AXI_ADDRESS_SHIM} -bif_name {AXI4_INITIATOR} -bif_signal_name {AWBURST} -core_signal_name {INITIATOR_OUT_AWBURST} 
hdl_core_assign_bif_signal -hdl_core_name {AXI_ADDRESS_SHIM} -bif_name {AXI4_INITIATOR} -bif_signal_name {AWVALID} -core_signal_name {INITIATOR_OUT_AWVALID} 
hdl_core_assign_bif_signal -hdl_core_name {AXI_ADDRESS_SHIM} -bif_name {AXI4_INITIATOR} -bif_signal_name {WDATA} -core_signal_name {INITIATOR_OUT_WDATA} 
hdl_core_assign_bif_signal -hdl_core_name {AXI_ADDRESS_SHIM} -bif_name {AXI4_INITIATOR} -bif_signal_name {WSTRB} -core_signal_name {INITIATOR_OUT_WSTRB} 
hdl_core_assign_bif_signal -hdl_core_name {AXI_ADDRESS_SHIM} -bif_name {AXI4_INITIATOR} -bif_signal_name {WLAST} -core_signal_name {INITIATOR_OUT_WLAST} 
hdl_core_assign_bif_signal -hdl_core_name {AXI_ADDRESS_SHIM} -bif_name {AXI4_INITIATOR} -bif_signal_name {WVALID} -core_signal_name {INITIATOR_OUT_WVALID} 
hdl_core_assign_bif_signal -hdl_core_name {AXI_ADDRESS_SHIM} -bif_name {AXI4_INITIATOR} -bif_signal_name {BREADY} -core_signal_name {INITIATOR_OUT_BREADY} 
hdl_core_assign_bif_signal -hdl_core_name {AXI_ADDRESS_SHIM} -bif_name {AXI4_INITIATOR} -bif_signal_name {ARID} -core_signal_name {INITIATOR_OUT_ARID} 
hdl_core_assign_bif_signal -hdl_core_name {AXI_ADDRESS_SHIM} -bif_name {AXI4_INITIATOR} -bif_signal_name {ARADDR} -core_signal_name {INITIATOR_OUT_ARADDR} 
hdl_core_assign_bif_signal -hdl_core_name {AXI_ADDRESS_SHIM} -bif_name {AXI4_INITIATOR} -bif_signal_name {ARLEN} -core_signal_name {INITIATOR_OUT_ARLEN} 
hdl_core_assign_bif_signal -hdl_core_name {AXI_ADDRESS_SHIM} -bif_name {AXI4_INITIATOR} -bif_signal_name {ARSIZE} -core_signal_name {INITIATOR_OUT_ARSIZE} 
hdl_core_assign_bif_signal -hdl_core_name {AXI_ADDRESS_SHIM} -bif_name {AXI4_INITIATOR} -bif_signal_name {ARBURST} -core_signal_name {INITIATOR_OUT_ARBURST} 
hdl_core_assign_bif_signal -hdl_core_name {AXI_ADDRESS_SHIM} -bif_name {AXI4_INITIATOR} -bif_signal_name {ARVALID} -core_signal_name {INITIATOR_OUT_ARVALID} 
hdl_core_assign_bif_signal -hdl_core_name {AXI_ADDRESS_SHIM} -bif_name {AXI4_INITIATOR} -bif_signal_name {RREADY} -core_signal_name {INITIATOR_OUT_RREADY} 
 
