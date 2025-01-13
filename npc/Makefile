CFLAGS = -I$(PWD)/include -Wall 
TOPNAME = top

VERILATOR = verilator 
VERILATOR_CFLAGS += -MMD --build -cc  \
			-O3 --x-assign fast --x-initial fast --noassert

BUILD_DIR = ./build
BIN = $(BUILD_DIR)/$(TOPNAME)

all:
	@echo "Write this Makefile by your self."

run: $(BIN)
	@$^

sim:
	$(call git_commit, "sim RTL") # DO NOT REMOVE THIS LINE!!!
	# @echo "Write this Makefile by your self."
	verilator $(CFLAGS) *.cpp *.v --cc --exe --build -j 0 --trace 
include ../Makefile
