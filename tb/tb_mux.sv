`include "vunit_defines.svh"
`timescale 1ns/1ns

module tb_mux;
  import micro_alpha_veryl_package_alu::*;

  localparam [31:0] CLOCK_PERIOD = 32'd10;

  logic [31:0]  din [0:1];
  logic         selector;
  wire  [31:0]  dout;

  `TEST_SUITE begin
    `TEST_CASE("test_select_first") begin
      din[0] = 16'hA5A5;
      din[1] = 16'h5A5A;
      selector = 1'b0;

      #CLOCK_PERIOD;

      `CHECK_EQUAL(dout, 16'hA5A5);
    end
    `TEST_CASE("test_select_second") begin
      din[0] = 16'hA5A5;
      din[1] = 16'h5A5A;
      selector = 1'b1;

      #CLOCK_PERIOD;

      `CHECK_EQUAL(dout, 16'h5A5A);
    end
  end

  `WATCHDOG(1ms);

  micro_alpha_veryl_mux dut(.*);
endmodule
