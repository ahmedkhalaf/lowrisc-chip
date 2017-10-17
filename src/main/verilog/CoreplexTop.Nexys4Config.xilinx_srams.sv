
module data_arrays_0_ext(
  input RW0_clk,
  input [8:0] RW0_addr,
  input RW0_en,
  input RW0_wmode,
  input [31:0] RW0_wmask,
  input [255:0] RW0_wdata,
  output [255:0] RW0_rdata
);

data_arrays_0_ext_artix xilinx_logicore_block_ram (
  .clka(RW0_clk),    // input wire clka
  .ena(RW0_en),      // input wire ena
  .wea(RW0_wmask),      // input wire [31 : 0] wea
  .addra(RW0_addr),  // input wire [8 : 0] addra
  .dina(RW0_wdata),    // input wire [255 : 0] dina
  .douta(RW0_rdata)  // output wire [255 : 0] douta
);

endmodule

module tag_array_ext(
  input RW0_clk,
  input [5:0] RW0_addr,
  input RW0_en,
  input RW0_wmode,
  input [3:0] RW0_wmask,
  input [87:0] RW0_wdata,
  output [87:0] RW0_rdata
);

  reg reg_RW0_ren;
  reg [5:0] reg_RW0_addr;
  reg [87:0] ram [63:0];
  `ifdef RANDOMIZE_MEM_INIT
    integer initvar;
    initial begin
      #0.002 begin end
      for (initvar = 0; initvar < 64; initvar = initvar+1)
        ram[initvar] = {3 {$random}};
      reg_RW0_addr = {1 {$random}};
    end
  `endif
  integer i;
  always @(posedge RW0_clk)
    reg_RW0_ren <= RW0_en && !RW0_wmode;
  always @(posedge RW0_clk)
    if (RW0_en && !RW0_wmode) reg_RW0_addr <= RW0_addr;
  always @(posedge RW0_clk)
    if (RW0_en && RW0_wmode) begin
      if (RW0_wmask[0]) ram[RW0_addr][21:0] <= RW0_wdata[21:0];
      if (RW0_wmask[1]) ram[RW0_addr][43:22] <= RW0_wdata[43:22];
      if (RW0_wmask[2]) ram[RW0_addr][65:44] <= RW0_wdata[65:44];
      if (RW0_wmask[3]) ram[RW0_addr][87:66] <= RW0_wdata[87:66];
    end
  `ifdef RANDOMIZE_GARBAGE_ASSIGN
  reg [95:0] RW0_random;
  `ifdef RANDOMIZE_MEM_INIT
    initial begin
      #0.002 begin end
      RW0_random = {$random, $random, $random};
      reg_RW0_ren = RW0_random[0];
    end
  `endif
  always @(posedge RW0_clk) RW0_random <= {$random, $random, $random};
  assign RW0_rdata = reg_RW0_ren ? ram[reg_RW0_addr] : RW0_random[87:0];
  `else
  assign RW0_rdata = ram[reg_RW0_addr];
  `endif

endmodule

module tag_array_0_ext(
  input RW0_clk,
  input [5:0] RW0_addr,
  input RW0_en,
  input RW0_wmode,
  input [3:0] RW0_wmask,
  input [83:0] RW0_wdata,
  output [83:0] RW0_rdata
);

  reg reg_RW0_ren;
  reg [5:0] reg_RW0_addr;
  reg [83:0] ram [63:0];
  `ifdef RANDOMIZE_MEM_INIT
    integer initvar;
    initial begin
      #0.002 begin end
      for (initvar = 0; initvar < 64; initvar = initvar+1)
        ram[initvar] = {3 {$random}};
      reg_RW0_addr = {1 {$random}};
    end
  `endif
  integer i;
  always @(posedge RW0_clk)
    reg_RW0_ren <= RW0_en && !RW0_wmode;
  always @(posedge RW0_clk)
    if (RW0_en && !RW0_wmode) reg_RW0_addr <= RW0_addr;
  always @(posedge RW0_clk)
    if (RW0_en && RW0_wmode) begin
      if (RW0_wmask[0]) ram[RW0_addr][20:0] <= RW0_wdata[20:0];
      if (RW0_wmask[1]) ram[RW0_addr][41:21] <= RW0_wdata[41:21];
      if (RW0_wmask[2]) ram[RW0_addr][62:42] <= RW0_wdata[62:42];
      if (RW0_wmask[3]) ram[RW0_addr][83:63] <= RW0_wdata[83:63];
    end
  `ifdef RANDOMIZE_GARBAGE_ASSIGN
  reg [95:0] RW0_random;
  `ifdef RANDOMIZE_MEM_INIT
    initial begin
      #0.002 begin end
      RW0_random = {$random, $random, $random};
      reg_RW0_ren = RW0_random[0];
    end
  `endif
  always @(posedge RW0_clk) RW0_random <= {$random, $random, $random};
  assign RW0_rdata = reg_RW0_ren ? ram[reg_RW0_addr] : RW0_random[83:0];
  `else
  assign RW0_rdata = ram[reg_RW0_addr];
  `endif

endmodule

module data_arrays_0_1_ext(
  input RW0_clk,
  input [8:0] RW0_addr,
  input RW0_en,
  input RW0_wmode,
  input [3:0] RW0_wmask,
  input [127:0] RW0_wdata,
  output [127:0] RW0_rdata
);

  reg reg_RW0_ren;
  reg [8:0] reg_RW0_addr;
  reg [127:0] ram [511:0];
  `ifdef RANDOMIZE_MEM_INIT
    integer initvar;
    initial begin
      #0.002 begin end
      for (initvar = 0; initvar < 512; initvar = initvar+1)
        ram[initvar] = {4 {$random}};
      reg_RW0_addr = {1 {$random}};
    end
  `endif
  integer i;
  always @(posedge RW0_clk)
    reg_RW0_ren <= RW0_en && !RW0_wmode;
  always @(posedge RW0_clk)
    if (RW0_en && !RW0_wmode) reg_RW0_addr <= RW0_addr;
  always @(posedge RW0_clk)
    if (RW0_en && RW0_wmode) begin
      if (RW0_wmask[0]) ram[RW0_addr][31:0] <= RW0_wdata[31:0];
      if (RW0_wmask[1]) ram[RW0_addr][63:32] <= RW0_wdata[63:32];
      if (RW0_wmask[2]) ram[RW0_addr][95:64] <= RW0_wdata[95:64];
      if (RW0_wmask[3]) ram[RW0_addr][127:96] <= RW0_wdata[127:96];
    end
  `ifdef RANDOMIZE_GARBAGE_ASSIGN
  reg [127:0] RW0_random;
  `ifdef RANDOMIZE_MEM_INIT
    initial begin
      #0.002 begin end
      RW0_random = {$random, $random, $random, $random};
      reg_RW0_ren = RW0_random[0];
    end
  `endif
  always @(posedge RW0_clk) RW0_random <= {$random, $random, $random, $random};
  assign RW0_rdata = reg_RW0_ren ? ram[reg_RW0_addr] : RW0_random[127:0];
  `else
  assign RW0_rdata = ram[reg_RW0_addr];
  `endif

endmodule
