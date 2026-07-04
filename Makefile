.PHONY: all clean

all:
	$(MAKE) -C fpga

clean:
	$(MAKE) clean -C fpga
	$(RM) -rf dependencies *.f target
