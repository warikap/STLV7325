###################################################################
# 
# Xilinx Vivado FPGA Makefile
# 
# Based on verilog-ethernet project by Alex Forencich
# https://github.com/alexforencich/verilog-ethernet
# 
# Copyright (c) 2021-2024 Marcin Zaremba
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
#
###################################################################
#
# Parameters:
# FPGA_TOP - Top module name
# FPGA_PART - FPGA device (e.g. xcvu095-ffva2104-2-e)
# SYN_FILES - space-separated list of source files
# XDC_FILES - space-separated list of timing constraint files
# XCI_FILES - space-separated list of IP XCI files
# TCL_FILES - space-separated list of tcl script files with IP and block diagram definitions
#
# Example:
#
# FPGA_TOP = fpga
# FPGA_PART = xcvu095-ffva2104-2-e
# SYN_FILES = rtl/fpga.v
# XDC_FILES = fpga.xdc
# XCI_FILES = ip/pcspma.xci
# include ../common/vivado.mk
#
###################################################################

# phony targets
.PHONY: clean fpga

# prevent make from deleting intermediate files and reports
.PRECIOUS: %.xpr %.bit %.mcs %.prm
.SECONDARY:

SYN_FILES_REL = $(patsubst %, ../%, $(SYN_FILES))
XCI_FILES_REL = $(patsubst %, ../%, $(XCI_FILES))
TCL_FILES_REL = $(patsubst %, ../%, $(TCL_FILES))
XDC_FILES_REL = $(patsubst %, ../%, $(XDC_FILES))

PROJ_DIR ?= $(FPGA_TOP)

# number of threads
JOBS ?= $$(( $(shell nproc) - 2 ))

###################################################################
# Main Targets
#
# all: build everything
# clean: remove output files and project files
###################################################################

all: fpga

fpga: $(PROJ_DIR)/$(FPGA_TOP).bit

vivado: $(PROJ_DIR)/$(FPGA_TOP).xpr
	cd $(PROJ_DIR) && vivado -nojournal -nolog $(FPGA_TOP).xpr

tmpclean:
	cd $(PROJ_DIR) && rm -rf *.log *.jou *.cache *.gen *.hbs *.hw *.ip_user_files *.runs *.xpr *.html *.xml *.sim *.srcs *.str .Xil
	cd $(PROJ_DIR) && rm -rf create_project.tcl run_synth.tcl run_impl.tcl generate_bit.tcl

clean: tmpclean
	cd $(PROJ_DIR) && rm -rf *.bit program.tcl

distclean:
	rm -rf $(PROJ_DIR)
	rm -rf rev

###################################################################
# Target implementations
###################################################################

# Vivado project file
$(PROJ_DIR)/%.xpr: Makefile $(SYN_FILES) $(XDC_FILES) $(XCI_FILES) $(TCL_FILES)
	mkdir -p $(PROJ_DIR)
	echo "create_project -force -part $(FPGA_PART) $*" > $(PROJ_DIR)/create_project.tcl
	for x in $(SYN_FILES_REL); do echo "add_files -fileset sources_1 $$x" >> $(PROJ_DIR)/create_project.tcl; done
	for x in $(XDC_FILES_REL); do echo "add_files -fileset constrs_1 $$x" >> $(PROJ_DIR)/create_project.tcl; done
	for x in $(XCI_FILES_REL); do echo "import_ip $$x" >> $(PROJ_DIR)/create_project.tcl; done
	for x in $(TCL_FILES_REL); do echo "source $$x" >> $(PROJ_DIR)/create_project.tcl; done
	echo "set_property STEPS.WRITE_BITSTREAM.ARGS.BIN_FILE true [get_runs impl_1]" >> $(PROJ_DIR)/create_project.tcl
	echo "exit" >> $(PROJ_DIR)/create_project.tcl
	cd $(PROJ_DIR) && vivado -nojournal -nolog -mode batch -source create_project.tcl

# synthesis run
$(PROJ_DIR)/%.runs/synth_1/%.dcp: $(PROJ_DIR)/%.xpr
	echo "open_project $*.xpr" > $(PROJ_DIR)/run_synth.tcl
	echo "update_compile_order -fileset sources_1" >> $(PROJ_DIR)/run_synth.tcl
	echo "reset_run synth_1" >> $(PROJ_DIR)/run_synth.tcl
	echo "reset_target all [get_files *.bd]" >> $(PROJ_DIR)/run_synth.tcl
	echo "delete_ip_run [get_files -of_objects [get_fileset sources_1] *.bd]" >> $(PROJ_DIR)/run_synth.tcl
	echo "generate_target all [get_files *.bd]" >> $(PROJ_DIR)/run_synth.tcl
	echo "export_ip_user_files -of_objects [get_files *.bd] -no_script -sync -force -quiet" >> $(PROJ_DIR)/run_synth.tcl
	echo "create_ip_run [get_files -of_objects [get_fileset sources_1] *.bd]" >> $(PROJ_DIR)/run_synth.tcl
	echo "launch_runs -jobs $(JOBS) synth_1" >> $(PROJ_DIR)/run_synth.tcl
	echo "wait_on_run synth_1" >> $(PROJ_DIR)/run_synth.tcl
	echo "exit" >> $(PROJ_DIR)/run_synth.tcl
	cd $(PROJ_DIR) && vivado -nojournal -nolog -mode batch -source run_synth.tcl

# implementation run
$(PROJ_DIR)/%.runs/impl_1/%_routed.dcp: $(PROJ_DIR)/%.runs/synth_1/%.dcp
	echo "open_project $*.xpr" > $(PROJ_DIR)/run_impl.tcl
	echo "reset_run impl_1" >> $(PROJ_DIR)/run_impl.tcl
	echo "launch_runs -jobs $(JOBS) impl_1" >> $(PROJ_DIR)/run_impl.tcl
	echo "wait_on_run impl_1" >> $(PROJ_DIR)/run_impl.tcl
	echo "exit" >> $(PROJ_DIR)/run_impl.tcl
	cd $(PROJ_DIR) && vivado -nojournal -nolog -mode batch -source run_impl.tcl

# bit file
$(PROJ_DIR)/%.bit: $(PROJ_DIR)/%.runs/impl_1/%_routed.dcp
	echo "open_project $*.xpr" > $(PROJ_DIR)/generate_bit.tcl
	echo "open_run impl_1" >> $(PROJ_DIR)/generate_bit.tcl
	echo "write_bitstream -force -bin_file $*.bit" >> $(PROJ_DIR)/generate_bit.tcl
	echo "exit" >> $(PROJ_DIR)/generate_bit.tcl
	cd $(PROJ_DIR) && vivado -nojournal -nolog -mode batch -source generate_bit.tcl
	mkdir -p rev
	EXT=bit; COUNT=100; \
	while [ -e rev/$*_rev$$COUNT.$$EXT ]; \
	do COUNT=$$((COUNT+1)); done; \
	cp $@ rev/$*_rev$$COUNT.$$EXT; \
	echo "Output: rev/$*_rev$$COUNT.$$EXT";
