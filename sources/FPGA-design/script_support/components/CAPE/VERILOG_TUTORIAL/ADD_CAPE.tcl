puts "======== Add cape option: VERILOG_TUTORIAL ========"

create_hdl_core -file $project_dir/hdl/CAPE.v -module {CAPE} -library {work} -package {}

hdl_core_add_bif -hdl_core_name {CAPE} -bif_definition {APB:AMBA:AMBA2:slave} -bif_name {BIF_1} -signal_map {} 
hdl_core_assign_bif_signal -hdl_core_name {CAPE} -bif_name {BIF_1} -bif_signal_name {PADDR} -core_signal_name {APB_SLAVE_SLAVE_PADDR} 
hdl_core_assign_bif_signal -hdl_core_name {CAPE} -bif_name {BIF_1} -bif_signal_name {PSELx} -core_signal_name {APB_SLAVE_SLAVE_PSEL} 
hdl_core_assign_bif_signal -hdl_core_name {CAPE} -bif_name {BIF_1} -bif_signal_name {PENABLE} -core_signal_name {APB_SLAVE_SLAVE_PENABLE} 
hdl_core_assign_bif_signal -hdl_core_name {CAPE} -bif_name {BIF_1} -bif_signal_name {PWRITE} -core_signal_name {APB_SLAVE_SLAVE_PWRITE} 
hdl_core_assign_bif_signal -hdl_core_name {CAPE} -bif_name {BIF_1} -bif_signal_name {PRDATA} -core_signal_name {APB_SLAVE_SLAVE_PRDATA} 
hdl_core_assign_bif_signal -hdl_core_name {CAPE} -bif_name {BIF_1} -bif_signal_name {PWDATA} -core_signal_name {APB_SLAVE_SLAVE_PWDATA} 
hdl_core_rename_bif -hdl_core_name {CAPE} -current_bif_name {BIF_1} -new_bif_name {APB_TARGET} 

#-------------------------------------------------------------------------------
# Build the Cape module
#-------------------------------------------------------------------------------
set sd_name ${top_level_name}

#-------------------------------------------------------------------------------
# Cape pins
#-------------------------------------------------------------------------------
sd_create_bus_port -sd_name ${sd_name} -port_name {P9} -port_direction {INOUT} -port_range {[20:19]} -port_is_pad {1}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {P9} -pin_slices {[20] [19]}

#-------------------------------------------------------------------------------
# Transform the RISCV_SUBSYSTEM
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
# Instantiate.
#-------------------------------------------------------------------------------
set sd_name ${top_level_name}
sd_instantiate_hdl_core -sd_name ${sd_name} -hdl_core_name {CAPE} -instance_name {CAPE} 

#-------------------------------------------------------------------------------
# Connections.
#-------------------------------------------------------------------------------

sd_delete_ports -sd_name ${sd_name} -port_names {P9_19}
sd_delete_ports -sd_name ${sd_name} -port_names {P9_20}

# Clocks and resets
sd_connect_pins -sd_name ${sd_name} -pin_names {"CLOCKS_AND_RESETS:FIC_3_PCLK" "CAPE:PCLK"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"CLOCKS_AND_RESETS:FIC_3_FABRIC_RESET_N" "CAPE:PRESETN" }

sd_connect_pins -sd_name ${sd_name} -pin_names {"BVF_RISCV_SUBSYSTEM:GPIO_2_F2M" "CAPE:GPIO_IN"} 
sd_connect_pins -sd_name ${sd_name} -pin_names {"BVF_RISCV_SUBSYSTEM:GPIO_2_M2F" "CAPE:GPIO_OUT"} 
sd_connect_pins -sd_name ${sd_name} -pin_names {"BVF_RISCV_SUBSYSTEM:GPIO_2_OE_M2F" "CAPE:GPIO_OE"} 

