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

sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_PIN11} -port_direction {INOUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_PIN12} -port_direction {INOUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_PIN13} -port_direction {INOUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_PIN14} -port_direction {INOUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_PIN15} -port_direction {INOUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_PIN16} -port_direction {INOUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_PIN17} -port_direction {INOUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_PIN18} -port_direction {INOUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_PIN21} -port_direction {INOUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_PIN22} -port_direction {INOUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_PIN23} -port_direction {INOUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_PIN24} -port_direction {INOUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_PIN25} -port_direction {INOUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_PIN26} -port_direction {INOUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_PIN27} -port_direction {INOUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_PIN28} -port_direction {INOUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_PIN29} -port_direction {INOUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_PIN30} -port_direction {INOUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_PIN31} -port_direction {INOUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_PIN41} -port_direction {INOUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_PIN42} -port_direction {INOUT} -port_is_pad {1}

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


# Adjust CAPE_DEFAULT_GPIOS
sd_instantiate_macro -sd_name {CAPE_DEFAULT_GPIOS} -macro_name {BIBUF} -instance_name {GPIO_10_BIBUF}
sd_connect_pins -sd_name {CAPE_DEFAULT_GPIOS} -pin_names {"GPIO_10_BIBUF:D" "GPIO_OUT[10:10]"}
sd_connect_pins -sd_name {CAPE_DEFAULT_GPIOS} -pin_names {"GPIO_10_BIBUF:E" "GPIO_OE[10:10]"}
sd_connect_pins -sd_name {CAPE_DEFAULT_GPIOS} -pin_names {"GPIO_10_BIBUF:Y" "GPIO_IN[10:10]"}
sd_connect_pin_to_port -sd_name {CAPE_DEFAULT_GPIOS} -pin_name {GPIO_10_BIBUF:PAD} -port_name {GPIO_10_PAD}

sd_instantiate_macro -sd_name {CAPE_DEFAULT_GPIOS} -macro_name {BIBUF} -instance_name {GPIO_16_BIBUF}
sd_connect_pins -sd_name {CAPE_DEFAULT_GPIOS} -pin_names {"GPIO_16_BIBUF:D" "GPIO_OUT[16:16]"}
sd_connect_pins -sd_name {CAPE_DEFAULT_GPIOS} -pin_names {"GPIO_16_BIBUF:E" "GPIO_OE[16:16]"}
sd_connect_pins -sd_name {CAPE_DEFAULT_GPIOS} -pin_names {"GPIO_16_BIBUF:Y" "GPIO_IN[16:16]"}
sd_connect_pin_to_port -sd_name {CAPE_DEFAULT_GPIOS} -pin_name {GPIO_16_BIBUF:PAD} -port_name {GPIO_16_PAD}

save_smartdesign -sd_name {CAPE_DEFAULT_GPIOS}
generate_component -component_name {CAPE_DEFAULT_GPIOS}

# Add CAPE_DEFAULT_GPIOS instance
sd_instantiate_component -sd_name ${sd_name} -component_name {CAPE_DEFAULT_GPIOS} -instance_name {CAPE_DEFAULT_GPIOS}



# Add CoreAPB3_CAPE_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {CoreAPB3_CAPE} -instance_name {CoreAPB3_CAPE_0}



# Add P8_GPIO_UPPER_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {P8_GPIO_UPPER} -instance_name {P8_GPIO_UPPER_0}


# Adjust P9_GPIO
sd_instantiate_macro -sd_name {P9_GPIO} -macro_name {BIBUF} -instance_name {GPIO_0_BIBUF}
sd_connect_pins -sd_name {P9_GPIO} -pin_names {"GPIO_0_BIBUF:D" "CoreGPIO_P9_0:GPIO_OUT[0:0]"}
sd_connect_pins -sd_name {P9_GPIO} -pin_names {"GPIO_0_BIBUF:E" "CoreGPIO_P9_0:GPIO_OE[0:0]"}
sd_connect_pins -sd_name {P9_GPIO} -pin_names {"GPIO_0_BIBUF:Y" "CoreGPIO_P9_0:GPIO_IN[0:0]"}
sd_connect_pin_to_port -sd_name {P9_GPIO} -pin_name {GPIO_0_BIBUF:PAD} -port_name {GPIO_0_PAD}

