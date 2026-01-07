#
# This is based on the Icicle Kit Refernece Design TCL script
#

#
# // Check Libero version and path length to verify project can be created
#

set libero_release [split [get_libero_version] .]

if {[string compare [lindex $libero_release 0] "2022"] == 0 && [string compare [lindex $libero_release 1] "3"] == 0} {
    puts "Libero v2022.3 detected."
} elseif {[string compare [lindex $libero_release 0] "2023"] == 0 && [string compare [lindex $libero_release 1] "2"] == 0} {
    puts "Libero v2023.2 detected."
} elseif {[string compare [lindex $libero_release 0] "2024"] == 0 && [string compare [lindex $libero_release 1] "1"] == 0} {
    puts "Libero v2024.1 detected."
} elseif {[string compare [lindex $libero_release 0] "2024"] == 0 && [string compare [lindex $libero_release 1] "2"] == 0} {
    puts "Libero v2024.2 detected."
} elseif {[string compare [lindex $libero_release 0] "2025"] == 0 && [string compare [lindex $libero_release 1] "1"] == 0} {
    puts "Libero v2025.1 detected."
} elseif {[string compare [lindex $libero_release 0] "2025"] == 0 && [string compare [lindex $libero_release 1] "2"] == 0} {
    puts "Libero v2025.2 detected."
} else {
    error "Incorrect Libero version detected. Please use Libero v2023.2, v2022.3, v2024.1, v2024.2, v2025.1 or v2025.2 to run these scripts."
}


if { [lindex $tcl_platform(os) 0]  == "Windows" } {
    if {[string length [pwd]] < 90} {
        puts "Project path length ok."
    } else {
        error "Path to project is too long, please reduce the path and try again."
    }
}

#
# // Process arguments
#

if { $::argc > 0 } {
    set i 1
    foreach arg $::argv {
        if {[string match "*:*" $arg]} {
            set temp [split $arg ":"]
            set display_value [lindex $temp 1]
            if {[string match "*PUBLIC_KEY*" [lindex $temp 0]]} {
                set display_value "[string range $display_value 0 7]..."
            }
            puts "Setting parameter [lindex $temp 0] to $display_value"
            set [lindex $temp 0] "[lindex $temp 1]"
        } else {
            set $arg 1
            puts "set $arg to 1"
        }
        incr i
    }
} else {
    puts "no command line argument passed"
}

#
# // Set required variables and add functions
#

set install_loc [defvar_get -name ACTEL_SW_DIR]
set mss_config_loc "$install_loc/bin64/pfsoc_mss"
set local_dir [pwd]
set constraint_path ./script_support/constraints
set project_name "BVF_GATEWARE_025T"
#set top_level_name BVF_GATEWARE

if {[info exists PROG_EXPORT_PATH]} {
    set prog_export_path $PROG_EXPORT_PATH/bitstream
} else {
    set prog_export_path $local_dir/bitstream
}

if {[info exists FPE_EXPORT_PATH]} {
    set fpe_export_path $FPE_EXPORT_PATH
} else {
    set fpe_export_path $prog_export_path/FlashProExpress
}

set directc_export_path $prog_export_path/DirectC

if {[info exists SMARTHLS_ELF_EXPORT_PATH]} {
    set smarthls_elf_export_path $SMARTHLS_ELF_EXPORT_PATH
} else {
    set smarthls_elf_export_path $prog_export_path/SmartHLS_Executables
}

if {[info exists TOP_LEVEL_NAME]} {
    set top_level_name $TOP_LEVEL_NAME
} else {
    set top_level_name BVF_GATEWARE
}

if {[info exists CAPE_OPTION]} {
    set cape_option "$CAPE_OPTION"
} else {
    set cape_option "DEFAULT"
}
puts "Cape options selected: $cape_option"

if {[info exists M2_OPTION]} {
    set m2_option "$M2_OPTION"
} else {
    set m2_option "DEFAULT"
}
puts "M.2 option selected: $m2_option"

if {[info exists APU_OPTION]} {
    set apu_option "$APU_OPTION"
} else {
    set apu_option "NONE"
}
puts "APU option selected: $apu_option"

if {[info exists SYZYGY_OPTION]} {
    set syzygy_option "$SYZYGY_OPTION"
} else {
    if {[info exists HIGH_SPEED_CONN_OPTION]} {
        set syzygy_option "$HIGH_SPEED_CONN_OPTION"
    } else {
        set syzygy_option "DEFAULT"
    }
}

