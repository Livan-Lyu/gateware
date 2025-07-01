proc read_program_dump {file_path} {
    # Open the file for reading
    set file [open $file_path r]
    
    # Read the first line to get the base address
    set base_address_line [gets $file]
    set base_address [scan [string range $base_address_line 1 end] %x]  ;# Skip '@' and convert to integer
    
    # Read the rest of the file and concatenate into a single string
    set hex_data ""
    while {[gets $file line] >= 0} {
        # Remove spaces and newlines from each line
        append hex_data [string trim [string map [list " " ""] $line]]
    }
    
    close $file
    
    return [list $base_address $hex_data]
}

proc calc_checksum {byte_count address record_type data} {
    set sum [expr {$byte_count + (($address & 0xFF00) >> 8) + ($address & 0xFF) + $record_type}]
    foreach byte $data {
        set sum [expr {$sum + $byte}]
    }
    set sum [expr {$sum & 0xFF}] ;# Ensure sum is within 0-255
    return [format "%02X" [expr {0x100 - $sum} & 0xFF]]
}

proc write_intelhex_file {base_address hex_data output_path} {
    set file [open $output_path w]
    
    # Initialize address
    set address $base_address
    
    # Write data to Intel HEX format
    for {set i 0} {$i < [string length $hex_data]} {incr i 8} {  ;# 8 hex chars = 32 bits
        set word [string range $hex_data $i [expr {$i+7}]]
        
        # Reverse the order of bytes within the 32-bit word
        set byte1 [string range $word 6 7]
        set byte2 [string range $word 4 5]
        set byte3 [string range $word 2 3]
        set byte4 [string range $word 0 1]
        set reversed_word "$byte1$byte2$byte3$byte4"
        
        # Convert the reversed 32-bit word into four 8-bit bytes
        set bytes [list]
        for {set j 0} {$j < 8} {incr j 2} {
            lappend bytes [scan [string range $reversed_word $j [expr {$j+1}]] %02X]
        }
        
        set byte_count 4
        set record_type 0
        set checksum [calc_checksum $byte_count $address $record_type $bytes]
        
        # Write the record
        puts $file [format ":%02X%04X%02X%s%s" $byte_count $address $record_type [join [lmap byte $bytes {format "%02X" $byte}] ""] $checksum]
        
        # Increment the address by 4 bytes
        incr address 4
    }
    
    # Write end of file record
    puts $file ":00000001FF"
    close $file
}

proc main {} {
    set input_file "script_support/components/APU/PICO_RV/firmware/program_dump.hex"
    set output_file "output.hex"
    
    # Read base address and hexadecimal data from the input file
    lassign [read_program_dump $input_file] base_address hex_data
    
    # Write data to Intel HEX format
    write_intelhex_file $base_address $hex_data $output_file
    
    puts "Conversion complete. Intel HEX file saved as '$output_file'."
}

main
