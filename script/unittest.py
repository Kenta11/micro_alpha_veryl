#!/usr/bin/env python3
# -*- coding: utf-8 -*-


from vunit.verilog import VUnit

vu = VUnit.from_argv()

lib = vu.add_library("lib")

lib.add_source_files("target/alu.sv")
lib.add_source_files("target/control_interface.sv")
lib.add_source_files("target/controler.sv")
lib.add_source_files("target/datapath.sv")
lib.add_source_files("target/mux.sv")
lib.add_source_files("target/package_alu.sv")
lib.add_source_files("target/package_control_data.sv")
lib.add_source_files("target/package_machine_data.sv")
lib.add_source_files("target/package_gpr_destination_selector.sv")
lib.add_source_files("target/package_ir_source_selector.sv")
lib.add_source_files("target/package_lbus_source_selector.sv")
lib.add_source_files("target/package_rbus_source_selector.sv")
lib.add_source_files("target/package_shifter.sv")
lib.add_source_files("target/shifter.sv")

lib.add_source_files("tb/tb_alu.sv")
lib.add_source_files("tb/tb_controler.sv")
lib.add_source_files("tb/tb_datapath.sv")
lib.add_source_files("tb/tb_mux.sv")
lib.add_source_files("tb/tb_shifter.sv")

vu.main()
