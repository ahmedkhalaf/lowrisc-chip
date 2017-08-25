// See LICENSE for license details.

module keeper
   (
    input                    clk, rstn,
    nasti_channel.slave      nasti
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
   
endmodule // keeper
