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

`timescale 1ns / 1ps

/*
 * eth_mac_10g_fifo core logic
 */
module eth_mac_10g_fifo_core
(
    (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 rx_clk CLK" *)
    (* X_INTERFACE_PARAMETER = "ASSOCIATED_BUSIF xgmii, ASSOCIATED_RESET rx_rst:tx_rst" *)
    input  wire                 xgmii_clk,
    (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 rx_rst RST" *)
    (* X_INTERFACE_PARAMETER = "POLARITY ACTIVE_HIGH" *)
    input  wire                 rx_rst,
    (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 tx_rst RST" *)
    (* X_INTERFACE_PARAMETER = "POLARITY ACTIVE_HIGH" *)
    input  wire                 tx_rst,
    (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 logic_clk CLK" *)
    (* X_INTERFACE_PARAMETER = "ASSOCIATED_BUSIF tx_axis:rx_axis, ASSOCIATED_RESET logic_rst" *)
    input  wire                 logic_clk,
    (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 logic_rst RST" *)
    (* X_INTERFACE_PARAMETER = "POLARITY ACTIVE_HIGH" *)
    input  wire                 logic_rst,

    /*
     * AXI output
     */
    output wire     [63:0]      rx_axis_tdata,
    output wire      [7:0]      rx_axis_tkeep,
    output wire                 rx_axis_tvalid,
    input  wire                 rx_axis_tready,
    output wire                 rx_axis_tlast,
    output wire      [0:0]      rx_axis_tuser,

    /*
     * AXI input
     */
    input  wire     [63:0]      tx_axis_tdata,
    input  wire      [7:0]      tx_axis_tkeep,
    input  wire                 tx_axis_tvalid,
    output wire                 tx_axis_tready,
    input  wire                 tx_axis_tlast,
    input  wire                 tx_axis_tuser,

    /*
     * XGMII interface
     */
    (* X_INTERFACE_INFO = "xilinx.com:interface:xgmii:1.0 xgmii RXD" *)
    input  wire     [63:0]      xgmii_rxd,
    (* X_INTERFACE_INFO = "xilinx.com:interface:xgmii:1.0 xgmii RXC" *)
    input  wire      [7:0]      xgmii_rxc,
    (* X_INTERFACE_INFO = "xilinx.com:interface:xgmii:1.0 xgmii TXD" *)
    output wire     [63:0]      xgmii_txd,
    (* X_INTERFACE_INFO = "xilinx.com:interface:xgmii:1.0 xgmii TXC" *)
    output wire      [7:0]      xgmii_txc,

    /*
     * Status
     */
    output wire                 tx_error_underflow,
    output wire                 tx_fifo_overflow,
    output wire                 tx_fifo_bad_frame,
    output wire                 tx_fifo_good_frame,
    output wire                 rx_error_bad_frame,
    output wire                 rx_error_bad_fcs,
    output wire                 rx_fifo_overflow,
    output wire                 rx_fifo_bad_frame,
    output wire                 rx_fifo_good_frame
);

eth_mac_10g_fifo #(
    .ENABLE_PADDING(1),
    .ENABLE_DIC(1),
    .MIN_FRAME_LENGTH(64),
    .TX_FIFO_DEPTH(4096),
    .TX_FRAME_FIFO(1),
    .RX_FIFO_DEPTH(4096),
    .RX_FRAME_FIFO(1)
) eth_mac_10g_fifo_inst 
(
    .rx_clk ( xgmii_clk ),
    .rx_rst ( rx_rst ),
    .tx_clk ( xgmii_clk ),
    .tx_rst ( tx_rst ),
    .logic_clk ( logic_clk ),
    .logic_rst ( logic_rst ),

    .tx_axis_tdata  ( tx_axis_tdata ),
    .tx_axis_tkeep  ( tx_axis_tkeep ),
    .tx_axis_tvalid ( tx_axis_tvalid ),
    .tx_axis_tready ( tx_axis_tready ),
    .tx_axis_tlast  ( tx_axis_tlast ),
    .tx_axis_tuser  ( tx_axis_tuser ),

    .rx_axis_tdata  ( rx_axis_tdata ),
    .rx_axis_tkeep  ( rx_axis_tkeep ),
    .rx_axis_tvalid ( rx_axis_tvalid ),
    .rx_axis_tready ( rx_axis_tready ),
    .rx_axis_tlast  ( rx_axis_tlast ),
    .rx_axis_tuser  ( rx_axis_tuser ),

    .xgmii_rxd  ( xgmii_rxd ),
    .xgmii_rxc  ( xgmii_rxc ),
    .xgmii_txd  ( xgmii_txd ),
    .xgmii_txc  ( xgmii_txc ),

    .tx_error_underflow ( tx_error_underflow ),
    .tx_fifo_overflow   ( tx_fifo_overflow ),
    .tx_fifo_bad_frame  ( tx_fifo_bad_frame ),
    .tx_fifo_good_frame ( tx_fifo_good_frame ),
    .rx_error_bad_frame ( rx_error_bad_frame ),
    .rx_error_bad_fcs   ( rx_error_bad_fcs ),
    .rx_fifo_overflow   ( rx_fifo_overflow ),
    .rx_fifo_bad_frame  ( rx_fifo_bad_frame ),
    .rx_fifo_good_frame ( rx_fifo_good_frame ),

    .ifg_delay(8'd12)
);

endmodule
