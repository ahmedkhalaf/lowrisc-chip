// See LICENSE for license details.

`include "consts.vh"
`include "config.vh"
`timescale 1ns/1ps

module tb;

   logic clk, rst;

   chip_top
   DUT
     (
      .*,
      .clk_p        ( clk       ),
      .clk_n        ( !clk      ),
`ifdef FPGA_FULL
 `ifdef NEXYS4_COMMON
      .rst_top      ( !rst      )         // NEXYS4's cpu_reset is active low
 `else
      .rst_top      ( rst       )
 `endif
`else
      .rst_top      ( rst       )
`endif
      );

   initial begin
      rst = 1;
      #130;
      rst = 0;
   end

   initial begin
      clk = 0;
  `ifdef KC705
      forever clk = #2.5 !clk;
  `else
      forever clk = #5 !clk;
  `endif
   end // initial begin

`ifdef ADD_PHY_DDR
 `ifdef KC705

   // DDRAM3
   wire [63:0]  ddr_dq;
   wire [7:0]   ddr_dqs_n;
   wire [7:0]   ddr_dqs_p;
   logic [13:0] ddr_addr;
   logic [2:0]  ddr_ba;
   logic        ddr_ras_n;
   logic        ddr_cas_n;
   logic        ddr_we_n;
   logic        ddr_reset_n;
   logic        ddr_ck_p;
   logic        ddr_ck_n;
   logic        ddr_cke;
   logic        ddr_cs_n;
   wire [7:0]   ddr_dm;
   logic        ddr_odt;

   // behavioural DDR3 RAM
   genvar       i;
   generate
      for (i = 0; i < 8; i = i + 1) begin: gen_mem
         ddr3_model u_comp_ddr3
               (
                .rst_n   ( ddr_reset_n     ),
                .ck      ( ddr_ck_p        ),
                .ck_n    ( ddr_ck_n        ),
                .cke     ( ddr_cke         ),
                .cs_n    ( ddr_cs_n        ),
                .ras_n   ( ddr_ras_n       ),
                .cas_n   ( ddr_cas_n       ),
                .we_n    ( ddr_we_n        ),
                .dm_tdqs ( ddr_dm[i]       ),
                .ba      ( ddr_ba          ),
                .addr    ( ddr_addr        ),
                .dq      ( ddr_dq[8*i +:8] ),
                .dqs     ( ddr_dqs_p[i]    ),
                .dqs_n   ( ddr_dqs_n[i]    ),
                .tdqs_n  (                 ),
                .odt     ( ddr_odt         )
                );
      end
   endgenerate

 `elsif NEXYS4_VIDEO

   // DDRAM3
   wire [15:0]  ddr_dq;
   wire [1:0]   ddr_dqs_n;
   wire [1:0]   ddr_dqs_p;
   logic [14:0] ddr_addr;
   logic [2:0]  ddr_ba;
   logic        ddr_ras_n;
   logic        ddr_cas_n;
   logic        ddr_we_n;
   logic        ddr_reset_n;
   logic        ddr_ck_p;
   logic        ddr_ck_n;
   logic        ddr_cke;
   logic        ddr_cs_n;
   wire [1:0]   ddr_dm;
   logic        ddr_odt;
   
   // behavioural DDR3 RAM
   genvar       i;
   generate
      for (i = 0; i < 2; i = i + 1) begin: gen_mem
         ddr3_model u_comp_ddr3
               (
                .rst_n   ( ddr_reset_n     ),
                .ck      ( ddr_ck_p        ),
                .ck_n    ( ddr_ck_n        ),
                .cke     ( ddr_cke         ),
                .cs_n    ( ddr_cs_n        ),
                .ras_n   ( ddr_ras_n       ),
                .cas_n   ( ddr_cas_n       ),
                .we_n    ( ddr_we_n        ),
                .dm_tdqs ( ddr_dm[i]       ),
                .ba      ( ddr_ba          ),
                .addr    ( ddr_addr        ),
                .dq      ( ddr_dq[8*i +:8] ),
                .dqs     ( ddr_dqs_p[i]    ),
                .dqs_n   ( ddr_dqs_n[i]    ),
                .tdqs_n  (                 ),
                .odt     ( ddr_odt         )
                );
      end
   endgenerate   

 `elsif NEXYS4

   wire [15:0]  ddr_dq;
   wire [1:0]   ddr_dqs_n;
   wire [1:0]   ddr_dqs_p;
   logic [12:0] ddr_addr;
   logic [2:0]  ddr_ba;
   logic        ddr_ras_n;
   logic        ddr_cas_n;
   logic        ddr_we_n;
   logic        ddr_ck_p;
   logic        ddr_ck_n;
   logic        ddr_cke;
   logic        ddr_cs_n;
   wire [1:0]   ddr_dm;
   logic        ddr_odt;

   // behavioural DDR2 RAM
   ddr2_model u_comp_ddr2
     (
      .ck      ( ddr_ck_p        ),
      .ck_n    ( ddr_ck_n        ),
      .cke     ( ddr_cke         ),
      .cs_n    ( ddr_cs_n        ),
      .ras_n   ( ddr_ras_n       ),
      .cas_n   ( ddr_cas_n       ),
      .we_n    ( ddr_we_n        ),
      .dm_rdqs ( ddr_dm          ),
      .ba      ( ddr_ba          ),
      .addr    ( ddr_addr        ),
      .dq      ( ddr_dq          ),
      .dqs     ( ddr_dqs_p       ),
      .dqs_n   ( ddr_dqs_n       ),
      .rdqs_n  (                 ),
      .odt     ( ddr_odt         )
      );
 `endif // !`elsif NEXYS4
