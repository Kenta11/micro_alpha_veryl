`include "vunit_defines.svh"
`timescale 1ns/1ns

module tb_shifter;
  import micro_alpha_veryl_machine_data_pkg::*;
  import micro_alpha_veryl_shifter_pkg::*;

  localparam [31:0] CLOCK_PERIOD = 32'd10;

  SHIFTER_OPERATION   operation;
  MICRO1_MACHINE_WORD in;
  logic               cin;
  MICRO1_MACHINE_WORD out;
  wire                cout;

  `TEST_SUITE begin
    `TEST_CASE("test_shift_left_logically_without_carry") begin
      operation = SHIFTER_OPERATION_LEFT_LOGICALLY;
      in = 16'hA5A5;
      cin = 0;

      #CLOCK_PERIOD;

      `CHECK_EQUAL(out, 16'h4B4A);
      `CHECK_EQUAL(cout, 1'b1);
    end
    `TEST_CASE("test_shift_left_logically_with_carry") begin
      operation = SHIFTER_OPERATION_LEFT_LOGICALLY;
      in = 16'hA5A5;
      cin = 1;

      #CLOCK_PERIOD;

      `CHECK_EQUAL(out, 16'h4B4B);
      `CHECK_EQUAL(cout, 1'b1);
    end
    `TEST_CASE("test_shift_right_logically_without_carry") begin
      operation = SHIFTER_OPERATION_RIGHT_LOGICALLY;
      in = 16'hA5A5;
      cin = 0;

      #CLOCK_PERIOD;

      `CHECK_EQUAL(out, 16'h52D2);
      `CHECK_EQUAL(cout, 1'b1);
    end
    `TEST_CASE("test_shift_right_logically_with_carry") begin
      operation = SHIFTER_OPERATION_RIGHT_LOGICALLY;
      in = 16'hA5A5;
      cin = 1;

      #CLOCK_PERIOD;

      `CHECK_EQUAL(out, 16'hD2D2);
      `CHECK_EQUAL(cout, 1'b1);
    end
    `TEST_CASE("test_shift_left_arithmetically_without_carry") begin
      operation = SHIFTER_OPERATION_LEFT_ARITHMETICALLY;
      in = 16'hFFFF;
      cin = 0;

      #CLOCK_PERIOD;

      `CHECK_EQUAL(out, 16'hFFFE);
      `CHECK_EQUAL(cout, 1'b1);
    end
    `TEST_CASE("test_shift_left_arithmetically_with_carry") begin
      operation = SHIFTER_OPERATION_LEFT_ARITHMETICALLY;
      in = 16'hFFFF;
      cin = 1;

      #CLOCK_PERIOD;

      `CHECK_EQUAL(out, 16'hFFFF);
      `CHECK_EQUAL(cout, 1'b1);
    end
    `TEST_CASE("test_shift_right_arithmetically_without_carry") begin
      operation = SHIFTER_OPERATION_RIGHT_ARITHMETICALLY;
      in = 16'hFFFF;
      cin = 0;

      #CLOCK_PERIOD;

      `CHECK_EQUAL(out, 16'hFFFF);
      `CHECK_EQUAL(cout, 1'b1);
    end
    `TEST_CASE("test_shift_right_arithmetically_with_carry") begin
      operation = SHIFTER_OPERATION_RIGHT_ARITHMETICALLY;
      in = 16'hFFFF;
      cin = 1;

      #CLOCK_PERIOD;

      `CHECK_EQUAL(out, 16'hFFFF);
      `CHECK_EQUAL(cout, 1'b1);
    end
    `TEST_CASE("test_extension_with_unsigned") begin
      operation = SHIFTER_OPERATION_EXTENSION;
      in = 16'h007F;
      cin = 0;

      #CLOCK_PERIOD;

      `CHECK_EQUAL(out, 16'h007F);
      `CHECK_EQUAL(cout, 1'b0);
    end
    `TEST_CASE("test_extension_with_signed") begin
      operation = SHIFTER_OPERATION_EXTENSION;
      in = 16'h00FF;
      cin = 0;

      #CLOCK_PERIOD;

      `CHECK_EQUAL(out, 16'hFFFF);
      `CHECK_EQUAL(cout, 1'b1);
    end
    `TEST_CASE("test_swap") begin
      operation = SHIFTER_OPERATION_SWAP;
      in = 16'h0123;
      cin = 0;

      #CLOCK_PERIOD;

      `CHECK_EQUAL(out, 16'h2301);
      `CHECK_EQUAL(cout, 1'b0);
    end
    `TEST_CASE("test_nop") begin
      operation = SHIFTER_OPERATION_NOP;
      in = 16'h0123;
      cin = 0;

      #CLOCK_PERIOD;

      `CHECK_EQUAL(out, 16'h0123);
      `CHECK_EQUAL(cout, 1'b0);
    end
  end

  `WATCHDOG(1ms);

  micro_alpha_veryl_shifter dut(.*);
endmodule
