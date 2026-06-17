# Creating SmartDesign "CAPE"
set sd_name {CAPE}
create_smartdesign -sd_name ${sd_name}
auto_promote_pad_pins -promote_all 0

# ===============================================================================
# Top level scalar/bus Ports
# ===============================================================================
sd_create_scalar_port -sd_name ${sd_name} -port_name {PCLK} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {PRESETN} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {AXI_ACLK} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {AXI_ARESETN} -port_direction {IN}
sd_create_bus_port -sd_name ${sd_name} -port_name {GPIO_OE} -port_direction {IN} -port_range {[27:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {GPIO_OUT} -port_direction {IN} -port_range {[27:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {GPIO_IN} -port_direction {OUT} -port_range {[27:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {INT} -port_direction {OUT} -port_range {[23:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {P8} -port_direction {INOUT} -port_range {[46:3]}
foreach p {11 12 13 14 15 16 17 18 21 22 23 24 25 26 27 28 29 30 31 41 42} {
    sd_create_scalar_port -sd_name ${sd_name} -port_name "P9_${p}" -port_direction {INOUT}
}

# ===============================================================================
# AXI signal ports — must exist before BIF can use them
# ===============================================================================
sd_create_bus_port -sd_name ${sd_name} -port_name {ax_araddr} -port_direction {OUT} -port_range {[31:0]}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ax_arvalid} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ax_arready} -port_direction {IN}
sd_create_bus_port -sd_name ${sd_name} -port_name {ax_rdata} -port_direction {IN} -port_range {[31:0]}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ax_rvalid} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ax_rready} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ax_rresp} -port_direction {IN}

# ===============================================================================
# AXI4 master BIF — maps to the ports just created above
# ===============================================================================
sd_create_bif_port -sd_name ${sd_name} -port_name {AXI4_INITIATOR} -port_bif_vlnv {AMBA:AMBA4:AXI4:r0p0} -port_bif_role {mirroredMaster} -port_bif_mapping {\
"ACLK:AXI_ACLK" \
"ARESETN:AXI_ARESETN" \
"ARADDR:ax_araddr" \
"ARVALID:ax_arvalid" \
"ARREADY:ax_arready" \
"RDATA:ax_rdata" \
"RVALID:ax_rvalid" \
"RREADY:ax_rready" \
"RRESP:ax_rresp" }

# ===============================================================================
# Instantiate Verilog CAPE core
# ===============================================================================
sd_instantiate_hdl_core -sd_name ${sd_name} -hdl_core_name {CAPE} -instance_name {CAPE_INST}

# ===============================================================================
# Connect scalar/bus ports to CAPE_INST
# ===============================================================================
sd_connect_pins -sd_name ${sd_name} -pin_names {PCLK CAPE_INST:PCLK}
sd_connect_pins -sd_name ${sd_name} -pin_names {PRESETN CAPE_INST:PRESETN}
sd_connect_pins -sd_name ${sd_name} -pin_names {AXI_ACLK CAPE_INST:ACLK}
sd_connect_pins -sd_name ${sd_name} -pin_names {AXI_ARESETN CAPE_INST:ARESETN}
sd_connect_pins -sd_name ${sd_name} -pin_names {GPIO_OE CAPE_INST:GPIO_OE}
sd_connect_pins -sd_name ${sd_name} -pin_names {GPIO_OUT CAPE_INST:GPIO_OUT}
sd_connect_pins -sd_name ${sd_name} -pin_names {GPIO_IN CAPE_INST:GPIO_IN}
sd_connect_pins -sd_name ${sd_name} -pin_names {INT CAPE_INST:INT}
sd_connect_pins -sd_name ${sd_name} -pin_names {P8 CAPE_INST:P8}
foreach p {11 12 13 14 15 16 17 18 21 22 23 24 25 26 27 28 29 30 31 41 42} {
    sd_connect_pins -sd_name ${sd_name} -pin_names "P9_${p} CAPE_INST:P9_${p}"
}

# ===============================================================================
# APB: promote CAPE_INST's existing APB_TARGET BIF to SmartDesign port
# ===============================================================================
sd_connect_pin_to_port -sd_name ${sd_name} -pin_name {CAPE_INST:APB_TARGET} -port_name {APB_TARGET}

# ===============================================================================
# AXI: connect SmartDesign AXI BIF signals → CAPE_INST raw AXI ports
# ===============================================================================
sd_connect_pins -sd_name ${sd_name} -pin_names {ax_araddr  CAPE_INST:M_AXI_ARADDR}
sd_connect_pins -sd_name ${sd_name} -pin_names {ax_arvalid CAPE_INST:M_AXI_ARVALID}
sd_connect_pins -sd_name ${sd_name} -pin_names {ax_arready CAPE_INST:M_AXI_ARREADY}
sd_connect_pins -sd_name ${sd_name} -pin_names {ax_rdata   CAPE_INST:M_AXI_RDATA}
sd_connect_pins -sd_name ${sd_name} -pin_names {ax_rvalid  CAPE_INST:M_AXI_RVALID}
sd_connect_pins -sd_name ${sd_name} -pin_names {ax_rready  CAPE_INST:M_AXI_RREADY}
sd_connect_pins -sd_name ${sd_name} -pin_names {ax_rresp   CAPE_INST:M_AXI_RRESP}

auto_promote_pad_pins -promote_all 1
save_smartdesign -sd_name ${sd_name}
generate_component -component_name ${sd_name}
