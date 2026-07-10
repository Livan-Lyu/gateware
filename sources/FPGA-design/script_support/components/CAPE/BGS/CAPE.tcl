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
sd_create_pin_slices -sd_name ${sd_name} -pin_name {INT} -pin_slices {[37:37]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {INT} -pin_slices {[39:38]}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {INT[39:38]} -value {GND}

# BGS: create dedicated CoreAPB3_CAPE_BGS with slot 3 enabled
create_and_configure_core -download_core -core_vlnv {Actel:DirectCore:CoreAPB3:*} -component_name {CoreAPB3_CAPE_BGS} -params {\
"APB_DWIDTH:32"  \
"APBSLOT0ENABLE:true"  \
"APBSLOT1ENABLE:true"  \
"APBSLOT2ENABLE:true"  \
"APBSLOT3ENABLE:true"  \
"APBSLOT4ENABLE:true"  \
"APBSLOT5ENABLE:true"  \
"APBSLOT6ENABLE:false"  \
"APBSLOT7ENABLE:false"  \
"APBSLOT8ENABLE:false"  \
"APBSLOT9ENABLE:false"  \
"APBSLOT10ENABLE:false"  \
"APBSLOT11ENABLE:false"  \
"APBSLOT12ENABLE:false"  \
"APBSLOT13ENABLE:false"  \
"APBSLOT14ENABLE:false"  \
"APBSLOT15ENABLE:false"  \
"IADDR_OPTION:0"  \
"MADDR_BITS:24"  \
"SC_0:false"  \
"SC_1:false"  \
"SC_2:false"  \
"SC_3:false"  \
"SC_4:false"  \
"SC_5:false"  \
"SC_6:false"  \
"SC_7:false"  \
"SC_8:false"  \
"SC_9:false"  \
"SC_10:false"  \
"SC_11:false"  \
"SC_12:false"  \
"SC_13:false"  \
"SC_14:false"  \
"SC_15:false"  \
"UPR_NIBBLE_POSN:5"   }

# Add APB_BUS_CONVERTER_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {APB_BUS_CONVERTER} -instance_name {APB_BUS_CONVERTER_0}



# Add CAPE_DEFAULT_GPIOS instance
sd_instantiate_component -sd_name ${sd_name} -component_name {CAPE_DEFAULT_GPIOS} -instance_name {CAPE_DEFAULT_GPIOS}



# Add CoreAPB3_CAPE_BGS_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {CoreAPB3_CAPE_BGS} -instance_name {CoreAPB3_CAPE_BGS_0}



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

# BGS: cape_regs wrapper (apb_ctrl_status + pixel_proc, CoreAPB3 slot 3)
create_hdl_core -file $project_dir/hdl/cape_regs.v -module {cape_regs} -library {work} -package {}
# APB slave BIF
hdl_core_add_bif -hdl_core_name {cape_regs} -bif_definition {APB:AMBA:AMBA2:slave} -bif_name {APB_BIF} -signal_map {}
hdl_core_assign_bif_signal -hdl_core_name {cape_regs} -bif_name {APB_BIF} -bif_signal_name {PADDR}   -core_signal_name {paddr}
hdl_core_assign_bif_signal -hdl_core_name {cape_regs} -bif_name {APB_BIF} -bif_signal_name {PSELx}   -core_signal_name {psel}
hdl_core_assign_bif_signal -hdl_core_name {cape_regs} -bif_name {APB_BIF} -bif_signal_name {PENABLE} -core_signal_name {penable}
hdl_core_assign_bif_signal -hdl_core_name {cape_regs} -bif_name {APB_BIF} -bif_signal_name {PWRITE}  -core_signal_name {pwrite}
hdl_core_assign_bif_signal -hdl_core_name {cape_regs} -bif_name {APB_BIF} -bif_signal_name {PRDATA}  -core_signal_name {prdata}
hdl_core_assign_bif_signal -hdl_core_name {cape_regs} -bif_name {APB_BIF} -bif_signal_name {PWDATA}  -core_signal_name {pwdata}
hdl_core_rename_bif -hdl_core_name {cape_regs} -current_bif_name {APB_BIF} -new_bif_name {APBslave}
# AXI4 master BIF (pixel_proc DMA)
hdl_core_add_bif -hdl_core_name {cape_regs} -bif_definition {AXI4:AMBA:AMBA4:master} -bif_name {AXI_BIF} -signal_map {}
hdl_core_rename_bif -hdl_core_name {cape_regs} -current_bif_name {AXI_BIF} -new_bif_name {AXI4_INITIATOR}
sd_instantiate_hdl_core -sd_name ${sd_name} -hdl_core_name {cape_regs} -instance_name {cape_regs_0}

# BGS: AXI4 crossbar for pixel_proc DMA
sd_create_scalar_port -sd_name ${sd_name} -port_name {AXI_ACLK} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {AXI_ARESETN} -port_direction {IN}
sd_create_bus_port -sd_name ${sd_name} -port_name {ms_araddr} -port_direction {OUT} -port_range {[37:0]}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ms_arvalid} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ms_arready} -port_direction {IN}
sd_create_bus_port -sd_name ${sd_name} -port_name {ms_rdata} -port_direction {IN} -port_range {[63:0]}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ms_rvalid} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ms_rready} -port_direction {OUT}
sd_create_bus_port -sd_name ${sd_name} -port_name {ms_rresp} -port_direction {IN} -port_range {[1:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {ms_awaddr} -port_direction {OUT} -port_range {[37:0]}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ms_awvalid} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ms_awready} -port_direction {IN}
sd_create_bus_port -sd_name ${sd_name} -port_name {ms_wdata} -port_direction {OUT} -port_range {[63:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {ms_wstrb} -port_direction {OUT} -port_range {[7:0]}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ms_wvalid} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ms_wready} -port_direction {IN}
sd_create_bus_port -sd_name ${sd_name} -port_name {ms_bresp} -port_direction {IN} -port_range {[1:0]}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ms_bvalid} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ms_bready} -port_direction {OUT}
sd_create_bus_port -sd_name ${sd_name} -port_name {ms_arid} -port_direction {IN} -port_range {[3:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {ms_rid} -port_direction {OUT} -port_range {[3:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {ms_awid} -port_direction {IN} -port_range {[3:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {ms_bid} -port_direction {OUT} -port_range {[3:0]}
sd_create_bif_port -sd_name ${sd_name} -port_name {AXI4mtarget0}     -port_bif_vlnv {AMBA:AMBA4:AXI4:r0p0} -port_bif_role {mirroredSlave} -port_bif_mapping {"ACLK:AXI_ACLK" "ARESETN:AXI_ARESETN" "ARADDR:ms_araddr" "ARVALID:ms_arvalid" "ARREADY:ms_arready" "RDATA:ms_rdata"   "RVALID:ms_rvalid"   "RREADY:ms_rready"   "RRESP:ms_rresp" "AWADDR:ms_awaddr" "AWVALID:ms_awvalid" "AWREADY:ms_awready" "WDATA:ms_wdata"   "WSTRB:ms_wstrb"     "WVALID:ms_wvalid"   "WREADY:ms_wready" "BRESP:ms_bresp"   "BVALID:ms_bvalid"   "BREADY:ms_bready" "ARID:ms_arid" "RID:ms_rid" "AWID:ms_awid" "BID:ms_bid" }
create_and_configure_core -core_vlnv {Actel:DirectCore:COREAXI4INTERCONNECT:*}     -component_name {CAPE_AXI_XBAR} -params {
    "NUM_INITIATORS:1" "NUM_TARGETS:1"
    "ADDR_WIDTH:38" "DATA_WIDTH:64" "ID_WIDTH:4"
    "INITIATOR0_DATA_WIDTH:64" "TARGET0_DATA_WIDTH:64"
    "INITIATOR0_ADDR_WIDTH:38" "TARGET0_ADDR_WIDTH:38"
    "INITIATOR0_ID_WIDTH:4" "TARGET0_ID_WIDTH:4"
    "INITIATOR0_READ_ACCEPTANCE:8" "TARGET0_READ_ACCEPTANCE:8"
    "INITIATOR0_WRITE_ACCEPTANCE:8" "TARGET0_WRITE_ACCEPTANCE:8"
    "ADVANCED:0" "AREG:1" "RREG:1"
    "TARGET0_ADDR_RANGE_START:0x80000000" "TARGET0_ADDR_RANGE_END:0xDFFFFFFF"
}
sd_instantiate_component -sd_name ${sd_name} -component_name {CAPE_AXI_XBAR} -instance_name {XBAR_0}


# Add scalar net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE_DEFAULT_GPIOS:GPIO_0_PAD" "P8[3]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE_DEFAULT_GPIOS:GPIO_11_PAD" "P8[14]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE_DEFAULT_GPIOS:GPIO_12_PAD" "P8[15]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE_DEFAULT_GPIOS:GPIO_13_PAD" "P8[16]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE_DEFAULT_GPIOS:GPIO_14_PAD" "P8[17]" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE_DEFAULT_GPIOS:GPIO_15_PAD" "P8[18]" }
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
sd_connect_pins -sd_name ${sd_name} -pin_names {"P8_GPIO_UPPER_0:PCLK" "P9_GPIO_0:PCLK" "PCLK" "PWM_0:PCLK" "PWM_1:PCLK" "PWM_2:PCLK" "cape_regs_0:pclk" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"P8_GPIO_UPPER_0:PRESETN" "P9_GPIO_0:PRESETN" "PRESETN" "PWM_0:PRESETN" "PWM_1:PRESETN" "PWM_2:PRESETN" "cape_regs_0:presetn" }
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
sd_connect_pins -sd_name ${sd_name} -pin_names {"APB_BUS_CONVERTER_0:APB_MASTER" "CoreAPB3_CAPE_BGS_0:APB3mmaster" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"APB_BUS_CONVERTER_0:APB_SLAVE" "APB_SLAVE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CoreAPB3_CAPE_BGS_0:APBmslave0" "PWM_0:APBslave" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CoreAPB3_CAPE_BGS_0:APBmslave1" "P8_GPIO_UPPER_0:APB_bif" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CoreAPB3_CAPE_BGS_0:APBmslave2" "P9_GPIO_0:APB_bif" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CoreAPB3_CAPE_BGS_0:APBmslave4" "PWM_1:APBslave" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CoreAPB3_CAPE_BGS_0:APBmslave5" "PWM_2:APBslave" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CoreAPB3_CAPE_BGS_0:APBmslave3" "cape_regs_0:APBslave" }

# BGS: AXI clock/reset connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"AXI_ACLK" "XBAR_0:ACLK" "cape_regs_0:ACLK"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"AXI_ARESETN" "XBAR_0:ARESETN" "cape_regs_0:ARESETN"}

# BGS: AXI4 initiator -> crossbar
sd_connect_pins -sd_name ${sd_name} -pin_names {"cape_regs_0:AXI4_INITIATOR" "XBAR_0:AXI4minitiator0"}

# BGS: XBAR target -> AXI4mtarget0 BIF export
sd_connect_pins -sd_name ${sd_name} -pin_names {"XBAR_0:AXI4mtarget0" "AXI4mtarget0"}

# Add GPIO BIBUFs
sd_instantiate_macro -sd_name ${sd_name} -macro_name {BIBUF} -instance_name {GPIO_13_BIBUF}
sd_instantiate_macro -sd_name ${sd_name} -macro_name {BIBUF} -instance_name {GPIO_19_BIBUF}
sd_instantiate_macro -sd_name ${sd_name} -macro_name {BIBUF} -instance_name {P9_14_BIBUF}
sd_instantiate_macro -sd_name ${sd_name} -macro_name {BIBUF} -instance_name {P9_16_BIBUF}

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

# BGS: connect cape_regs irq and tie off unused ports
sd_connect_pins -sd_name ${sd_name} -pin_names {"INT[37]" "cape_regs_0:irq"}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {cape_regs_0:control}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {cape_regs_0:status} -value {GND}

# Re-enable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 1
# Save the SmartDesign 
save_smartdesign -sd_name ${sd_name}
# Generate SmartDesign "CAPE"
generate_component -component_name ${sd_name}
