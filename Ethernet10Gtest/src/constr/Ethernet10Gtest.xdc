set_property IOSTANDARD LVCMOS25 [get_ports KEY3]
set_property PACKAGE_PIN C24 [get_ports KEY3]

set_property IOSTANDARD LVCMOS25 [get_ports clk100]
set_property PACKAGE_PIN F17 [get_ports clk100]

set_property IOSTANDARD DIFF_SSTL15 [get_ports clk156_p]
set_property PACKAGE_PIN D6 [get_ports clk156_p]
set_property PACKAGE_PIN J4 [get_ports rxp_0]
set_property PACKAGE_PIN L4 [get_ports rxp_1]

set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets clk]
