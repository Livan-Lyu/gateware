puts "======== Add cape option: ROBOTICS ========"

create_hdl_core -file $project_dir/hdl/apb_rotary_enc.v -module {apb_rotary_enc} -library {work} -package {}

hdl_core_add_bif -hdl_core_name {apb_rotary_enc} -bif_definition {APB:AMBA:AMBA2:slave} -bif_name {BIF_1} -signal_map {} 
hdl_core_assign_bif_signal -hdl_core_name {apb_rotary_enc} -bif_name {BIF_1} -bif_signal_name {PADDR} -core_signal_name {paddr} 
hdl_core_assign_bif_signal -hdl_core_name {apb_rotary_enc} -bif_name {BIF_1} -bif_signal_name {PENABLE} -core_signal_name {penable} 
hdl_core_assign_bif_signal -hdl_core_name {apb_rotary_enc} -bif_name {BIF_1} -bif_signal_name {PWRITE} -core_signal_name {pwrite} 
hdl_core_assign_bif_signal -hdl_core_name {apb_rotary_enc} -bif_name {BIF_1} -bif_signal_name {PRDATA} -core_signal_name {prdata} 
hdl_core_assign_bif_signal -hdl_core_name {apb_rotary_enc} -bif_name {BIF_1} -bif_signal_name {PWDATA} -core_signal_name {pwdata} 
hdl_core_assign_bif_signal -hdl_core_name {apb_rotary_enc} -bif_name {BIF_1} -bif_signal_name {PREADY} -core_signal_name {pready} 
hdl_core_assign_bif_signal -hdl_core_name {apb_rotary_enc} -bif_name {BIF_1} -bif_signal_name {PSLVERR} -core_signal_name {pslverr} 
hdl_core_assign_bif_signal -hdl_core_name {apb_rotary_enc} -bif_name {BIF_1} -bif_signal_name {PSELx} -core_signal_name {psel} 
hdl_core_rename_bif -hdl_core_name {apb_rotary_enc} -current_bif_name {BIF_1} -new_bif_name {APB_TARGET} 

create_hdl_core -file $project_dir/hdl/servos.v -module {servos} -library {work} -package {}

hdl_core_add_bif -hdl_core_name {servos} -bif_definition {APB:AMBA:AMBA2:slave} -bif_name {BIF_1} -signal_map {} 
hdl_core_assign_bif_signal -hdl_core_name {servos} -bif_name {BIF_1} -bif_signal_name {PADDR} -core_signal_name {paddr} 
hdl_core_assign_bif_signal -hdl_core_name {servos} -bif_name {BIF_1} -bif_signal_name {PENABLE} -core_signal_name {penable} 
hdl_core_assign_bif_signal -hdl_core_name {servos} -bif_name {BIF_1} -bif_signal_name {PWRITE} -core_signal_name {pwrite} 
hdl_core_assign_bif_signal -hdl_core_name {servos} -bif_name {BIF_1} -bif_signal_name {PRDATA} -core_signal_name {prdata} 
hdl_core_assign_bif_signal -hdl_core_name {servos} -bif_name {BIF_1} -bif_signal_name {PWDATA} -core_signal_name {pwdata} 
#hdl_core_assign_bif_signal -hdl_core_name {servos} -bif_name {BIF_1} -bif_signal_name {PREADY} -core_signal_name {pready} 
#hdl_core_assign_bif_signal -hdl_core_name {servos} -bif_name {BIF_1} -bif_signal_name {PSLVERR} -core_signal_name {pslverr} 
hdl_core_assign_bif_signal -hdl_core_name {servos} -bif_name {BIF_1} -bif_signal_name {PSELx} -core_signal_name {psel} 
hdl_core_rename_bif -hdl_core_name {servos} -current_bif_name {BIF_1} -new_bif_name {APB_TARGET} 


#-------------------------------------------------------------------------------
# Build cape's submodules
#-------------------------------------------------------------------------------
::safe_source script_support/components/CAPE/shared/APB_BUS_CONVERTER.tcl
::safe_source script_support/components/CAPE/shared/CoreAPB3_CAPE.tcl
::safe_source script_support/components/CAPE/shared/CoreGPIO_P8_UPPER.tcl
::safe_source script_support/components/CAPE/shared/P8_GPIO_UPPER.tcl
::safe_source script_support/components/CAPE/shared/CAPE_DEFAULT_GPIOS.tcl
::safe_source script_support/components/CAPE/shared/CorePWM_C1.tcl
::safe_source script_support/components/CAPE/shared/CAPE_PWM.tcl
::safe_source script_support/components/CAPE/shared/CoreGPIO_P9.tcl
::safe_source script_support/components/CAPE/shared/P9_GPIO.tcl
::safe_source script_support/components/CAPE/$cape_option/CAPE.tcl

# Disable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 0

#-------------------------------------------------------------------------------
# Build the Cape module
#-------------------------------------------------------------------------------
set sd_name ${top_level_name}

#-------------------------------------------------------------------------------
# Cape pins
#-------------------------------------------------------------------------------
sd_create_bus_port -sd_name ${sd_name} -port_name {P8} -port_direction {INOUT} -port_range {[46:3]} -port_is_pad {1}
sd_create_bus_port -sd_name ${sd_name} -port_name {P9} -port_direction {INOUT} -port_range {[20:11]} -port_is_pad {1}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {P9} -pin_slices {[20] [19] [18] [17] [16] [15] [14] [13] [12] [11]}

sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_23} -port_direction {INOUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_25} -port_direction {INOUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_27} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_30} -port_direction {INOUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_41} -port_direction {INOUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_42} -port_direction {IN}

#-------------------------------------------------------------------------------
# Transform the RISCV_SUBSYSTEM
#-------------------------------------------------------------------------------
set sd_name {BVF_RISCV_SUBSYSTEM}

sd_instantiate_macro -sd_name ${sd_name} -macro_name {BIBUF} -instance_name {MMUART_4_RXD_BIBUF}
sd_delete_ports -sd_name ${sd_name} -port_names {MMUART_4_RXD}
sd_connect_pin_to_port -sd_name ${sd_name} -pin_name {MMUART_4_RXD_BIBUF:PAD} -port_name {MMUART_4_RXD}
sd_connect_pins -sd_name ${sd_name} -pin_names {"MMUART_4_RXD_BIBUF:Y" "PF_SOC_MSS:MMUART_4_RXD_F2M"}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {MMUART_4_RXD_BIBUF:E} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {MMUART_4_RXD_BIBUF:D} -value {GND}

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
sd_instantiate_component -sd_name ${sd_name} -component_name {CAPE} -instance_name {CAPE}

sd_instantiate_macro -sd_name ${sd_name} -macro_name {BIBUF} -instance_name {DUMMY_17_BIBUF}
sd_instantiate_macro -sd_name ${sd_name} -macro_name {BIBUF} -instance_name {DUMMY_18_BIBUF}

#-------------------------------------------------------------------------------
# Connections.
#-------------------------------------------------------------------------------

sd_delete_ports -sd_name ${sd_name} -port_names {P9_19}
sd_delete_ports -sd_name ${sd_name} -port_names {P9_20}

# Clocks and resets
sd_connect_pins -sd_name ${sd_name} -pin_names {"CLOCKS_AND_RESETS:FIC_3_PCLK" "CAPE:PCLK"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"CLOCKS_AND_RESETS:FIC_3_FABRIC_RESET_N" "CAPE:PRESETN" }

sd_connect_pins -sd_name ${sd_name} -pin_names {"P9[11]" "BVF_RISCV_SUBSYSTEM:MMUART_4_RXD"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9[12]" "CAPE:P9_PIN12"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9[13]" "CAPE:P9_PIN13"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9[14]" "CAPE:P9_14"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9[15]" "CAPE:P9_PIN15"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9[16]" "CAPE:P9_16"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9[17]" "DUMMY_17_BIBUF:PAD"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9[18]" "DUMMY_18_BIBUF:PAD"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9[19]" "BVF_RISCV_SUBSYSTEM:I2C0_SCL"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9[20]" ""BVF_RISCV_SUBSYSTEM:I2C0_SDA""}

sd_mark_pins_unused -sd_name ${sd_name} -pin_names {BVF_RISCV_SUBSYSTEM:MMUART_4_TXD}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {DUMMY_17_BIBUF:Y}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {DUMMY_18_BIBUF:Y}

sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {DUMMY_17_BIBUF:D} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {DUMMY_17_BIBUF:E} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {DUMMY_18_BIBUF:D} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {DUMMY_18_BIBUF:E} -value {GND}

sd_connect_pins -sd_name ${sd_name} -pin_names {"BVF_RISCV_SUBSYSTEM:GPIO_2_F2M" "CAPE:GPIO_IN"} 
sd_connect_pins -sd_name ${sd_name} -pin_names {"BVF_RISCV_SUBSYSTEM:GPIO_2_M2F" "CAPE:GPIO_OUT"} 
sd_connect_pins -sd_name ${sd_name} -pin_names {"BVF_RISCV_SUBSYSTEM:GPIO_2_OE_M2F" "CAPE:GPIO_OE"} 

sd_connect_pins -sd_name ${sd_name} -pin_names {CAPE:P9_PIN23 P9_23}
sd_connect_pins -sd_name ${sd_name} -pin_names {CAPE:P9_PIN25 P9_25}
sd_connect_pins -sd_name ${sd_name} -pin_names {CAPE:P9_PIN27 P9_27}
sd_connect_pins -sd_name ${sd_name} -pin_names {CAPE:P9_PIN30 P9_30}
sd_connect_pins -sd_name ${sd_name} -pin_names {CAPE:P9_PIN41 P9_41}
sd_connect_pins -sd_name ${sd_name} -pin_names {CAPE:P9_PIN42 P9_42}

sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE:P8" "P8"}

sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE:APB_SLAVE" "BVF_RISCV_SUBSYSTEM:CAPE_APB_MTARGET"}

sd_clear_pin_attributes -sd_name ${sd_name} -pin_names {BVF_RISCV_SUBSYSTEM:MSS_INT_F2M} 
sd_create_pin_slices -sd_name ${sd_name} -pin_name {BVF_RISCV_SUBSYSTEM:MSS_INT_F2M} -pin_slices {[7:3] [31:8] [58:32]}
sd_connect_pins -sd_name ${sd_name} -pin_names {"BVF_RISCV_SUBSYSTEM:MSS_INT_F2M[31:8]" "CAPE:INT"} 
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {BVF_RISCV_SUBSYSTEM:MSS_INT_F2M[7:3]} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {BVF_RISCV_SUBSYSTEM:MSS_INT_F2M[58:32]} -value {GND}

# Re-enable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 1
