puts "======== Add MSS DDR in GATEWARE option: LPDDR3 ========"

# Adding MSS DDR connections with the GATEWARE
set sd_name ${top_level_name}

# Disable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 0

# Adjust widths for 0-based bus indexing
set DQ_WIDTH  [expr {$mss_ddr_width - 1}]
set DQS_WIDTH [expr {($mss_ddr_width / 8) - 1}]
set DM_WIDTH  [expr {($mss_ddr_width / 8) - 1}]

# Create bus ports (escape square brackets to avoid command substitution)
sd_create_bus_port -sd_name ${sd_name} -port_name {CA}    -port_direction {OUT}   -port_range {[5:0]}              -port_is_pad {1}
sd_create_bus_port -sd_name ${sd_name} -port_name {DQ}    -port_direction {INOUT} -port_range "\[${DQ_WIDTH}:0\]"    -port_is_pad {1}
sd_create_bus_port -sd_name ${sd_name} -port_name {DQS}   -port_direction {INOUT} -port_range "\[${DQS_WIDTH}:0\]"   -port_is_pad {1}
sd_create_bus_port -sd_name ${sd_name} -port_name {DQS_N} -port_direction {INOUT} -port_range "\[${DQS_WIDTH}:0\]"   -port_is_pad {1}
sd_create_bus_port -sd_name ${sd_name} -port_name {DM}    -port_direction {OUT}   -port_range "\[${DM_WIDTH}:0\]"    -port_is_pad {1}

# Create top level Ports
sd_create_scalar_port -sd_name ${sd_name} -port_name {RESET_N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ODT}     -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CKE}     -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CS}      -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CK}      -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CK_N}    -port_direction {OUT} -port_is_pad {1}


# Add scalar net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"CK"      "BVF_RISCV_SUBSYSTEM:CK"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"CK_N"    "BVF_RISCV_SUBSYSTEM:CK_N"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"CKE"     "BVF_RISCV_SUBSYSTEM:CKE"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"CS"      "BVF_RISCV_SUBSYSTEM:CS"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"ODT"     "BVF_RISCV_SUBSYSTEM:ODT"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"RESET_N" "BVF_RISCV_SUBSYSTEM:RESET_N"}

# Add bus net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"BVF_RISCV_SUBSYSTEM:CA"    "CA"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"DM"                       "BVF_RISCV_SUBSYSTEM:DM"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"DQ"                       "BVF_RISCV_SUBSYSTEM:DQ"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"DQS"                      "BVF_RISCV_SUBSYSTEM:DQS"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"DQS_N"                    "BVF_RISCV_SUBSYSTEM:DQS_N"}
