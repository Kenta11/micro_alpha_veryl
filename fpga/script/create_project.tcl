set project_directory "vivado/$env(BOARD_NAME)"

create_project $env(BOARD_NAME) ${project_directory} -part $env(PART_NAME)

set project_root [get_property directory [current_project]]

################################# sources_1 #################################

if {[string equal [get_filesets -quiet sources_1] ""]} {
  create_fileset -srcset sources_1
}

set f [open "${project_root}/../../../micro_alpha_veryl.f" r]
set file_list [split [read $f] "\n"]
close $f
puts $file_list
set file_list [lsearch -all -inline -not -exact $file_list ""]
puts $file_list
add_files $file_list

create_ip -name blk_mem_gen -vendor xilinx.com -library ip -version 8.4 -module_name main_memory
set_property -dict [list CONFIG.Write_Depth_A $env(MAIN_MEMORY_SIZE) CONFIG.Enable_A {Always_Enabled} CONFIG.Load_Init_File {true} CONFIG.Coe_File [file normalize "${project_root}/machine_program.coe"]] [get_ips main_memory]
create_ip -name blk_mem_gen -vendor xilinx.com -library ip -version 8.4 -module_name control_memory
set_property -dict [list CONFIG.Memory_Type {Single_Port_ROM} CONFIG.Write_Width_A {40} CONFIG.Write_Depth_A $env(CONTROL_MEMORY_SIZE) CONFIG.Read_Width_A {40} CONFIG.Enable_A {Always_Enabled} CONFIG.Write_Width_B {40} CONFIG.Read_Width_B {40} CONFIG.Load_Init_File {true} CONFIG.Coe_File [file normalize "${project_root}/control_program.coe"] CONFIG.Port_A_Write_Rate {0}] [get_ips control_memory]
create_ip -name fifo_generator -vendor xilinx.com -library ip -version 13.2 -module_name fifo_generator_0
set_property -dict [list CONFIG.Input_Data_Width {8} CONFIG.Input_Depth {256} CONFIG.Output_Data_Width {8} CONFIG.Output_Depth {256} CONFIG.Data_Count_Width {8} CONFIG.Write_Data_Count_Width {8} CONFIG.Read_Data_Count_Width {8} CONFIG.Full_Threshold_Assert_Value {254} CONFIG.Full_Threshold_Negate_Value {253}] [get_ips fifo_generator_0]

################################# constrs_1 #################################

if {[string equal [get_filesets -quiet constrs_1] ""]} {
  create_fileset -constrset constrs_1
}
add_files -fileset constrs_1 "${project_root}/../../board/$env(BOARD_NAME)/constr.xdc"

################################### sim_1 ###################################

if {[string equal [get_filesets -quiet sim_1] ""]} {
    create_fileset -simset sim_1
}
add_files -fileset sim_1 "${project_root}/../../testbench.sv"

################################## synth_1 ##################################

if {[string equal [get_runs -quiet synth_1] ""]} {
    create_run -name synth_1 -part $env(PART_NAME) -flow {Vivado Synthesis 2022} -strategy "Vivado Synthesis Defaults" -report_strategy {No Reports} -constrset constrs_1
} else {
  set_property strategy "Vivado Synthesis Defaults" [get_runs synth_1]
  set_property flow "Vivado Synthesis 2022" [get_runs synth_1]
}
current_run -synthesis [get_runs synth_1]

################################### impl_1 ##################################

if {[string equal [get_runs -quiet impl_1] ""]} {
    create_run -name impl_1 -part $env(PART_NAME) -flow {Vivado Implementation 2022} -strategy "Vivado Implementation Defaults" -report_strategy {No Reports} -constrset constrs_1 -parent_run synth_1
} else {
  set_property strategy "Vivado Implementation Defaults" [get_runs impl_1]
  set_property flow "Vivado Implementation 2022" [get_runs impl_1]
}
current_run -implementation [get_runs impl_1]

quit
