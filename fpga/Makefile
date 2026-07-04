SCRIPT   := script/create_project.tcl
BOARD    ?= arty-a7-100
M_SOURCE ?= machine_program
C_SOURCE ?= MICROONE

include board/$(BOARD)/config.mk

M_OBJECT := $(M_SOURCE).b
C_OBJECT := $(C_SOURCE).o
M_COE    := vivado/$(BOARD)/machine_program.coe
C_COE    := vivado/$(BOARD)/control_program.coe

.PHONY: all veryl_build vivado/$(BOARD) clean

all: veryl_build $(M_COE) $(C_COE)
	$(MAKE) vivado/$(BOARD)

veryl_build:
	sed -i 's/^reset_type.*$$/reset_type = "$(RESET_TYPE)"/g' ../Veryl.toml
	cd ../ && veryl build

$(M_COE): $(M_OBJECT)
	mkdir -p $$(dirname $@)
	./script/obj2coe.py $< $@

$(M_OBJECT): $(M_SOURCE)
	rm1asm $< -o $@

$(C_COE): $(C_OBJECT)
	mkdir -p $$(dirname $@)
	./script/obj2coe.py $< $@

$(C_OBJECT): $(C_SOURCE)
	rm1masm $< -o $@

$(C_SOURCE):
	curl -s http://www.ced.is.utsunomiya-u.ac.jp/lecture/2025/jikkenb/micro/chap5/MICROONE | iconv -f sjis -t utf8 | tr -d "\32" > $@

vivado/$(BOARD):
	vivado -mode tcl -source $(SCRIPT)

clean:
	$(RM) -rf vivado *.jou *.log $(M_OBJECT) $(C_OBJECT) $(M_SOURCE) $(C_SOURCE)

