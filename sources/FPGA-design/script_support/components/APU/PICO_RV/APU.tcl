# Creating SmartDesign "APU"
set sd_name {APU}
create_smartdesign -sd_name ${sd_name}

# Disable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 0

# Create top level Scalar Ports
sd_create_scalar_port -sd_name ${sd_name} -port_name {ACLK} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {APB_SLAVE_PENABLE} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {APB_SLAVE_PSEL} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {APB_SLAVE_PWRITE} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ARESETN} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {AXI4mmaster0_MASTER0_ARVALID} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {AXI4mmaster0_MASTER0_AWVALID} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {AXI4mmaster0_MASTER0_BREADY} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {AXI4mmaster0_MASTER0_RREADY} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {AXI4mmaster0_MASTER0_WLAST} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {AXI4mmaster0_MASTER0_WVALID} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {PCLK} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {PRESETN} -port_direction {IN}

sd_create_scalar_port -sd_name ${sd_name} -port_name {APB_SLAVE_PREADY} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {APB_SLAVE_PSLVERR} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {AXI4mmaster0_MASTER0_ARREADY} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {AXI4mmaster0_MASTER0_AWREADY} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {AXI4mmaster0_MASTER0_BVALID} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {AXI4mmaster0_MASTER0_RLAST} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {AXI4mmaster0_MASTER0_RVALID} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {AXI4mmaster0_MASTER0_WREADY} -port_direction {OUT}