sd_connect_pin_to_port -sd_name ${sd_name} -pin_name {CAPE:P8} -port_name {} 
sd_connect_pin_to_port -sd_name ${sd_name} -pin_name {CAPE:P9_11} -port_name {} 
sd_connect_pin_to_port -sd_name ${sd_name} -pin_name {CAPE:P9_12} -port_name {} 
sd_connect_pin_to_port -sd_name ${sd_name} -pin_name {CAPE:P9_13} -port_name {} 
sd_connect_pin_to_port -sd_name ${sd_name} -pin_name {CAPE:P9_14} -port_name {} 
sd_connect_pin_to_port -sd_name ${sd_name} -pin_name {CAPE:P9_15} -port_name {} 
sd_connect_pin_to_port -sd_name ${sd_name} -pin_name {CAPE:P9_16} -port_name {} 
sd_connect_pin_to_port -sd_name ${sd_name} -pin_name {CAPE:P9_17} -port_name {} 
sd_connect_pin_to_port -sd_name ${sd_name} -pin_name {CAPE:P9_18} -port_name {} 
sd_connect_pin_to_port -sd_name ${sd_name} -pin_name {CAPE:P9_21} -port_name {} 
sd_connect_pin_to_port -sd_name ${sd_name} -pin_name {CAPE:P9_22} -port_name {} 
sd_connect_pin_to_port -sd_name ${sd_name} -pin_name {CAPE:P9_23} -port_name {} 
sd_connect_pin_to_port -sd_name ${sd_name} -pin_name {CAPE:P9_24} -port_name {} 
sd_connect_pin_to_port -sd_name ${sd_name} -pin_name {CAPE:P9_25} -port_name {} 
sd_connect_pin_to_port -sd_name ${sd_name} -pin_name {CAPE:P9_26} -port_name {} 
sd_connect_pin_to_port -sd_name ${sd_name} -pin_name {CAPE:P9_27} -port_name {} 
sd_connect_pin_to_port -sd_name ${sd_name} -pin_name {CAPE:P9_28} -port_name {} 
sd_connect_pin_to_port -sd_name ${sd_name} -pin_name {CAPE:P9_29} -port_name {} 
sd_connect_pin_to_port -sd_name ${sd_name} -pin_name {CAPE:P9_30} -port_name {} 
sd_connect_pin_to_port -sd_name ${sd_name} -pin_name {CAPE:P9_31} -port_name {} 
sd_connect_pin_to_port -sd_name ${sd_name} -pin_name {CAPE:P9_41} -port_name {} 
sd_connect_pin_to_port -sd_name ${sd_name} -pin_name {CAPE:P9_42} -port_name {} 

sd_connect_pins -sd_name ${sd_name} -pin_names {"P9[19]" "BVF_RISCV_SUBSYSTEM:I2C0_SCL"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9[20]" "BVF_RISCV_SUBSYSTEM:I2C0_SDA"}

sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE:APB_TARGET" "BVF_RISCV_SUBSYSTEM:CAPE_APB_MTARGET"}

sd_mark_pins_unused -sd_name ${sd_name} -pin_names {BVF_RISCV_SUBSYSTEM:MMUART_4_TXD} 
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {BVF_RISCV_SUBSYSTEM:MMUART_4_RXD} -value {GND} 

sd_clear_pin_attributes -sd_name ${sd_name} -pin_names {BVF_RISCV_SUBSYSTEM:MSS_INT_F2M} 
sd_create_pin_slices -sd_name ${sd_name} -pin_name {BVF_RISCV_SUBSYSTEM:MSS_INT_F2M} -pin_slices {[7:3] [31:8] [58:32]}
sd_connect_pins -sd_name ${sd_name} -pin_names {"BVF_RISCV_SUBSYSTEM:MSS_INT_F2M[31:8]" "CAPE:INT"} 
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {BVF_RISCV_SUBSYSTEM:MSS_INT_F2M[7:3]} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {BVF_RISCV_SUBSYSTEM:MSS_INT_F2M[58:32]} -value {GND}
