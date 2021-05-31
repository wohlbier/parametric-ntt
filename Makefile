PROJECT = fpga/fhe
SOURCES= \
	src/AddressGenerator.v \
	src/BRAM.v \
	src/CSA.v \
	src/defines.v \
	src/FA.v \
	src/intMult.v \
	src/ModMult.v \
	src/ModRed_sub.v \
	src/ModRed.v \
	src/NTT2.v \
	src/NTTN.v \
	src/ShiftReg.v \
	src/test_NTTN.v

ICEBREAKER_DEVICE = up5k
ICEBREAKER_PIN_DEF = fpga/icebreaker.pcf
ICEBREAKER_PACKAGE = sg48
SEED = 1

# COCOTB variables
export COCOTB_REDUCED_LOG_FMT=1
export PYTHONPATH := test:$(PYTHONPATH)

all: test_NTTN

test_NTTN:
	$(RM) -rf sim_build/
	mkdir sim_build/
	iverilog -o sim_build/sim.vvp -s test_NTTN -s dump -g2012 $(SOURCES) test/dump_NTTN.v
	PYTHONOPTIMIZE=${NOASSERT} MODULE=test.test_NTTN vvp -M $$(cocotb-config --prefix)/cocotb/libs -m libcocotbvpi_icarus sim_build/sim.vvp

show_%: %.vcd %.gtkw
	gtkwave $^

# FPGA recipes

show_synth_%: src/%.v
	yosys -p "read_verilog $<; proc; opt; show -colors 2 -width -signed"

%.json: $(SOURCES)
	yosys -l fpga/yosys.log -p 'synth_ice40 -top rgb_mixer -json $(PROJECT).json' $(SOURCES)

%.asc: %.json $(ICEBREAKER_PIN_DEF) 
	nextpnr-ice40 -l fpga/nextpnr.log --seed $(SEED) --freq 20 --package $(ICEBREAKER_PACKAGE) --$(ICEBREAKER_DEVICE) --asc $@ --pcf $(ICEBREAKER_PIN_DEF) --json $<

%.bin: %.asc
	icepack $< $@

prog: $(PROJECT).bin
	iceprog $<

# general recipes

lint:
	verible-verilog-lint src/*v --rules_config verible.rules

clean:
	-$(RM) -rf *vcd fpga/*bin fpga/*log sim_build test/__pycache__

allclean: clean
	-$(RM) -rf results.xml test/*.txt

.PHONY: allclean clean
