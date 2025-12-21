`include "vunit_defines.svh"
`timescale 1ns/1ns

module tb_alu;
  import micro_alpha_veryl_alu_pkg::*;
  import micro_alpha_veryl_machine_data_pkg::*;

  localparam [31:0] CLOCK_PERIOD = 32'd10;

  alu_operation_t     operation;
  MICRO1_MACHINE_WORD left;
  MICRO1_MACHINE_WORD right;
  logic               cin;
  MICRO1_MACHINE_WORD result;
  wire                cout;

  `TEST_SUITE begin
    `TEST_CASE("test_add_without_carry") begin
      operation = alu_operation_t_ADD;
      left = 16'd20;
      right = 16'd32;
      cin = 1'b0;

      #CLOCK_PERIOD;

      `CHECK_EQUAL(result, 16'd52);
      `CHECK_EQUAL(cout, 1'b0);
    end
    `TEST_CASE("test_add_with_carry") begin
      operation = alu_operation_t_ADD;
      left = 16'd20;
      right = 16'd32;
      cin = 1'b1;

      #CLOCK_PERIOD;

      `CHECK_EQUAL(result, 16'd53);
      `CHECK_EQUAL(cout, 1'b0);
    end
    `TEST_CASE("test_add_without_carry_then_overflow") begin
      operation = alu_operation_t_ADD;
      left = 16'hFFF3;
      right = 16'h000E;
      cin = 1'b0;

      #CLOCK_PERIOD;

      `CHECK_EQUAL(result, 16'd1);
      `CHECK_EQUAL(cout, 1'b1);
    end
    `TEST_CASE("test_add_with_carry_then_overflow") begin
      operation = alu_operation_t_ADD;
      left = 16'hFFF3;
      right = 16'h000E;
      cin = 1'b1;

      #CLOCK_PERIOD;

      `CHECK_EQUAL(result, 16'd2);
      `CHECK_EQUAL(cout, 1'b1);
    end
    `TEST_CASE("test_sub_without_carry") begin
      operation = alu_operation_t_SUB;
      left = 16'd58;
      right = 16'd13;
      cin = 1'b0;

      #CLOCK_PERIOD;

      `CHECK_EQUAL(result, 16'd45);
      `CHECK_EQUAL(cout, 1'b0);
    end
    `TEST_CASE("test_sub_with_carry") begin
      operation = alu_operation_t_SUB;
      left = 16'd58;
      right = 16'd13;
      cin = 1'b1;

      #CLOCK_PERIOD;

      `CHECK_EQUAL(result, 16'd44);
      `CHECK_EQUAL(cout, 1'b0);
    end
    `TEST_CASE("test_sub_without_carry_then_underflow") begin
      operation = alu_operation_t_SUB;
      left = 16'd2;
      right = 16'd5;
      cin = 1'b0;

      #CLOCK_PERIOD;

      `CHECK_EQUAL(result, 16'hFFFD);
      `CHECK_EQUAL(cout, 1'b1);
    end
    `TEST_CASE("test_sub_with_carry_then_underflow") begin
      operation = alu_operation_t_SUB;
      left = 16'd3;
      right = 16'd7;
      cin = 1'b1;

      #CLOCK_PERIOD;

      `CHECK_EQUAL(result, 16'hFFFB);
      `CHECK_EQUAL(cout, 1'b1);
    end
    `TEST_CASE("test_and") begin
      operation = alu_operation_t_AND;
      left = 16'hFAFA;
      right = 16'h5F5F;
      cin = 1'b0;

      #CLOCK_PERIOD;

      `CHECK_EQUAL(result, 16'h5A5A);
      `CHECK_EQUAL(cout, 1'b0);
    end
    `TEST_CASE("test_or") begin
      operation = alu_operation_t_OR;
      left = 16'h5A5A;
      right = 16'hA5A5;
      cin = 1'b0;

      #CLOCK_PERIOD;

      `CHECK_EQUAL(result, 16'hFFFF);
      `CHECK_EQUAL(cout, 1'b0);
    end
    `TEST_CASE("test_xor") begin
      operation = alu_operation_t_XOR;
      left = 16'hFFFF;
      right = 16'h5A5A;
      cin = 1'b0;

      #CLOCK_PERIOD;

      `CHECK_EQUAL(result, 16'hA5A5);
      `CHECK_EQUAL(cout, 1'b0);
    end
    `TEST_CASE("test_nop") begin
      operation = alu_operation_t_NOP;
      left = 16'hA5A5;
      right = 16'h5A5A;
      cin = 1'b0;

      #CLOCK_PERIOD;

      `CHECK_EQUAL(result, 16'hFFFF);
      `CHECK_EQUAL(cout, 1'b0);
    end
  end

  `WATCHDOG(1ms);

  micro_alpha_veryl_alu dut(.*);
endmodule
