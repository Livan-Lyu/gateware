puts "======== Add cape option: 4_UARTS ========"

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
sd_create_bus_port -sd_name ${sd_name} -port_name {P9} -port_direction {INOUT} -port_range {[31:11]} -port_is_pad {1}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {P9} -pin_slices {\
[31] [30] [29] [28] [27] [26] [25] [24] [23] [22] [21] [20] [19] [18] [17] [16] [15] [14] [13] [12] [11]}

sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_41} -port_direction {INOUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_42} -port_direction {OUT}

#sd_clear_pin_attributes -sd_name ${sd_name} -pin_names {BVF_RISCV_SUBSYSTEM:SPI_0_CLK} 
#sd_clear_pin_attributes -sd_name ${sd_name} -pin_names {BVF_RISCV_SUBSYSTEM:SPI_0_DI} 
sd_clear_pin_attributes -sd_name ${sd_name} -pin_names {BVF_RISCV_SUBSYSTEM:SPI_0_DO}
sd_clear_pin_attributes -sd_name ${sd_name} -pin_names {BVF_RISCV_SUBSYSTEM:SPI_0_SS1}

sd_clear_pin_attributes -sd_name ${sd_name} -pin_names {BVF_RISCV_SUBSYSTEM:MMUART_2_TXD}
sd_clear_pin_attributes -sd_name ${sd_name} -pin_names {BVF_RISCV_SUBSYSTEM:MMUART_3_TXD}

sd_clear_pin_attributes -sd_name ${sd_name} -pin_names {BVF_RISCV_SUBSYSTEM:SPI_1_SS1}
sd_clear_pin_attributes -sd_name ${sd_name} -pin_names {BVF_RISCV_SUBSYSTEM:SPI_1_CLK}

#-------------------------------------------------------------------------------
# Transform the RISCV_SUBSYSTEM
#-------------------------------------------------------------------------------
set sd_name {BVF_RISCV_SUBSYSTEM}

sd_instantiate_macro -sd_name ${sd_name} -macro_name {BIBUF} -instance_name {MMUART_2_TXD_BIBUF}
sd_delete_ports -sd_name ${sd_name} -port_names {MMUART_2_TXD}
sd_connect_pin_to_port -sd_name ${sd_name} -pin_name {MMUART_2_TXD_BIBUF:PAD} -port_name {MMUART_2_TXD}
sd_connect_pins -sd_name ${sd_name} -pin_names {"MMUART_2_TXD_BIBUF:D" "PF_SOC_MSS:MMUART_2_TXD_M2F"}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {MMUART_2_TXD_BIBUF:Y}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {MMUART_2_TXD_BIBUF:E} -value {VCC}

sd_instantiate_macro -sd_name ${sd_name} -macro_name {BIBUF} -instance_name {MMUART_2_RXD_BIBUF}
sd_delete_ports -sd_name ${sd_name} -port_names {MMUART_2_RXD}
sd_connect_pin_to_port -sd_name ${sd_name} -pin_name {MMUART_2_RXD_BIBUF:PAD} -port_name {MMUART_2_RXD}
sd_connect_pins -sd_name ${sd_name} -pin_names {"MMUART_2_RXD_BIBUF:Y" "PF_SOC_MSS:MMUART_2_RXD_F2M"}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {MMUART_2_RXD_BIBUF:E} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {MMUART_2_RXD_BIBUF:D} -value {GND}

sd_instantiate_macro -sd_name ${sd_name} -macro_name {BIBUF} -instance_name {MMUART_3_TXD_BIBUF}
sd_delete_ports -sd_name ${sd_name} -port_names {MMUART_3_TXD}
sd_connect_pin_to_port -sd_name ${sd_name} -pin_name {MMUART_3_TXD_BIBUF:PAD} -port_name {MMUART_3_TXD}
sd_connect_pins -sd_name ${sd_name} -pin_names {"MMUART_3_TXD_BIBUF:D" "PF_SOC_MSS:MMUART_3_TXD_M2F"}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {MMUART_3_TXD_BIBUF:Y}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {MMUART_3_TXD_BIBUF:E} -value {VCC}

