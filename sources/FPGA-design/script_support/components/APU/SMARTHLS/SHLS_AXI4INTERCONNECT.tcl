puts "TCL_BEGIN: [info script]"

set base_addr_start 0x60000000
set base_increment 0x500000
set base_size 0x40000
set default_base_addresses {}

## ------------ Number of accelerators -------------- ##
set num_accelerators 0

foreach var [info vars SHLS*] {
    # Get the value of the variable (the folder path)
    set abs_smarthls_path [file join $INITIAL_DIRECTORY "sources" [set $var]]

    # Check if the directory exists before proceeding
    if {[file isdirectory $abs_smarthls_path]} {
        incr num_accelerators
    } else {
        error "Error: The directory does not exist: $abs_smarthls_path"
    }
}
puts "Number of accelerators: $num_accelerators"

for {set i 0} {$i < $num_accelerators} {incr i} {
    lappend default_base_addresses [format "0x%08x" [expr {$base_addr_start + $i * $base_increment}]]
}

# Calculate the number of masters and slaves
set num_masters [expr {$num_accelerators + 1}]
set num_slaves [expr {$num_accelerators + 1}]
set num_masters_width [expr {int(ceil(log($num_masters) / log(2)))}]

# Initialize parameters
set params "NUM_SLAVES:$num_slaves \
            NUM_MASTERS:$num_masters \
            NUM_MASTERS_WIDTH:$num_masters_width \
            ADDR_WIDTH:38 \
            ID_WIDTH:8 \
            USER_WIDTH:4 \
            CROSSBAR_MODE:1 \
            NUM_THREADS:4 \
            OPEN_TRANS_MAX:8 \
            OPTIMIZATION:1 \
            DATA_WIDTH:128 \
            MASTER0_DATA_WIDTH:64 \
            SLAVE0_START_ADDR:0x80000000 \
            SLAVE0_END_ADDR:0xdfffffff \
            SLAVE0_DATA_WIDTH:64 \
            SLAVE0_TYPE:0"

# Configure slaves and masters
for {set i 1} {$i <= $num_accelerators} {incr i} {
    set base_addr [lindex $default_base_addresses [expr {$i - 1}]]
    append params " SLAVE${i}_START_ADDR:$base_addr"
    append params " SLAVE${i}_END_ADDR:[format 0x%08x [expr {$base_addr + $base_size}]]"
    append params " SLAVE${i}_DATA_WIDTH:64 SLAVE${i}_TYPE:0"
    append params " MASTER${i}_TYPE:0 MASTER${i}_DATA_WIDTH:64"
}

# Configure master-slave access permissions
for {set m 0} {$m < $num_masters} {incr m} {
    for {set s 0} {$s < $num_slaves} {incr s} {
        if {$m == 0 && $s == 0} {
            # Master0 (CPU) cannot access Slave0 (prevents loop-back)
            append params " MASTER${m}_READ_SLAVE${s}:false"
            append params " MASTER${m}_WRITE_SLAVE${s}:false"
        } elseif {$m > 0 && $s == 0} {
            # Accelerator masters can access memory (Slave0)
            append params " MASTER${m}_READ_SLAVE${s}:true"
            append params " MASTER${m}_WRITE_SLAVE${s}:true"
        } elseif {$m == 0 && $s > 0} {
            # CPU (Master0) can access all accelerators
            append params " MASTER${m}_READ_SLAVE${s}:true"
            append params " MASTER${m}_WRITE_SLAVE${s}:true"
        } elseif {$m > 0 && $s > 0 && $m != $s} {
            # Accelerators cannot access other accelerators (optional - can be changed if needed)
            append params " MASTER${m}_READ_SLAVE${s}:false"
            append params " MASTER${m}_WRITE_SLAVE${s}:false"
        } elseif {$m > 0 && $s > 0 && $m == $s} {
            # Accelerators cannot access themselves (prevents loop-back)
            append params " MASTER${m}_READ_SLAVE${s}:false"
            append params " MASTER${m}_WRITE_SLAVE${s}:false"
        } else {
            # Default case (should not happen)
            append params " MASTER${m}_READ_SLAVE${s}:false"
            append params " MASTER${m}_WRITE_SLAVE${s}:false"
        }
    }
}

# Add default channel and clock domain crossing settings for all masters and slaves
for {set i 0} {$i < $num_masters} {incr i} {
    append params " MASTER${i}_CHAN_RS:true"
    append params " MASTER${i}_CLOCK_DOMAIN_CROSSING:false"
    append params " MASTER${i}_DWC_DATA_FIFO_DEPTH:32"
    append params " MASTER${i}_READ_INTERLEAVE:false"
}

for {set i 0} {$i < $num_slaves} {incr i} {
    append params " SLAVE${i}_CHAN_RS:true"
    append params " SLAVE${i}_CLOCK_DOMAIN_CROSSING:false"
    append params " SLAVE${i}_DWC_DATA_FIFO_DEPTH:32"
    append params " SLAVE${i}_READ_INTERLEAVE:false"
}

# Add additional required parameters
append params " RD_ARB_EN:false"
append params " DWC_ADDR_FIFO_DEPTH_CEILING:64"
append params " SLV_AXI4PRT_ADDRDEPTH:8"
append params " SLV_AXI4PRT_DATADEPTH:9"

# Create and configure the core
create_and_configure_core -component_name {SHLS_AXI4Interconnect} -core_vlnv {Actel:DirectCore:COREAXI4INTERCONNECT:*} -download_core -params $params

puts "TCL_END: [info script]"
