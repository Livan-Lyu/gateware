puts "======== Add MSS DDR in BVF_RISCV_SUBSYSTEM option: LPDDR3 ========"

# Adding MSS DDR connections with the RISC-V Subsystem.
set sd_name {BVF_RISCV_SUBSYSTEM}

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
sd_connect_pins -sd_name ${sd_name} -pin_names {"CK"      "PF_SOC_MSS:CK"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"CK_N"    "PF_SOC_MSS:CK_N"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"CKE"     "PF_SOC_MSS:CKE"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"CS"      "PF_SOC_MSS:CS"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"RESET_N" "PF_SOC_MSS:RESET_N"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"ODT"     "PF_SOC_MSS:ODT"}

# Add bus net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"PF_SOC_MSS:CA"    "CA"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"DM"               "PF_SOC_MSS:DM"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"DQ"               "PF_SOC_MSS:DQ"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"DQS"              "PF_SOC_MSS:DQS"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"DQS_N"            "PF_SOC_MSS:DQS_N"}

# Mark unused pins
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {PF_SOC_MSS:PLL_DDR_LOCK_M2F}