sd_instantiate_macro -sd_name ${sd_name} -macro_name {BIBUF} -instance_name {MMUART_3_RXD_BIBUF}
sd_delete_ports -sd_name ${sd_name} -port_names {MMUART_3_RXD}
sd_connect_pin_to_port -sd_name ${sd_name} -pin_name {MMUART_3_RXD_BIBUF:PAD} -port_name {MMUART_3_RXD}
sd_connect_pins -sd_name ${sd_name} -pin_names {"MMUART_3_RXD_BIBUF:Y" "PF_SOC_MSS:MMUART_3_RXD_F2M"}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {MMUART_3_RXD_BIBUF:E} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {MMUART_3_RXD_BIBUF:D} -value {GND}

sd_instantiate_macro -sd_name ${sd_name} -macro_name {BIBUF} -instance_name {MMUART_4_TXD_BIBUF}
sd_delete_ports -sd_name ${sd_name} -port_names {MMUART_4_TXD}
sd_connect_pin_to_port -sd_name ${sd_name} -pin_name {MMUART_4_TXD_BIBUF:PAD} -port_name {MMUART_4_TXD}
sd_connect_pins -sd_name ${sd_name} -pin_names {"MMUART_4_TXD_BIBUF:D" "PF_SOC_MSS:MMUART_4_TXD_M2F"}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {MMUART_4_TXD_BIBUF:Y}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {MMUART_4_TXD_BIBUF:E} -value {VCC}

sd_instantiate_macro -sd_name ${sd_name} -macro_name {BIBUF} -instance_name {MMUART_4_RXD_BIBUF}
sd_delete_ports -sd_name ${sd_name} -port_names {MMUART_4_RXD}
sd_connect_pin_to_port -sd_name ${sd_name} -pin_name {MMUART_4_RXD_BIBUF:PAD} -port_name {MMUART_4_RXD}
sd_connect_pins -sd_name ${sd_name} -pin_names {"MMUART_4_RXD_BIBUF:Y" "PF_SOC_MSS:MMUART_4_RXD_F2M"}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {MMUART_4_RXD_BIBUF:E} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {MMUART_4_RXD_BIBUF:D} -value {GND}

# Add SPI_0_DO_BIBUF instance
sd_delete_ports -sd_name ${sd_name} -port_names {SPI_0_DO}
sd_instantiate_macro -sd_name ${sd_name} -macro_name {BIBUF} -instance_name {SPI_0_DO_BIBUF}
sd_connect_pins -sd_name ${sd_name} -pin_names {PF_SOC_MSS:SPI_0_DO_OE_M2F SPI_0_DO_BIBUF:E}
sd_connect_pins -sd_name ${sd_name} -pin_names {PF_SOC_MSS:SPI_0_DO_M2F SPI_0_DO_BIBUF:D}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SPI_0_DO_BIBUF:Y}
sd_connect_pin_to_port -sd_name ${sd_name} -pin_name {SPI_0_DO_BIBUF:PAD} -port_name {SPI_0_DO} 

# Add SPI_0_SS1_BIBUF instance
sd_delete_ports -sd_name ${sd_name} -port_names {SPI_0_SS1}
sd_instantiate_macro -sd_name ${sd_name} -macro_name {BIBUF} -instance_name {SPI_0_SS1_BIBUF}
sd_connect_pins -sd_name ${sd_name} -pin_names {PF_SOC_MSS:SPI_0_SS1_OE_M2F SPI_0_SS1_BIBUF:E}
sd_connect_pins -sd_name ${sd_name} -pin_names {PF_SOC_MSS:SPI_0_SS_F2M SPI_0_SS1_BIBUF:Y}
sd_connect_pins -sd_name ${sd_name} -pin_names {PF_SOC_MSS:SPI_0_SS1_M2F SPI_0_SS1_BIBUF:D}
sd_connect_pin_to_port -sd_name ${sd_name} -pin_name {SPI_0_SS1_BIBUF:PAD} -port_name {SPI_0_SS1} 

