// See LICENSE for license details.

module nasti_ram_behav
  #(
    ID_WIDTH = 1,
    ADDR_WIDTH = 16,
    DATA_WIDTH = 128,
    USER_WIDTH = 1
    )
   (
    input clk, rstn,
    nasti_channel.slave nasti
    );

     wire                                    PENABLE    ;
     wire                                    PWRITE     ;
     wire [31:0]                             PADDR      ;
     wire                                    PSEL       ;
     wire [31:0]                             PWDATA     ;
     reg  [31:0]                             PRDATA     ;
     wire                                    PREADY = 1'b1   ;
     wire                                    PSLVERR = 1'b0  ;

axi2apb32
#(
    .AXI4_ADDRESS_WIDTH ( ADDR_WIDTH ),
    .AXI4_RDATA_WIDTH   ( DATA_WIDTH ),
    .AXI4_WDATA_WIDTH   ( DATA_WIDTH ),
    .AXI4_ID_WIDTH      ( ID_WIDTH   ),
    .AXI4_USER_WIDTH    ( USER_WIDTH )
)
DUT
(
    .ACLK           (  clk                  ),
    .ARESETn        (  rstn                 ),

    .AWID_i         (  mem_nasti.aw_id      ),
    .AWADDR_i       (  mem_nasti.aw_addr    ),
    .AWLEN_i        (  mem_nasti.aw_len     ),
    .AWSIZE_i       (  mem_nasti.aw_size    ),
    .AWBURST_i      (  mem_nasti.aw_burst   ),
    .AWLOCK_i       (  mem_nasti.aw_lock    ),
    .AWCACHE_i      (  mem_nasti.aw_cache   ),
    .AWPROT_i       (  mem_nasti.aw_prot    ),
    .AWREGION_i     (  mem_nasti.aw_region  ),
    .AWUSER_i       (  mem_nasti.aw_user    ),
    .AWQOS_i        (  mem_nasti.aw_qos     ),
    .AWVALID_i      (  mem_nasti.aw_valid   ),
    .AWREADY_o      (  mem_nasti.aw_ready   ),

    .WDATA_i        (  mem_nasti.w_data     ),
    .WSTRB_i        (  mem_nasti.w_strb     ),
    .WLAST_i        (  mem_nasti.w_last     ),
    .WUSER_i        (  mem_nasti.w_user     ),
    .WVALID_i       (  mem_nasti.w_valid    ),
    .WREADY_o       (  mem_nasti.w_ready    ),

    .BID_o          (  mem_nasti.b_id       ),
    .BRESP_o        (  mem_nasti.b_resp     ),
    .BVALID_o       (  mem_nasti.b_valid    ),
    .BUSER_o        (  mem_nasti.b_user     ),
    .BREADY_i       (  mem_nasti.b_ready    ),

    .ARID_i         (  mem_nasti.ar_id      ),
    .ARADDR_i       (  mem_nasti.ar_addr    ),
    .ARLEN_i        (  mem_nasti.ar_len     ),
    .ARSIZE_i       (  mem_nasti.ar_size    ),
    .ARBURST_i      (  mem_nasti.ar_burst   ),
    .ARLOCK_i       (  mem_nasti.ar_lock    ),
    .ARCACHE_i      (  mem_nasti.ar_cache   ),
    .ARPROT_i       (  mem_nasti.ar_prot    ),
    .ARREGION_i     (  mem_nasti.ar_region  ),
    .ARUSER_i       (  mem_nasti.ar_user    ),
    .ARQOS_i        (  mem_nasti.ar_qos     ),
    .ARVALID_i      (  mem_nasti.ar_valid   ),
    .ARREADY_o      (  mem_nasti.ar_ready   ),

    .RID_o          (  mem_nasti.r_id       ),
    .RDATA_o        (  mem_nasti.r_data     ),
    .RRESP_o        (  mem_nasti.r_resp     ),
    .RLAST_o        (  mem_nasti.r_last     ),
    .RUSER_o        (  mem_nasti.r_user     ),
    .RVALID_o       (  mem_nasti.r_valid    ),
    .RREADY_i       (  mem_nasti.r_ready    ),
    
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

   reg [DATA_WIDTH-1:0]                      mem[0 : (1<<ADDR_WIDTH) ];

   always @(posedge clk) if (PSEL && PENABLE)
     begin
        if (PWRITE)
          mem[PADDR[ADDR_WIDTH-1:0]] <= PWDATA;
        else
          PRDATA <= mem[PADDR[ADDR_WIDTH-1:0]];
     end
   
endmodule // nasti_ram_behav