puts "SYZYGY high speed connector option option selected: $syzygy_option"

if {[info exists MIPI_CSI_OPTION]} {
    set mipi_csi_option "$MIPI_CSI_OPTION"
} else {
    set mipi_csi_option "DEFAULT"
}
puts "MIPI CSI option option selected: $mipi_csi_option"

if {[info exists PROJECT_LOCATION]} {
    set project_dir "$PROJECT_LOCATION"
} else {
    set project_dir "$local_dir/$project_name"
}
puts "PROJECT_LOCATION: $project_dir"

if {[info exists DESIGN_VERSION]} {
    set gateware_design_version "$DESIGN_VERSION"
} else {
    set gateware_design_version "1"
}
puts "DESIGN_VERSION: $gateware_design_version"

if {[info exists SILICON_SIGNATURE]} {
    set gateware_silicon_signature "$SILICON_SIGNATURE"
} else {
    set gateware_silicon_signature "bea913b0"
}
puts "SILICON_SIGNATURE: $gateware_silicon_signature"


################# Board , Die , Package #######################

if {[info exists BOARD]} {
    set board "$BOARD"
} else {
    set board "bvf"
}
puts "BOARD: $board"

if {[info exists DIE]} {
    set die "$DIE"
} else {
    set die "MPFS025T"
}
puts "DIE: $die"

if {[info exists PACKAGE]} {
    set package "$PACKAGE"
} else {
    set package "FCVG484"
}
puts "PACKAGE: $package"

if {[info exists DIE_VOLTAGE]} {
    set die_voltage "$DIE_VOLTAGE"
} else {
    set die_voltage 1.0
}
puts "DIE_VOLTAGE: $die_voltage"

if {[info exists PART_RANGE]} {
    set part_range "$PART_RANGE"
} else {
    set part_range "EXT"
}
puts "PART_RANGE: $part_range"

if {[info exists SPEED]} {
    set speed "$SPEED"
} else {
    set speed "STD"
}
puts "SPEED: $speed"

if {[info exists MSS_DDR]} {
    set mss_ddr "$MSS_DDR"
} else {
    set mss_ddr "LPDDR4"
}
puts "MSS_DDR: $mss_ddr"

if {[info exists MSS_DDR_WIDTH]} {
    set mss_ddr_width "$MSS_DDR_WIDTH"
} else {
    set mss_ddr_width "32"
}
puts "MSS_DDR_WIDTH: $mss_ddr_width"

################ Boot Mode Options ########################

if {[info exists BOOTMODE]} {
    set bootmode_option "$BOOTMODE"
} else {
    set bootmode_option "BM1"
}
puts "BOOTMODE: $bootmode_option"

source ./script_support/additional_configurations/functions.tcl

#
# // Create Libero project
#

new_project \
    -location $project_dir \
    -name $project_name \
    -project_description {} \
    -block_mode 0 \
    -standalone_peripheral_initialization 0 \
    -instantiate_in_smartdesign 1 \
    -ondemand_build_dh 1 \
    -use_relative_path 0 \
    -linked_files_root_dir_env {} \
    -hdl {VERILOG} \
    -family {PolarFireSoC} \
    -die $die \
    -package $package \
    -speed $speed \
    -die_voltage $die_voltage \
    -part_range $part_range \
    -adv_options {IO_DEFT_STD:LVCMOS 1.8V} \
    -adv_options {RESTRICTPROBEPINS:0} \
    -adv_options {RESTRICTSPIPINS:0} \
    -adv_options {SYSTEM_CONTROLLER_SUSPEND_MODE:0} \
    -adv_options {TARGETDEVICESFORMIGRATION:MPFS095T;MPFS160T;MPFS095TL;MPFS160TL;} \
    -adv_options "TEMPR:$part_range" \
    -adv_options "VCCI_1.2_VOLTR:$part_range" \
    -adv_options "VCCI_1.5_VOLTR:$part_range" \
    -adv_options "VCCI_1.8_VOLTR:$part_range" \
    -adv_options "VCCI_2.5_VOLTR:$part_range" \
    -adv_options "VCCI_3.3_VOLTR:$part_range" \
    -adv_options "VOLTR:$part_range"

