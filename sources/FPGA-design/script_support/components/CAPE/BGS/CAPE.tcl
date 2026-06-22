# CAPE_TOP SmartDesign — wraps CAPE.v + COREAXI4INTERCONNECT (SMARTHLS pattern)
set sd_name {CAPE_TOP}
create_smartdesign -sd_name ${sd_name}
auto_promote_pad_pins -promote_all 0

# ===============================================================================
# Raw scalar / bus ports
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
# APB raw ports (for BIF mapping)
sd_create_bus_port -sd_name ${sd_name} -port_name {apb_paddr} -port_direction {IN} -port_range {[31:0]}
sd_create_scalar_port -sd_name ${sd_name} -port_name {apb_psel} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {apb_penable} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {apb_pwrite} -port_direction {IN}
sd_create_bus_port -sd_name ${sd_name} -port_name {apb_pwdata} -port_direction {IN} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {apb_prdata} -port_direction {OUT} -port_range {[31:0]}
sd_create_scalar_port -sd_name ${sd_name} -port_name {apb_pready} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {apb_pslverr} -port_direction {OUT}

# ===============================================================================
# BIF Ports
# ===============================================================================
# APB slave (from MSS CAPE_APB_MTARGET)
sd_create_bif_port -sd_name ${sd_name} -port_name {APB_SLAVE} \
    -port_bif_vlnv {AMBA:AMBA2:APB:r0p0} -port_bif_role {slave} -port_bif_mapping {\
"PADDR:apb_paddr" "PSELx:apb_psel" "PENABLE:apb_penable" \
"PWRITE:apb_pwrite" "PRDATA:apb_prdata" "PWDATA:apb_pwdata" \
"PREADY:apb_pready" "PSLVERR:apb_pslverr" }

# ===== AXI raw ports: pixel_proc → XBAR (mirroredMaster direction) =====
# CAPE_INST drives AR*, RREADY; receives R*, ARREADY
sd_create_bus_port -sd_name ${sd_name} -port_name {px_araddr} -port_direction {IN} -port_range {[37:0]}
sd_create_scalar_port -sd_name ${sd_name} -port_name {px_arvalid} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {px_arready} -port_direction {OUT}
sd_create_bus_port -sd_name ${sd_name} -port_name {px_rdata} -port_direction {OUT} -port_range {[63:0]}
sd_create_scalar_port -sd_name ${sd_name} -port_name {px_rvalid} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {px_rready} -port_direction {IN}
sd_create_bus_port -sd_name ${sd_name} -port_name {px_rresp} -port_direction {OUT} -port_range {[1:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {px_awaddr} -port_direction {IN} -port_range {[37:0]}
sd_create_scalar_port -sd_name ${sd_name} -port_name {px_awvalid} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {px_awready} -port_direction {OUT}
sd_create_bus_port -sd_name ${sd_name} -port_name {px_wdata} -port_direction {IN} -port_range {[63:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {px_wstrb} -port_direction {IN} -port_range {[7:0]}
sd_create_scalar_port -sd_name ${sd_name} -port_name {px_wvalid} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {px_wready} -port_direction {OUT}
sd_create_bus_port -sd_name ${sd_name} -port_name {px_bresp} -port_direction {OUT} -port_range {[1:0]}
sd_create_scalar_port -sd_name ${sd_name} -port_name {px_bvalid} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {px_bready} -port_direction {IN}

# Tie unused write inputs
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {px_awaddr} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {px_awvalid} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {px_wdata} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {px_wstrb} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {px_wvalid} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {px_bready} -value {GND}

# ===== AXI raw ports: XBAR → FIC_0 export (mirroredSlave direction) =====
sd_create_bus_port -sd_name ${sd_name} -port_name {ms0_araddr} -port_direction {OUT} -port_range {[37:0]}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ms0_arvalid} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ms0_arready} -port_direction {IN}
sd_create_bus_port -sd_name ${sd_name} -port_name {ms0_rdata} -port_direction {IN} -port_range {[63:0]}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ms0_rvalid} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ms0_rready} -port_direction {OUT}
sd_create_bus_port -sd_name ${sd_name} -port_name {ms0_rresp} -port_direction {IN} -port_range {[1:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {ms0_awaddr} -port_direction {OUT} -port_range {[37:0]}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ms0_awvalid} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ms0_awready} -port_direction {IN}
sd_create_bus_port -sd_name ${sd_name} -port_name {ms0_wdata} -port_direction {OUT} -port_range {[63:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {ms0_wstrb} -port_direction {OUT} -port_range {[7:0]}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ms0_wvalid} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ms0_wready} -port_direction {IN}
sd_create_bus_port -sd_name ${sd_name} -port_name {ms0_bresp} -port_direction {IN} -port_range {[1:0]}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ms0_bvalid} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ms0_bready} -port_direction {OUT}