`endif //  `ifdef ADD_PHY_DDR

`ifdef ADD_UART
   wire         rxd;
   wire         txd;
   wire         rts;
   wire         cts;

   assign rxd = 'b1;
   assign cts = 'b1;

`endif

`ifdef ADD_FLASH
   tri1         flash_ss;
   tri1 [3:0]   flash_io;

`endif

`ifdef ADD_SPI
   tri1         spi_cs;
   tri1         spi_sclk;
   tri1         spi_mosi;
   tri1         spi_miso;
   tri1         sd_reset;

`else
`ifdef ADD_MINION_SD

   // 4-bit full SD interface
   wire         sd_sclk;
   wire         sd_detect;
   wire [3:0]   sd_dat;
   wire         sd_cmd;
   wire         sd_reset;

   sd_card
   sdflash1
     (
      .sdClk ( sd_sclk ),
      .cmd   ( sd_cmd  ),
      .dat   ( sd_dat  )
      );

   // LED and DIP switch
   wire [7:0]   o_led;
   tri1 [3:0]   i_dip;

   // push button array
   wire         GPIO_SW_C;
   wire         GPIO_SW_W;
   wire         GPIO_SW_E;
   wire         GPIO_SW_N;
   wire         GPIO_SW_S;

   assign GPIO_SW_C = 'b1;
   assign GPIO_SW_W = 'b1;
   assign GPIO_SW_E = 'b1;
   assign GPIO_SW_N = 'b1;
   assign GPIO_SW_S = 'b1;

   //keyboard
   wire         PS2_CLK;
   wire         PS2_DATA;

   assign PS2_CLK = 'bz;
   assign PS2_DATA = 'bz;

  // display
   wire        VGA_HS_O;
   wire        VGA_VS_O;
   wire [3:0]  VGA_RED_O;
   wire [3:0]  VGA_BLUE_O;
   wire [3:0]  VGA_GREEN_O;

`endif //  `ifdef MINION_SD
`endif //  `ifdef ADD_SPI

`ifndef VERILATOR
   // handle all run-time arguments
   string     memfile = "";
   string     vcd_name = "";
   longint    unsigned max_cycle = 0;
   longint    unsigned cycle_cnt = 0;

`ifdef ADD_MEMORY_LOAD
   initial begin
      #1.1;
      if($value$plusargs("load=%s", memfile))
        DUT.ram_behav.memory_load_mem(memfile);
   end // initial begin
`endif

   initial begin
      $value$plusargs("max-cycles=%d", max_cycle);
   end // initial begin

   // vcd
   initial
     begin
        vcd_name = "test.vcd";
        $dumpfile(vcd_name);
        $dumpvars(0);
        $dumpon;
     end // initial begin

   always @(posedge clk) begin
      cycle_cnt = cycle_cnt + 1;
      if(max_cycle != 0 && max_cycle == cycle_cnt)
        $fatal(0, "maximal cycle of %d is reached...", cycle_cnt);
   end
`endif

`ifdef ADD_HOST
   int rv;
   always @(posedge clk) begin
      rv = DUT.host.check_exit();
      if(rv > 0)
        $fatal(rv);
      else if(rv == 0)
        $finish();
   end
`endif

endmodule // tb
