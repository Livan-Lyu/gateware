# Creating SmartDesign "CAPE"
set sd_name {CAPE}
create_smartdesign -sd_name ${sd_name}

# Disable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 0

# Create top level Scalar Ports
sd_create_scalar_port -sd_name ${sd_name} -port_name {APB_SLAVE_SLAVE_PENABLE} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {APB_SLAVE_SLAVE_PSEL} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {APB_SLAVE_SLAVE_PWRITE} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {PCLK} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {PRESETN} -port_direction {IN}

sd_create_scalar_port -sd_name ${sd_name} -port_name {APB_SLAVE_SLAVE_PREADY} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {APB_SLAVE_SLAVE_PSLVERR} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_14} -port_direction {INOUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_16} -port_direction {INOUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_PIN42} -port_direction {OUT}

sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_PIN12} -port_direction {INOUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_PIN15} -port_direction {INOUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_PIN23} -port_direction {INOUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_PIN25} -port_direction {INOUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_PIN27} -port_direction {INOUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_PIN30} -port_direction {INOUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_PIN41} -port_direction {INOUT} -port_is_pad {1}

# Create top level Bus Ports
sd_create_bus_port -sd_name ${sd_name} -port_name {P8} -port_direction {INOUT} -port_range {[46:3]}
sd_create_bus_port -sd_name ${sd_name} -port_name {APB_SLAVE_SLAVE_PADDR} -port_direction {IN} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {APB_SLAVE_SLAVE_PWDATA} -port_direction {IN} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {GPIO_OE} -port_direction {IN} -port_range {[27:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {GPIO_OUT} -port_direction {IN} -port_range {[27:0]}

sd_create_bus_port -sd_name ${sd_name} -port_name {APB_SLAVE_SLAVE_PRDATA} -port_direction {OUT} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {GPIO_IN} -port_direction {OUT} -port_range {[27:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {INT} -port_direction {OUT} -port_range {[43:0]}


# Create top level Bus interface Ports
sd_create_bif_port -sd_name ${sd_name} -port_name {APB_SLAVE} -port_bif_vlnv {AMBA:AMBA2:APB:r0p0} -port_bif_role {slave} -port_bif_mapping {\
"PADDR:APB_SLAVE_SLAVE_PADDR" \
"PSELx:APB_SLAVE_SLAVE_PSEL" \
"PENABLE:APB_SLAVE_SLAVE_PENABLE" \
"PWRITE:APB_SLAVE_SLAVE_PWRITE" \
"PRDATA:APB_SLAVE_SLAVE_PRDATA" \
"PWDATA:APB_SLAVE_SLAVE_PWDATA" \
"PREADY:APB_SLAVE_SLAVE_PREADY" \
"PSLVERR:APB_SLAVE_SLAVE_PSLVERR" } 

sd_create_pin_slices -sd_name ${sd_name} -pin_name {P8} -pin_slices {\
[3] [4] [5] [6] [7] [8] [9] [10] [11] [12] [13] [14] [15] [16] [17] [18] [19] [20] [21] [22] [23] [24]\
[25] [26] [27] [28] [29] [30] [31] [32] [33] [34] [35] [36] [37] [38] [39] [40] [41] [42] [43] [44] [45] [46]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {INT} -pin_slices {[15:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {INT} -pin_slices {[36:16]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {INT} -pin_slices {[39:37]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {INT} -pin_slices {[43] [42] [41] [40]}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {INT[39:37]} -value {GND}
# Add APB_BUS_CONVERTER_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {APB_BUS_CONVERTER} -instance_name {APB_BUS_CONVERTER_0}



# Adjust CAPE_DEFAULT_GPIOS smartdesign
sd_create_scalar_port -sd_name {CAPE_DEFAULT_GPIOS} -port_name {GPIO_10_PAD} -port_direction {INOUT} -port_is_pad {1}
sd_create_scalar_port -sd_name {CAPE_DEFAULT_GPIOS} -port_name {GPIO_16_PAD} -port_direction {INOUT} -port_is_pad {1}
sd_instantiate_macro -sd_name {CAPE_DEFAULT_GPIOS} -macro_name {BIBUF} -instance_name {GPIO_10_BIBUF}
sd_instantiate_macro -sd_name {CAPE_DEFAULT_GPIOS} -macro_name {BIBUF} -instance_name {GPIO_16_BIBUF}
sd_clear_pin_attributes -sd_name {CAPE_DEFAULT_GPIOS} -pin_names {GPIO_IN[10]}
sd_clear_pin_attributes -sd_name {CAPE_DEFAULT_GPIOS} -pin_names {GPIO_IN[16]}
sd_connect_pins -sd_name {CAPE_DEFAULT_GPIOS} -pin_names {"GPIO_10_BIBUF:D" "GPIO_OUT[10]"}
sd_connect_pins -sd_name {CAPE_DEFAULT_GPIOS} -pin_names {"GPIO_10_BIBUF:E" "GPIO_OE[10]"}
sd_connect_pins -sd_name {CAPE_DEFAULT_GPIOS} -pin_names {"GPIO_10_BIBUF:Y" "GPIO_IN[10]"}
sd_connect_pins -sd_name {CAPE_DEFAULT_GPIOS} -pin_names {"GPIO_10_BIBUF:PAD" "GPIO_10_PAD"}
sd_connect_pins -sd_name {CAPE_DEFAULT_GPIOS} -pin_names {"GPIO_16_BIBUF:D" "GPIO_OUT[16]"}
sd_connect_pins -sd_name {CAPE_DEFAULT_GPIOS} -pin_names {"GPIO_16_BIBUF:E" "GPIO_OE[16]"}
sd_connect_pins -sd_name {CAPE_DEFAULT_GPIOS} -pin_names {"GPIO_16_BIBUF:Y" "GPIO_IN[16]"}
sd_connect_pins -sd_name {CAPE_DEFAULT_GPIOS} -pin_names {"GPIO_16_BIBUF:PAD" "GPIO_16_PAD"}
save_smartdesign -sd_name {CAPE_DEFAULT_GPIOS}
generate_component -component_name {CAPE_DEFAULT_GPIOS}



# Add CAPE_DEFAULT_GPIOS instance
sd_instantiate_component -sd_name ${sd_name} -component_name {CAPE_DEFAULT_GPIOS} -instance_name {CAPE_DEFAULT_GPIOS}



# Add CoreAPB3_CAPE_0 instance
configure_core -component_name {CoreAPB3_CAPE} -params {"APBSLOT3ENABLE:true" "APBSLOT6ENABLE:true" "APBSLOT7ENABLE:true" }
sd_instantiate_component -sd_name ${sd_name} -component_name {CoreAPB3_CAPE} -instance_name {CoreAPB3_CAPE_0}



# Adjust P8_GPIO_UPPER smartdesign
sd_delete_instances -sd_name {P8_GPIO_UPPER} -instance_names {GPIO_15_BIBUF}
sd_delete_instances -sd_name {P8_GPIO_UPPER} -instance_names {GPIO_14_BIBUF}
sd_delete_instances -sd_name {P8_GPIO_UPPER} -instance_names {GPIO_13_BIBUF}
sd_delete_instances -sd_name {P8_GPIO_UPPER} -instance_names {GPIO_11_BIBUF}
sd_delete_instances -sd_name {P8_GPIO_UPPER} -instance_names {GPIO_10_BIBUF}
sd_delete_instances -sd_name {P8_GPIO_UPPER} -instance_names {GPIO_9_BIBUF}
sd_delete_instances -sd_name {P8_GPIO_UPPER} -instance_names {GPIO_7_BIBUF}
sd_delete_instances -sd_name {P8_GPIO_UPPER} -instance_names {GPIO_6_BIBUF}
sd_delete_instances -sd_name {P8_GPIO_UPPER} -instance_names {GPIO_5_BIBUF}
sd_delete_instances -sd_name {P8_GPIO_UPPER} -instance_names {GPIO_3_BIBUF}
sd_delete_instances -sd_name {P8_GPIO_UPPER} -instance_names {GPIO_2_BIBUF}
sd_delete_instances -sd_name {P8_GPIO_UPPER} -instance_names {GPIO_1_BIBUF}
sd_connect_pins_to_constant -sd_name {P8_GPIO_UPPER} -pin_names {CoreGPIO_P8_UPPER_0:GPIO_IN[15]} -value {GND}
sd_connect_pins_to_constant -sd_name {P8_GPIO_UPPER} -pin_names {CoreGPIO_P8_UPPER_0:GPIO_IN[14]} -value {GND}
sd_connect_pins_to_constant -sd_name {P8_GPIO_UPPER} -pin_names {CoreGPIO_P8_UPPER_0:GPIO_IN[13]} -value {GND}
sd_connect_pins_to_constant -sd_name {P8_GPIO_UPPER} -pin_names {CoreGPIO_P8_UPPER_0:GPIO_IN[11]} -value {GND}
sd_connect_pins_to_constant -sd_name {P8_GPIO_UPPER} -pin_names {CoreGPIO_P8_UPPER_0:GPIO_IN[10]} -value {GND}
sd_connect_pins_to_constant -sd_name {P8_GPIO_UPPER} -pin_names {CoreGPIO_P8_UPPER_0:GPIO_IN[9]} -value {GND}
sd_connect_pins_to_constant -sd_name {P8_GPIO_UPPER} -pin_names {CoreGPIO_P8_UPPER_0:GPIO_IN[7]} -value {GND}
sd_connect_pins_to_constant -sd_name {P8_GPIO_UPPER} -pin_names {CoreGPIO_P8_UPPER_0:GPIO_IN[6]} -value {GND}
sd_connect_pins_to_constant -sd_name {P8_GPIO_UPPER} -pin_names {CoreGPIO_P8_UPPER_0:GPIO_IN[5]} -value {GND}
sd_connect_pins_to_constant -sd_name {P8_GPIO_UPPER} -pin_names {CoreGPIO_P8_UPPER_0:GPIO_IN[3]} -value {GND}
sd_connect_pins_to_constant -sd_name {P8_GPIO_UPPER} -pin_names {CoreGPIO_P8_UPPER_0:GPIO_IN[2]} -value {GND}
sd_connect_pins_to_constant -sd_name {P8_GPIO_UPPER} -pin_names {CoreGPIO_P8_UPPER_0:GPIO_IN[1]} -value {GND}
save_smartdesign -sd_name {P8_GPIO_UPPER}
generate_component -component_name {P8_GPIO_UPPER}



# Add P8_GPIO_UPPER_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {P8_GPIO_UPPER} -instance_name {P8_GPIO_UPPER_0}



# Add P9_GPIO_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {P9_GPIO} -instance_name {P9_GPIO_0}



# Add PWM_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {CAPE_PWM} -instance_name {PWM_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {PWM_0:PWM_1}



# Add SPI_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {CoreSPI_C0} -instance_name {CoreSPI_C0_0}
# Add SPI_1 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {CoreSPI_C0} -instance_name {CoreSPI_C0_1}
# Add SPI_2 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {CoreSPI_C0} -instance_name {CoreSPI_C0_2}
# Add SPI_3 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {CoreSPI_C0} -instance_name {CoreSPI_C0_3}



# Add PWM_1 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {CAPE_PWM} -instance_name {PWM_1}



# Add scalar net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE_DEFAULT_GPIOS:GPIO_0_PAD" "P8[3]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE_DEFAULT_GPIOS:GPIO_10_PAD" "P8[13]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE_DEFAULT_GPIOS:GPIO_11_PAD" "P8[14]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE_DEFAULT_GPIOS:GPIO_12_PAD" "P8[15]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE_DEFAULT_GPIOS:GPIO_13_PAD" "P8[16]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE_DEFAULT_GPIOS:GPIO_14_PAD" "P8[17]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE_DEFAULT_GPIOS:GPIO_15_PAD" "P8[18]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE_DEFAULT_GPIOS:GPIO_16_PAD" "P8[19]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE_DEFAULT_GPIOS:GPIO_17_PAD" "P8[20]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE_DEFAULT_GPIOS:GPIO_18_PAD" "P8[21]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE_DEFAULT_GPIOS:GPIO_19_PAD" "P8[22]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE_DEFAULT_GPIOS:GPIO_1_PAD" "P8[4]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE_DEFAULT_GPIOS:GPIO_20_PAD" "P8[23]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE_DEFAULT_GPIOS:GPIO_21_PAD" "P8[24]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE_DEFAULT_GPIOS:GPIO_22_PAD" "P8[25]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE_DEFAULT_GPIOS:GPIO_23_PAD" "P8[26]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE_DEFAULT_GPIOS:GPIO_24_PAD" "P8[27]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE_DEFAULT_GPIOS:GPIO_25_PAD" "P8[28]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE_DEFAULT_GPIOS:GPIO_26_PAD" "P8[29]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE_DEFAULT_GPIOS:GPIO_27_PAD" "P8[30]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE_DEFAULT_GPIOS:GPIO_2_PAD" "P8[5]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE_DEFAULT_GPIOS:GPIO_3_PAD" "P8[6]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE_DEFAULT_GPIOS:GPIO_4_PAD" "P8[7]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE_DEFAULT_GPIOS:GPIO_5_PAD" "P8[8]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE_DEFAULT_GPIOS:GPIO_6_PAD" "P8[9]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE_DEFAULT_GPIOS:GPIO_7_PAD" "P8[10]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE_DEFAULT_GPIOS:GPIO_8_PAD" "P8[11]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE_DEFAULT_GPIOS:GPIO_9_PAD" "P8[12]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P8_GPIO_UPPER_0:GPIO_0_PAD" "P8[31]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P8_GPIO_UPPER_0:GPIO_12_PAD" "P8[43]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P8_GPIO_UPPER_0:GPIO_4_PAD" "P8[35]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P8_GPIO_UPPER_0:GPIO_8_PAD" "P8[39]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PCLK" \
"P8_GPIO_UPPER_0:PCLK" "P9_GPIO_0:PCLK" "PWM_0:PCLK" "PWM_1:PCLK" \
"CoreSPI_C0_0:PCLK" "CoreSPI_C0_1:PCLK" "CoreSPI_C0_2:PCLK" "CoreSPI_C0_3:PCLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PRESETN" \
"P8_GPIO_UPPER_0:PRESETN" "P9_GPIO_0:PRESETN" "PWM_0:PRESETN" "PWM_1:PRESETN" \
"CoreSPI_C0_0:PRESETN" "CoreSPI_C0_1:PRESETN" "CoreSPI_C0_2:PRESETN" "CoreSPI_C0_3:PRESETN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9_GPIO_0:GPIO_10_PAD" "P9_PIN23" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9_GPIO_0:GPIO_12_PAD" "P9_PIN25" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9_GPIO_0:GPIO_14_PAD" "P9_PIN27" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9_GPIO_0:GPIO_17_PAD" "P9_PIN30" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9_GPIO_0:GPIO_19_PAD" "P9_PIN41" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9_GPIO_0:GPIO_1_PAD" "P9_PIN12" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9_GPIO_0:GPIO_4_PAD" "P9_PIN15" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9_PIN42" "PWM_0:PWM_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"INT[40]" "CoreSPI_C0_0:SPIINT"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"INT[41]" "CoreSPI_C0_1:SPIINT"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"INT[42]" "CoreSPI_C0_2:SPIINT"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"INT[43]" "CoreSPI_C0_3:SPIINT"}

# Add bus net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE_DEFAULT_GPIOS:GPIO_IN" "GPIO_IN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE_DEFAULT_GPIOS:GPIO_OE" "GPIO_OE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE_DEFAULT_GPIOS:GPIO_OUT" "GPIO_OUT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"INT[15:0]" "P8_GPIO_UPPER_0:INT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"INT[36:16]" "P9_GPIO_0:INT" }

# Add bus interface net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"APB_BUS_CONVERTER_0:APB_MASTER" "CoreAPB3_CAPE_0:APB3mmaster" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"APB_BUS_CONVERTER_0:APB_SLAVE" "APB_SLAVE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CoreAPB3_CAPE_0:APBmslave0" "PWM_0:APBslave" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CoreAPB3_CAPE_0:APBmslave1" "P8_GPIO_UPPER_0:APB_bif" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CoreAPB3_CAPE_0:APBmslave2" "P9_GPIO_0:APB_bif" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CoreAPB3_CAPE_0:APBmslave3" "CoreSPI_C0_0:APB_bif" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CoreAPB3_CAPE_0:APBmslave4" "PWM_1:APBslave" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CoreAPB3_CAPE_0:APBmslave5" "CoreSPI_C0_1:APB_bif" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CoreAPB3_CAPE_0:APBmslave6" "CoreSPI_C0_2:APB_bif" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CoreAPB3_CAPE_0:APBmslave7" "CoreSPI_C0_3:APB_bif" }

# Add GPIO BIBUFs
sd_instantiate_macro -sd_name ${sd_name} -macro_name {BIBUF} -instance_name {P9_14_BIBUF}
sd_instantiate_macro -sd_name ${sd_name} -macro_name {BIBUF} -instance_name {P9_16_BIBUF}

sd_connect_pins -sd_name ${sd_name} -pin_names {"P9_14_BIBUF:PAD" "P9_14"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9_14_BIBUF:D" "PWM_1:PWM_0"}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {P9_14_BIBUF:Y}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {P9_14_BIBUF:E} -value {VCC}

sd_connect_pins -sd_name ${sd_name} -pin_names {"P9_16_BIBUF:PAD" "P9_16"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9_16_BIBUF:D" "PWM_1:PWM_1"}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {P9_16_BIBUF:Y}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {P9_16_BIBUF:E} -value {VCC}

sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CoreSPI_C0_0:SPICLKI} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CoreSPI_C0_0:SPISSI} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CoreSPI_C0_1:SPICLKI} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CoreSPI_C0_1:SPISSI} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CoreSPI_C0_2:SPICLKI} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CoreSPI_C0_2:SPISSI} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CoreSPI_C0_3:SPICLKI} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CoreSPI_C0_3:SPISSI} -value {GND}

# Add SPI BIBUFs
sd_instantiate_macro -sd_name ${sd_name} -macro_name {BIBUF} -instance_name {SPI0_C_BIBUF}
sd_instantiate_macro -sd_name ${sd_name} -macro_name {BIBUF} -instance_name {SPI0_I_BIBUF}
sd_instantiate_macro -sd_name ${sd_name} -macro_name {BIBUF} -instance_name {SPI0_O_BIBUF}
sd_instantiate_macro -sd_name ${sd_name} -macro_name {BIBUF} -instance_name {SPI1_C_BIBUF}
sd_instantiate_macro -sd_name ${sd_name} -macro_name {BIBUF} -instance_name {SPI1_I_BIBUF}
sd_instantiate_macro -sd_name ${sd_name} -macro_name {BIBUF} -instance_name {SPI1_O_BIBUF}
sd_instantiate_macro -sd_name ${sd_name} -macro_name {BIBUF} -instance_name {SPI2_C_BIBUF}
sd_instantiate_macro -sd_name ${sd_name} -macro_name {BIBUF} -instance_name {SPI2_I_BIBUF}
sd_instantiate_macro -sd_name ${sd_name} -macro_name {BIBUF} -instance_name {SPI2_O_BIBUF}
sd_instantiate_macro -sd_name ${sd_name} -macro_name {BIBUF} -instance_name {SPI3_C_BIBUF}
sd_instantiate_macro -sd_name ${sd_name} -macro_name {BIBUF} -instance_name {SPI3_I_BIBUF}
sd_instantiate_macro -sd_name ${sd_name} -macro_name {BIBUF} -instance_name {SPI3_O_BIBUF}

sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI0_C_BIBUF:D" "CoreSPI_C0_0:SPISCLKO"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI0_C_BIBUF:E" "CoreSPI_C0_0:SPIOEN"}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SPI0_C_BIBUF:Y}
sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI0_C_BIBUF:PAD" "P8[32]"}

sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI0_I_BIBUF:Y" "CoreSPI_C0_0:SPISDI"}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SPI0_I_BIBUF:D} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SPI0_I_BIBUF:E} -value {GND}
sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI0_I_BIBUF:PAD" "P8[34]"}

sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI0_O_BIBUF:D" "CoreSPI_C0_0:SPISDO"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI0_O_BIBUF:E" "CoreSPI_C0_0:SPIOEN"}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SPI0_O_BIBUF:Y}
sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI0_O_BIBUF:PAD" "P8[33]"}

sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI1_C_BIBUF:D" "CoreSPI_C0_1:SPISCLKO"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI1_C_BIBUF:E" "CoreSPI_C0_1:SPIOEN"}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SPI1_C_BIBUF:Y}
sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI1_C_BIBUF:PAD" "P8[36]"}

sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI1_I_BIBUF:Y" "CoreSPI_C0_1:SPISDI"}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SPI1_I_BIBUF:D} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SPI1_I_BIBUF:E} -value {GND}
sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI1_I_BIBUF:PAD" "P8[38]"}

sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI1_O_BIBUF:D" "CoreSPI_C0_1:SPISDO"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI1_O_BIBUF:E" "CoreSPI_C0_1:SPIOEN"}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SPI1_O_BIBUF:Y}
sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI1_O_BIBUF:PAD" "P8[37]"}

sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI2_C_BIBUF:D" "CoreSPI_C0_2:SPISCLKO"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI2_C_BIBUF:E" "CoreSPI_C0_2:SPIOEN"}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SPI2_C_BIBUF:Y}
sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI2_C_BIBUF:PAD" "P8[40]"}

sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI2_I_BIBUF:Y" "CoreSPI_C0_2:SPISDI"}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SPI2_I_BIBUF:D} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SPI2_I_BIBUF:E} -value {GND}
sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI2_I_BIBUF:PAD" "P8[42]"}

sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI2_O_BIBUF:D" "CoreSPI_C0_2:SPISDO"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI2_O_BIBUF:E" "CoreSPI_C0_2:SPIOEN"}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SPI2_O_BIBUF:Y}
sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI2_O_BIBUF:PAD" "P8[41]"}

sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI3_C_BIBUF:D" "CoreSPI_C0_3:SPISCLKO"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI3_C_BIBUF:E" "CoreSPI_C0_3:SPIOEN"}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SPI3_C_BIBUF:Y}
sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI3_C_BIBUF:PAD" "P8[44]" }

sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI3_I_BIBUF:Y" "CoreSPI_C0_3:SPISDI"}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SPI3_I_BIBUF:D} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {SPI3_I_BIBUF:E} -value {GND}
sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI3_I_BIBUF:PAD" "P8[46]"}

sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI3_O_BIBUF:D" "CoreSPI_C0_3:SPISDO"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI3_O_BIBUF:E" "CoreSPI_C0_3:SPIOEN"}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {SPI3_O_BIBUF:Y}
sd_connect_pins -sd_name ${sd_name} -pin_names {"SPI3_O_BIBUF:PAD" "P8[45]" }

sd_mark_pins_unused -sd_name ${sd_name} -pin_names {CoreSPI_C0_0:SPIRXAVAIL}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {CoreSPI_C0_1:SPIRXAVAIL}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {CoreSPI_C0_2:SPIRXAVAIL}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {CoreSPI_C0_3:SPIRXAVAIL}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {CoreSPI_C0_0:SPITXRFM}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {CoreSPI_C0_1:SPITXRFM}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {CoreSPI_C0_2:SPITXRFM}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {CoreSPI_C0_3:SPITXRFM}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {CoreSPI_C0_0:SPISS}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {CoreSPI_C0_1:SPISS}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {CoreSPI_C0_2:SPISS}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {CoreSPI_C0_3:SPISS}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {CoreSPI_C0_0:SPIMODE}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {CoreSPI_C0_1:SPIMODE}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {CoreSPI_C0_2:SPIMODE}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {CoreSPI_C0_3:SPIMODE}

# Re-enable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 1
# Save the SmartDesign 
save_smartdesign -sd_name ${sd_name}
# Generate SmartDesign "CAPE"
generate_component -component_name ${sd_name}
