puts "TCL_BEGIN: [info script]"

#------------------------------------------------------------------------------
# Initialize environment
#------------------------------------------------------------------------------
# Save the current working directory before changing to HLS module directory
set cwd [pwd]
set hlsModuleDir [file normalize $::SMARTHLS]
cd $hlsModuleDir

# Detect SmartHLS location
set shls_path [getHlsPath]

proc run_shls_command {command log_path} {
    puts "Running: $command"
    puts "Logging SmartHLS output to: $log_path"

    set log_fid [open $log_path w]
    puts $log_fid "Running: $command"

    if {[catch {open [list | sh -c "$command 2>&1"] r} fid]} {
        puts $log_fid $fid
        close $log_fid
        error "ERROR: Failed to launch '$command': $fid"
    }

    while {[gets $fid line] != -1} {
        puts $line
        puts $log_fid $line
    }

    set close_status [catch {close $fid} close_error]
    close $log_fid

    if {$close_status} {
        error "ERROR: SmartHLS command failed: '$command'. See $log_path. Tcl close error: $close_error"
    }
}

#
# Calling SmartHLS to setup the environment.
#
puts "Compiling SmartHLS accelerator..."
run_shls_command "shls clean" [file join $hlsModuleDir "shls_clean.log"]

#------------------------------------------------------------------------------
# Compile SmartHLS accelerator
#------------------------------------------------------------------------------
# Generate and compile RISC-V software binary and Verilog hardware
# The "soc_sw_compile_accel" target handles both software driver and hardware
puts "Compiling SmartHLS accelerator..."
run_shls_command "shls -a soc_sw_compile_accel" [file join $hlsModuleDir "shls_soc_sw_compile_accel.log"]

#------------------------------------------------------------------------------
# Integrate hardware modules into Libero project
#------------------------------------------------------------------------------
open_smartdesign -sd_name {APU}

puts "Accelerator Number: $accel_num"
puts "Creating HLS HDL+ cores..."

# Source the HDL Plus creation script
::safe_source $hlsModuleDir/hls_output/scripts/libero/create_hdl_plus.tcl

#------------------------------------------------------------------------------
# Find accelerator name from generated files
#------------------------------------------------------------------------------
# Look for all files in the libero directory
set liberoDir [file join $hlsModuleDir "hls_output" "scripts" "libero"]
set files [glob -nocomplain -directory $liberoDir "*"]
puts "Searching for accelerator name in: $liberoDir"

set accel_name ""

# Extract accelerator name from HDL Plus filenames
foreach file $files {
    set filename [file tail $file]

    if {[regexp {^create_hdl_plus_(.+)\.tcl$} $filename match extracted_name]} {
        set accel_name $extracted_name
        puts "Found accelerator: $accel_name"
        break
    }
}

# Validate accelerator name
if {$accel_name eq ""} {
    error "ERROR: No valid accelerator name found in $liberoDir"
} else {
    puts "Using accelerator: $accel_name"
}

#------------------------------------------------------------------------------
# Instantiate and connect accelerator
#------------------------------------------------------------------------------
set accel_instance "${accel_name}_0"

# Instantiate the accelerator core
puts "Instantiating accelerator: $accel_instance"
sd_instantiate_hdl_core -sd_name {APU} -hdl_core_name ${accel_name} -instance_name ${accel_instance}

# Connect the accelerator to the system
puts "Connecting accelerator to system bus and clock..."
sd_connect_pins -sd_name {APU} -pin_names "$accel_instance:axi4target SHLS_AXI4Interconnect_0:AXI4mtarget$accel_num"
sd_connect_pins -sd_name {APU} -pin_names "$accel_instance:axi4initiator SHLS_AXI4Interconnect_0:AXI4minitiator$accel_num"
sd_connect_pins -sd_name {APU} -pin_names "$accel_instance:reset ARESETN"
sd_connect_pins -sd_name {APU} -pin_names "$accel_instance:clk ACLK"
sd_invert_pins -sd_name {APU} -pin_names "$accel_instance:reset"

#------------------------------------------------------------------------------
# Generate and save design
#------------------------------------------------------------------------------
puts "Generating component..."
generate_component -component_name {APU} -recursive 0
sd_reset_layout -sd_name {APU}
save_smartdesign -sd_name {APU}

#------------------------------------------------------------------------------
# Cleanup
#------------------------------------------------------------------------------
# Restore the original working directory
cd $cwd

puts "TCL_END: [info script]"