# Create top level Bus Ports
sd_create_bus_port -sd_name ${sd_name} -port_name {APB_SLAVE_PADDR} -port_direction {IN} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {APB_SLAVE_PWDATA} -port_direction {IN} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {AXI4mmaster0_MASTER0_ARADDR} -port_direction {IN} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {AXI4mmaster0_MASTER0_ARBURST} -port_direction {IN} -port_range {[1:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {AXI4mmaster0_MASTER0_ARCACHE} -port_direction {IN} -port_range {[3:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {AXI4mmaster0_MASTER0_ARID} -port_direction {IN} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {AXI4mmaster0_MASTER0_ARLEN} -port_direction {IN} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {AXI4mmaster0_MASTER0_ARLOCK} -port_direction {IN} -port_range {[1:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {AXI4mmaster0_MASTER0_ARPROT} -port_direction {IN} -port_range {[2:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {AXI4mmaster0_MASTER0_ARQOS} -port_direction {IN} -port_range {[3:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {AXI4mmaster0_MASTER0_ARREGION} -port_direction {IN} -port_range {[3:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {AXI4mmaster0_MASTER0_ARSIZE} -port_direction {IN} -port_range {[2:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {AXI4mmaster0_MASTER0_ARUSER} -port_direction {IN} -port_range {[0:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {AXI4mmaster0_MASTER0_AWADDR} -port_direction {IN} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {AXI4mmaster0_MASTER0_AWBURST} -port_direction {IN} -port_range {[1:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {AXI4mmaster0_MASTER0_AWCACHE} -port_direction {IN} -port_range {[3:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {AXI4mmaster0_MASTER0_AWID} -port_direction {IN} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {AXI4mmaster0_MASTER0_AWLEN} -port_direction {IN} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {AXI4mmaster0_MASTER0_AWLOCK} -port_direction {IN} -port_range {[1:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {AXI4mmaster0_MASTER0_AWPROT} -port_direction {IN} -port_range {[2:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {AXI4mmaster0_MASTER0_AWQOS} -port_direction {IN} -port_range {[3:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {AXI4mmaster0_MASTER0_AWREGION} -port_direction {IN} -port_range {[3:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {AXI4mmaster0_MASTER0_AWSIZE} -port_direction {IN} -port_range {[2:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {AXI4mmaster0_MASTER0_AWUSER} -port_direction {IN} -port_range {[0:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {AXI4mmaster0_MASTER0_WDATA} -port_direction {IN} -port_range {[63:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {AXI4mmaster0_MASTER0_WSTRB} -port_direction {IN} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {AXI4mmaster0_MASTER0_WUSER} -port_direction {IN} -port_range {[0:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {BVF_GPIO_OE} -port_direction {IN} -port_range {[27:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {BVF_GPIO_OUT} -port_direction {IN} -port_range {[27:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {CAPE_GPIO_IN} -port_direction {IN} -port_range {[27:0]}

sd_create_bus_port -sd_name ${sd_name} -port_name {APB_SLAVE_PRDATA} -port_direction {OUT} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {AXI4mmaster0_MASTER0_BID} -port_direction {OUT} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {AXI4mmaster0_MASTER0_BRESP} -port_direction {OUT} -port_range {[1:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {AXI4mmaster0_MASTER0_BUSER} -port_direction {OUT} -port_range {[0:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {AXI4mmaster0_MASTER0_RDATA} -port_direction {OUT} -port_range {[63:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {AXI4mmaster0_MASTER0_RID} -port_direction {OUT} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {AXI4mmaster0_MASTER0_RRESP} -port_direction {OUT} -port_range {[1:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {AXI4mmaster0_MASTER0_RUSER} -port_direction {OUT} -port_range {[0:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {BVF_GPIO_IN} -port_direction {OUT} -port_range {[27:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {CAPE_GPIO_OE} -port_direction {OUT} -port_range {[27:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {CAPE_GPIO_OUT} -port_direction {OUT} -port_range {[27:0]}

# Create top level Bus interface Ports
sd_create_bif_port -sd_name ${sd_name} -port_name {AXI4mmaster0} -port_bif_vlnv {AMBA:AMBA4:AXI4:r0p0_0} -port_bif_role {mirroredMaster} -port_bif_mapping {\
"AWID:AXI4mmaster0_MASTER0_AWID" \
"AWADDR:AXI4mmaster0_MASTER0_AWADDR" \
"AWLEN:AXI4mmaster0_MASTER0_AWLEN" \
"AWSIZE:AXI4mmaster0_MASTER0_AWSIZE" \
"AWBURST:AXI4mmaster0_MASTER0_AWBURST" \
"AWLOCK:AXI4mmaster0_MASTER0_AWLOCK" \
"AWCACHE:AXI4mmaster0_MASTER0_AWCACHE" \
"AWPROT:AXI4mmaster0_MASTER0_AWPROT" \
"AWQOS:AXI4mmaster0_MASTER0_AWQOS" \
"AWREGION:AXI4mmaster0_MASTER0_AWREGION" \
"AWVALID:AXI4mmaster0_MASTER0_AWVALID" \
"AWREADY:AXI4mmaster0_MASTER0_AWREADY" \
"WDATA:AXI4mmaster0_MASTER0_WDATA" \
"WSTRB:AXI4mmaster0_MASTER0_WSTRB" \
"WLAST:AXI4mmaster0_MASTER0_WLAST" \
"WVALID:AXI4mmaster0_MASTER0_WVALID" \
"WREADY:AXI4mmaster0_MASTER0_WREADY" \
"BID:AXI4mmaster0_MASTER0_BID" \
"BRESP:AXI4mmaster0_MASTER0_BRESP" \
"BVALID:AXI4mmaster0_MASTER0_BVALID" \
"BREADY:AXI4mmaster0_MASTER0_BREADY" \
"ARID:AXI4mmaster0_MASTER0_ARID" \
"ARADDR:AXI4mmaster0_MASTER0_ARADDR" \
"ARLEN:AXI4mmaster0_MASTER0_ARLEN" \
"ARSIZE:AXI4mmaster0_MASTER0_ARSIZE" \
"ARBURST:AXI4mmaster0_MASTER0_ARBURST" \
"ARLOCK:AXI4mmaster0_MASTER0_ARLOCK" \
"ARCACHE:AXI4mmaster0_MASTER0_ARCACHE" \
"ARPROT:AXI4mmaster0_MASTER0_ARPROT" \
"ARQOS:AXI4mmaster0_MASTER0_ARQOS" \
"ARREGION:AXI4mmaster0_MASTER0_ARREGION" \
"ARVALID:AXI4mmaster0_MASTER0_ARVALID" \
"ARREADY:AXI4mmaster0_MASTER0_ARREADY" \
"RID:AXI4mmaster0_MASTER0_RID" \
"RDATA:AXI4mmaster0_MASTER0_RDATA" \
"RRESP:AXI4mmaster0_MASTER0_RRESP" \
"RLAST:AXI4mmaster0_MASTER0_RLAST" \
"RVALID:AXI4mmaster0_MASTER0_RVALID" \
"RREADY:AXI4mmaster0_MASTER0_RREADY" \
"AWUSER:AXI4mmaster0_MASTER0_AWUSER" \
"WUSER:AXI4mmaster0_MASTER0_WUSER" \
"BUSER:AXI4mmaster0_MASTER0_BUSER" \
"ARUSER:AXI4mmaster0_MASTER0_ARUSER" \
"RUSER:AXI4mmaster0_MASTER0_RUSER" } 

sd_create_bif_port -sd_name ${sd_name} -port_name {APB_SLAVE} -port_bif_vlnv {AMBA:AMBA2:APB:r0p0} -port_bif_role {slave} -port_bif_mapping {\
"PADDR:APB_SLAVE_PADDR" \
"PSELx:APB_SLAVE_PSEL" \
"PENABLE:APB_SLAVE_PENABLE" \
"PWRITE:APB_SLAVE_PWRITE" \
"PRDATA:APB_SLAVE_PRDATA" \
"PWDATA:APB_SLAVE_PWDATA" \
"PREADY:APB_SLAVE_PREADY" \
"PSLVERR:APB_SLAVE_PSLVERR" } 

# Add COREAXI4INTERCONNECT_C0_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {COREAXI4INTERCONNECT_C0} -instance_name {COREAXI4INTERCONNECT_C0_0}

# Add PROGRAM_MEMORY instance
sd_instantiate_component -sd_name ${sd_name} -component_name {PF_SRAM_AHBL_AXI_C0} -instance_name {PROGRAM_MEMORY}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {PROGRAM_MEMORY:B_WEN} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {PROGRAM_MEMORY:B_BLK_EN} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {PROGRAM_MEMORY:B_WBYTE_EN} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {PROGRAM_MEMORY:B_DIN} -value {GND}

# Add APU_0 instance
sd_instantiate_hdl_core -sd_name ${sd_name} -hdl_core_name {PICO_RV} -instance_name {APU_0}

# Add scalar net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"ACLK" "COREAXI4INTERCONNECT_C0_0:ACLK" "PROGRAM_MEMORY:ACLK" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ARESETN" "COREAXI4INTERCONNECT_C0_0:ARESETN" "PROGRAM_MEMORY:ARESETN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PCLK" "PROGRAM_MEMORY:B_CLK" "APU_0:CLK" "APU_0:pclk" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PRESETN" "APU_0:RESETN" "APU_0:presetn" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PROGRAM_MEMORY:B_REN" "APU_0:LSRAM_REN" }

# Add bus net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"BVF_GPIO_IN" "APU_0:BVF_GPIO_IN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"BVF_GPIO_OE" "APU_0:BVF_GPIO_OE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"BVF_GPIO_OUT" "APU_0:BVF_GPIO_OUT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE_GPIO_IN" "APU_0:CAPE_GPIO_IN" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE_GPIO_OE" "APU_0:CAPE_GPIO_OE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE_GPIO_OUT" "APU_0:CAPE_GPIO_OUT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PROGRAM_MEMORY:B_ADDR" "APU_0:LSRAM_ADDR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PROGRAM_MEMORY:B_DOUT" "APU_0:LSRAM_DATA" }

# Add bus interface net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"APB_SLAVE" "APU_0:APB_TARGET" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AXI4mmaster0" "COREAXI4INTERCONNECT_C0_0:AXI4mmaster0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"COREAXI4INTERCONNECT_C0_0:AXI4mslave0" "PROGRAM_MEMORY:AXI4_Slave" }

# Re-enable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 1
# Save the SmartDesign 
save_smartdesign -sd_name ${sd_name}
# Generate SmartDesign "APU"
generate_component -component_name ${sd_name}
