# Creating SmartDesign "CAPE"
set sd_name {CAPE}
create_smartdesign -sd_name ${sd_name}

# Disable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 0

# Create top level Scalar Ports
sd_create_scalar_port -sd_name ${sd_name} -port_name {APB_SLAVE_SLAVE_PENABLE} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {APB_SLAVE_SLAVE_PSEL} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {APB_SLAVE_SLAVE_PWRITE} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_PIN27} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_PIN42} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {PCLK} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {PRESETN} -port_direction {IN}

sd_create_scalar_port -sd_name ${sd_name} -port_name {APB_SLAVE_SLAVE_PREADY} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {APB_SLAVE_SLAVE_PSLVERR} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_14} -port_direction {INOUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_16} -port_direction {INOUT} -port_is_pad {1}

sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_PIN12} -port_direction {INOUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_PIN13} -port_direction {INOUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_PIN15} -port_direction {INOUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_PIN23} -port_direction {INOUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_PIN25} -port_direction {INOUT} -port_is_pad {1}
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
sd_create_bus_port -sd_name ${sd_name} -port_name {INT} -port_direction {OUT} -port_range {[23:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {INT} -pin_slices {[15:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {INT} -pin_slices {[23:16]}


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
# Add APB_BUS_CONVERTER_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {APB_BUS_CONVERTER} -instance_name {APB_BUS_CONVERTER_0}



# Add apb_rotary_enc_0 instance
sd_instantiate_hdl_core -sd_name ${sd_name} -hdl_core_name {apb_rotary_enc} -instance_name {apb_rotary_enc_0}


# Adjust CAPE_DEFAULT_GPIOS
sd_delete_instances -sd_name {CAPE_DEFAULT_GPIOS} -instance_names {GPIO_8_BIBUF}
sd_delete_instances -sd_name {CAPE_DEFAULT_GPIOS} -instance_names {GPIO_9_BIBUF}
sd_delete_instances -sd_name {CAPE_DEFAULT_GPIOS} -instance_names {GPIO_12_BIBUF}
sd_delete_instances -sd_name {CAPE_DEFAULT_GPIOS} -instance_names {GPIO_13_BIBUF}
sd_delete_instances -sd_name {CAPE_DEFAULT_GPIOS} -instance_names {GPIO_24_BIBUF}
sd_delete_instances -sd_name {CAPE_DEFAULT_GPIOS} -instance_names {GPIO_25_BIBUF}
sd_delete_instances -sd_name {CAPE_DEFAULT_GPIOS} -instance_names {GPIO_26_BIBUF}
sd_delete_instances -sd_name {CAPE_DEFAULT_GPIOS} -instance_names {GPIO_27_BIBUF}
sd_connect_pins_to_constant -sd_name {CAPE_DEFAULT_GPIOS} -pin_names {GPIO_IN[8:8]} -value {GND}
sd_connect_pins_to_constant -sd_name {CAPE_DEFAULT_GPIOS} -pin_names {GPIO_IN[9:9]} -value {GND}
sd_connect_pins_to_constant -sd_name {CAPE_DEFAULT_GPIOS} -pin_names {GPIO_IN[12:12]} -value {GND}
sd_connect_pins_to_constant -sd_name {CAPE_DEFAULT_GPIOS} -pin_names {GPIO_IN[13:13]} -value {GND}
sd_connect_pins_to_constant -sd_name {CAPE_DEFAULT_GPIOS} -pin_names {GPIO_IN[24:24]} -value {GND}
sd_connect_pins_to_constant -sd_name {CAPE_DEFAULT_GPIOS} -pin_names {GPIO_IN[25:25]} -value {GND}
sd_connect_pins_to_constant -sd_name {CAPE_DEFAULT_GPIOS} -pin_names {GPIO_IN[26:26]} -value {GND}
sd_connect_pins_to_constant -sd_name {CAPE_DEFAULT_GPIOS} -pin_names {GPIO_IN[27:27]} -value {GND}
save_smartdesign -sd_name {CAPE_DEFAULT_GPIOS}
generate_component -component_name {CAPE_DEFAULT_GPIOS}

# Add CAPE_DEFAULT_GPIOS instance
sd_instantiate_component -sd_name ${sd_name} -component_name {CAPE_DEFAULT_GPIOS} -instance_name {CAPE_DEFAULT_GPIOS}


# Adjust CoreAPB3_CAPE
configure_core -component_name {CoreAPB3_CAPE} -params { "APBSLOT3ENABLE:true" }

# Add CoreAPB3_CAPE_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {CoreAPB3_CAPE} -instance_name {CoreAPB3_CAPE_0}


# Adjust P8_GPIO_UPPER
sd_delete_instances -sd_name {P8_GPIO_UPPER} -instance_names {GPIO_2_BIBUF}
sd_delete_instances -sd_name {P8_GPIO_UPPER} -instance_names {GPIO_4_BIBUF}
sd_delete_instances -sd_name {P8_GPIO_UPPER} -instance_names {GPIO_8_BIBUF}
sd_delete_instances -sd_name {P8_GPIO_UPPER} -instance_names {GPIO_9_BIBUF}
sd_delete_instances -sd_name {P8_GPIO_UPPER} -instance_names {GPIO_10_BIBUF}
sd_delete_instances -sd_name {P8_GPIO_UPPER} -instance_names {GPIO_11_BIBUF}
sd_connect_pins_to_constant -sd_name {P8_GPIO_UPPER} -pin_names {CoreGPIO_P8_UPPER_0:GPIO_IN[2:2]} -value {GND}
sd_connect_pins_to_constant -sd_name {P8_GPIO_UPPER} -pin_names {CoreGPIO_P8_UPPER_0:GPIO_IN[4:4]} -value {GND}
sd_connect_pins_to_constant -sd_name {P8_GPIO_UPPER} -pin_names {CoreGPIO_P8_UPPER_0:GPIO_IN[8:8]} -value {GND}
sd_connect_pins_to_constant -sd_name {P8_GPIO_UPPER} -pin_names {CoreGPIO_P8_UPPER_0:GPIO_IN[9:9]} -value {GND}
sd_connect_pins_to_constant -sd_name {P8_GPIO_UPPER} -pin_names {CoreGPIO_P8_UPPER_0:GPIO_IN[10:10]} -value {GND}
sd_connect_pins_to_constant -sd_name {P8_GPIO_UPPER} -pin_names {CoreGPIO_P8_UPPER_0:GPIO_IN[11:11]} -value {GND}
sd_mark_pins_unused -sd_name {P8_GPIO_UPPER} -pin_names {CoreGPIO_P8_UPPER_0:GPIO_OE[2:2]}
sd_mark_pins_unused -sd_name {P8_GPIO_UPPER} -pin_names {CoreGPIO_P8_UPPER_0:GPIO_OE[4:4]}
sd_mark_pins_unused -sd_name {P8_GPIO_UPPER} -pin_names {CoreGPIO_P8_UPPER_0:GPIO_OE[8:8]}
sd_mark_pins_unused -sd_name {P8_GPIO_UPPER} -pin_names {CoreGPIO_P8_UPPER_0:GPIO_OE[9:9]}
sd_mark_pins_unused -sd_name {P8_GPIO_UPPER} -pin_names {CoreGPIO_P8_UPPER_0:GPIO_OE[10:10]}
sd_mark_pins_unused -sd_name {P8_GPIO_UPPER} -pin_names {CoreGPIO_P8_UPPER_0:GPIO_OE[11:11]}
sd_mark_pins_unused -sd_name {P8_GPIO_UPPER} -pin_names {CoreGPIO_P8_UPPER_0:GPIO_OUT[2:2]}
sd_mark_pins_unused -sd_name {P8_GPIO_UPPER} -pin_names {CoreGPIO_P8_UPPER_0:GPIO_OUT[4:4]}
sd_mark_pins_unused -sd_name {P8_GPIO_UPPER} -pin_names {CoreGPIO_P8_UPPER_0:GPIO_OUT[8:8]}
sd_mark_pins_unused -sd_name {P8_GPIO_UPPER} -pin_names {CoreGPIO_P8_UPPER_0:GPIO_OUT[9:9]}
sd_mark_pins_unused -sd_name {P8_GPIO_UPPER} -pin_names {CoreGPIO_P8_UPPER_0:GPIO_OUT[10:10]}
sd_mark_pins_unused -sd_name {P8_GPIO_UPPER} -pin_names {CoreGPIO_P8_UPPER_0:GPIO_OUT[11:11]}
save_smartdesign -sd_name {P8_GPIO_UPPER}
generate_component -component_name {P8_GPIO_UPPER}

# Add P8_GPIO_UPPER_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {P8_GPIO_UPPER} -instance_name {P8_GPIO_UPPER_0}


# Adjust CoreGPIO_P9
configure_core -component_name {CoreGPIO_P9} -params {\
"FIXED_CONFIG_0:false"  \
"FIXED_CONFIG_1:false"  \
"FIXED_CONFIG_2:false"  \
"FIXED_CONFIG_3:false"  \
"FIXED_CONFIG_4:false"  \
"FIXED_CONFIG_5:false"  \
"FIXED_CONFIG_6:false"  \
"FIXED_CONFIG_7:false"  \
"IO_NUM:8"     \
"IO_TYPE_0:0"  \
"IO_TYPE_1:0"  \
"IO_TYPE_2:0"  \
"IO_TYPE_3:0"  \
"IO_TYPE_4:0"  \
"IO_TYPE_5:0"  \
"IO_TYPE_6:0"  \
"IO_TYPE_7:0"  }

sd_update_instance -sd_name {P9_GPIO} -instance_name {CoreGPIO_P9_0}

sd_create_scalar_port -sd_name {P9_GPIO} -port_name {PAD_0} -port_direction {INOUT} -port_is_pad {1}
sd_create_scalar_port -sd_name {P9_GPIO} -port_name {PAD_1} -port_direction {INOUT} -port_is_pad {1}
sd_create_scalar_port -sd_name {P9_GPIO} -port_name {PAD_2} -port_direction {INOUT} -port_is_pad {1}
sd_create_scalar_port -sd_name {P9_GPIO} -port_name {PAD_3} -port_direction {INOUT} -port_is_pad {1}
sd_create_scalar_port -sd_name {P9_GPIO} -port_name {PAD_5} -port_direction {INOUT} -port_is_pad {1}
sd_create_scalar_port -sd_name {P9_GPIO} -port_name {PAD_6} -port_direction {INOUT} -port_is_pad {1}
sd_create_scalar_port -sd_name {P9_GPIO} -port_name {PAD_7} -port_direction {INOUT} -port_is_pad {1}

sd_instantiate_macro -sd_name {P9_GPIO} -macro_name {BIBUF} -instance_name {BIBUF_0}
sd_instantiate_macro -sd_name {P9_GPIO} -macro_name {BIBUF} -instance_name {BIBUF_1}
sd_instantiate_macro -sd_name {P9_GPIO} -macro_name {BIBUF} -instance_name {BIBUF_2}
sd_instantiate_macro -sd_name {P9_GPIO} -macro_name {BIBUF} -instance_name {BIBUF_3}
sd_instantiate_macro -sd_name {P9_GPIO} -macro_name {BIBUF} -instance_name {BIBUF_5}
sd_instantiate_macro -sd_name {P9_GPIO} -macro_name {BIBUF} -instance_name {BIBUF_6}
sd_instantiate_macro -sd_name {P9_GPIO} -macro_name {BIBUF} -instance_name {BIBUF_7}
sd_connect_pins -sd_name {P9_GPIO} -pin_names {"BIBUF_0:D" "CoreGPIO_P9_0:GPIO_OUT[0:0]" }
sd_connect_pins -sd_name {P9_GPIO} -pin_names {"BIBUF_0:E" "CoreGPIO_P9_0:GPIO_OE[0:0]" }
sd_connect_pins -sd_name {P9_GPIO} -pin_names {"BIBUF_0:PAD" "PAD_0" }
sd_connect_pins -sd_name {P9_GPIO} -pin_names {"BIBUF_0:Y" "CoreGPIO_P9_0:GPIO_IN[0:0]" }
sd_connect_pins -sd_name {P9_GPIO} -pin_names {"BIBUF_1:D" "CoreGPIO_P9_0:GPIO_OUT[1:1]" }
sd_connect_pins -sd_name {P9_GPIO} -pin_names {"BIBUF_1:E" "CoreGPIO_P9_0:GPIO_OE[1:1]" }
sd_connect_pins -sd_name {P9_GPIO} -pin_names {"BIBUF_1:PAD" "PAD_1" }
sd_connect_pins -sd_name {P9_GPIO} -pin_names {"BIBUF_1:Y" "CoreGPIO_P9_0:GPIO_IN[1:1]" }
sd_connect_pins -sd_name {P9_GPIO} -pin_names {"BIBUF_2:D" "CoreGPIO_P9_0:GPIO_OUT[2:2]" }
sd_connect_pins -sd_name {P9_GPIO} -pin_names {"BIBUF_2:E" "CoreGPIO_P9_0:GPIO_OE[2:2]" }
sd_connect_pins -sd_name {P9_GPIO} -pin_names {"BIBUF_2:PAD" "PAD_2" }
sd_connect_pins -sd_name {P9_GPIO} -pin_names {"BIBUF_2:Y" "CoreGPIO_P9_0:GPIO_IN[2:2]" }
sd_connect_pins -sd_name {P9_GPIO} -pin_names {"BIBUF_3:D" "CoreGPIO_P9_0:GPIO_OUT[3:3]" }
sd_connect_pins -sd_name {P9_GPIO} -pin_names {"BIBUF_3:E" "CoreGPIO_P9_0:GPIO_OE[3:3]" }
sd_connect_pins -sd_name {P9_GPIO} -pin_names {"BIBUF_3:PAD" "PAD_3" }
sd_connect_pins -sd_name {P9_GPIO} -pin_names {"BIBUF_3:Y" "CoreGPIO_P9_0:GPIO_IN[3:3]" }
sd_connect_pins -sd_name {P9_GPIO} -pin_names {"BIBUF_5:D" "CoreGPIO_P9_0:GPIO_OUT[5:5]" }
sd_connect_pins -sd_name {P9_GPIO} -pin_names {"BIBUF_5:E" "CoreGPIO_P9_0:GPIO_OE[5:5]" }
sd_connect_pins -sd_name {P9_GPIO} -pin_names {"BIBUF_5:PAD" "PAD_5" }
sd_connect_pins -sd_name {P9_GPIO} -pin_names {"BIBUF_5:Y" "CoreGPIO_P9_0:GPIO_IN[5:5]" }
sd_connect_pins -sd_name {P9_GPIO} -pin_names {"BIBUF_6:D" "CoreGPIO_P9_0:GPIO_OUT[6:6]" }
sd_connect_pins -sd_name {P9_GPIO} -pin_names {"BIBUF_6:E" "CoreGPIO_P9_0:GPIO_OE[6:6]" }
sd_connect_pins -sd_name {P9_GPIO} -pin_names {"BIBUF_6:PAD" "PAD_6" }
sd_connect_pins -sd_name {P9_GPIO} -pin_names {"BIBUF_6:Y" "CoreGPIO_P9_0:GPIO_IN[6:6]" }
sd_connect_pins -sd_name {P9_GPIO} -pin_names {"BIBUF_7:D" "CoreGPIO_P9_0:GPIO_OUT[7:7]" }
sd_connect_pins -sd_name {P9_GPIO} -pin_names {"BIBUF_7:E" "CoreGPIO_P9_0:GPIO_OE[7:7]" }
sd_connect_pins -sd_name {P9_GPIO} -pin_names {"BIBUF_7:PAD" "PAD_7" }
sd_connect_pins -sd_name {P9_GPIO} -pin_names {"BIBUF_7:Y" "CoreGPIO_P9_0:GPIO_IN[7:7]" }

sd_delete_instances -sd_name {P9_GPIO} -instance_names {GPIO_1_BIBUF}
sd_delete_instances -sd_name {P9_GPIO} -instance_names {GPIO_4_BIBUF}
sd_delete_instances -sd_name {P9_GPIO} -instance_names {GPIO_10_BIBUF}
sd_delete_instances -sd_name {P9_GPIO} -instance_names {GPIO_12_BIBUF}
sd_delete_instances -sd_name {P9_GPIO} -instance_names {GPIO_14_BIBUF}
sd_delete_instances -sd_name {P9_GPIO} -instance_names {GPIO_17_BIBUF}
sd_delete_instances -sd_name {P9_GPIO} -instance_names {GPIO_19_BIBUF}

sd_connect_pins_to_constant -sd_name {P9_GPIO} -pin_names {CoreGPIO_P9_0:GPIO_IN[4:4]} -value {GND}
sd_mark_pins_unused -sd_name {P9_GPIO} -pin_names {CoreGPIO_P9_0:GPIO_OUT[4:4]}
sd_mark_pins_unused -sd_name {P9_GPIO} -pin_names {CoreGPIO_P9_0:GPIO_OE[4:4]}

sd_delete_ports -sd_name {P9_GPIO} -port_names {INT}
sd_create_bus_port -sd_name {P9_GPIO} -port_name {INT} -port_direction {OUT} -port_range {[7:0]}
sd_connect_pins -sd_name {P9_GPIO} -pin_names {"CoreGPIO_P9_0:INT" "INT" }

save_smartdesign -sd_name {P9_GPIO}
generate_component -component_name {P9_GPIO}

# Add P9_GPIO_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {P9_GPIO} -instance_name {P9_GPIO_0}


# Adjust corepwm_C1
configure_core -component_name {corepwm_C1} -params { "SHADOW_REG_EN1:false" "SHADOW_REG_EN2:false" }

# Add PWM_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {CAPE_PWM} -instance_name {PWM_0}



# Add PWM_1 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {CAPE_PWM} -instance_name {PWM_1}



# Add servos_0 instance
sd_instantiate_hdl_core -sd_name ${sd_name} -hdl_core_name {servos} -instance_name {servos_0}
# Exporting Parameters of instance servos_0
sd_configure_core_instance -sd_name ${sd_name} -instance_name {servos_0} -params {\
"NB_OF_SERVOS:16" \
"SERVO_VALUE_WIDTH:15" }\
-validate_rules 0
sd_save_core_instance_config -sd_name ${sd_name} -instance_name {servos_0}
sd_update_instance -sd_name ${sd_name} -instance_name {servos_0}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {servos_0:servos_out} -pin_slices {[0:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {servos_0:servos_out} -pin_slices {[10:10]}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {servos_0:servos_out[10:10]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {servos_0:servos_out} -pin_slices {[11:11]}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {servos_0:servos_out[11:11]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {servos_0:servos_out} -pin_slices {[12:12]}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {servos_0:servos_out[12:12]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {servos_0:servos_out} -pin_slices {[13:13]}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {servos_0:servos_out[13:13]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {servos_0:servos_out} -pin_slices {[14:14]}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {servos_0:servos_out[14:14]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {servos_0:servos_out} -pin_slices {[15:15]}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {servos_0:servos_out[15:15]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {servos_0:servos_out} -pin_slices {[1:1]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {servos_0:servos_out} -pin_slices {[2:2]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {servos_0:servos_out} -pin_slices {[3:3]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {servos_0:servos_out} -pin_slices {[4:4]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {servos_0:servos_out} -pin_slices {[5:5]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {servos_0:servos_out} -pin_slices {[6:6]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {servos_0:servos_out} -pin_slices {[7:7]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {servos_0:servos_out} -pin_slices {[8:8]}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {servos_0:servos_out[8:8]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {servos_0:servos_out} -pin_slices {[9:9]}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {servos_0:servos_out[9:9]}



# Add scalar net connections
sd_create_scalar_net -sd_name ${sd_name} -net_name {P9_12}
sd_create_scalar_net -sd_name ${sd_name} -net_name {P9_PIN15}
sd_connect_net_to_pins -sd_name ${sd_name} -net_name {P9_12} -pin_names {"P9_GPIO_0:PAD_0" "P9_PIN12" }
sd_connect_net_to_pins -sd_name ${sd_name} -net_name {P9_PIN15} -pin_names {"P9_GPIO_0:PAD_6" "P9_PIN41" }

sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE_DEFAULT_GPIOS:GPIO_0_PAD" "P8[3]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE_DEFAULT_GPIOS:GPIO_1_PAD" "P8[4]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE_DEFAULT_GPIOS:GPIO_2_PAD" "P8[5]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE_DEFAULT_GPIOS:GPIO_3_PAD" "P8[6]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE_DEFAULT_GPIOS:GPIO_4_PAD" "P8[7]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE_DEFAULT_GPIOS:GPIO_5_PAD" "P8[8]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE_DEFAULT_GPIOS:GPIO_6_PAD" "P8[9]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE_DEFAULT_GPIOS:GPIO_7_PAD" "P8[10]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE_DEFAULT_GPIOS:GPIO_11_PAD" "P8[14]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE_DEFAULT_GPIOS:GPIO_14_PAD" "P8[17]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE_DEFAULT_GPIOS:GPIO_15_PAD" "P8[18]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE_DEFAULT_GPIOS:GPIO_17_PAD" "P8[20]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE_DEFAULT_GPIOS:GPIO_18_PAD" "P8[21]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE_DEFAULT_GPIOS:GPIO_19_PAD" "P8[22]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE_DEFAULT_GPIOS:GPIO_20_PAD" "P8[23]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE_DEFAULT_GPIOS:GPIO_21_PAD" "P8[24]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE_DEFAULT_GPIOS:GPIO_22_PAD" "P8[25]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE_DEFAULT_GPIOS:GPIO_23_PAD" "P8[26]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P8_GPIO_UPPER_0:GPIO_0_PAD" "P8[31]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P8_GPIO_UPPER_0:GPIO_12_PAD" "P8[43]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P8_GPIO_UPPER_0:GPIO_13_PAD" "P8[44]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P8_GPIO_UPPER_0:GPIO_14_PAD" "P8[45]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P8_GPIO_UPPER_0:GPIO_15_PAD" "P8[46]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P8_GPIO_UPPER_0:GPIO_1_PAD" "P8[32]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P8_GPIO_UPPER_0:GPIO_3_PAD" "P8[34]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P8_GPIO_UPPER_0:GPIO_5_PAD" "P8[36]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P8_GPIO_UPPER_0:GPIO_6_PAD" "P8[37]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P8_GPIO_UPPER_0:GPIO_7_PAD" "P8[38]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P8_GPIO_UPPER_0:PCLK" "P9_GPIO_0:PCLK" "PCLK" "PWM_0:PCLK" "PWM_1:PCLK" "apb_rotary_enc_0:pclk" "servos_0:pclk" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P8_GPIO_UPPER_0:PRESETN" "P9_GPIO_0:PRESETN" "PRESETN" "PWM_0:PRESETN" "PWM_1:PRESETN" "apb_rotary_enc_0:presetn" "servos_0:presetn" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9_GPIO_0:PAD_1" "P9_PIN15" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9_GPIO_0:PAD_2" "P9_PIN23" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9_GPIO_0:PAD_3" "P9_PIN25" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9_GPIO_0:PAD_5" "P9_PIN30" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9_GPIO_0:PAD_7" "P9_PIN13" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9_PIN27" "apb_rotary_enc_0:enc0_b" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9_PIN42" "apb_rotary_enc_0:enc0_a" }

# Add GPIO BIBUFs
sd_instantiate_macro -sd_name ${sd_name} -macro_name {BIBUF} -instance_name {GPIO_11_BIBUF}
sd_connect_pins -sd_name ${sd_name} -pin_names {"GPIO_11_BIBUF:PAD" "P8[11]"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"GPIO_11_BIBUF:Y" "apb_rotary_enc_0:enc2_b" }
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {GPIO_11_BIBUF:D} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {GPIO_11_BIBUF:E} -value {GND}

sd_instantiate_macro -sd_name ${sd_name} -macro_name {BIBUF} -instance_name {GPIO_12_BIBUF}
sd_connect_pins -sd_name ${sd_name} -pin_names {"GPIO_12_BIBUF:PAD" "P8[12]"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"GPIO_12_BIBUF:Y" "apb_rotary_enc_0:enc2_a" }
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {GPIO_12_BIBUF:D} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {GPIO_12_BIBUF:E} -value {GND}


sd_instantiate_macro -sd_name ${sd_name} -macro_name {BIBUF} -instance_name {GPIO_13_BIBUF}
sd_connect_pins -sd_name ${sd_name} -pin_names {"GPIO_13_BIBUF:PAD" "P8[13]"}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {GPIO_13_BIBUF:Y}
sd_connect_pins -sd_name ${sd_name} -pin_names {"GPIO_13_BIBUF:D" "PWM_1:PWM_1" }
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {GPIO_13_BIBUF:E} -value {VCC}


sd_instantiate_macro -sd_name ${sd_name} -macro_name {BIBUF} -instance_name {GPIO_15_BIBUF}
sd_connect_pins -sd_name ${sd_name} -pin_names {"GPIO_15_BIBUF:PAD" "P8[15]"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"GPIO_15_BIBUF:Y" "apb_rotary_enc_0:enc3_b" }
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {GPIO_15_BIBUF:D} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {GPIO_15_BIBUF:E} -value {GND}

sd_instantiate_macro -sd_name ${sd_name} -macro_name {BIBUF} -instance_name {GPIO_16_BIBUF}
sd_connect_pins -sd_name ${sd_name} -pin_names {"GPIO_16_BIBUF:PAD" "P8[16]"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"GPIO_16_BIBUF:Y" "apb_rotary_enc_0:enc3_a" }
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {GPIO_16_BIBUF:D} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {GPIO_16_BIBUF:E} -value {GND}


sd_instantiate_macro -sd_name ${sd_name} -macro_name {BIBUF} -instance_name {GPIO_19_BIBUF}
sd_connect_pins -sd_name ${sd_name} -pin_names {"GPIO_19_BIBUF:PAD" "P8[19]"}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {GPIO_19_BIBUF:Y}
sd_connect_pins -sd_name ${sd_name} -pin_names {"GPIO_19_BIBUF:D" "PWM_1:PWM_0" }
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {GPIO_19_BIBUF:E} -value {VCC}


sd_instantiate_macro -sd_name ${sd_name} -macro_name {BIBUF} -instance_name {GPIO_27_BIBUF}
sd_connect_pins -sd_name ${sd_name} -pin_names {"GPIO_27_BIBUF:PAD" "P8[27]"}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {GPIO_27_BIBUF:Y}
sd_connect_pins -sd_name ${sd_name} -pin_names {"GPIO_27_BIBUF:D" "servos_0:servos_out[0]" }
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {GPIO_27_BIBUF:E} -value {VCC}

sd_instantiate_macro -sd_name ${sd_name} -macro_name {BIBUF} -instance_name {GPIO_28_BIBUF}
sd_connect_pins -sd_name ${sd_name} -pin_names {"GPIO_28_BIBUF:PAD" "P8[28]"}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {GPIO_28_BIBUF:Y}
sd_connect_pins -sd_name ${sd_name} -pin_names {"GPIO_28_BIBUF:D" "servos_0:servos_out[1]" }
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {GPIO_28_BIBUF:E} -value {VCC}

sd_instantiate_macro -sd_name ${sd_name} -macro_name {BIBUF} -instance_name {GPIO_29_BIBUF}
sd_connect_pins -sd_name ${sd_name} -pin_names {"GPIO_29_BIBUF:PAD" "P8[29]"}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {GPIO_29_BIBUF:Y}
sd_connect_pins -sd_name ${sd_name} -pin_names {"GPIO_29_BIBUF:D" "servos_0:servos_out[2]" }
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {GPIO_29_BIBUF:E} -value {VCC}

sd_instantiate_macro -sd_name ${sd_name} -macro_name {BIBUF} -instance_name {GPIO_30_BIBUF}
sd_connect_pins -sd_name ${sd_name} -pin_names {"GPIO_30_BIBUF:PAD" "P8[30]"}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {GPIO_30_BIBUF:Y}
sd_connect_pins -sd_name ${sd_name} -pin_names {"GPIO_30_BIBUF:D" "servos_0:servos_out[3]" }
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {GPIO_30_BIBUF:E} -value {VCC}

sd_instantiate_macro -sd_name ${sd_name} -macro_name {BIBUF} -instance_name {GPIO_33_BIBUF}
sd_connect_pins -sd_name ${sd_name} -pin_names {"GPIO_33_BIBUF:PAD" "P8[33]"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"GPIO_33_BIBUF:Y" "apb_rotary_enc_0:enc1_b" }
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {GPIO_33_BIBUF:D} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {GPIO_33_BIBUF:E} -value {GND}

sd_instantiate_macro -sd_name ${sd_name} -macro_name {BIBUF} -instance_name {GPIO_35_BIBUF}
sd_connect_pins -sd_name ${sd_name} -pin_names {"GPIO_35_BIBUF:PAD" "P8[35]"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"GPIO_35_BIBUF:Y" "apb_rotary_enc_0:enc1_a" }
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {GPIO_35_BIBUF:D} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {GPIO_35_BIBUF:E} -value {GND}

sd_instantiate_macro -sd_name ${sd_name} -macro_name {BIBUF} -instance_name {GPIO_39_BIBUF}
sd_connect_pins -sd_name ${sd_name} -pin_names {"GPIO_39_BIBUF:PAD" "P8[39]"}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {GPIO_39_BIBUF:Y}
sd_connect_pins -sd_name ${sd_name} -pin_names {"GPIO_39_BIBUF:D" "servos_0:servos_out[4]" }
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {GPIO_39_BIBUF:E} -value {VCC}

sd_instantiate_macro -sd_name ${sd_name} -macro_name {BIBUF} -instance_name {GPIO_40_BIBUF}
sd_connect_pins -sd_name ${sd_name} -pin_names {"GPIO_40_BIBUF:PAD" "P8[40]"}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {GPIO_40_BIBUF:Y}
sd_connect_pins -sd_name ${sd_name} -pin_names {"GPIO_40_BIBUF:D" "servos_0:servos_out[5]" }
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {GPIO_40_BIBUF:E} -value {VCC}

sd_instantiate_macro -sd_name ${sd_name} -macro_name {BIBUF} -instance_name {GPIO_41_BIBUF}
sd_connect_pins -sd_name ${sd_name} -pin_names {"GPIO_41_BIBUF:PAD" "P8[41]"}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {GPIO_41_BIBUF:Y}
sd_connect_pins -sd_name ${sd_name} -pin_names {"GPIO_41_BIBUF:D" "servos_0:servos_out[6]" }
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {GPIO_41_BIBUF:E} -value {VCC}

sd_instantiate_macro -sd_name ${sd_name} -macro_name {BIBUF} -instance_name {GPIO_42_BIBUF}
sd_connect_pins -sd_name ${sd_name} -pin_names {"GPIO_42_BIBUF:PAD" "P8[42]"}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {GPIO_42_BIBUF:Y}
sd_connect_pins -sd_name ${sd_name} -pin_names {"GPIO_42_BIBUF:D" "servos_0:servos_out[7]" }
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {GPIO_42_BIBUF:E} -value {VCC}

sd_instantiate_macro -sd_name ${sd_name} -macro_name {BIBUF} -instance_name {P9_14_BIBUF}
sd_instantiate_macro -sd_name ${sd_name} -macro_name {BIBUF} -instance_name {P9_16_BIBUF}

# Add bus net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE_DEFAULT_GPIOS:GPIO_IN" "GPIO_IN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE_DEFAULT_GPIOS:GPIO_OE" "GPIO_OE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE_DEFAULT_GPIOS:GPIO_OUT" "GPIO_OUT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"INT[15:0]" "P8_GPIO_UPPER_0:INT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"INT[23:16]" "P9_GPIO_0:INT" }

# Add bus interface net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"APB_BUS_CONVERTER_0:APB_MASTER" "CoreAPB3_CAPE_0:APB3mmaster" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"APB_BUS_CONVERTER_0:APB_SLAVE" "APB_SLAVE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CoreAPB3_CAPE_0:APBmslave0" "servos_0:APB_TARGET" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CoreAPB3_CAPE_0:APBmslave1" "P8_GPIO_UPPER_0:APB_bif" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CoreAPB3_CAPE_0:APBmslave2" "P9_GPIO_0:APB_bif" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CoreAPB3_CAPE_0:APBmslave3" "apb_rotary_enc_0:APB_TARGET" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CoreAPB3_CAPE_0:APBmslave4" "PWM_0:APBslave" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CoreAPB3_CAPE_0:APBmslave5" "PWM_1:APBslave" }

sd_connect_pins -sd_name ${sd_name} -pin_names {"P9_14_BIBUF:PAD" "P9_14"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9_14_BIBUF:D" "PWM_1:PWM_0"}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {P9_14_BIBUF:Y}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {P9_14_BIBUF:E} -value {VCC}

sd_connect_pins -sd_name ${sd_name} -pin_names {"P9_16_BIBUF:PAD" "P9_16"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9_16_BIBUF:D" "PWM_1:PWM_1"}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {P9_16_BIBUF:Y}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {P9_16_BIBUF:E} -value {VCC}

# Re-enable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 1
# Save the SmartDesign 
save_smartdesign -sd_name ${sd_name}
# Generate SmartDesign "CAPE"
generate_component -component_name ${sd_name}
