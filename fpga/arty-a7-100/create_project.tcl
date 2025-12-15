set project_directory "vivado/arty-a7-100"
set project_name      "arty-a7-100"

create_project ${project_name} ${project_directory} -part xc7a100tcsg324-1

set project_root [get_property directory [current_project]]

################################# sources_1 #################################

if {[string equal [get_filesets -quiet sources_1] ""]} {
  create_fileset -srcset sources_1
}
add_files [list \
  [file normalize "${project_root}/../../target/package_alu.sv"]\
  [file normalize "${project_root}/../../target/package_machine_data.sv"]\
  [file normalize "${project_root}/../../target/alu.sv"]\
  [file normalize "${project_root}/../../target/package_gpr_destination_selector.sv"]\
  [file normalize "${project_root}/../../target/package_ir_source_selector.sv"]\
  [file normalize "${project_root}/../../target/package_lbus_source_selector.sv"]\
  [file normalize "${project_root}/../../target/package_rbus_source_selector.sv"]\
  [file normalize "${project_root}/../../target/package_shifter.sv"]\
  [file normalize "${project_root}/../../target/control_interface.sv"]\
  [file normalize "${project_root}/../../target/package_control_data.sv"]\
  [file normalize "${project_root}/../../target/controler.sv"]\
  [file normalize "${project_root}/../../target/datapath.sv"]\
  [file normalize "${project_root}/../../target/micro_alpha.sv"]\
  [file normalize "${project_root}/../../target/mux.sv"]\
  [file normalize "${project_root}/../../target/shifter.sv"]\
  [file normalize "${project_root}/../../target/uart_receiver.sv"]\
  [file normalize "${project_root}/../../target/uart_receiver_controler.sv"]\
  [file normalize "${project_root}/../../target/uart_transmitter.sv"]\
  [file normalize "${project_root}/../../target/uart_transmitter_controler.sv"]\
  [file normalize "${project_root}/../../target/top.sv"]\
]

create_ip -name blk_mem_gen -vendor xilinx.com -library ip -version 8.4 -module_name main_memory
set_property -dict [list CONFIG.Component_Name {main_memory} CONFIG.Write_Depth_A {65536} CONFIG.Enable_A {Always_Enabled} CONFIG.Load_Init_File {true} CONFIG.Coe_File [file normalize "${project_root}/../../fpga/arty-a7-100/machine_program.coe"]] [get_ips main_memory]
create_ip -name blk_mem_gen -vendor xilinx.com -library ip -version 8.4 -module_name control_memory
set_property -dict [list CONFIG.Component_Name {control_memory} CONFIG.Memory_Type {Single_Port_ROM} CONFIG.Write_Width_A {40} CONFIG.Write_Depth_A {4096} CONFIG.Read_Width_A {40} CONFIG.Enable_A {Always_Enabled} CONFIG.Write_Width_B {40} CONFIG.Read_Width_B {40} CONFIG.Load_Init_File {true} CONFIG.Coe_File [file normalize "${project_root}/../../fpga/arty-a7-100/control_program.coe"] CONFIG.Port_A_Write_Rate {0}] [get_ips control_memory]
create_ip -name fifo_generator -vendor xilinx.com -library ip -version 13.2 -module_name fifo_generator_0
set_property -dict [list CONFIG.Input_Data_Width {8} CONFIG.Input_Depth {256} CONFIG.Output_Data_Width {8} CONFIG.Output_Depth {256} CONFIG.Data_Count_Width {8} CONFIG.Write_Data_Count_Width {8} CONFIG.Read_Data_Count_Width {8} CONFIG.Full_Threshold_Assert_Value {254} CONFIG.Full_Threshold_Negate_Value {253}] [get_ips fifo_generator_0]

################################# constrs_1 #################################

if {[string equal [get_filesets -quiet constrs_1] ""]} {
  create_fileset -constrset constrs_1
}
add_files -fileset constrs_1 "${project_root}/../../fpga/arty-a7-100/constr.xdc"

################################### sim_1 ###################################

if {[string equal [get_filesets -quiet sim_1] ""]} {
    create_fileset -simset sim_1
}
add_files -fileset sim_1 "${project_root}/../../tb/testbench.sv"

################################## synth_1 ##################################

if {[string equal [get_runs -quiet synth_1] ""]} {
    create_run -name synth_1 -part xc7a100tcsg324-1 -flow {Vivado Synthesis 2022} -strategy "Flow_PerfOptimized_high" -report_strategy {No Reports} -constrset constrs_1
} else {
  set_property strategy "Flow_PerfOptimized_high" [get_runs synth_1]
  set_property flow "Vivado Synthesis 2022" [get_runs synth_1]
}
current_run -synthesis [get_runs synth_1]

################################### impl_1 ##################################

if {[string equal [get_runs -quiet impl_1] ""]} {
    create_run -name impl_1 -part xc7a100tcsg324-1 -flow {Vivado Implementation 2022} -strategy "Vivado Implementation Defaults" -report_strategy {No Reports} -constrset constrs_1 -parent_run synth_1
} else {
  set_property strategy "Vivado Implementation Defaults" [get_runs impl_1]
  set_property flow "Vivado Implementation 2022" [get_runs impl_1]
}
current_run -implementation [get_runs impl_1]

quit
