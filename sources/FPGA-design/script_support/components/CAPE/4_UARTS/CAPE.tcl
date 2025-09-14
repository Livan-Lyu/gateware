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
sd_create_bus_port -sd_name ${sd_name} -port_name {INT} -port_direction {OUT} -port_range {[39:0]}


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
[3:3] [4:4] [5:5] [6:6] [7:7] [8:8] [9:9] [10:10] [11:11] [12:12] [13:13] [14:14]\
[15:15] [16:16] [17:17] [18:18] [19:19] [20:20] [21:21] [22:22] [23:23] [24:24]\
[25:25] [26:26] [27:27] [28:28] [29:29] [30:30] [31:31] [32:32] [33:33] [34:34]\
[35:35] [36:36] [37:37] [38:38] [39:39] [40:40] [41:41] [42:42] [43:43] [44:44] [45:45] [46:46]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {INT} -pin_slices {[15:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {INT} -pin_slices {[36:16]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {INT} -pin_slices {[39:37]}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {INT[39:37]} -value {GND}
# Add APB_BUS_CONVERTER_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {APB_BUS_CONVERTER} -instance_name {APB_BUS_CONVERTER_0}



# Add CAPE_DEFAULT_GPIOS instance
sd_instantiate_component -sd_name ${sd_name} -component_name {CAPE_DEFAULT_GPIOS} -instance_name {CAPE_DEFAULT_GPIOS}



# Add CoreAPB3_CAPE_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {CoreAPB3_CAPE} -instance_name {CoreAPB3_CAPE_0}



# Adjust P8_GPIO_UPPER
sd_delete_instances -sd_name {P8_GPIO_UPPER} -instance_names {GPIO_6_BIBUF GPIO_7_BIBUF}
sd_connect_pins_to_constant -sd_name {P8_GPIO_UPPER} -pin_names {CoreGPIO_P8_UPPER_0:GPIO_IN[6:6]} -value {GND}
sd_connect_pins_to_constant -sd_name {P8_GPIO_UPPER} -pin_names {CoreGPIO_P8_UPPER_0:GPIO_IN[7:7]} -value {GND}
sd_mark_pins_unused -sd_name {P8_GPIO_UPPER} -pin_names {CoreGPIO_P8_UPPER_0:GPIO_OE[6:6]}
sd_mark_pins_unused -sd_name {P8_GPIO_UPPER} -pin_names {CoreGPIO_P8_UPPER_0:GPIO_OE[7:7]}
sd_mark_pins_unused -sd_name {P8_GPIO_UPPER} -pin_names {CoreGPIO_P8_UPPER_0:GPIO_OUT[6:6]}
sd_mark_pins_unused -sd_name {P8_GPIO_UPPER} -pin_names {CoreGPIO_P8_UPPER_0:GPIO_OUT[7:7]}
save_smartdesign -sd_name {P8_GPIO_UPPER}
generate_component -component_name {P8_GPIO_UPPER}

# Add P8_GPIO_UPPER_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {P8_GPIO_UPPER} -instance_name {P8_GPIO_UPPER_0}



# Add P9_GPIO_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {P9_GPIO} -instance_name {P9_GPIO_0}



# Add PWM_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {CAPE_PWM} -instance_name {PWM_0}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {PWM_0:PWM_1}



# Add PWM_1 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {CAPE_PWM} -instance_name {PWM_1}



# Add PWM_2 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {CAPE_PWM} -instance_name {PWM_2}



# Add scalar net connections
sd_connect_pins -sd_name ${sd_name} -pin_names { "P8[3]" "CAPE_DEFAULT_GPIOS:GPIO_0_PAD"}
sd_connect_pins -sd_name ${sd_name} -pin_names { "P8[4]" "CAPE_DEFAULT_GPIOS:GPIO_1_PAD"}
sd_connect_pins -sd_name ${sd_name} -pin_names { "P8[5]" "CAPE_DEFAULT_GPIOS:GPIO_2_PAD"}
sd_connect_pins -sd_name ${sd_name} -pin_names { "P8[6]" "CAPE_DEFAULT_GPIOS:GPIO_3_PAD"}
sd_connect_pins -sd_name ${sd_name} -pin_names { "P8[7]" "CAPE_DEFAULT_GPIOS:GPIO_4_PAD"}
sd_connect_pins -sd_name ${sd_name} -pin_names { "P8[8]" "CAPE_DEFAULT_GPIOS:GPIO_5_PAD"}
sd_connect_pins -sd_name ${sd_name} -pin_names { "P8[9]" "CAPE_DEFAULT_GPIOS:GPIO_6_PAD"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"P8[10]" "CAPE_DEFAULT_GPIOS:GPIO_7_PAD"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"P8[11]" "CAPE_DEFAULT_GPIOS:GPIO_8_PAD"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"P8[12]" "CAPE_DEFAULT_GPIOS:GPIO_9_PAD"}

sd_connect_pins -sd_name ${sd_name} -pin_names {"P8[14]" "CAPE_DEFAULT_GPIOS:GPIO_11_PAD"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"P8[15]" "CAPE_DEFAULT_GPIOS:GPIO_12_PAD"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"P8[16]" "CAPE_DEFAULT_GPIOS:GPIO_13_PAD"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"P8[17]" "CAPE_DEFAULT_GPIOS:GPIO_14_PAD"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"P8[18]" "CAPE_DEFAULT_GPIOS:GPIO_15_PAD"}

sd_connect_pins -sd_name ${sd_name} -pin_names {"P8[20]" "CAPE_DEFAULT_GPIOS:GPIO_17_PAD"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"P8[21]" "CAPE_DEFAULT_GPIOS:GPIO_18_PAD"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"P8[22]" "CAPE_DEFAULT_GPIOS:GPIO_19_PAD"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"P8[23]" "CAPE_DEFAULT_GPIOS:GPIO_20_PAD"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"P8[24]" "CAPE_DEFAULT_GPIOS:GPIO_21_PAD"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"P8[25]" "CAPE_DEFAULT_GPIOS:GPIO_22_PAD"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"P8[26]" "CAPE_DEFAULT_GPIOS:GPIO_23_PAD"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"P8[27]" "CAPE_DEFAULT_GPIOS:GPIO_24_PAD"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"P8[28]" "CAPE_DEFAULT_GPIOS:GPIO_25_PAD"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"P8[29]" "CAPE_DEFAULT_GPIOS:GPIO_26_PAD"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"P8[30]" "CAPE_DEFAULT_GPIOS:GPIO_27_PAD"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"P8[31]" "P8_GPIO_UPPER_0:GPIO_0_PAD"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"P8[32]" "P8_GPIO_UPPER_0:GPIO_1_PAD"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"P8[33]" "P8_GPIO_UPPER_0:GPIO_2_PAD"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"P8[34]" "P8_GPIO_UPPER_0:GPIO_3_PAD"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"P8[35]" "P8_GPIO_UPPER_0:GPIO_4_PAD"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"P8[36]" "P8_GPIO_UPPER_0:GPIO_5_PAD"}

sd_connect_pins -sd_name ${sd_name} -pin_names {"P8[39]" "P8_GPIO_UPPER_0:GPIO_8_PAD"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"P8[40]" "P8_GPIO_UPPER_0:GPIO_9_PAD"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"P8[41]" "P8_GPIO_UPPER_0:GPIO_10_PAD"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"P8[42]" "P8_GPIO_UPPER_0:GPIO_11_PAD"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"P8[43]" "P8_GPIO_UPPER_0:GPIO_12_PAD"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"P8[44]" "P8_GPIO_UPPER_0:GPIO_13_PAD"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"P8[45]" "P8_GPIO_UPPER_0:GPIO_14_PAD"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"P8[46]" "P8_GPIO_UPPER_0:GPIO_15_PAD"}

sd_connect_pins -sd_name ${sd_name} -pin_names {"P8_GPIO_UPPER_0:PCLK" "P9_GPIO_0:PCLK" "PCLK" "PWM_0:PCLK" "PWM_1:PCLK" "PWM_2:PCLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P8_GPIO_UPPER_0:PRESETN" "P9_GPIO_0:PRESETN" "PRESETN" "PWM_0:PRESETN" "PWM_1:PRESETN" "PWM_2:PRESETN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9_GPIO_0:GPIO_10_PAD" "P9_PIN23" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9_GPIO_0:GPIO_12_PAD" "P9_PIN25" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9_GPIO_0:GPIO_14_PAD" "P9_PIN27" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9_GPIO_0:GPIO_17_PAD" "P9_PIN30" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9_GPIO_0:GPIO_19_PAD" "P9_PIN41" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9_GPIO_0:GPIO_1_PAD" "P9_PIN12" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9_GPIO_0:GPIO_4_PAD" "P9_PIN15" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9_PIN42" "PWM_0:PWM_0" }

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
sd_connect_pins -sd_name ${sd_name} -pin_names {"CoreAPB3_CAPE_0:APBmslave4" "PWM_1:APBslave" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CoreAPB3_CAPE_0:APBmslave5" "PWM_2:APBslave" }

# Add GPIO BIBUFs
sd_instantiate_macro -sd_name ${sd_name} -macro_name {BIBUF} -instance_name {GPIO_13_BIBUF}
sd_instantiate_macro -sd_name ${sd_name} -macro_name {BIBUF} -instance_name {GPIO_19_BIBUF}
sd_instantiate_macro -sd_name ${sd_name} -macro_name {BIBUF} -instance_name {P9_14_BIBUF}
sd_instantiate_macro -sd_name ${sd_name} -macro_name {BIBUF} -instance_name {P9_16_BIBUF}
sd_instantiate_macro -sd_name ${sd_name} -macro_name {BIBUF} -instance_name {GPIO_37_BIBUF}
sd_instantiate_macro -sd_name ${sd_name} -macro_name {BIBUF} -instance_name {GPIO_38_BIBUF}

sd_connect_pins -sd_name ${sd_name} -pin_names {"GPIO_13_BIBUF:PAD" "P8[13]"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"GPIO_13_BIBUF:D" "PWM_2:PWM_1"}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {GPIO_13_BIBUF:Y}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {GPIO_13_BIBUF:E} -value {VCC}

sd_connect_pins -sd_name ${sd_name} -pin_names {"GPIO_19_BIBUF:PAD" "P8[19]"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"GPIO_19_BIBUF:D" "PWM_2:PWM_0"}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {GPIO_19_BIBUF:Y}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {GPIO_19_BIBUF:E} -value {VCC}

sd_connect_pins -sd_name ${sd_name} -pin_names {"P9_14_BIBUF:PAD" "P9_14"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9_14_BIBUF:D" "PWM_1:PWM_0"}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {P9_14_BIBUF:Y}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {P9_14_BIBUF:E} -value {VCC}

sd_connect_pins -sd_name ${sd_name} -pin_names {"P9_16_BIBUF:PAD" "P9_16"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9_16_BIBUF:D" "PWM_1:PWM_1"}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {P9_16_BIBUF:Y}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {P9_16_BIBUF:E} -value {VCC}

sd_connect_pins -sd_name ${sd_name} -pin_names {"GPIO_37_BIBUF:PAD" "P8[37]"}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {GPIO_37_BIBUF:E} -value {VCC}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {GPIO_37_BIBUF:Y}
sd_connect_pin_to_port -sd_name ${sd_name} -pin_name {GPIO_37_BIBUF:D} -port_name {}
sd_rename_port -sd_name ${sd_name} -current_port_name {D} -new_port_name {M2_UART_TXD}

sd_connect_pins -sd_name ${sd_name} -pin_names {"GPIO_38_BIBUF:PAD" "P8[38]"}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {GPIO_38_BIBUF:D} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {GPIO_38_BIBUF:E} -value {GND}
sd_connect_pin_to_port -sd_name ${sd_name} -pin_name {GPIO_38_BIBUF:Y} -port_name {}
sd_rename_port -sd_name ${sd_name} -current_port_name {Y} -new_port_name {M2_UART_RXD}

# Re-enable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 1
# Save the SmartDesign 
save_smartdesign -sd_name ${sd_name}
# Generate SmartDesign "CAPE"
generate_component -component_name ${sd_name}
