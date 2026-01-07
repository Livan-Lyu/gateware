puts "======== Add ENVM option: BM1 ========"

set envm_bm1_config [generate_temp_file 0]
puts "Temporary eNVM config: $envm_bm1_config"

create_eNVM_bm1_config "$envm_bm1_config" "$HSS_IMAGE_PATH"

run_tool -name {GENERATEPROGRAMMINGDATA}
configure_envm -cfg_file $envm_bm1_config