# Tie-off unused write outputs
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {ms0_awaddr} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {ms0_awvalid} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {ms0_wdata} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {ms0_wstrb} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {ms0_wvalid} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {ms0_bready} -value {GND}

# ===== BIFs =====
# mirroredMaster: pixel_proc → XBAR (CAPE_INST is the initiator)
sd_create_bif_port -sd_name ${sd_name} -port_name {axi_mm_bif} \
    -port_bif_vlnv {AMBA:AMBA4:AXI4:r0p0} -port_bif_role {mirroredMaster} -port_bif_mapping {\
"ACLK:AXI_ACLK" "ARESETN:AXI_ARESETN" \
"ARADDR:px_araddr" "ARVALID:px_arvalid" "ARREADY:px_arready" \
"RDATA:px_rdata"   "RVALID:px_rvalid"   "RREADY:px_rready"   "RRESP:px_rresp" \
"AWADDR:px_awaddr" "AWVALID:px_awvalid" "AWREADY:px_awready" \
"WDATA:px_wdata"   "WSTRB:px_wstrb"     "WVALID:px_wvalid"   "WREADY:px_wready" \
"BRESP:px_bresp"   "BVALID:px_bvalid"   "BREADY:px_bready" }

# mirroredSlave: XBAR → FIC_0 (export to DDR)
sd_create_bif_port -sd_name ${sd_name} -port_name {AXI4mslave0} \
    -port_bif_vlnv {AMBA:AMBA4:AXI4:r0p0} -port_bif_role {mirroredSlave} -port_bif_mapping {\
"ACLK:AXI_ACLK" "ARESETN:AXI_ARESETN" \
"ARADDR:ms0_araddr" "ARVALID:ms0_arvalid" "ARREADY:ms0_arready" \
"RDATA:ms0_rdata"   "RVALID:ms0_rvalid"   "RREADY:ms0_rready"   "RRESP:ms0_rresp" \
"AWADDR:ms0_awaddr" "AWVALID:ms0_awvalid" "AWREADY:ms0_awready" \
"WDATA:ms0_wdata"   "WSTRB:ms0_wstrb"     "WVALID:ms0_wvalid"   "WREADY:ms0_wready" \
"BRESP:ms0_bresp"   "BVALID:ms0_bvalid"   "BREADY:ms0_bready" }

# ===============================================================================
# COREAXI4INTERCONNECT — 1 master (→FIC_0), 1 slave (←pixel_proc)
# ===============================================================================
create_and_configure_core -download_core -core_vlnv {Actel:DirectCore:COREAXI4INTERCONNECT:*} \
    -component_name {CAPE_AXI_XBAR} -params {
    "NUM_MASTERS:1" "NUM_SLAVES:1"
    "ADDR_WIDTH:38" "DATA_WIDTH:64" "ID_WIDTH:4"
    "MASTER0_DATA_WIDTH:64" "SLAVE0_DATA_WIDTH:64"
    "MASTER0_ADDR_WIDTH:38" "SLAVE0_ADDR_WIDTH:38"
    "MASTER0_ID_WIDTH:4" "SLAVE0_ID_WIDTH:4"
    "MASTER0_READ_ACCEPTANCE:8" "SLAVE0_READ_ACCEPTANCE:8"
    "MASTER0_WRITE_ACCEPTANCE:8" "SLAVE0_WRITE_ACCEPTANCE:8"
    "ADVANCED:0" "AREG:1" "RREG:1"
    "SLAVE0_ADDR_RANGE_START:0x80000000" "SLAVE0_ADDR_RANGE_END:0xDFFFFFFF"
}
sd_instantiate_component -sd_name ${sd_name} -component_name {CAPE_AXI_XBAR} -instance_name {XBAR_0}

