#############SPI Configurate Setting##################
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
##slow 3,6,9,12,16,22,26,33,40,50,66 fast
set_property BITSTREAM.CONFIG.CONFIGRATE 50 [current_design]
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]

set_property PACKAGE_PIN H6 [get_ports pcie_refclk_clk_p]
create_clock -period 10.000 -name pcie_refclk [get_ports pcie_refclk_clk_p]

set_property IOSTANDARD LVCMOS15 [get_ports led0]
set_property PACKAGE_PIN AA2 [get_ports led0]
set_property IOSTANDARD LVCMOS15 [get_ports led1]
set_property PACKAGE_PIN AD5 [get_ports led1]

#set_property IOSTANDARD LVCMOS33 [get_ports pcie_perstn]
#set_property PACKAGE_PIN C26 [get_ports pcie_perstn]
#set_property PULLUP true [get_ports pcie_perstn]

set_property IOSTANDARD LVCMOS25 [get_ports pcie_perstn]
set_property PACKAGE_PIN E17 [get_ports pcie_perstn]
set_property PULLUP true [get_ports pcie_perstn]

#set_property LOC PCIE_X0Y0 [get_cells inst_gvi_pcie/pcie_wrapper/pcie_k7_gen2x4/U0/inst/pcie_top_i/pcie_7x_i/pcie_block_i]
# set_property LOC IBUFDS_GTE2_X0Y1 [get_cells {inst_gvi_pcie/pcie_wrapper/refclk_ibuf}]
# PCIe Lane 0
#set_property LOC GTXE2_CHANNEL_X0Y7 [get_cells {inst_gvi_pcie/pcie_wrapper/pcie_k7_gen2x4/U0/inst/gt_top_i/pipe_wrapper_i/pipe_lane[0].gt_wrapper_i/gtx_channel.gtxe2_channel_i}]
set_property PACKAGE_PIN B6 [get_ports {pcie_rx_p[0]}]
# PCIe Lane 1
#set_property LOC GTXE2_CHANNEL_X0Y6 [get_cells {inst_gvi_pcie/pcie_wrapper/pcie_k7_gen2x4/U0/inst/gt_top_i/pipe_wrapper_i/pipe_lane[1].gt_wrapper_i/gtx_channel.gtxe2_channel_i}]
set_property PACKAGE_PIN C4 [get_ports {pcie_rx_p[1]}]
# PCIe Lane 2
#set_property LOC GTXE2_CHANNEL_X0Y5 [get_cells {inst_gvi_pcie/pcie_wrapper/pcie_k7_gen2x4/U0/inst/gt_top_i/pipe_wrapper_i/pipe_lane[2].gt_wrapper_i/gtx_channel.gtxe2_channel_i}]
set_property PACKAGE_PIN E4 [get_ports {pcie_rx_p[2]}]
# PCIe Lane 3
#set_property LOC GTXE2_CHANNEL_X0Y4 [get_cells {inst_gvi_pcie/pcie_wrapper/pcie_k7_gen2x4/U0/inst/gt_top_i/pipe_wrapper_i/pipe_lane[3].gt_wrapper_i/gtx_channel.gtxe2_channel_i}]
set_property PACKAGE_PIN G4 [get_ports {pcie_rx_p[3]}]