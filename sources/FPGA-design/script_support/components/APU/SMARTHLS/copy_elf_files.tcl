set num_accelerators 0

# Ensure base export path exists
file mkdir $smarthls_elf_export_path

# Parse only SHLS_* arguments (format: SHLS_0:../path)
foreach arg $argv {
    if {[string match "SHLS_*:*" $arg]} {
        lassign [split $arg ":"] varname path
        set $varname $path  ;# Dynamically defines SHLS_0, SHLS_1, etc.

        set abs_hls_output_dir [file join $INITIAL_DIRECTORY "sources" $path "hls_output"]

        if {[file isdirectory $abs_hls_output_dir]} {
            puts "DEBUG: Directory exists -> $abs_hls_output_dir"
            incr num_accelerators

            set elf_files [glob -nocomplain [file join $abs_hls_output_dir "*.accel.elf"]]

            if {[llength $elf_files] > 0} {
                # Create a subdirectory named SHLS_0, SHLS_1, etc., under the export path
                set export_subdir [file join $smarthls_elf_export_path $varname]
                file mkdir $export_subdir

                foreach elf_file $elf_files {
                    file copy -force $elf_file $export_subdir
                }
            } else {
                puts "Warning: No .accel.elf files found in $hls_output_dir"
            }

        } else {
            puts "Warning: $hls_output_dir is not a directory"
        }
    }
}
