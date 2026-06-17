puts "======== Add cape option: BGS ========"

# ---- Register CAPE.v as hdl_core ----
create_hdl_core -file $project_dir/hdl/CAPE.v -module {CAPE} -library {work} -package {}

# ---- Build CAPE SmartDesign wrapper (handles APB + AXI BIFs) ----
::safe_source script_support/components/CAPE/$cape_option/CAPE.tcl

auto_promote_pad_pins -promote_all 0

#-------------------------------------------------------------------------------
# Build the Cape module
#-------------------------------------------------------------------------------
set sd_name ${top_level_name}

#-------------------------------------------------------------------------------
# Cape pins
#-------------------------------------------------------------------------------
sd_create_bus_port -sd_name ${sd_name} -port_name {P9} -port_direction {INOUT} -port_range {[20:19]} -port_is_pad {1}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {P9} -pin_slices {[20] [19]}

#-------------------------------------------------------------------------------
# Transform the RISCV_SUBSYSTEM
#-------------------------------------------------------------------------------
set sd_name {BVF_RISCV_SUBSYSTEM}

adapter::remove_pin "SPI_1_SS1"
adapter::remove_pin "SPI_1_CLK"
adapter::remove_pin "SPI_1_DI"
adapter::remove_pin "SPI_1_DO"

save_smartdesign -sd_name ${sd_name}
sd_update_instance -sd_name ${top_level_name} -instance_name ${sd_name}
generate_component -component_name ${sd_name}

#-------------------------------------------------------------------------------
# Instantiate CAPE_TOP SmartDesign component (wraps CAPE hdl_core)
#-------------------------------------------------------------------------------
set sd_name ${top_level_name}
sd_instantiate_component -sd_name ${sd_name} -component_name {CAPE_TOP} -instance_name {CAPE}

#-------------------------------------------------------------------------------
# Connections
#-------------------------------------------------------------------------------
sd_delete_ports -sd_name ${sd_name} -port_names {P9_19}
sd_delete_ports -sd_name ${sd_name} -port_names {P9_20}

# Clocks and resets
sd_connect_pins -sd_name ${sd_name} -pin_names {"CLOCKS_AND_RESETS:FIC_3_PCLK" "CAPE:PCLK"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"CLOCKS_AND_RESETS:FIC_3_FABRIC_RESET_N" "CAPE:PRESETN"}
# AXI clock/reset — same domain as APB
sd_connect_pins -sd_name ${sd_name} -pin_names {"CLOCKS_AND_RESETS:FIC_3_PCLK" "CAPE:AXI_ACLK"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"CLOCKS_AND_RESETS:FIC_3_FABRIC_RESET_N" "CAPE:AXI_ARESETN"}

sd_connect_pins -sd_name ${sd_name} -pin_names {"BVF_RISCV_SUBSYSTEM:GPIO_2_F2M" "CAPE:GPIO_IN"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"BVF_RISCV_SUBSYSTEM:GPIO_2_M2F" "CAPE:GPIO_OUT"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"BVF_RISCV_SUBSYSTEM:GPIO_2_OE_M2F" "CAPE:GPIO_OE"}

sd_connect_pin_to_port -sd_name ${sd_name} -pin_name {CAPE:P8} -port_name {}
sd_connect_pin_to_port -sd_name ${sd_name} -pin_name {CAPE:P9_11} -port_name {}
sd_connect_pin_to_port -sd_name ${sd_name} -pin_name {CAPE:P9_12} -port_name {}
sd_connect_pin_to_port -sd_name ${sd_name} -pin_name {CAPE:P9_13} -port_name {}
sd_connect_pin_to_port -sd_name ${sd_name} -pin_name {CAPE:P9_14} -port_name {}
sd_connect_pin_to_port -sd_name ${sd_name} -pin_name {CAPE:P9_15} -port_name {}
sd_connect_pin_to_port -sd_name ${sd_name} -pin_name {CAPE:P9_16} -port_name {}
sd_connect_pin_to_port -sd_name ${sd_name} -pin_name {CAPE:P9_17} -port_name {}
sd_connect_pin_to_port -sd_name ${sd_name} -pin_name {CAPE:P9_18} -port_name {}
sd_connect_pin_to_port -sd_name ${sd_name} -pin_name {CAPE:P9_21} -port_name {}
sd_connect_pin_to_port -sd_name ${sd_name} -pin_name {CAPE:P9_22} -port_name {}
sd_connect_pin_to_port -sd_name ${sd_name} -pin_name {CAPE:P9_23} -port_name {}
sd_connect_pin_to_port -sd_name ${sd_name} -pin_name {CAPE:P9_24} -port_name {}
sd_connect_pin_to_port -sd_name ${sd_name} -pin_name {CAPE:P9_25} -port_name {}
sd_connect_pin_to_port -sd_name ${sd_name} -pin_name {CAPE:P9_26} -port_name {}
sd_connect_pin_to_port -sd_name ${sd_name} -pin_name {CAPE:P9_27} -port_name {}
sd_connect_pin_to_port -sd_name ${sd_name} -pin_name {CAPE:P9_28} -port_name {}
sd_connect_pin_to_port -sd_name ${sd_name} -pin_name {CAPE:P9_29} -port_name {}
sd_connect_pin_to_port -sd_name ${sd_name} -pin_name {CAPE:P9_30} -port_name {}
sd_connect_pin_to_port -sd_name ${sd_name} -pin_name {CAPE:P9_31} -port_name {}
sd_connect_pin_to_port -sd_name ${sd_name} -pin_name {CAPE:P9_41} -port_name {}
sd_connect_pin_to_port -sd_name ${sd_name} -pin_name {CAPE:P9_42} -port_name {}

sd_connect_pins -sd_name ${sd_name} -pin_names {"P9[19]" "BVF_RISCV_SUBSYSTEM:I2C0_SCL"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"P9[20]" "BVF_RISCV_SUBSYSTEM:I2C0_SDA"}

# APB slave (promoted from CAPE_INST:APB_TARGET)
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE:APB_TARGET" "BVF_RISCV_SUBSYSTEM:CAPE_APB_MTARGET"}

# AXI4 master → FIC_0 (FPGA reads DDR)
sd_clear_pin_attributes -sd_name ${sd_name} -pin_names {BVF_RISCV_SUBSYSTEM:FIC_0_AXI4_TARGET}
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE:AXI4_INITIATOR" "BVF_RISCV_SUBSYSTEM:FIC_0_AXI4_TARGET"}

sd_mark_pins_unused -sd_name ${sd_name} -pin_names {BVF_RISCV_SUBSYSTEM:MMUART_4_TXD}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {BVF_RISCV_SUBSYSTEM:MMUART_4_RXD} -value {GND}

sd_clear_pin_attributes -sd_name ${sd_name} -pin_names {BVF_RISCV_SUBSYSTEM:MSS_INT_F2M}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {BVF_RISCV_SUBSYSTEM:MSS_INT_F2M} -pin_slices {[7:3] [31:8] [58:32]}
sd_connect_pins -sd_name ${sd_name} -pin_names {"BVF_RISCV_SUBSYSTEM:MSS_INT_F2M[31:8]" "CAPE:INT"}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {BVF_RISCV_SUBSYSTEM:MSS_INT_F2M[7:3]} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {BVF_RISCV_SUBSYSTEM:MSS_INT_F2M[58:32]} -value {GND}

auto_promote_pad_pins -promote_all 1
