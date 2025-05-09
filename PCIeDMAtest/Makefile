# FPGA settings
FPGA_PART = xc7k325tffv676-2
FPGA_TOP = PCIeDMAtest

# Files for synthesis
SYN_FILES = src/rtl/PCIeDMAtest.v
#SYN_FILES += src/rtl/eth_mac_10g_fifo_core.v
#SYN_FILES += lib/axis/rtl/axis_adapter.v
#SYN_FILES += lib/axis/rtl/axis_async_fifo.v
#SYN_FILES += lib/axis/rtl/axis_async_fifo_adapter.v
#SYN_FILES += lib/ethernet/rtl/axis_xgmii_rx_32.v
#SYN_FILES += lib/ethernet/rtl/axis_xgmii_rx_64.v
#SYN_FILES += lib/ethernet/rtl/axis_xgmii_tx_32.v
#SYN_FILES += lib/ethernet/rtl/axis_xgmii_tx_64.v
#SYN_FILES += lib/ethernet/rtl/eth_mac_10g.v
#SYN_FILES += lib/ethernet/rtl/eth_mac_10g_fifo.v
#SYN_FILES += lib/ethernet/rtl/lfsr.v
#SYN_FILES += lib/ethernet/rtl/ptp_clock_cdc.v

# XDC files
XDC_FILES = src/constr/PCIeDMAtest.xdc
#XDC_FILES += lib/ethernet/syn/vivado/eth_mac_fifo.tcl
#XDC_FILES += lib/ethernet/lib/axis/syn/vivado/axis_async_fifo.tcl

# IP and BD
TCL_FILES = src/bd/system.tcl

include ../common/vivado.mk
