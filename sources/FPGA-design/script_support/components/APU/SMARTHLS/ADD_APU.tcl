puts "======== Add APU option: SMARTHLS ========"


#-------------------------------------------------------------------------------
# Build APU submodules
#-------------------------------------------------------------------------------
source script_support/components/APU/SMARTHLS/SHLS_AXI4INTERCONNECT.tcl
source script_support/components/APU/SMARTHLS/APU.tcl

#-------------------------------------------------------------------------------
# Copy *.accel.elf executable files
#-------------------------------------------------------------------------------
source script_support/components/APU/SMARTHLS/copy_elf_files.tcl


#-------------------------------------------------------------------------------
# APU integration
#-------------------------------------------------------------------------------
set sd_name ${top_level_name}


#-------------------------------------------------------------------------------
# Instantiation.
#-------------------------------------------------------------------------------
sd_instantiate_component -sd_name ${sd_name} -component_name {APU} -instance_name {APU}


#-------------------------------------------------------------------------------
# Connections.
#-------------------------------------------------------------------------------

# Clocks and resets
sd_connect_pins -sd_name ${sd_name} -pin_names {"APU:ACLK" "CLOCKS_AND_RESETS:FIC_0_ACLK"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"APU:ARESETN" "CLOCKS_AND_RESETS:FIC_0_FABRIC_RESET_N"}


# BVF RISCV SUBSYSTEM
sd_clear_pin_attributes -sd_name ${sd_name} -pin_names {BVF_RISCV_SUBSYSTEM:FIC_0_AXI4_TARGET}
sd_clear_pin_attributes -sd_name ${sd_name} -pin_names {BVF_RISCV_SUBSYSTEM:FIC_0_AXI4_INITIATOR}
sd_connect_pins -sd_name ${sd_name} -pin_names {"APU:AXI4mmaster0" "BVF_RISCV_SUBSYSTEM:FIC_0_AXI4_INITIATOR"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"APU:AXI4mslave0" "BVF_RISCV_SUBSYSTEM:FIC_0_AXI4_TARGET"}

#-------------------------------------------------------------------------------
# Cleanup
#-------------------------------------------------------------------------------
if {[file isdirectory $local_dir/component]} {
    file delete -force $local_dir/component
}