sd_instantiate_macro -sd_name {P9_GPIO} -macro_name {BIBUF} -instance_name {GPIO_2_BIBUF}
sd_connect_pins -sd_name {P9_GPIO} -pin_names {"GPIO_2_BIBUF:D" "CoreGPIO_P9_0:GPIO_OUT[2:2]"}
sd_connect_pins -sd_name {P9_GPIO} -pin_names {"GPIO_2_BIBUF:E" "CoreGPIO_P9_0:GPIO_OE[2:2]"}
sd_connect_pins -sd_name {P9_GPIO} -pin_names {"GPIO_2_BIBUF:Y" "CoreGPIO_P9_0:GPIO_IN[2:2]"}
sd_connect_pin_to_port -sd_name {P9_GPIO} -pin_name {GPIO_2_BIBUF:PAD} -port_name {GPIO_2_PAD}

sd_instantiate_macro -sd_name {P9_GPIO} -macro_name {BIBUF} -instance_name {GPIO_3_BIBUF}
sd_connect_pins -sd_name {P9_GPIO} -pin_names {"GPIO_3_BIBUF:D" "CoreGPIO_P9_0:GPIO_OUT[3:3]"}
sd_connect_pins -sd_name {P9_GPIO} -pin_names {"GPIO_3_BIBUF:E" "CoreGPIO_P9_0:GPIO_OE[3:3]"}
sd_connect_pins -sd_name {P9_GPIO} -pin_names {"GPIO_3_BIBUF:Y" "CoreGPIO_P9_0:GPIO_IN[3:3]"}
sd_connect_pin_to_port -sd_name {P9_GPIO} -pin_name {GPIO_3_BIBUF:PAD} -port_name {GPIO_3_PAD}

sd_instantiate_macro -sd_name {P9_GPIO} -macro_name {BIBUF} -instance_name {GPIO_5_BIBUF}
sd_connect_pins -sd_name {P9_GPIO} -pin_names {"GPIO_5_BIBUF:D" "CoreGPIO_P9_0:GPIO_OUT[5:5]"}
sd_connect_pins -sd_name {P9_GPIO} -pin_names {"GPIO_5_BIBUF:E" "CoreGPIO_P9_0:GPIO_OE[5:5]"}
sd_connect_pins -sd_name {P9_GPIO} -pin_names {"GPIO_5_BIBUF:Y" "CoreGPIO_P9_0:GPIO_IN[5:5]"}
sd_connect_pin_to_port -sd_name {P9_GPIO} -pin_name {GPIO_5_BIBUF:PAD} -port_name {GPIO_5_PAD}

sd_instantiate_macro -sd_name {P9_GPIO} -macro_name {BIBUF} -instance_name {GPIO_6_BIBUF}
sd_connect_pins -sd_name {P9_GPIO} -pin_names {"GPIO_6_BIBUF:D" "CoreGPIO_P9_0:GPIO_OUT[6:6]"}
sd_connect_pins -sd_name {P9_GPIO} -pin_names {"GPIO_6_BIBUF:E" "CoreGPIO_P9_0:GPIO_OE[6:6]"}
sd_connect_pins -sd_name {P9_GPIO} -pin_names {"GPIO_6_BIBUF:Y" "CoreGPIO_P9_0:GPIO_IN[6:6]"}
sd_connect_pin_to_port -sd_name {P9_GPIO} -pin_name {GPIO_6_BIBUF:PAD} -port_name {GPIO_6_PAD}

