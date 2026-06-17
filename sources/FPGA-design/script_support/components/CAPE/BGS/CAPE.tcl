# Creating SmartDesign "CAPE"
set sd_name {CAPE}
create_smartdesign -sd_name ${sd_name}
auto_promote_pad_pins -promote_all 0

# ===============================================================================
# Top-level ports on CAPE SmartDesign
# ===============================================================================
# APB slave
sd_create_bif_port -sd_name ${sd_name} -port_name {APB_SLAVE} \
    -port_bif_vlnv {AMBA:AMBA2:APB:r0p0} -port_bif_role {slave} -port_bif_mapping {
    "PADDR:APB_SLAVE_SLAVE_PADDR"
    "PSELx:APB_SLAVE_SLAVE_PSEL"
    "PENABLE:APB_SLAVE_SLAVE_PENABLE"
    "PWRITE:APB_SLAVE_SLAVE_PWRITE"
    "PRDATA:APB_SLAVE_SLAVE_PRDATA"
    "PWDATA:APB_SLAVE_SLAVE_PWDATA"
    "PREADY:APB_SLAVE_SLAVE_PREADY"
    "PSLVERR:APB_SLAVE_SLAVE_PSLVERR"}

# AXI4 master (fabric reads DDR)
sd_create_bif_port -sd_name ${sd_name} -port_name {AXI4_INITIATOR} \
    -port_bif_vlnv {AMBA:AMBA4:AXI4:r0p0} -port_bif_role {mirroredMaster} \
    -port_bif_mapping {
    "ACLK:AXI_ACLK"
    "ARESETN:AXI_ARESETN"
    "ARADDR:AXI_ARADDR"
    "ARVALID:AXI_ARVALID"
    "ARREADY:AXI_ARREADY"
    "RDATA:AXI_RDATA"
    "RVALID:AXI_RVALID"
    "RREADY:AXI_RREADY"
    "RRESP:AXI_RRESP"}

# GPIO / INT / clock
sd_create_scalar_port -sd_name ${sd_name} -port_name {PCLK} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {PRESETN} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {AXI_ACLK} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {AXI_ARESETN} -port_direction {IN}
sd_create_bus_port -sd_name ${sd_name} -port_name {GPIO_OE} -port_direction {IN} -port_range {[27:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {GPIO_OUT} -port_direction {IN} -port_range {[27:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {GPIO_IN} -port_direction {OUT} -port_range {[27:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {INT} -port_direction {OUT} -port_range {[23:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {P8} -port_direction {INOUT} -port_range {[46:3]}
sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_11} -port_direction {INOUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_12} -port_direction {INOUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_13} -port_direction {INOUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_14} -port_direction {INOUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_15} -port_direction {INOUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_16} -port_direction {INOUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_17} -port_direction {INOUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_18} -port_direction {INOUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_21} -port_direction {INOUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_22} -port_direction {INOUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_23} -port_direction {INOUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_24} -port_direction {INOUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_25} -port_direction {INOUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_26} -port_direction {INOUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_27} -port_direction {INOUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_28} -port_direction {INOUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_29} -port_direction {INOUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_30} -port_direction {INOUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_31} -port_direction {INOUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_41} -port_direction {INOUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {P9_42} -port_direction {INOUT}

# ===============================================================================
# Instantiate Verilog CAPE core
# ===============================================================================
sd_instantiate_hdl_core -sd_name ${sd_name} -hdl_core_name {CAPE} -instance_name {CAPE_INST}

# ===============================================================================
# Internal connections: CAPE SmartDesign ports → CAPE_INST Verilog ports
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
sd_connect_pins -sd_name ${sd_name} -pin_names {P9_11 CAPE_INST:P9_11}
sd_connect_pins -sd_name ${sd_name} -pin_names {P9_12 CAPE_INST:P9_12}
sd_connect_pins -sd_name ${sd_name} -pin_names {P9_13 CAPE_INST:P9_13}
sd_connect_pins -sd_name ${sd_name} -pin_names {P9_14 CAPE_INST:P9_14}
sd_connect_pins -sd_name ${sd_name} -pin_names {P9_15 CAPE_INST:P9_15}
sd_connect_pins -sd_name ${sd_name} -pin_names {P9_16 CAPE_INST:P9_16}
sd_connect_pins -sd_name ${sd_name} -pin_names {P9_17 CAPE_INST:P9_17}
sd_connect_pins -sd_name ${sd_name} -pin_names {P9_18 CAPE_INST:P9_18}
sd_connect_pins -sd_name ${sd_name} -pin_names {P9_21 CAPE_INST:P9_21}
sd_connect_pins -sd_name ${sd_name} -pin_names {P9_22 CAPE_INST:P9_22}
sd_connect_pins -sd_name ${sd_name} -pin_names {P9_23 CAPE_INST:P9_23}
sd_connect_pins -sd_name ${sd_name} -pin_names {P9_24 CAPE_INST:P9_24}
sd_connect_pins -sd_name ${sd_name} -pin_names {P9_25 CAPE_INST:P9_25}
sd_connect_pins -sd_name ${sd_name} -pin_names {P9_26 CAPE_INST:P9_26}
sd_connect_pins -sd_name ${sd_name} -pin_names {P9_27 CAPE_INST:P9_27}
sd_connect_pins -sd_name ${sd_name} -pin_names {P9_28 CAPE_INST:P9_28}
sd_connect_pins -sd_name ${sd_name} -pin_names {P9_29 CAPE_INST:P9_29}
sd_connect_pins -sd_name ${sd_name} -pin_names {P9_30 CAPE_INST:P9_30}
sd_connect_pins -sd_name ${sd_name} -pin_names {P9_31 CAPE_INST:P9_31}
sd_connect_pins -sd_name ${sd_name} -pin_names {P9_41 CAPE_INST:P9_41}
sd_connect_pins -sd_name ${sd_name} -pin_names {P9_42 CAPE_INST:P9_42}

# APB BIF
sd_connect_pins -sd_name ${sd_name} -pin_names {APB_SLAVE CAPE_INST:APB_TARGET}

# AXI BIF: SmartDesign port → CAPE_INST raw AXI ports
sd_connect_pins -sd_name ${sd_name} -pin_names {AXI_ARADDR  CAPE_INST:M_AXI_ARADDR}
sd_connect_pins -sd_name ${sd_name} -pin_names {AXI_ARVALID CAPE_INST:M_AXI_ARVALID}
sd_connect_pins -sd_name ${sd_name} -pin_names {AXI_ARREADY CAPE_INST:M_AXI_ARREADY}
sd_connect_pins -sd_name ${sd_name} -pin_names {AXI_RDATA   CAPE_INST:M_AXI_RDATA}
sd_connect_pins -sd_name ${sd_name} -pin_names {AXI_RVALID  CAPE_INST:M_AXI_RVALID}
sd_connect_pins -sd_name ${sd_name} -pin_names {AXI_RREADY  CAPE_INST:M_AXI_RREADY}
sd_connect_pins -sd_name ${sd_name} -pin_names {AXI_RRESP   CAPE_INST:M_AXI_RRESP}

auto_promote_pad_pins -promote_all 1
save_smartdesign -sd_name ${sd_name}
generate_component -component_name ${sd_name}
