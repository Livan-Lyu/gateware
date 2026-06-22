puts "======== Add cape option: BGS ========"

# ---- Register CAPE.v as hdl_core ----
create_hdl_core -file $project_dir/hdl/CAPE.v -module {CAPE} -library {work} -package {}

# APB BIF
hdl_core_add_bif -hdl_core_name {CAPE} -bif_definition {APB:AMBA:AMBA2:slave} -bif_name {APB_BIF} -signal_map {}
hdl_core_assign_bif_signal -hdl_core_name {CAPE} -bif_name {APB_BIF} -bif_signal_name {PADDR}   -core_signal_name {APB_SLAVE_SLAVE_PADDR}
hdl_core_assign_bif_signal -hdl_core_name {CAPE} -bif_name {APB_BIF} -bif_signal_name {PSELx}   -core_signal_name {APB_SLAVE_SLAVE_PSEL}
hdl_core_assign_bif_signal -hdl_core_name {CAPE} -bif_name {APB_BIF} -bif_signal_name {PENABLE} -core_signal_name {APB_SLAVE_SLAVE_PENABLE}
hdl_core_assign_bif_signal -hdl_core_name {CAPE} -bif_name {APB_BIF} -bif_signal_name {PWRITE}  -core_signal_name {APB_SLAVE_SLAVE_PWRITE}
hdl_core_assign_bif_signal -hdl_core_name {CAPE} -bif_name {APB_BIF} -bif_signal_name {PRDATA}  -core_signal_name {APB_SLAVE_SLAVE_PRDATA}
hdl_core_assign_bif_signal -hdl_core_name {CAPE} -bif_name {APB_BIF} -bif_signal_name {PWDATA}  -core_signal_name {APB_SLAVE_SLAVE_PWDATA}
hdl_core_rename_bif -hdl_core_name {CAPE} -current_bif_name {APB_BIF} -new_bif_name {APB_TARGET}

# AXI4 master BIF (pixel_proc reads DDR via COREAXI4INTERCONNECT)
hdl_core_add_bif -hdl_core_name {CAPE} -bif_definition {AXI4:AMBA:AMBA4:master} -bif_name {AXI_BIF} -signal_map {}
hdl_core_assign_bif_signal -hdl_core_name {CAPE} -bif_name {AXI_BIF} -bif_signal_name {ARADDR}  -core_signal_name {M_AXI_ARADDR}
hdl_core_assign_bif_signal -hdl_core_name {CAPE} -bif_name {AXI_BIF} -bif_signal_name {ARVALID} -core_signal_name {M_AXI_ARVALID}
hdl_core_assign_bif_signal -hdl_core_name {CAPE} -bif_name {AXI_BIF} -bif_signal_name {ARREADY} -core_signal_name {M_AXI_ARREADY}
hdl_core_assign_bif_signal -hdl_core_name {CAPE} -bif_name {AXI_BIF} -bif_signal_name {RDATA}   -core_signal_name {M_AXI_RDATA}
hdl_core_assign_bif_signal -hdl_core_name {CAPE} -bif_name {AXI_BIF} -bif_signal_name {RVALID}  -core_signal_name {M_AXI_RVALID}
hdl_core_assign_bif_signal -hdl_core_name {CAPE} -bif_name {AXI_BIF} -bif_signal_name {RREADY}  -core_signal_name {M_AXI_RREADY}
hdl_core_assign_bif_signal -hdl_core_name {CAPE} -bif_name {AXI_BIF} -bif_signal_name {RRESP}   -core_signal_name {M_AXI_RRESP}
hdl_core_assign_bif_signal -hdl_core_name {CAPE} -bif_name {AXI_BIF} -bif_signal_name {AWADDR}  -core_signal_name {M_AXI_AWADDR}
hdl_core_assign_bif_signal -hdl_core_name {CAPE} -bif_name {AXI_BIF} -bif_signal_name {AWVALID} -core_signal_name {M_AXI_AWVALID}
hdl_core_assign_bif_signal -hdl_core_name {CAPE} -bif_name {AXI_BIF} -bif_signal_name {AWREADY} -core_signal_name {M_AXI_AWREADY}
hdl_core_assign_bif_signal -hdl_core_name {CAPE} -bif_name {AXI_BIF} -bif_signal_name {WDATA}   -core_signal_name {M_AXI_WDATA}
hdl_core_assign_bif_signal -hdl_core_name {CAPE} -bif_name {AXI_BIF} -bif_signal_name {WSTRB}   -core_signal_name {M_AXI_WSTRB}
hdl_core_assign_bif_signal -hdl_core_name {CAPE} -bif_name {AXI_BIF} -bif_signal_name {WVALID}  -core_signal_name {M_AXI_WVALID}
hdl_core_assign_bif_signal -hdl_core_name {CAPE} -bif_name {AXI_BIF} -bif_signal_name {WREADY}  -core_signal_name {M_AXI_WREADY}
hdl_core_assign_bif_signal -hdl_core_name {CAPE} -bif_name {AXI_BIF} -bif_signal_name {BRESP}   -core_signal_name {M_AXI_BRESP}
hdl_core_assign_bif_signal -hdl_core_name {CAPE} -bif_name {AXI_BIF} -bif_signal_name {BVALID}  -core_signal_name {M_AXI_BVALID}
hdl_core_assign_bif_signal -hdl_core_name {CAPE} -bif_name {AXI_BIF} -bif_signal_name {BREADY}  -core_signal_name {M_AXI_BREADY}
hdl_core_rename_bif -hdl_core_name {CAPE} -current_bif_name {AXI_BIF} -new_bif_name {AXI4_INITIATOR}

