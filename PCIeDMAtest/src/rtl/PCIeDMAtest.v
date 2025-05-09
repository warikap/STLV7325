/*

Copyright (c) 2025 Marcin Zaremba

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

*/

// Language: Verilog 2001

`timescale 1 ps / 1 ps

module PCIeDMAtest
(
    input   [3:0]   pcie_rx_n,
    input   [3:0]   pcie_rx_p,
    output  [3:0]   pcie_tx_n,
    output  [3:0]   pcie_tx_p,
    input           pcie_perstn,
    input           pcie_refclk_clk_n,
    input           pcie_refclk_clk_p,
    output          led0,
    output          led1
);

wire user_clk_heartbeat;
wire user_lnk_up;
assign led0 = ~user_clk_heartbeat;
assign led1 = ~user_lnk_up;

system system_i
(
    .pci_express_x4_rxn ( pcie_rx_n ),
    .pci_express_x4_rxp ( pcie_rx_p ),
    .pci_express_x4_txn ( pcie_tx_n ),
    .pci_express_x4_txp ( pcie_tx_p ),
    .pcie_perstn        ( pcie_perstn ),
    .pcie_refclk_clk_n  ( pcie_refclk_clk_n ),
    .pcie_refclk_clk_p  ( pcie_refclk_clk_p ),

    .user_clk_heartbeat ( user_clk_heartbeat ),
    .user_lnk_up        ( user_lnk_up ),
    .user_resetn        (  )
);

endmodule