# ===============================================================================
# CAPE.v hdl_core (apb_ctrl_status + pixel_proc + GPIO)
# ===============================================================================
sd_instantiate_hdl_core -sd_name ${sd_name} -hdl_core_name {CAPE} -instance_name {CAPE_INST}

# ===============================================================================
# APB: SmartDesign port → CAPE_INST
# ===============================================================================
sd_connect_pins -sd_name ${sd_name} -pin_names {APB_SLAVE CAPE_INST:APB_TARGET}

# ===============================================================================
# AXI connections
# ===============================================================================
# CAPE_INST raw AXI → px_* ports (mirroredMaster: CAPE is initiator)
sd_connect_pins -sd_name ${sd_name} -pin_names {CAPE_INST:M_AXI_ARADDR px_araddr}
sd_connect_pins -sd_name ${sd_name} -pin_names {CAPE_INST:M_AXI_ARVALID px_arvalid}
sd_connect_pins -sd_name ${sd_name} -pin_names {CAPE_INST:M_AXI_ARREADY px_arready}
sd_connect_pins -sd_name ${sd_name} -pin_names {CAPE_INST:M_AXI_RDATA px_rdata}
sd_connect_pins -sd_name ${sd_name} -pin_names {CAPE_INST:M_AXI_RVALID px_rvalid}
sd_connect_pins -sd_name ${sd_name} -pin_names {CAPE_INST:M_AXI_RREADY px_rready}
sd_connect_pins -sd_name ${sd_name} -pin_names {CAPE_INST:M_AXI_RRESP px_rresp}

# mirroredMaster BIF → XBAR mmaster (receives from initiator/pixel_proc)
sd_connect_pins -sd_name ${sd_name} -pin_names {axi_mm_bif XBAR_0:AXI4mmaster0}
# XBAR mslave → mirroredSlave BIF (sends to DDR/FIC_0)
sd_connect_pins -sd_name ${sd_name} -pin_names {XBAR_0:AXI4mslave0 AXI4mslave0}

# ===============================================================================
# Clock / Reset / GPIO
# ===============================================================================
sd_connect_pins -sd_name ${sd_name} -pin_names {PCLK CAPE_INST:PCLK}
sd_connect_pins -sd_name ${sd_name} -pin_names {PRESETN CAPE_INST:PRESETN}
sd_connect_pins -sd_name ${sd_name} -pin_names {AXI_ACLK CAPE_INST:ACLK XBAR_0:ACLK}
sd_connect_pins -sd_name ${sd_name} -pin_names {AXI_ARESETN CAPE_INST:ARESETN XBAR_0:ARESETN}
sd_connect_pins -sd_name ${sd_name} -pin_names {GPIO_OE CAPE_INST:GPIO_OE}
sd_connect_pins -sd_name ${sd_name} -pin_names {GPIO_OUT CAPE_INST:GPIO_OUT}
sd_connect_pins -sd_name ${sd_name} -pin_names {GPIO_IN CAPE_INST:GPIO_IN}
sd_connect_pins -sd_name ${sd_name} -pin_names {INT CAPE_INST:INT}
sd_connect_pins -sd_name ${sd_name} -pin_names {P8 CAPE_INST:P8}
foreach p {11 12 13 14 15 16 17 18 21 22 23 24 25 26 27 28 29 30 31 41 42} {
    sd_connect_pins -sd_name ${sd_name} -pin_names "P9_${p} CAPE_INST:P9_${p}"
}

auto_promote_pad_pins -promote_all 1
save_smartdesign -sd_name ${sd_name}
generate_component -component_name ${sd_name}