sd_instantiate_macro -sd_name {P9_GPIO} -macro_name {BIBUF} -instance_name {GPIO_7_BIBUF}
sd_connect_pins -sd_name {P9_GPIO} -pin_names {"GPIO_7_BIBUF:D" "CoreGPIO_P9_0:GPIO_OUT[7:7]"}
sd_connect_pins -sd_name {P9_GPIO} -pin_names {"GPIO_7_BIBUF:E" "CoreGPIO_P9_0:GPIO_OE[7:7]"}
sd_connect_pins -sd_name {P9_GPIO} -pin_names {"GPIO_7_BIBUF:Y" "CoreGPIO_P9_0:GPIO_IN[7:7]"}
sd_connect_pin_to_port -sd_name {P9_GPIO} -pin_name {GPIO_7_BIBUF:PAD} -port_name {GPIO_7_PAD}

sd_instantiate_macro -sd_name {P9_GPIO} -macro_name {BIBUF} -instance_name {GPIO_8_BIBUF}
sd_connect_pins -sd_name {P9_GPIO} -pin_names {"GPIO_8_BIBUF:D" "CoreGPIO_P9_0:GPIO_OUT[8:8]"}
sd_connect_pins -sd_name {P9_GPIO} -pin_names {"GPIO_8_BIBUF:E" "CoreGPIO_P9_0:GPIO_OE[8:8]"}
sd_connect_pins -sd_name {P9_GPIO} -pin_names {"GPIO_8_BIBUF:Y" "CoreGPIO_P9_0:GPIO_IN[8:8]"}
sd_connect_pin_to_port -sd_name {P9_GPIO} -pin_name {GPIO_8_BIBUF:PAD} -port_name {GPIO_8_PAD}

sd_instantiate_macro -sd_name {P9_GPIO} -macro_name {BIBUF} -instance_name {GPIO_9_BIBUF}
sd_connect_pins -sd_name {P9_GPIO} -pin_names {"GPIO_9_BIBUF:D" "CoreGPIO_P9_0:GPIO_OUT[9:9]"}
sd_connect_pins -sd_name {P9_GPIO} -pin_names {"GPIO_9_BIBUF:E" "CoreGPIO_P9_0:GPIO_OE[9:9]"}
sd_connect_pins -sd_name {P9_GPIO} -pin_names {"GPIO_9_BIBUF:Y" "CoreGPIO_P9_0:GPIO_IN[9:9]"}
sd_connect_pin_to_port -sd_name {P9_GPIO} -pin_name {GPIO_9_BIBUF:PAD} -port_name {GPIO_9_PAD}

sd_instantiate_macro -sd_name {P9_GPIO} -macro_name {BIBUF} -instance_name {GPIO_11_BIBUF}
sd_connect_pins -sd_name {P9_GPIO} -pin_names {"GPIO_11_BIBUF:D" "CoreGPIO_P9_0:GPIO_OUT[11:11]"}
sd_connect_pins -sd_name {P9_GPIO} -pin_names {"GPIO_11_BIBUF:E" "CoreGPIO_P9_0:GPIO_OE[11:11]"}
sd_connect_pins -sd_name {P9_GPIO} -pin_names {"GPIO_11_BIBUF:Y" "CoreGPIO_P9_0:GPIO_IN[11:11]"}
sd_connect_pin_to_port -sd_name {P9_GPIO} -pin_name {GPIO_11_BIBUF:PAD} -port_name {GPIO_11_PAD}

sd_instantiate_macro -sd_name {P9_GPIO} -macro_name {BIBUF} -instance_name {GPIO_13_BIBUF}
sd_connect_pins -sd_name {P9_GPIO} -pin_names {"GPIO_13_BIBUF:D" "CoreGPIO_P9_0:GPIO_OUT[13:13]"}
sd_connect_pins -sd_name {P9_GPIO} -pin_names {"GPIO_13_BIBUF:E" "CoreGPIO_P9_0:GPIO_OE[13:13]"}
sd_connect_pins -sd_name {P9_GPIO} -pin_names {"GPIO_13_BIBUF:Y" "CoreGPIO_P9_0:GPIO_IN[13:13]"}
sd_connect_pin_to_port -sd_name {P9_GPIO} -pin_name {GPIO_13_BIBUF:PAD} -port_name {GPIO_13_PAD}

