puts "======== Add APU option: PICO_RV ========" 

create_hdl_core -file $project_dir/hdl/TOP_CONTROL.v -module {PICO_RV} -library {work} -package {}

hdl_core_add_bif -hdl_core_name {PICO_RV} -bif_definition {APB:AMBA:AMBA2:slave} -bif_name {APB_TARGET} -signal_map {} 
hdl_core_assign_bif_signal -hdl_core_name {PICO_RV} -bif_name {APB_TARGET} -bif_signal_name {PADDR} -core_signal_name {paddr} 
hdl_core_assign_bif_signal -hdl_core_name {PICO_RV} -bif_name {APB_TARGET} -bif_signal_name {PENABLE} -core_signal_name {penable} 
hdl_core_assign_bif_signal -hdl_core_name {PICO_RV} -bif_name {APB_TARGET} -bif_signal_name {PWRITE} -core_signal_name {pwrite} 
hdl_core_assign_bif_signal -hdl_core_name {PICO_RV} -bif_name {APB_TARGET} -bif_signal_name {PRDATA} -core_signal_name {prdata} 
hdl_core_assign_bif_signal -hdl_core_name {PICO_RV} -bif_name {APB_TARGET} -bif_signal_name {PWDATA} -core_signal_name {pwdata} 
hdl_core_assign_bif_signal -hdl_core_name {PICO_RV} -bif_name {APB_TARGET} -bif_signal_name {PREADY} -core_signal_name {pready} 
hdl_core_assign_bif_signal -hdl_core_name {PICO_RV} -bif_name {APB_TARGET} -bif_signal_name {PSLVERR} -core_signal_name {pslverr} 
hdl_core_assign_bif_signal -hdl_core_name {PICO_RV} -bif_name {APB_TARGET} -bif_signal_name {PSELx} -core_signal_name {psel} 

#-------------------------------------------------------------------------------
# Build APU submodules 
#-------------------------------------------------------------------------------
::safe_source script_support/components/APU/PICO_RV/COREAXI4INTERCONNECT_C0.tcl 
::safe_source script_support/components/APU/PICO_RV/PF_SRAM_AHBL_AXI_C0.tcl 
::safe_source script_support/components/APU/PICO_RV/APU.tcl

#-------------------------------------------------------------------------------
# Build the APU module
#-------------------------------------------------------------------------------
set sd_name ${top_level_name}

#-------------------------------------------------------------------------------
# Adding APB Slave 
#-------------------------------------------------------------------------------
configure_core -component_name {FIC3_INITIATOR} -params {"APBSLOT12ENABLE:true"}
sd_update_instance -sd_name {BVF_RISCV_SUBSYSTEM} -instance_name {FIC3_INITIATOR}
sd_connect_pin_to_port -sd_name {BVF_RISCV_SUBSYSTEM} -pin_name {FIC3_INITIATOR:APBmslave12} -port_name {} 
sd_rename_port -sd_name {BVF_RISCV_SUBSYSTEM} -current_port_name {APBmslave12} -new_port_name {APU_APB_MTARGET}
generate_component -component_name {BVF_RISCV_SUBSYSTEM}
sd_update_instance -sd_name ${sd_name} -instance_name {BVF_RISCV_SUBSYSTEM} 

#-------------------------------------------------------------------------------
# Instantiation.
#-------------------------------------------------------------------------------
sd_instantiate_component -sd_name ${sd_name} -component_name {APU} -instance_name {APU}

#-------------------------------------------------------------------------------
# Connections.
#-------------------------------------------------------------------------------

# Clocks and resets
sd_connect_pins -sd_name ${sd_name} -pin_names {"CLOCKS_AND_RESETS:FIC_0_ACLK" "APU:ACLK"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"CLOCKS_AND_RESETS:FIC_0_FABRIC_RESET_N" "APU:ARESETN"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"CLOCKS_AND_RESETS:FIC_3_PCLK" "APU:PCLK"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"CLOCKS_AND_RESETS:FIC_3_FABRIC_RESET_N" "APU:PRESETN"}

# CAPE
sd_disconnect_pins -sd_name ${sd_name} -pin_names {"CAPE:GPIO_OE"}
sd_disconnect_pins -sd_name ${sd_name} -pin_names {"CAPE:GPIO_OUT"}
sd_disconnect_pins -sd_name ${sd_name} -pin_names {"CAPE:GPIO_IN"}

sd_connect_pins -sd_name ${sd_name} -pin_names {"CAPE:GPIO_IN" "APU:CAPE_GPIO_IN"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"APU:CAPE_GPIO_OE" "CAPE:GPIO_OE"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"APU:CAPE_GPIO_OUT" "CAPE:GPIO_OUT"}

# BVF RISCV SUBSYSTEM
sd_connect_pins -sd_name ${sd_name} -pin_names {"BVF_RISCV_SUBSYSTEM:GPIO_2_M2F" "APU:BVF_GPIO_OUT"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"BVF_RISCV_SUBSYSTEM:GPIO_2_OE_M2F" "APU:BVF_GPIO_OE"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"APU:BVF_GPIO_IN" "BVF_RISCV_SUBSYSTEM:GPIO_2_F2M"}

# Add bus interface net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"BVF_RISCV_SUBSYSTEM:FIC_0_AXI4_INITIATOR" "APU:AXI4mmaster0"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"BVF_RISCV_SUBSYSTEM:APU_APB_MTARGET" "APU:APB_SLAVE"}
