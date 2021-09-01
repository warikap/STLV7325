/*

Copyright (c) 2021 Marcin Zaremba

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

module Ethernet10Gtest
(
    input       clk100,
    input       clk156_p,
    input       clk156_n,
    
    input       KEY3,
    
    input       rxn_0,
    input       rxp_0,
    output      txn_0,
    output      txp_0,
    
    input       rxn_1,
    input       rxp_1,
    output      txn_1,
    output      txp_1
);

wire [535:0] configuration_vector_0;
wire [535:0] configuration_vector_1;

//assign configuration_vector_0[0]   = pma_loopback;
assign configuration_vector_0[0]   = 1'b0;
assign configuration_vector_0[14:1] = 0;
//assign configuration_vector_0[15]  = pma_reset;
assign configuration_vector_0[15]  = 1'b0;
//assign configuration_vector_0[16]  = global_tx_disable;
assign configuration_vector_0[16]  = 1'b0;
assign configuration_vector_0[79:17] = 0;
assign configuration_vector_0[83:80] = 0;
assign configuration_vector_0[109:84] = 0;
//assign configuration_vector_0[110] = pcs_loopback;
assign configuration_vector_0[110] = 1'b0;
//assign configuration_vector_0[111] = pcs_reset;
assign configuration_vector_0[111] = 1'b0;
//assign configuration_vector_0[169:112] = test_patt_a_b;
assign configuration_vector_0[169:112] = 58'b0;
assign configuration_vector_0[175:170] = 0;
//assign configuration_vector_0[233:176] = test_patt_a_b;
assign configuration_vector_0[233:176] = 58'b0;
assign configuration_vector_0[239:234] = 0;
//assign configuration_vector_0[240] = data_patt_sel;
assign configuration_vector_0[240] = 1'b0;
//assign configuration_vector_0[241] = test_patt_sel;
assign configuration_vector_0[241] = 1'b0;
//assign configuration_vector_0[242] = rx_test_patt_en;
assign configuration_vector_0[242] = 1'b0;
//assign configuration_vector_0[243] = tx_test_patt_en;
assign configuration_vector_0[243] = 1'b0;
//assign configuration_vector_0[244] = prbs31_tx_en;
assign configuration_vector_0[244] = 1'b0;
//assign configuration_vector_0[245] = prbs31_rx_en;
assign configuration_vector_0[245] = 1'b0;
assign configuration_vector_0[269:246] = 0;
assign configuration_vector_0[271:270] = 0;
assign configuration_vector_0[383:272] = 0;
assign configuration_vector_0[399:384] = 16'h4C4B;
assign configuration_vector_0[511:400] = 0;
//assign configuration_vector_0[512] = set_pma_link_status;
assign configuration_vector_0[512] = 1'b0;
assign configuration_vector_0[515:513] = 0;
//assign configuration_vector_0[516] = set_pcs_link_status;
assign configuration_vector_0[516] = 1'b0;
assign configuration_vector_0[517] = 0;
//assign configuration_vector[518] = clear_pcs_status2;
assign configuration_vector_0[518] = 1'b0;
//assign configuration_vector_0[519] = clear_test_patt_err_count;
assign configuration_vector_0[519] = 1'b0;
assign configuration_vector_0[535:520] = 0;

//assign configuration_vector_1[0]   = pma_loopback;
assign configuration_vector_1[0]   = 1'b0;
assign configuration_vector_1[14:1] = 0;
//assign configuration_vector_1[15]  = pma_reset;
assign configuration_vector_1[15]  = 1'b0;
//assign configuration_vector_1[16]  = global_tx_disable;
assign configuration_vector_1[16]  = 1'b0;
assign configuration_vector_1[79:17] = 0;
assign configuration_vector_1[83:80] = 0;
assign configuration_vector_1[109:84] = 0;
//assign configuration_vector_1[110] = pcs_loopback;
assign configuration_vector_1[110] = 1'b0;
//assign configuration_vector_1[111] = pcs_reset;
assign configuration_vector_1[111] = 1'b0;
//assign configuration_vector_1[169:112] = test_patt_a_b;
assign configuration_vector_1[169:112] = 58'b0;
assign configuration_vector_1[175:170] = 0;
//assign configuration_vector_1[233:176] = test_patt_a_b;
assign configuration_vector_1[233:176] = 58'b0;
assign configuration_vector_1[239:234] = 0;
//assign configuration_vector_1[240] = data_patt_sel;
assign configuration_vector_1[240] = 1'b0;
//assign configuration_vector_1[241] = test_patt_sel;
assign configuration_vector_1[241] = 1'b0;
//assign configuration_vector_1[242] = rx_test_patt_en;
assign configuration_vector_1[242] = 1'b0;
//assign configuration_vector_1[243] = tx_test_patt_en;
assign configuration_vector_1[243] = 1'b0;
//assign configuration_vector_1[244] = prbs31_tx_en;
assign configuration_vector_1[244] = 1'b0;
//assign configuration_vector_1[245] = prbs31_rx_en;
assign configuration_vector_1[245] = 1'b0;
assign configuration_vector_1[269:246] = 0;
assign configuration_vector_1[271:270] = 0;
assign configuration_vector_1[383:272] = 0;
assign configuration_vector_1[399:384] = 16'h4C4B;
assign configuration_vector_1[511:400] = 0;
//assign configuration_vector_1[512] = set_pma_link_status;
assign configuration_vector_1[512] = 1'b0;
assign configuration_vector_1[515:513] = 0;
//assign configuration_vector_1[516] = set_pcs_link_status;
assign configuration_vector_1[516] = 1'b0;
assign configuration_vector_1[517] = 0;
//assign configuration_vector_1[518] = clear_pcs_status2;
assign configuration_vector_1[518] = 1'b0;
//assign configuration_vector_1[519] = clear_test_patt_err_count;
assign configuration_vector_1[519] = 1'b0;
assign configuration_vector_1[535:520] = 0;

system system_i (
    .clk100 ( clk100 ),
    .resetn ( KEY3 ),
    
    .rxn_0  ( rxn_0 ),
    .rxp_0  ( rxp_0 ),
    .txn_0  ( txn_0 ),
    .txp_0  ( txp_0 ),
    .configuration_vector_0 ( configuration_vector_0 ),
    
    .rxn_1  ( rxn_1 ),
    .rxp_1  ( rxp_1 ),
    .txn_1  ( txn_1 ),
    .txp_1  ( txp_1 ),
    .configuration_vector_1 ( configuration_vector_1 ),
    
    .xcvr_refclk_156_clk_n ( clk156_n ),
    .xcvr_refclk_156_clk_p ( clk156_p )
);

endmodule
