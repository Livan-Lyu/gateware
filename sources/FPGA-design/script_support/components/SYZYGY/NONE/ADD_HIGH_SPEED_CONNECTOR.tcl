puts "======== Add High Speed Connector option: NONE ========"

# Register the shared APB terminator HDL core (once per build session)
if {![info exists ::apb_terminator_registered]} {
    create_hdl_core -file $project_dir/hdl/apb_terminator.v -module {apb_terminator} -library {work} -package {}
    hdl_core_add_bif -hdl_core_name {apb_terminator} -bif_definition {APB:AMBA:AMBA2:slave} -bif_name {BIF_1} -signal_map {}
    hdl_core_assign_bif_signal -hdl_core_name {apb_terminator} -bif_name {BIF_1} -bif_signal_name {PADDR}   -core_signal_name {PADDR}
    hdl_core_assign_bif_signal -hdl_core_name {apb_terminator} -bif_name {BIF_1} -bif_signal_name {PSELx}   -core_signal_name {PSEL}
    hdl_core_assign_bif_signal -hdl_core_name {apb_terminator} -bif_name {BIF_1} -bif_signal_name {PENABLE} -core_signal_name {PENABLE}
    hdl_core_assign_bif_signal -hdl_core_name {apb_terminator} -bif_name {BIF_1} -bif_signal_name {PWRITE}  -core_signal_name {PWRITE}
    hdl_core_assign_bif_signal -hdl_core_name {apb_terminator} -bif_name {BIF_1} -bif_signal_name {PRDATA}  -core_signal_name {PRDATA}
    hdl_core_assign_bif_signal -hdl_core_name {apb_terminator} -bif_name {BIF_1} -bif_signal_name {PWDATA}  -core_signal_name {PWDATA}
    hdl_core_rename_bif -hdl_core_name {apb_terminator} -current_bif_name {BIF_1} -new_bif_name {APB_TARGET}
    set ::apb_terminator_registered 1
}

# Instantiate terminator for FIC3 slot 4 (HSI_APB_MTARGET)
set sd_name ${top_level_name}
sd_instantiate_hdl_core -sd_name ${sd_name} -hdl_core_name {apb_terminator} -instance_name {HSI_APB_TERM}

# Clocks
sd_connect_pins -sd_name ${sd_name} -pin_names {"CLOCKS_AND_RESETS:FIC_3_PCLK" "HSI_APB_TERM:PCLK"}
sd_connect_pins -sd_name ${sd_name} -pin_names {"CLOCKS_AND_RESETS:FIC_3_FABRIC_RESET_N" "HSI_APB_TERM:PRESETN"}

# APB — connect terminator to FIC3 slot 4
sd_connect_pins -sd_name ${sd_name} -pin_names {"HSI_APB_TERM:APB_TARGET" "BVF_RISCV_SUBSYSTEM:HSI_APB_MTARGET"}