# ---- Build CAPE_TOP SmartDesign (COREAXI4INTERCONNECT + CAPE hdl_core) ----
::safe_source script_support/components/CAPE/$cape_option/CAPE.tcl

auto_promote_pad_pins -promote_all 0

#-------------------------------------------------------------------------------
set sd_name ${top_level_name}

sd_create_bus_port -sd_name ${sd_name} -port_name {P9} -port_direction {INOUT} -port_range {[20:19]} -port_is_pad {1}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {P9} -pin_slices {[20] [19]}

#-------------------------------------------------------------------------------
set sd_name {BVF_RISCV_SUBSYSTEM}
adapter::remove_pin "SPI_1_SS1"
adapter::remove_pin "SPI_1_CLK"
adapter::remove_pin "SPI_1_DI"
adapter::remove_pin "SPI_1_DO"
save_smartdesign -sd_name ${sd_name}
sd_update_instance -sd_name ${top_level_name} -instance_name ${sd_name}
generate_component -component_name ${sd_name}

#-------------------------------------------------------------------------------
set sd_name ${top_level_name}
sd_instantiate_component -sd_name ${sd_name} -component_name {CAPE_TOP} -instance_name {CAPE}

#-------------------------------------------------------------------------------
sd_delete_ports -sd_name ${sd_name} -port_names {P9_19}
sd_delete_ports -sd_name ${sd_name} -port_names {P9_20}

# Clocks — APB on FIC_3, AXI on FIC_0
sd_connect_pins -sd_name ${sd_name} -pin_names {"CLOCKS_AND_RESETS:FIC_3_PCLK" "CAPE:PCLK"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"CLOCKS_AND_RESETS:FIC_3_FABRIC_RESET_N" "CAPE:PRESETN"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"CLOCKS_AND_RESETS:FIC_0_ACLK" "CAPE:AXI_ACLK"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"CLOCKS_AND_RESETS:FIC_0_FABRIC_RESET_N" "CAPE:AXI_ARESETN"}

# GPIO
sd_connect_pins -sd_name ${sd_name} -pin_names {"BVF_RISCV_SUBSYSTEM:GPIO_2_F2M" "CAPE:GPIO_IN"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"BVF_RISCV_SUBSYSTEM:GPIO_2_M2F" "CAPE:GPIO_OUT"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"BVF_RISCV_SUBSYSTEM:GPIO_2_OE_M2F" "CAPE:GPIO_OE"}

sd_connect_pin_to_port -sd_name ${sd_name} -pin_name {CAPE:P8} -port_name {}
foreach p {11 12 13 14 15 16 17 18 21 22 23 24 25 26 27 28 29 30 31 41 42} {
    sd_connect_pin_to_port -sd_name ${sd_name} -pin_name "CAPE:P9_${p}" -port_name {}
}
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9[19]" "BVF_RISCV_SUBSYSTEM:I2C0_SCL"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9[20]" "BVF_RISCV_SUBSYSTEM:I2C0_SDA"}

# APB
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE:APB_SLAVE" "BVF_RISCV_SUBSYSTEM:CAPE_APB_MTARGET"}

# AXI → FIC_0
sd_clear_pin_attributes -sd_name ${sd_name} -pin_names {BVF_RISCV_SUBSYSTEM:FIC_0_AXI4_TARGET}
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE:AXI4mslave0" "BVF_RISCV_SUBSYSTEM:FIC_0_AXI4_TARGET"}

sd_mark_pins_unused -sd_name ${sd_name} -pin_names {BVF_RISCV_SUBSYSTEM:MMUART_4_TXD}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {BVF_RISCV_SUBSYSTEM:MMUART_4_RXD} -value {GND}

sd_clear_pin_attributes -sd_name ${sd_name} -pin_names {BVF_RISCV_SUBSYSTEM:MSS_INT_F2M}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {BVF_RISCV_SUBSYSTEM:MSS_INT_F2M} -pin_slices {[7:3] [31:8] [58:32]}
sd_connect_pins -sd_name ${sd_name} -pin_names {"BVF_RISCV_SUBSYSTEM:MSS_INT_F2M[31:8]" "CAPE:INT"}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {BVF_RISCV_SUBSYSTEM:MSS_INT_F2M[7:3]} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {BVF_RISCV_SUBSYSTEM:MSS_INT_F2M[58:32]} -value {GND}

auto_promote_pad_pins -promote_all 1
