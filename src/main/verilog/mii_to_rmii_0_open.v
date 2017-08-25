// File mii_to_rmii_0_exdes.vhd translated with vhd2vl v2.0 VHDL to Verilog RTL translator
// Copyright (C) 2001 Vincenzo Liguori - Ocean Logic Pty Ltd - http://www.ocean-logic.com
// Modifications (C) 2006 Mark Gonzales - PMC Sierra Inc
// 
// vhd2vl comes with ABSOLUTELY NO WARRANTY
// ALWAYS RUN A FORMAL VERIFICATION TOOL TO COMPARE VHDL INPUT TO VERILOG OUTPUT 
// 
// This is free software, and you are welcome to redistribute it under certain conditions.
// See the license file license.txt included with the source for details.

//Example design Top
// file: exdes_top.vhd
// 
// (c) Copyright 2008 - 2013 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
//----------------------------------------------------------------------------
// User entered comments
//----------------------------------------------------------------------------
// This is a self-desigined TOP Wrapper developed for MII to RMII Example Design
//
//----------------------------------------------------------------------------
`default_nettype none

module mii_to_rmii_0_open(
input wire clk_50,
input wire clk_100,
input wire locked,
// SMSC ethernet PHY
output wire eth_rstn,
input wire eth_crsdv,
output wire eth_refclk,
output wire[1:0] eth_txd,
output wire eth_txen,
input wire[1:0] eth_rxd,
input wire eth_rxerr,
output wire eth_mdc,
input wire phy_mdio_i,
output wire phy_mdio_o,
output wire phy_mdio_t,
input wire s_axi_aclk,
input wire s_axi_aresetn,
input wire[31:0] s_axi_awaddr,
input wire s_axi_awvalid,
output wire s_axi_awready,
input wire[31:0] s_axi_wdata,
input wire[3:0] s_axi_wstrb,
input wire s_axi_wvalid,
output wire s_axi_wready,
output wire[1:0] s_axi_bresp,
output wire s_axi_bvalid,
input wire s_axi_bready,
input wire[31:0] s_axi_araddr,
input wire s_axi_arvalid,
output wire s_axi_arready,
output wire[31:0] s_axi_rdata,
output wire[1:0] s_axi_rresp,
output wire s_axi_rvalid,
input wire s_axi_rready,
output wire ip2intc_irpt);

     wire                                    PENABLE    ;
     wire                                    PWRITE     ;
     wire [31:0]                             PADDR      ;
     wire                                    PSEL       ;
     wire [31:0]                             PWDATA     ;
     wire [31:0]                             PRDATA     ;
     wire                                    PREADY = 1'b1   ;
   wire                                      PSLVERR = 1'b0  ;

   assign    ip2intc_irpt = 1'b0;
   

axi2apb32
#(
    .AXI4_ADDRESS_WIDTH ( 32 ),
    .AXI4_RDATA_WIDTH   ( 32 ),
    .AXI4_WDATA_WIDTH   ( 32 ),
    .AXI4_ID_WIDTH      ( 8  ),
    .AXI4_USER_WIDTH    ( 1  )
)
DUT
(
    .ACLK           (  s_axi_aclk       ),
    .ARESETn        (  s_axi_aresetn    ),

    .AWID_i         (  8'b0      ),
    .AWADDR_i       (  s_axi_awaddr   ),
    .AWLEN_i        (  8'b0     ),
    .AWSIZE_i       (  3'b0    ),
    .AWBURST_i      (  2'b0   ),
    .AWLOCK_i       (  1'b0    ),
    .AWCACHE_i      (  4'b0   ),
    .AWPROT_i       (  3'b0    ),
    .AWREGION_i     (  4'b0  ),
    .AWUSER_i       (  1'b0    ),
    .AWQOS_i        (  4'b0     ),
    .AWVALID_i      (  s_axi_awvalid   ),
    .AWREADY_o      (  s_axi_awready   ),

      .WDATA_i          ( s_axi_wdata         ),
      .WSTRB_i          ( s_axi_wstrb         ),
      .WLAST_i          ( 1'b0         ),
      .WUSER_i          ( 1'b0         ),
      .WVALID_i         ( s_axi_wvalid        ),
      .WREADY_o         ( s_axi_wready        ),

      .BID_o            (            ),
      .BRESP_o          ( s_axi_bresp         ),
      .BVALID_o         ( s_axi_bvalid        ),
      .BUSER_o          (          ),
      .BREADY_i         ( s_axi_bready        ),

    .ARID_i         (  8'b0      ),
    .ARADDR_i       (  s_axi_araddr    ),
    .ARLEN_i        (  8'b0     ),
    .ARSIZE_i       (  3'b0    ),
    .ARBURST_i      (  2'b0   ),
    .ARLOCK_i       (  1'b0    ),
    .ARCACHE_i      (  4'b0   ),
    .ARPROT_i       (  3'b0    ),
    .ARREGION_i     (  4'b0  ),
    .ARUSER_i       (  1'b0    ),
    .ARQOS_i        (  4'b0     ),
    .ARVALID_i      (  s_axi_arvalid   ),
    .ARREADY_o      (  s_axi_arready   ),

    .RID_o          (         ),
    .RDATA_o        (  s_axi_rdata     ),
    .RRESP_o        (  s_axi_rresp     ),
    .RLAST_o        (       ),
    .RUSER_o        (       ),
    .RVALID_o       (  s_axi_rvalid    ),
    .RREADY_i       (  s_axi_rready    ),
    
    .PENABLE    (PENABLE    ),
    .PWRITE     (PWRITE     ),
    .PADDR      (PADDR      ),
    .PSEL       (PSEL       ),
    .PWDATA     (PWDATA     ),
    .PRDATA     (PRDATA     ),
    .PREADY     (PREADY     ),
    .PSLVERR    (PSLVERR    ),
   
    .test_en_i      (  1'b0             )
 
);

  wire [3:0] core_lsu_be = 4'b1111;

  //! Ethernet MAC PHY interface signals
wire redled;
   
framing_top open
  (
   .rstn(locked),
   .msoc_clk(s_axi_aclk),
   .clk_50(clk_50),
   .clk_100(clk_100),
   .core_lsu_addr(PADDR),
   .core_lsu_wdata(PWDATA),
   .core_lsu_be(core_lsu_be),
   .ce_d(PENABLE),
   .we_d(PWRITE),
   .framing_sel(PSEL),
   .framing_rdata(PRDATA),
   .o_edutrefclk     (eth_refclk     ),
   .i_edutrxd    (eth_rxd    ),
   .i_edutrx_dv       (eth_crsdv       ),
   .i_edutrx_er       (eth_rxerr       ),
   .o_eduttxd   (eth_txd   ),
   .o_eduttx_en      (eth_txen      ),
   .o_edutmdc        (eth_mdc        ),
   .i_edutmdio   (phy_mdio_i   ),
   .o_edutmdio   (phy_mdio_o   ),
   .oe_edutmdio   (phy_mdio_t   ),
   .o_edutrstn    (eth_rstn    ),   
   .redled(redled)
   );

endmodule
