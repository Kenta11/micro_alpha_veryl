SCRIPT = fpga/arty-a7-100/create_project.tcl # Arty A7-100
# SCRIPT = fpga/basys-3/create_project.tcl # Basys 3

SRCS = alu.sv \
       control_interface.sv \
       controler.sv \
       datapath.sv \
       mux.sv \
       package_alu.sv \
       package_control_data.sv \
       package_gpr_destination_selector.sv \
       package_ir_source_selector.sv \
       package_lbus_source_selector.sv \
       package_machine_data.sv \
       package_rbus_source_selector.sv \
       package_shifter.sv \
       shifter.sv
TESTS = tb_alu.sv \
        tb_controler.sv \
        tb_datapath.sv \
        tb_mux.sv \
        tb_shifter.sv

.PHONY: all test clean

all: vivado

vivado: $(SCRIPT) $(addprefix target/, $(SRCS))
	vivado -mode tcl -source $(SCRIPT)

test: vunit_out

vunit_out: script/unittest.py $(addprefix target/, $(SRCS)) $(addprefix tb/, $(TESTS))
	python script/unittest.py

clean:
	rm -rf vivado *.jou *.log vunit_out