adapter::remove_pin "SPI_1_DO"

save_smartdesign -sd_name ${sd_name}
sd_update_instance -sd_name ${top_level_name} -instance_name ${sd_name}
generate_component -component_name ${sd_name}

#-------------------------------------------------------------------------------
# Instantiate.
#-------------------------------------------------------------------------------
set sd_name ${top_level_name}
sd_instantiate_component -sd_name ${sd_name} -component_name {CAPE} -instance_name {CAPE}

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

sd_connect_pins -sd_name ${sd_name} -pin_names {"P9[11]" "BVF_RISCV_SUBSYSTEM:MMUART_4_RXD"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9[12]" "CAPE:P9_PIN12"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9[13]" "BVF_RISCV_SUBSYSTEM:MMUART_4_TXD"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9[14]" "CAPE:P9_14"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9[15]" "CAPE:P9_PIN15"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9[16]" "CAPE:P9_16"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9[17]" "BVF_RISCV_SUBSYSTEM:SPI_0_SS1"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9[18]" "BVF_RISCV_SUBSYSTEM:SPI_0_DO"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9[19]" "BVF_RISCV_SUBSYSTEM:I2C0_SCL"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9[20]" "BVF_RISCV_SUBSYSTEM:I2C0_SDA"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9[21]" "BVF_RISCV_SUBSYSTEM:MMUART_3_TXD"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9[22]" "BVF_RISCV_SUBSYSTEM:MMUART_3_RXD"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9[23]" "CAPE:P9_PIN23"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9[24]" "BVF_RISCV_SUBSYSTEM:MMUART_2_TXD"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9[25]" "CAPE:P9_PIN25"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9[26]" "BVF_RISCV_SUBSYSTEM:MMUART_2_RXD"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9[27]" "CAPE:P9_PIN27"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9[28]" "BVF_RISCV_SUBSYSTEM:SPI_1_SS1"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9[29]" "BVF_RISCV_SUBSYSTEM:SPI_1_DI"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9[30]" "CAPE:P9_PIN30"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9[31]" "BVF_RISCV_SUBSYSTEM:SPI_1_CLK"}

sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE:P9_PIN41" "P9_41"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE:P9_PIN42" "P9_42"}

sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE:P8" "P8"}

sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE:APB_SLAVE" "BVF_RISCV_SUBSYSTEM:CAPE_APB_MTARGET"}

sd_clear_pin_attributes -sd_name ${sd_name} -pin_names {BVF_RISCV_SUBSYSTEM:MSS_INT_F2M} 
sd_create_pin_slices -sd_name ${sd_name} -pin_name {BVF_RISCV_SUBSYSTEM:MSS_INT_F2M} -pin_slices {[7:3] [47:8] [58:48]}
sd_connect_pins -sd_name ${sd_name} -pin_names {"BVF_RISCV_SUBSYSTEM:MSS_INT_F2M[47:8]" "CAPE:INT"} 
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {BVF_RISCV_SUBSYSTEM:MSS_INT_F2M[7:3]} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {BVF_RISCV_SUBSYSTEM:MSS_INT_F2M[58:48]} -value {GND}

sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {BVF_RISCV_SUBSYSTEM:M2_UART_CTS} -value {VCC} 
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {BVF_RISCV_SUBSYSTEM:M2_UART_RTS} 
sd_clear_pin_attributes -sd_name ${sd_name} -pin_names {BVF_RISCV_SUBSYSTEM:M2_UART_RXD} 
sd_clear_pin_attributes -sd_name ${sd_name} -pin_names {BVF_RISCV_SUBSYSTEM:M2_UART_TXD} 
sd_connect_pins -sd_name ${sd_name} -pin_names {"BVF_RISCV_SUBSYSTEM:M2_UART_RXD" "CAPE:M2_UART_RXD"} 
sd_connect_pins -sd_name ${sd_name} -pin_names {"BVF_RISCV_SUBSYSTEM:M2_UART_TXD" "CAPE:M2_UART_TXD"} 

# Re-enable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 1