sd_instantiate_macro -sd_name {P9_GPIO} -macro_name {BIBUF} -instance_name {GPIO_15_BIBUF}
sd_connect_pins -sd_name {P9_GPIO} -pin_names {"GPIO_15_BIBUF:D" "CoreGPIO_P9_0:GPIO_OUT[15:15]"}
sd_connect_pins -sd_name {P9_GPIO} -pin_names {"GPIO_15_BIBUF:E" "CoreGPIO_P9_0:GPIO_OE[15:15]"}
sd_connect_pins -sd_name {P9_GPIO} -pin_names {"GPIO_15_BIBUF:Y" "CoreGPIO_P9_0:GPIO_IN[15:15]"}
sd_connect_pin_to_port -sd_name {P9_GPIO} -pin_name {GPIO_15_BIBUF:PAD} -port_name {GPIO_15_PAD}

sd_instantiate_macro -sd_name {P9_GPIO} -macro_name {BIBUF} -instance_name {GPIO_16_BIBUF}
sd_connect_pins -sd_name {P9_GPIO} -pin_names {"GPIO_16_BIBUF:D" "CoreGPIO_P9_0:GPIO_OUT[16:16]"}
sd_connect_pins -sd_name {P9_GPIO} -pin_names {"GPIO_16_BIBUF:E" "CoreGPIO_P9_0:GPIO_OE[16:16]"}
sd_connect_pins -sd_name {P9_GPIO} -pin_names {"GPIO_16_BIBUF:Y" "CoreGPIO_P9_0:GPIO_IN[16:16]"}
sd_connect_pin_to_port -sd_name {P9_GPIO} -pin_name {GPIO_16_BIBUF:PAD} -port_name {GPIO_16_PAD}

sd_instantiate_macro -sd_name {P9_GPIO} -macro_name {BIBUF} -instance_name {GPIO_18_BIBUF}
sd_connect_pins -sd_name {P9_GPIO} -pin_names {"GPIO_18_BIBUF:D" "CoreGPIO_P9_0:GPIO_OUT[18:18]"}
sd_connect_pins -sd_name {P9_GPIO} -pin_names {"GPIO_18_BIBUF:E" "CoreGPIO_P9_0:GPIO_OE[18:18]"}
sd_connect_pins -sd_name {P9_GPIO} -pin_names {"GPIO_18_BIBUF:Y" "CoreGPIO_P9_0:GPIO_IN[18:18]"}
sd_connect_pin_to_port -sd_name {P9_GPIO} -pin_name {GPIO_18_BIBUF:PAD} -port_name {GPIO_18_PAD}

sd_instantiate_macro -sd_name {P9_GPIO} -macro_name {BIBUF} -instance_name {GPIO_20_BIBUF}
sd_connect_pins -sd_name {P9_GPIO} -pin_names {"GPIO_20_BIBUF:D" "CoreGPIO_P9_0:GPIO_OUT[20:20]"}
sd_connect_pins -sd_name {P9_GPIO} -pin_names {"GPIO_20_BIBUF:E" "CoreGPIO_P9_0:GPIO_OE[20:20]"}
sd_connect_pins -sd_name {P9_GPIO} -pin_names {"GPIO_20_BIBUF:Y" "CoreGPIO_P9_0:GPIO_IN[20:20]"}
sd_connect_pin_to_port -sd_name {P9_GPIO} -pin_name {GPIO_20_BIBUF:PAD} -port_name {GPIO_20_PAD}

save_smartdesign -sd_name {P9_GPIO}
generate_component -component_name {P9_GPIO}

