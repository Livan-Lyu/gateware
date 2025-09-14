puts "======== Add cape option: COMMS_CAPE ========"

#-------------------------------------------------------------------------------
# Build cape's submodules
#-------------------------------------------------------------------------------
::safe_source script_support/components/CAPE/shared/APB_BUS_CONVERTER.tcl
::safe_source script_support/components/CAPE/shared/CoreAPB3_CAPE.tcl
::safe_source script_support/components/CAPE/shared/CoreGPIO_P8_UPPER.tcl
::safe_source script_support/components/CAPE/shared/P8_GPIO_UPPER.tcl
::safe_source script_support/components/CAPE/shared/CoreGPIO_P9.tcl
::safe_source script_support/components/CAPE/shared/P9_GPIO.tcl
::safe_source script_support/components/CAPE/shared/CAPE_DEFAULT_GPIOS.tcl
::safe_source script_support/components/CAPE/shared/CorePWM_C1.tcl
::safe_source script_support/components/CAPE/shared/CAPE_PWM.tcl
::safe_source script_support/components/CAPE/$cape_option/CAPE.tcl

#-------------------------------------------------------------------------------
# Build the Cape module
#-------------------------------------------------------------------------------
set sd_name ${top_level_name}

#-------------------------------------------------------------------------------
# Cape pins
#-------------------------------------------------------------------------------
sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_11} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_13} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_PIN14} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_PIN16} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_PIN42} -port_direction {OUT}

sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_29} -port_direction {IN} 

#-------------------------------------------------------------------------------
# Instantiate.
#-------------------------------------------------------------------------------

sd_instantiate_component -sd_name ${sd_name} -component_name {CAPE} -instance_name {CAPE}

#-------------------------------------------------------------------------------
# Connections.
#-------------------------------------------------------------------------------

# Clocks and resets
sd_connect_pins -sd_name ${sd_name} -pin_names {"CLOCKS_AND_RESETS:FIC_3_PCLK" "CAPE:PCLK"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"CLOCKS_AND_RESETS:FIC_3_FABRIC_RESET_N" "CAPE:PRESETN" }

sd_connect_pins -sd_name ${sd_name} -pin_names {"BVF_RISCV_SUBSYSTEM:MMUART_4_TXD" "P9_13"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"BVF_RISCV_SUBSYSTEM:MMUART_4_RXD" "P9_11"}

sd_connect_pins -sd_name ${sd_name} -pin_names {"BVF_RISCV_SUBSYSTEM:GPIO_2_F2M" "CAPE:GPIO_IN"} 
sd_connect_pins -sd_name ${sd_name} -pin_names {"BVF_RISCV_SUBSYSTEM:GPIO_2_M2F" "CAPE:GPIO_OUT"} 
sd_connect_pins -sd_name ${sd_name} -pin_names {"BVF_RISCV_SUBSYSTEM:GPIO_2_OE_M2F" "CAPE:GPIO_OE"} 

sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE:P9_PIN14" "P9_PIN14"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE:P9_PIN16" "P9_PIN16"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE:P9_PIN42" "P9_PIN42"}

sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE:APB_SLAVE" "BVF_RISCV_SUBSYSTEM:CAPE_APB_MTARGET"}

sd_clear_pin_attributes -sd_name ${sd_name} -pin_names {BVF_RISCV_SUBSYSTEM:MSS_INT_F2M} 
sd_create_pin_slices -sd_name ${sd_name} -pin_name {BVF_RISCV_SUBSYSTEM:MSS_INT_F2M} -pin_slices {[7:3] [47:8] [58:48]}
sd_connect_pins -sd_name ${sd_name} -pin_names {"BVF_RISCV_SUBSYSTEM:MSS_INT_F2M[47:8]" "CAPE:INT"} 
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {BVF_RISCV_SUBSYSTEM:MSS_INT_F2M[7:3]} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {BVF_RISCV_SUBSYSTEM:MSS_INT_F2M[58:48]} -value {GND}

sd_clear_pin_attributes -sd_name ${sd_name} -pin_names {BVF_RISCV_SUBSYSTEM:MMUART_2_TXD} 
sd_connect_pin_to_port -sd_name ${sd_name} -pin_name {BVF_RISCV_SUBSYSTEM:MMUART_2_TXD} -port_name {} 
sd_rename_port -sd_name ${sd_name} -current_port_name {MMUART_2_TXD} -new_port_name {P9_24} 
sd_clear_pin_attributes -sd_name ${sd_name} -pin_names {BVF_RISCV_SUBSYSTEM:MMUART_2_RXD} 
sd_connect_pin_to_port -sd_name ${sd_name} -pin_name {BVF_RISCV_SUBSYSTEM:MMUART_2_RXD} -port_name {} 
sd_rename_port -sd_name ${sd_name} -current_port_name {MMUART_2_RXD} -new_port_name {P9_26} 

