.PHONY: all check clean

all:
	$(MAKE) -C fpga

check:
	veryl test

clean:
	$(MAKE) clean -C fpga
	$(RM) -rf dependencies *.f target