#
# // Import I/O constraints
#
set import_pdc_files "-io_pdc \"./constraints/base_design.pdc\""
set place_route_pdc_files "-file \"${project_dir}/constraint/io/base_design.pdc\""
smartdesign -memory_map_drc_change_error_to_warning 1

import_files \
    -convert_EDN_to_HDL 0 \
    -io_pdc "${constraint_path}/$board/base_design.pdc" \
    -fp_pdc "${constraint_path}/$board/NW_PLL.pdc" \
    -sdc "${constraint_path}/$board/fic_clocks.sdc" \
    -fp_pdc "./script_support/components/SYZYGY/$syzygy_option/constraints/fp/$board/SYZYGY.pdc" \
    -io_pdc "./script_support/components/CAPE/$cape_option/constraints/$board/cape.pdc" \
    -io_pdc "./script_support/components/M2/$m2_option/constraints/$board/M2.pdc" \
    -io_pdc "./script_support/components/SYZYGY/$syzygy_option/constraints/$board/SYZYGY.pdc" \
    -io_pdc "./script_support/components/MIPI_CSI/$mipi_csi_option/constraints/$board/MIPI_CSI_INTERFACE.pdc"

#
# // Generate base design
#
safe_source [file join $INITIAL_DIRECTORY "sources" "MSS" "scripts" "B_V_F_recursive.tcl"]

#
# // Associate imported constraints with the design flow
#

organize_tool_files \
    -tool {SYNTHESIZE} \
    -file "${project_dir}/constraint/fic_clocks.sdc" \
    -module ${top_level_name}::work \
    -input_type {constraint}

organize_tool_files \
    -tool {PLACEROUTE} \
    -file "${project_dir}/constraint/io/base_design.pdc" \
    -file "${project_dir}/constraint/fp/NW_PLL.pdc" \
    -file "${project_dir}/constraint/fp/SYZYGY.pdc" \
    -file "${project_dir}/constraint/fic_clocks.sdc" \
    -file "${project_dir}/constraint/io/cape.pdc" \
    -file "${project_dir}/constraint/io/M2.pdc" \
    -file "${project_dir}/constraint/io/SYZYGY.pdc" \
    -file "${project_dir}/constraint/io/MIPI_CSI_INTERFACE.pdc" \
    -module ${top_level_name}::work \
    -input_type {constraint}

organize_tool_files \
    -tool {VERIFYTIMING} \
    -file "${project_dir}/constraint/fic_clocks.sdc" \
    -module ${top_level_name}::work \
    -input_type {constraint}

configure_tool \
         -name {CONFIGURE_PROG_OPTIONS} \
         -params {back_level_version:0} \
         -params design_version:$gateware_design_version \
         -params silicon_signature:$gateware_silicon_signature 

#
# // Derive timing constraints
#

build_design_hierarchy
derive_constraints_sdc 

#
# // Run the design flow and add eNVM clients if required
#
file mkdir $prog_export_path
file mkdir $prog_export_path/FlashProExpress
file mkdir $prog_export_path/LinuxProgramming
file mkdir $prog_export_path/DirectC

if !{[info exists ONLY_CREATE_DESIGN]} {
    run_tool -name {SYNTHESIZE}
    run_tool -name {PLACEROUTE}
    run_tool -name {VERIFYTIMING}
    if {[info exists HSS_IMAGE_PATH]} {
        safe_source script_support/design_init/ENVM/$bootmode_option/ADD_ENVM.tcl
        safe_source ./script_support/export_fns/export_spi_prog_file.tcl
        configure_spiflash -cfg_file {./script_support/design_init/SPI_FLASH/AUTO_UPDATE/spiflash.cfg}
        run_tool -name {GENERATEPROGRAMMINGFILE}
#       run_tool -name {GENERATE_SPI_FLASH_IMAGE}
        safe_source ./script_support/export_fns/export_flashproexpress.tcl
        safe_source ./script_support/export_fns/export_directc.tcl
    } else {
        run_tool -name {GENERATEPROGRAMMINGDATA}
        puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
        puts "!!!              No Hart Software Services (HSS) image provided.             !!!"
        puts "!!! Make sure this is what you were planning. If so, you know what you are   !!!"
        puts "!!! doing: Open the Libero project to generate the design's programming      !!!"
        puts "!!! bitstream flavor you need.                                               !!!"
        puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    }
} 

save_project 