sd_clear_pin_attributes -sd_name ${sd_name} -pin_names {BVF_RISCV_SUBSYSTEM:SPI_0_CLK} 
sd_clear_pin_attributes -sd_name ${sd_name} -pin_names {BVF_RISCV_SUBSYSTEM:SPI_0_DO} 
sd_clear_pin_attributes -sd_name ${sd_name} -pin_names {BVF_RISCV_SUBSYSTEM:SPI_0_SS1} 
sd_clear_pin_attributes -sd_name ${sd_name} -pin_names {BVF_RISCV_SUBSYSTEM:SPI_0_DI} 
sd_connect_pin_to_port -sd_name ${sd_name} -pin_name {BVF_RISCV_SUBSYSTEM:SPI_0_DI} -port_name {} 
sd_connect_pin_to_port -sd_name ${sd_name} -pin_name {BVF_RISCV_SUBSYSTEM:SPI_0_SS1} -port_name {} 
sd_connect_pin_to_port -sd_name ${sd_name} -pin_name {BVF_RISCV_SUBSYSTEM:SPI_0_CLK} -port_name {} 
sd_connect_pin_to_port -sd_name ${sd_name} -pin_name {BVF_RISCV_SUBSYSTEM:SPI_0_DO} -port_name {} 
sd_rename_port -sd_name ${sd_name} -current_port_name {SPI_0_DI} -new_port_name {P9_21} 
sd_rename_port -sd_name ${sd_name} -current_port_name {SPI_0_CLK} -new_port_name {P9_22} 
sd_rename_port -sd_name ${sd_name} -current_port_name {SPI_0_DO} -new_port_name {P9_18} 
sd_rename_port -sd_name ${sd_name} -current_port_name {SPI_0_SS1} -new_port_name {P9_17} 

sd_clear_pin_attributes -sd_name ${sd_name} -pin_names {BVF_RISCV_SUBSYSTEM:SPI_1_SS1} 
sd_clear_pin_attributes -sd_name ${sd_name} -pin_names {BVF_RISCV_SUBSYSTEM:SPI_1_CLK} 
sd_connect_pin_to_port -sd_name ${sd_name} -pin_name {BVF_RISCV_SUBSYSTEM:SPI_1_SS1} -port_name {} 
sd_connect_pin_to_port -sd_name ${sd_name} -pin_name {BVF_RISCV_SUBSYSTEM:SPI_1_CLK} -port_name {} 
sd_rename_port -sd_name ${sd_name} -current_port_name {SPI_1_SS1} -new_port_name {P9_28} 
sd_rename_port -sd_name ${sd_name} -current_port_name {SPI_1_CLK} -new_port_name {P9_31} 

sd_connect_pins -sd_name ${sd_name} -pin_names {"BVF_RISCV_SUBSYSTEM:SPI_1_DI" "P9_29"}

#-------------------------------------------------------------------------------
# RS485 pins
#-------------------------------------------------------------------------------
sd_disconnect_pins -sd_name ${sd_name} -pin_names {"BVF_RISCV_SUBSYSTEM:MMUART_2_TXD" "BVF_RISCV_SUBSYSTEM:MMUART_2_RXD" }
sd_delete_ports -sd_name ${sd_name} -port_names {P9_24}
sd_delete_ports -sd_name ${sd_name} -port_names {P9_26}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {BVF_RISCV_SUBSYSTEM:MMUART_2_RXD} -value {GND} 
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {BVF_RISCV_SUBSYSTEM:MMUART_2_TXD} 

#-------------------------------------------------------------------------------
# CAN pins
#-------------------------------------------------------------------------------

sd_clear_pin_attributes -sd_name ${sd_name} -pin_names {BVF_RISCV_SUBSYSTEM:CAN_1_RXBUS}
sd_clear_pin_attributes -sd_name ${sd_name} -pin_names {BVF_RISCV_SUBSYSTEM:CAN_1_TXBUS}
sd_connect_pin_to_port -sd_name ${sd_name} -pin_name {BVF_RISCV_SUBSYSTEM:CAN_1_RXBUS} -port_name {}
sd_connect_pin_to_port -sd_name ${sd_name} -pin_name {BVF_RISCV_SUBSYSTEM:CAN_1_TXBUS} -port_name {}
sd_rename_port -sd_name ${sd_name} -current_port_name {CAN_1_RXBUS} -new_port_name {P9_24}
sd_rename_port -sd_name ${sd_name} -current_port_name {CAN_1_TXBUS} -new_port_name {P9_26}
sd_clear_pin_attributes -sd_name ${sd_name} -pin_names {BVF_RISCV_SUBSYSTEM:CAN_1_TX_EBL}
sd_connect_pin_to_port -sd_name ${sd_name} -pin_name {BVF_RISCV_SUBSYSTEM:CAN_1_TX_EBL} -port_name {}
sd_rename_port -sd_name ${sd_name} -current_port_name {CAN_1_TX_EBL} -new_port_name {P9_25}