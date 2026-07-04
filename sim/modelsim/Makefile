F_FILE := ../../micro_alpha_veryl.f
SRCS   := $(shell cat $(F_FILE) 2>/dev/null)
TESTS  := $(wildcard tb/*)

.PHONY: all clean

all: veryl_build
	$(MAKE) vunit_out

veryl_build:
	cd ../../ && veryl build

vunit_out: $(SRCS) $(TESTS)
	SRCS="$(SRCS)" TESTS="$(TESTS)" python script/unittest.py

clean:
	$(RM) -rf vunit_out
