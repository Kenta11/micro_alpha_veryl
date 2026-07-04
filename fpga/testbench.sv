`timescale 1ns / 1ps
module testbench;
  logic       clk;
  logic       rst;
  wire        rxd;
  wire        txd;
  wire        led_hlt;
  wire        led_ov;
  logic [7:0] din;
  logic       empty;
  wire        re;
  wire  [7:0] dout;
  wire        we;
  string str = "6 2 + 3 1 - *\r";

  micro_alpha_veryl_top dut (
    .clk_in(clk),
    .rst_in(rst),
    .rxd(rxd),
    .txd(txd),
    .led_hlt(led_hlt),
    .led_ov(led_ov)
  );
  
  micro_alpha_veryl_uart_transmitter_controler tx(
    .clk(clk),
    .rst(~rst),
    .din(din),
    .empty(empty),
    .re(re),
    .dout(rxd)
  );
  
  micro_alpha_veryl_uart_receiver_controler rx (
    .clk(clk),
    .rst(~rst),
    .din(txd),
    .dout(dout),
    .full(1'b0),
    .we(we)
  );
  
  parameter [31:0] CLOCK_PERIOD = 32'd10;
  
  always
    #(CLOCK_PERIOD/2) clk = ~clk;

  initial 
  begin
    clk = 1'b0;
    rst = 1'b1;
    din    = 8'h0;
    empty  = 1'h1;
    
    #CLOCK_PERIOD rst = 1'b0;
    
    #CLOCK_PERIOD rst = 1'b1;
    
    #(CLOCK_PERIOD*600);
    
    for (integer i = 0; i < str.len(); i = i + 1)
    begin
      din = str[i];
      empty = 1'b0;
      #CLOCK_PERIOD empty = 1'b1;
      #(CLOCK_PERIOD*10000);
    end
    
    $stop;
  end

endmodule
