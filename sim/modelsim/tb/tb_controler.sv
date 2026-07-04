`include "vunit_defines.svh"
`timescale 1ns/1ns

module tb_control;
  import micro_alpha_veryl_alu_pkg::*;
  import micro_alpha_veryl_control_data_pkg::*;
  import micro_alpha_veryl_gpr_destination_selector_pkg::*;
  import micro_alpha_veryl_ir_source_selector_pkg::*;
  import micro_alpha_veryl_lbus_source_selector_pkg::*;
  import micro_alpha_veryl_rbus_source_selector_pkg::*;
  import micro_alpha_veryl_shifter_pkg::*;

  localparam [31:0] CLOCK_PERIOD = 32'd10;

  logic                  clk;
  logic                  rst;
  micro_alpha_veryl_control_if      c_if();
  micro1_control_address_t cm_addr;
  micro1_control_word_t    cm_din;
  logic                  mm_we;
  logic                  if_empty;
  logic                  if_re;
  logic                  of_full;
  logic                  of_we;
  logic                  led_hlt;
  logic                  led_ov;

  always
    #(CLOCK_PERIOD/2) clk = ~clk;

  `TEST_SUITE begin
    `TEST_CASE_SETUP begin
      clk                = 1'b0;
      rst                = 1'b0;
      c_if.ir           = 16'h0;
      c_if.alu_cout     = 1'b0;
      c_if.shifter_cout = 1'b0;
      c_if.lbus_msb     = 1'b0;
      c_if.rbus_msb     = 1'b0;
      c_if.rbus_lower   = 8'h0;
      c_if.abus         = 16'h0;
      c_if.sbus_msb     = 1'b0;
      cm_din             = 40'hFFFFFFFFFF;
      mm_we              = 1'b0;
      if_empty           = 1'b1;
      of_full            = 1'b1;
      led_hlt            = 1'b0;
      led_ov             = 1'b0;

      #CLOCK_PERIOD;

      rst = 1'b1;

      #CLOCK_PERIOD;

      rst = 1'b0;
    end
    `TEST_CASE("test_lbus") begin
      /*************************** phase INIT ***************************/
      cm_din             = 40'h0FFFFFFE00;

      #CLOCK_PERIOD;

      /**************************** phase T1 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_R0);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hFE00);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T2 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_R0);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hFE00);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T3 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_R0);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hFE00);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T4 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_R0);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hFE00);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T5 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_R0);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hFE00);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);
    end
    `TEST_CASE("test_rbus") begin
      /*************************** phase INIT ***************************/
      cm_din             = 40'hF0FFFFFE00;

      #CLOCK_PERIOD;

      /**************************** phase T1 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_R0);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hFE00);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T2 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_R0);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hFE00);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T3 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_R0);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hFE00);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T4 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_R0);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hFE00);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T5 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_R0);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hFE00);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);
    end
    `TEST_CASE("test_al") begin
      /*************************** phase INIT ***************************/
      cm_din             = 40'hFF1FFFFE00;

      #CLOCK_PERIOD;

      /**************************** phase T1 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_ADD);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hFE00);
      `CHECK_EQUAL(c_if.flags, 4'b1001);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T2 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_ADD);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hFE00);
      `CHECK_EQUAL(c_if.flags, 4'b1001);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T3 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_ADD);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hFE00);
      `CHECK_EQUAL(c_if.flags, 4'b1001);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T4 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_ADD);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hFE00);
      `CHECK_EQUAL(c_if.flags, 4'b1001);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T5 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_ADD);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hFE00);
      `CHECK_EQUAL(c_if.flags, 4'b1001);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);
    end
    `TEST_CASE("test_sh") begin
      /*************************** phase INIT ***************************/
      cm_din             = 40'hFFE3FFFE00;

      #CLOCK_PERIOD;

      /**************************** phase T1 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_LEFT_LOGICALLY);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hFE00);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T2 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_LEFT_LOGICALLY);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hFE00);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T3 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_LEFT_LOGICALLY);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hFE00);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T4 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_LEFT_LOGICALLY);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hFE00);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T5 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_LEFT_LOGICALLY);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hFE00);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);
    end
    `TEST_CASE("test_sbus_to_gpr") begin
      /*************************** phase INIT ***************************/
      cm_din             = 40'hFFFC3FFE00;

      #CLOCK_PERIOD;

      /**************************** phase T1 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hFE00);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T2 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hFE00);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T3 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hFE00);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T4 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hFE00);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T5 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_GPR0);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hFE00);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);
    end
    `TEST_CASE("test_sbus_to_pc") begin
      /*************************** phase INIT ***************************/
      cm_din             = 40'hFFFF3FFE00;

      #CLOCK_PERIOD;

      /**************************** phase T1 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hFE00);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T2 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hFE00);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T3 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hFE00);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T4 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hFE00);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T5 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b1);
      `CHECK_EQUAL(c_if.literal, 16'hFE00);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);
    end
    `TEST_CASE("test_mm_rm") begin
      /*************************** phase INIT ***************************/
      cm_din             = 40'hFFFFCFFE00;

      #CLOCK_PERIOD;

      /**************************** phase T1 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hFE00);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T2 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b1);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hFE00);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T3 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hFE00);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T4 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hFE00);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T5 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hFE00);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      cm_din             = 40'hFFFFFFFE00;

      #CLOCK_PERIOD;

      /**************************** phase T1 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hFE00);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T2 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hFE00);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T3 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hFE00);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h002);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T4 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hFE00);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h002);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T5 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hFE00);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h002);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);
    end
    `TEST_CASE("test_mm_wm") begin
      /*************************** phase INIT ***************************/
      cm_din             = 40'hFFFFDFFE00;

      #CLOCK_PERIOD;

      /**************************** phase T1 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hFE00);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T2 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b1);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hFE00);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T3 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hFE00);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T4 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hFE00);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T5 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hFE00);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      cm_din             = 40'hFFFFFFFE00;

      #CLOCK_PERIOD;

      /**************************** phase T1 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hFE00);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T2 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hFE00);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b1);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T3 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hFE00);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h002);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T4 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hFE00);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h002);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T5 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hFE00);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h002);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);
    end
    `TEST_CASE("test_sq") begin
      /*************************** phase INIT ***************************/
      cm_din             = 40'hFFFFF0FE00;

      #CLOCK_PERIOD;

      /**************************** phase T1 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hFE00);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T2 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hFE00);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T3 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hFE00);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'hE00);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T4 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hFE00);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'hE00);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T5 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hFE00);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'hE00);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);
    end
    `TEST_CASE("test_ex_fls") begin
      /*************************** phase INIT ***************************/
      cm_din             = 40'hFFFFFFE200;

      #CLOCK_PERIOD;

      /**************************** phase T1 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hE200);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T2 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hE200);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T3 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hE200);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T4 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hE200);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T5 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b1);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hE200);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);
    end
    `TEST_CASE("test_ex_asc") begin
      /*************************** phase INIT ***************************/
      cm_din             = 40'hFFFFFFE400;

      #CLOCK_PERIOD;

      /**************************** phase T1 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hE400);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T2 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hE400);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T3 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hE400);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T4 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hE400);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T5 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hE400);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);
    end
    `TEST_CASE("test_ex_as1") begin
      /*************************** phase INIT ***************************/
      cm_din             = 40'hFFFFFFE600;

      #CLOCK_PERIOD;

      /**************************** phase T1 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hE600);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b1);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T2 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hE600);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b1);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T3 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hE600);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b1);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T4 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hE600);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b1);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T5 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hE600);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b1);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);
    end
    `TEST_CASE("test_ex_lir") begin
      /*************************** phase INIT ***************************/
      cm_din             = 40'hFFFFFFE800;

      #CLOCK_PERIOD;

      /**************************** phase T1 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hE800);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T2 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hE800);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T3 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_SET_IR);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hE800);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T4 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hE800);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T5 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hE800);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);
    end
    `TEST_CASE("test_ex_lio") begin
      /*************************** phase INIT ***************************/
      c_if.ir           = 16'hED01;
      cm_din             = 40'hFFFFFFEA00;
      of_full            = 1'b0;

      #CLOCK_PERIOD;

      /**************************** phase T1 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hEA00);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T2 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hEA00);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T3 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hEA00);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b1);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T4 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hEA00);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T5 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hEA00);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);
    end
    `TEST_CASE("test_ex_eio") begin
      /*************************** phase INIT ***************************/
      c_if.ir           = 16'hEC00;
      cm_din             = 40'hFFFFFFEE00;
      if_empty           = 1'b0;

      #CLOCK_PERIOD;

      /**************************** phase T1 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hEE00);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T2 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hEE00);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b1);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T3 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hEE00);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b1);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T4 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hEE00);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b1);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T5 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hEE00);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b1);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);
    end
    `TEST_CASE("test_ex_ina") begin
      /*************************** phase INIT ***************************/
      cm_din             = 40'hFFFFFFF400;

      #CLOCK_PERIOD;

      /**************************** phase T1 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hF400);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T2 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hF400);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T3 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hF400);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T4 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hF400);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T5 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_INCREASE_RA);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hF400);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);
    end
    `TEST_CASE("test_ex_inb") begin
      /*************************** phase INIT ***************************/
      cm_din             = 40'hFFFFFFF600;

      #CLOCK_PERIOD;

      /**************************** phase T1 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hF600);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T2 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hF600);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T3 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hF600);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T4 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hF600);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T5 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_INCREASE_RB);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hF600);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);
    end
    `TEST_CASE("test_ex_dcb") begin
      /*************************** phase INIT ***************************/
      cm_din             = 40'hFFFFFFF800;

      #CLOCK_PERIOD;

      /**************************** phase T1 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hF800);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T2 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hF800);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T3 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hF800);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T4 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hF800);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T5 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_DECREASE_RB);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hF800);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);
    end
    `TEST_CASE("test_ex_hlt") begin
      /*************************** phase INIT ***************************/
      cm_din             = 40'hFFFFFFFA00;

      #CLOCK_PERIOD;

      /**************************** phase T1 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hFA00);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T2 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hFA00);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T3 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hFA00);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T4 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hFA00);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T5 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hFA00);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase HLT ***************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hFA00);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b1);
      `CHECK_EQUAL(led_ov, 1'b0);
    end
    `TEST_CASE("test_ex_ov") begin
      /*************************** phase INIT ***************************/
      cm_din             = 40'hFFFFFFFC00;

      #CLOCK_PERIOD;

      /**************************** phase T1 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hFC00);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T2 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hFC00);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h000);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T3 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hFC00);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T4 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hFC00);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase T5 ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hFC00);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b0);

      #CLOCK_PERIOD;

      /**************************** phase OV ****************************/
      `CHECK_EQUAL(c_if.lbus_source_selector, lbus_source_selector_t_NLB);
      `CHECK_EQUAL(c_if.rbus_source_selector, rbus_source_selector_t_NRB);
      `CHECK_EQUAL(c_if.alu_operation, alu_operation_t_NOP);
      `CHECK_EQUAL(c_if.shifter_operation, shifter_operation_t_NOP);
      `CHECK_EQUAL(c_if.gpr_destination_selector, gpr_destination_selector_t_NONE);
      `CHECK_EQUAL(c_if.ir_source_selector, ir_source_selector_t_NO_OPERATION);
      `CHECK_EQUAL(c_if.set_mar, 1'b0);
      `CHECK_EQUAL(c_if.set_fsr, 1'b0);
      `CHECK_EQUAL(c_if.set_pc, 1'b0);
      `CHECK_EQUAL(c_if.literal, 16'hFC00);
      `CHECK_EQUAL(c_if.flags, 4'b0000);
      `CHECK_EQUAL(c_if.cin, 1'b0);
      `CHECK_EQUAL(c_if.inbus_valid, 1'b0);
      `CHECK_EQUAL(cm_addr, 12'h001);
      `CHECK_EQUAL(mm_we, 1'b0);
      `CHECK_EQUAL(if_re, 1'b0);
      `CHECK_EQUAL(of_we, 1'b0);
      `CHECK_EQUAL(led_hlt, 1'b0);
      `CHECK_EQUAL(led_ov, 1'b1);
    end
  end

  `WATCHDOG(1ms);

  micro_alpha_veryl_controler dut(.*);
endmodule
