SCRIPT = fpga/arty-a7-100/create_project.tcl # Arty A7-100
# SCRIPT = fpga/basys-3/create_project.tcl # Basys 3

SRCS = alu.sv \
       control_if.sv \
       controler.sv \
       datapath.sv \
       alu_pkg.sv \
       control_data_pkg.sv \
       gpr_destination_selector_pkg.sv \
       ir_source_selector_pkg.sv \
       lbus_source_selector_pkg.sv \
       machine_data_pkg.sv \
       rbus_source_selector_pkg.sv \
       shifter_pkg.sv \
       shifter.sv
TESTS = tb_alu.sv \
        tb_controler.sv \
        tb_datapath.sv \
        tb_shifter.sv

.PHONY: all test clean

all: vivado

vivado: $(SCRIPT) $(addprefix target/, $(SRCS))
	vivado -mode tcl -source $(SCRIPT)

test: vunit_out

vunit_out: script/unittest.py $(addprefix target/, $(SRCS)) $(addprefix tb/, $(TESTS)) dependencies/std/selector/mux.sv
	python script/unittest.py

clean:
	rm -rf vivado *.jou *.log vunit_out
