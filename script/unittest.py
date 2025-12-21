#!/usr/bin/env python3
# -*- coding: utf-8 -*-


from vunit.verilog import VUnit

vu = VUnit.from_argv()

lib = vu.add_library("lib")

lib.add_source_files("target/alu.sv")
lib.add_source_files("target/control_if.sv")
lib.add_source_files("target/controler.sv")
lib.add_source_files("target/datapath.sv")
lib.add_source_files("dependencies/std/selector/mux.sv")
lib.add_source_files("dependencies/std/selector/selector_pkg.sv")
lib.add_source_files("target/alu_pkg.sv")
lib.add_source_files("target/control_data_pkg.sv")
lib.add_source_files("target/machine_data_pkg.sv")
lib.add_source_files("target/gpr_destination_selector_pkg.sv")
lib.add_source_files("target/ir_source_selector_pkg.sv")
lib.add_source_files("target/lbus_source_selector_pkg.sv")
lib.add_source_files("target/rbus_source_selector_pkg.sv")
lib.add_source_files("target/shifter_pkg.sv")
lib.add_source_files("target/shifter.sv")

lib.add_source_files("tb/tb_alu.sv")
lib.add_source_files("tb/tb_controler.sv")
lib.add_source_files("tb/tb_datapath.sv")
lib.add_source_files("tb/tb_shifter.sv")

vu.main()
