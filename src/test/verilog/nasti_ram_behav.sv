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

   assign nasti.ar_ready = 0;

   assign nasti.aw_ready = 1'b0;
   assign nasti.w_ready = 1'b0;

   assign nasti.b_valid = nasti.w_valid && nasti.w_ready;

   assign nasti.b_id = 0;
   assign nasti.b_resp = 0;
   assign nasti.b_user = 0;

   assign nasti.r_id = 0;
   assign nasti.r_data = 0;
   assign nasti.r_resp = 0;
   assign nasti.r_last = 0;
   assign nasti.r_user = 0;
   assign nasti.r_valid = 0;   

endmodule // nasti_ram_behav
