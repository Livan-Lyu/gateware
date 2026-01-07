puts "======== Add ENVM option: BM3 ========"

set envm_bm3_config [generate_temp_file 0]
puts "Temporary eNVM config: $envm_bm3_config"

create_eNVM_bm3_config "$envm_bm3_config" "$HSS_IMAGE_PATH" "$PUBLIC_KEY_X" "$PUBLIC_KEY_Y"

run_tool -name {GENERATEPROGRAMMINGDATA}
configure_envm -cfg_file $envm_bm3_config