# Add P9_GPIO_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {P9_GPIO} -instance_name {P9_GPIO_0}



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
sd_connect_pins -sd_name ${sd_name} -pin_names {"P8_GPIO_UPPER_0:GPIO_10_PAD" "P8[41]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P8_GPIO_UPPER_0:GPIO_11_PAD" "P8[42]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P8_GPIO_UPPER_0:GPIO_12_PAD" "P8[43]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P8_GPIO_UPPER_0:GPIO_13_PAD" "P8[44]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P8_GPIO_UPPER_0:GPIO_14_PAD" "P8[45]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P8_GPIO_UPPER_0:GPIO_15_PAD" "P8[46]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P8_GPIO_UPPER_0:GPIO_1_PAD" "P8[32]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P8_GPIO_UPPER_0:GPIO_2_PAD" "P8[33]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P8_GPIO_UPPER_0:GPIO_3_PAD" "P8[34]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P8_GPIO_UPPER_0:GPIO_4_PAD" "P8[35]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P8_GPIO_UPPER_0:GPIO_5_PAD" "P8[36]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P8_GPIO_UPPER_0:GPIO_6_PAD" "P8[37]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P8_GPIO_UPPER_0:GPIO_7_PAD" "P8[38]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P8_GPIO_UPPER_0:GPIO_8_PAD" "P8[39]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P8_GPIO_UPPER_0:GPIO_9_PAD" "P8[40]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P8_GPIO_UPPER_0:PCLK" "P9_GPIO_0:PCLK" "PCLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P8_GPIO_UPPER_0:PRESETN" "P9_GPIO_0:PRESETN" "PRESETN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9_GPIO_0:GPIO_0_PAD" "P9_PIN11" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9_GPIO_0:GPIO_10_PAD" "P9_PIN23" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9_GPIO_0:GPIO_11_PAD" "P9_PIN24" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9_GPIO_0:GPIO_12_PAD" "P9_PIN25" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9_GPIO_0:GPIO_13_PAD" "P9_PIN26" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9_GPIO_0:GPIO_14_PAD" "P9_PIN27" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9_GPIO_0:GPIO_15_PAD" "P9_PIN28" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9_GPIO_0:GPIO_16_PAD" "P9_PIN29" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9_GPIO_0:GPIO_17_PAD" "P9_PIN30" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9_GPIO_0:GPIO_18_PAD" "P9_PIN31" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9_GPIO_0:GPIO_19_PAD" "P9_PIN41" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9_GPIO_0:GPIO_1_PAD" "P9_PIN12" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9_GPIO_0:GPIO_20_PAD" "P9_PIN42" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9_GPIO_0:GPIO_2_PAD" "P9_PIN13" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9_GPIO_0:GPIO_3_PAD" "P9_PIN14" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9_GPIO_0:GPIO_4_PAD" "P9_PIN15" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9_GPIO_0:GPIO_5_PAD" "P9_PIN16" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9_GPIO_0:GPIO_6_PAD" "P9_PIN17" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9_GPIO_0:GPIO_7_PAD" "P9_PIN18" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9_GPIO_0:GPIO_8_PAD" "P9_PIN21" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9_GPIO_0:GPIO_9_PAD" "P9_PIN22" }

# Add bus net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE_DEFAULT_GPIOS:GPIO_IN" "GPIO_IN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE_DEFAULT_GPIOS:GPIO_OE" "GPIO_OE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE_DEFAULT_GPIOS:GPIO_OUT" "GPIO_OUT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"INT[15:0]" "P8_GPIO_UPPER_0:INT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"INT[36:16]" "P9_GPIO_0:INT" }

# Add bus interface net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"APB_BUS_CONVERTER_0:APB_MASTER" "CoreAPB3_CAPE_0:APB3mmaster" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"APB_BUS_CONVERTER_0:APB_SLAVE" "APB_SLAVE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CoreAPB3_CAPE_0:APBmslave1" "P8_GPIO_UPPER_0:APB_bif" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CoreAPB3_CAPE_0:APBmslave2" "P9_GPIO_0:APB_bif" }

# Re-enable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 1
# Save the SmartDesign 
save_smartdesign -sd_name ${sd_name}
# Generate SmartDesign "CAPE"
generate_component -component_name ${sd_name}
