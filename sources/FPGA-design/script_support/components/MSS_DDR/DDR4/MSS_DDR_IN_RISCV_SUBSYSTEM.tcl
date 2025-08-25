puts "======== Add MSS DDR in BVF_RISCV_SUBSYSTEM option: DDR4 ========"

# Adding MSS DDR connections with the RISC-V Subsystem.
set sd_name {BVF_RISCV_SUBSYSTEM}

# Disable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 0


# Adjust widths for 0-based bus indexing
set DQ_WIDTH  [expr {$mss_ddr_width - 1}]
set DQS_WIDTH [expr {($mss_ddr_width / 8) - 1}]
set DM_WIDTH  [expr {($mss_ddr_width / 8) - 1}]

set MSS_DDR_BANK_ADDR_WIDTH_0 [expr {$MSS_DDR_BANK_ADDR_WIDTH - 1}]
set MSS_DDR_ROW_ADDR_WIDTH_0 [expr {$MSS_DDR_ROW_ADDR_WIDTH - 2}]


# Create bus ports
sd_create_bus_port -sd_name ${sd_name} -port_name {DQ}    -port_direction {INOUT} -port_range "\[${DQ_WIDTH}:0\]"    -port_is_pad {1}
sd_create_bus_port -sd_name ${sd_name} -port_name {DQS}   -port_direction {INOUT} -port_range "\[${DQS_WIDTH}:0\]"   -port_is_pad {1}
sd_create_bus_port -sd_name ${sd_name} -port_name {DQS_N} -port_direction {INOUT} -port_range "\[${DQS_WIDTH}:0\]"   -port_is_pad {1}
sd_create_bus_port -sd_name ${sd_name} -port_name {DM}    -port_direction {OUT}   -port_range "\[${DM_WIDTH}:0\]"    -port_is_pad {1}
sd_create_bus_port -sd_name ${sd_name} -port_name {A} -port_direction {OUT} -port_range "\[${MSS_DDR_ROW_ADDR_WIDTH_0}:0\]" -port_is_pad {1}
sd_create_bus_port -sd_name ${sd_name} -port_name {BA} -port_direction {OUT} -port_range "\[${MSS_DDR_BANK_ADDR_WIDTH_0}:0\]" -port_is_pad {1}

# Create scalar net ports
sd_create_scalar_port -sd_name ${sd_name} -port_name {ACT_N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {BG0} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CAS_N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CK0} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CK0_N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CKE0} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CS0_N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ODT0} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {RAS_N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {RESET_N} -port_direction {OUT} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {WE_N} -port_direction {OUT} -port_is_pad {1}


# Add scalar net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"ACT_N"   "PF_SOC_MSS:ACT_N"   }
sd_connect_pins -sd_name ${sd_name} -pin_names {"BG0"     "PF_SOC_MSS:BG0"     }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CAS_N"   "PF_SOC_MSS:CAS_N"   }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CK0"     "PF_SOC_MSS:CK0"     }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CK0_N"   "PF_SOC_MSS:CK0_N"   }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CKE0"    "PF_SOC_MSS:CKE0"    }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CS0_N"   "PF_SOC_MSS:CS0_N"   }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ODT0"    "PF_SOC_MSS:ODT0"    }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RAS_N"   "PF_SOC_MSS:RAS_N"   }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RESET_N" "PF_SOC_MSS:RESET_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"WE_N"    "PF_SOC_MSS:WE_N"    }




# Add bus net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"A"     "PF_SOC_MSS:A"     }
sd_connect_pins -sd_name ${sd_name} -pin_names {"BA"    "PF_SOC_MSS:BA"    }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DM"    "PF_SOC_MSS:DM"    }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DQ"    "PF_SOC_MSS:DQ"    }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DQS"   "PF_SOC_MSS:DQS"   }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DQS_N" "PF_SOC_MSS:DQS_N" }