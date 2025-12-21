`include "vunit_defines.svh"
`timescale 1ns/1ns

module tb_datapath;
  import micro_alpha_veryl_alu_pkg::*;
  import micro_alpha_veryl_machine_data_pkg::*;
  import micro_alpha_veryl_gpr_destination_selector_pkg::*;
  import micro_alpha_veryl_ir_source_selector_pkg::*;
  import micro_alpha_veryl_lbus_source_selector_pkg::*;
  import micro_alpha_veryl_rbus_source_selector_pkg::*;
  import micro_alpha_veryl_shifter_pkg::*;

  localparam [31:0] CLOCK_PERIOD = 32'd10;

  logic                  clk;
  logic                  rst;
  micro_alpha_veryl_control_if      c_if();
  MICRO1_MACHINE_ADDRESS mm_addr;
  MICRO1_MACHINE_WORD    mm_din;
  MICRO1_MACHINE_WORD    mm_dout;
  logic [7:0]            if_dout;
  logic [7:0]            of_din;

  always
    #(CLOCK_PERIOD/2) clk = ~clk;

  `TEST_SUITE begin
    `TEST_CASE_SETUP begin
      clk                            = 1'b0;
      rst                            = 1'b0;
      c_if.lbus_source_selector     = LBUS_SOURCE_SELECTOR_NLB;
      c_if.rbus_source_selector     = RBUS_SOURCE_SELECTOR_NRB;
      c_if.alu_operation            = ALU_OPERATION_NOP;
      c_if.shifter_operation        = SHIFTER_OPERATION_NOP;
      c_if.gpr_destination_selector = GPR_DESTINATION_SELECTOR_NONE;
      c_if.ir_source_selector       = IR_SOURCE_SELECTOR_NO_OPERATION;
      c_if.set_mar                  = 1'h0;
      c_if.set_fsr                  = 1'h0;
      c_if.set_pc                   = 1'h0;
      c_if.literal                  = 16'h0;
      c_if.flags                    = 4'h0;
      c_if.cin                      = 1'h0;
      c_if.inbus_valid              = 1'h0;
      mm_din                         = 16'h0;
      if_dout                        = 8'h0;

      #CLOCK_PERIOD;

      rst = 1'b1;

      #CLOCK_PERIOD;

      rst = 1'b0;

      #CLOCK_PERIOD;
    end
    `TEST_CASE("test_mar") begin
      c_if.rbus_source_selector     = RBUS_SOURCE_SELECTOR_LLT;
      c_if.gpr_destination_selector = GPR_DESTINATION_SELECTOR_GPR0;
      c_if.literal                  = 16'hBEEF;

      #CLOCK_PERIOD;

      c_if.rbus_source_selector     = RBUS_SOURCE_SELECTOR_NRB;
      c_if.lbus_source_selector     = LBUS_SOURCE_SELECTOR_R0;
      c_if.gpr_destination_selector = GPR_DESTINATION_SELECTOR_NONE;
      c_if.set_mar                  = 1'h1;

      #CLOCK_PERIOD;

      c_if.set_mar                  = 1'h0;

      #CLOCK_PERIOD;

      `CHECK_EQUAL(c_if.ir, 16'h0);
      `CHECK_EQUAL(c_if.alu_cout, 16'h0);
      `CHECK_EQUAL(c_if.shifter_cout, 16'h0);
      `CHECK_EQUAL(c_if.lbus_msb, 1'b1);
      `CHECK_EQUAL(c_if.rbus_msb, 1'b0);
      `CHECK_EQUAL(c_if.rbus_lower, 8'h0);
      `CHECK_EQUAL(c_if.abus, 16'hBEEF);
      `CHECK_EQUAL(c_if.sbus_msb, 1'b1);
      `CHECK_EQUAL(mm_addr, 16'hBEEF);
      `CHECK_EQUAL(mm_dout, 16'hBEEF);
      `CHECK_EQUAL(of_din, 8'hEF);
    end
    `TEST_CASE("test_ir") begin
      c_if.rbus_source_selector     = RBUS_SOURCE_SELECTOR_LLT;
      c_if.gpr_destination_selector = GPR_DESTINATION_SELECTOR_GPR0;
      c_if.literal                  = 16'hBEEF;

      #CLOCK_PERIOD;

      c_if.rbus_source_selector     = RBUS_SOURCE_SELECTOR_NRB;
      c_if.lbus_source_selector     = LBUS_SOURCE_SELECTOR_R0;
      c_if.gpr_destination_selector = GPR_DESTINATION_SELECTOR_NONE;
      c_if.ir_source_selector       = IR_SOURCE_SELECTOR_NO_OPERATION;

      #CLOCK_PERIOD;

      c_if.ir_source_selector       = IR_SOURCE_SELECTOR_SET_IR;

      #CLOCK_PERIOD;

      `CHECK_EQUAL(c_if.ir, 16'hBEEF);
      `CHECK_EQUAL(c_if.alu_cout, 16'h0);
      `CHECK_EQUAL(c_if.shifter_cout, 16'h0);
      `CHECK_EQUAL(c_if.lbus_msb, 1'b1);
      `CHECK_EQUAL(c_if.rbus_msb, 1'b0);
      `CHECK_EQUAL(c_if.rbus_lower, 8'h0);
      `CHECK_EQUAL(c_if.abus, 16'hBEEF);
      `CHECK_EQUAL(c_if.sbus_msb, 1'b1);
      `CHECK_EQUAL(mm_addr, 16'h0140);
      `CHECK_EQUAL(mm_dout, 16'hBEEF);
      `CHECK_EQUAL(of_din, 8'hEF);
    end
    `TEST_CASE("test_flag_zer") begin
      c_if.flags                    = 4'b1000;
      c_if.set_fsr                  = 1'h1;

      #CLOCK_PERIOD;

      c_if.lbus_source_selector     = LBUS_SOURCE_SELECTOR_FSR;
      c_if.set_fsr                  = 1'h0;

      #CLOCK_PERIOD;

      `CHECK_EQUAL(c_if.ir, 16'h0);
      `CHECK_EQUAL(c_if.alu_cout, 16'h0);
      `CHECK_EQUAL(c_if.shifter_cout, 16'h0);
      `CHECK_EQUAL(c_if.lbus_msb, 1'b0);
      `CHECK_EQUAL(c_if.rbus_msb, 1'b0);
      `CHECK_EQUAL(c_if.rbus_lower, 8'h0);
      `CHECK_EQUAL(c_if.abus, 16'h8);
      `CHECK_EQUAL(c_if.sbus_msb, 1'b0);
      `CHECK_EQUAL(mm_addr, 16'h0140);
      `CHECK_EQUAL(mm_dout, 16'h8);
      `CHECK_EQUAL(of_din, 8'h08);
    end
    `TEST_CASE("test_flag_neg") begin
      c_if.flags                    = 4'b0100;
      c_if.set_fsr                  = 1'h1;

      #CLOCK_PERIOD;

      c_if.lbus_source_selector     = LBUS_SOURCE_SELECTOR_FSR;
      c_if.set_fsr                  = 1'h0;

      #CLOCK_PERIOD;

      `CHECK_EQUAL(c_if.ir, 16'h0);
      `CHECK_EQUAL(c_if.alu_cout, 16'h0);
      `CHECK_EQUAL(c_if.shifter_cout, 16'h0);
      `CHECK_EQUAL(c_if.lbus_msb, 1'b0);
      `CHECK_EQUAL(c_if.rbus_msb, 1'b0);
      `CHECK_EQUAL(c_if.rbus_lower, 8'h0);
      `CHECK_EQUAL(c_if.abus, 16'h4);
      `CHECK_EQUAL(c_if.sbus_msb, 1'b0);
      `CHECK_EQUAL(mm_addr, 16'h0140);
      `CHECK_EQUAL(mm_dout, 16'h4);
      `CHECK_EQUAL(of_din, 8'h04);
    end
    `TEST_CASE("test_flag_cry") begin
      c_if.flags                    = 4'b0010;
      c_if.set_fsr                  = 1'h1;

      #CLOCK_PERIOD;

      c_if.lbus_source_selector     = LBUS_SOURCE_SELECTOR_FSR;
      c_if.set_fsr                  = 1'h0;

      #CLOCK_PERIOD;

      `CHECK_EQUAL(c_if.ir, 16'h0);
      `CHECK_EQUAL(c_if.alu_cout, 16'h0);
      `CHECK_EQUAL(c_if.shifter_cout, 16'h0);
      `CHECK_EQUAL(c_if.lbus_msb, 1'b0);
      `CHECK_EQUAL(c_if.rbus_msb, 1'b0);
      `CHECK_EQUAL(c_if.rbus_lower, 8'h0);
      `CHECK_EQUAL(c_if.abus, 16'h2);
      `CHECK_EQUAL(c_if.sbus_msb, 1'b0);
      `CHECK_EQUAL(mm_addr, 16'h0140);
      `CHECK_EQUAL(mm_dout, 16'h2);
      `CHECK_EQUAL(of_din, 8'h02);
    end
    `TEST_CASE("test_flag_ov") begin
      c_if.flags                    = 4'b0001;
      c_if.set_fsr                  = 1'h1;

      #CLOCK_PERIOD;

      c_if.lbus_source_selector     = LBUS_SOURCE_SELECTOR_FSR;
      c_if.set_fsr                  = 1'h0;

      #CLOCK_PERIOD;

      `CHECK_EQUAL(c_if.ir, 16'h0);
      `CHECK_EQUAL(c_if.alu_cout, 16'h0);
      `CHECK_EQUAL(c_if.shifter_cout, 16'h0);
      `CHECK_EQUAL(c_if.lbus_msb, 1'b0);
      `CHECK_EQUAL(c_if.rbus_msb, 1'b0);
      `CHECK_EQUAL(c_if.rbus_lower, 8'h0);
      `CHECK_EQUAL(c_if.abus, 16'h1);
      `CHECK_EQUAL(c_if.sbus_msb, 1'b0);
      `CHECK_EQUAL(mm_addr, 16'h0140);
      `CHECK_EQUAL(mm_dout, 16'h1);
      `CHECK_EQUAL(of_din, 8'h01);
    end
    `TEST_CASE("test_gpr0") begin
      c_if.rbus_source_selector     = RBUS_SOURCE_SELECTOR_LLT;
      c_if.gpr_destination_selector = GPR_DESTINATION_SELECTOR_GPR0;
      c_if.literal                  = 16'hBEEF;

      #CLOCK_PERIOD;

      c_if.rbus_source_selector     = RBUS_SOURCE_SELECTOR_NRB;
      c_if.lbus_source_selector     = LBUS_SOURCE_SELECTOR_R0;
      c_if.gpr_destination_selector = GPR_DESTINATION_SELECTOR_NONE;

      #CLOCK_PERIOD;

      `CHECK_EQUAL(c_if.ir, 16'h0);
      `CHECK_EQUAL(c_if.alu_cout, 16'h0);
      `CHECK_EQUAL(c_if.shifter_cout, 16'h0);
      // `CHECK_EQUAL(c_if.lbus_msb, 1'b1);
      `CHECK_EQUAL(c_if.rbus_msb, 1'b0);
      `CHECK_EQUAL(c_if.rbus_lower, 8'h0);
      `CHECK_EQUAL(c_if.abus, 16'hBEEF);
      `CHECK_EQUAL(c_if.sbus_msb, 1'b1);
      `CHECK_EQUAL(mm_addr, 16'h0140);
      `CHECK_EQUAL(mm_dout, 16'hBEEF);
      `CHECK_EQUAL(of_din, 8'hEF);
    end
    `TEST_CASE("test_gpr1") begin
      c_if.rbus_source_selector     = RBUS_SOURCE_SELECTOR_LLT;
      c_if.gpr_destination_selector = GPR_DESTINATION_SELECTOR_GPR1;
      c_if.literal                  = 16'hBEEF;

      #CLOCK_PERIOD;

      c_if.rbus_source_selector     = RBUS_SOURCE_SELECTOR_NRB;
      c_if.lbus_source_selector     = LBUS_SOURCE_SELECTOR_R1;
      c_if.gpr_destination_selector = GPR_DESTINATION_SELECTOR_NONE;

      #CLOCK_PERIOD;

      `CHECK_EQUAL(c_if.ir, 16'h0);
      `CHECK_EQUAL(c_if.alu_cout, 16'h0);
      `CHECK_EQUAL(c_if.shifter_cout, 16'h0);
      `CHECK_EQUAL(c_if.lbus_msb, 1'b1);
      `CHECK_EQUAL(c_if.rbus_msb, 1'b0);
      `CHECK_EQUAL(c_if.rbus_lower, 8'h0);
      `CHECK_EQUAL(c_if.abus, 16'hBEEF);
      `CHECK_EQUAL(c_if.sbus_msb, 1'b1);
      `CHECK_EQUAL(mm_addr, 16'h0140);
      `CHECK_EQUAL(mm_dout, 16'hBEEF);
      `CHECK_EQUAL(of_din, 8'hEF);
    end
    `TEST_CASE("test_gpr2") begin
      c_if.rbus_source_selector     = RBUS_SOURCE_SELECTOR_LLT;
      c_if.gpr_destination_selector = GPR_DESTINATION_SELECTOR_GPR2;
      c_if.literal                  = 16'hBEEF;

      #CLOCK_PERIOD;

      c_if.rbus_source_selector     = RBUS_SOURCE_SELECTOR_NRB;
      c_if.lbus_source_selector     = LBUS_SOURCE_SELECTOR_R2;
      c_if.gpr_destination_selector = GPR_DESTINATION_SELECTOR_NONE;

      #CLOCK_PERIOD;

      `CHECK_EQUAL(c_if.ir, 16'h0);
      `CHECK_EQUAL(c_if.alu_cout, 16'h0);
      `CHECK_EQUAL(c_if.shifter_cout, 16'h0);
      `CHECK_EQUAL(c_if.lbus_msb, 1'b1);
      `CHECK_EQUAL(c_if.rbus_msb, 1'b0);
      `CHECK_EQUAL(c_if.rbus_lower, 8'h0);
      `CHECK_EQUAL(c_if.abus, 16'hBEEF);
      `CHECK_EQUAL(c_if.sbus_msb, 1'b1);
      `CHECK_EQUAL(mm_addr, 16'h0140);
      `CHECK_EQUAL(mm_dout, 16'hBEEF);
      `CHECK_EQUAL(of_din, 8'hEF);
    end
    `TEST_CASE("test_gpr3") begin
      c_if.rbus_source_selector     = RBUS_SOURCE_SELECTOR_LLT;
      c_if.gpr_destination_selector = GPR_DESTINATION_SELECTOR_GPR3;
      c_if.literal                  = 16'hBEEF;

      #CLOCK_PERIOD;

      c_if.rbus_source_selector     = RBUS_SOURCE_SELECTOR_NRB;
      c_if.lbus_source_selector     = LBUS_SOURCE_SELECTOR_R3;
      c_if.gpr_destination_selector = GPR_DESTINATION_SELECTOR_NONE;

      #CLOCK_PERIOD;

      `CHECK_EQUAL(c_if.ir, 16'h0);
      `CHECK_EQUAL(c_if.alu_cout, 16'h0);
      `CHECK_EQUAL(c_if.shifter_cout, 16'h0);
      `CHECK_EQUAL(c_if.lbus_msb, 1'b1);
      `CHECK_EQUAL(c_if.rbus_msb, 1'b0);
      `CHECK_EQUAL(c_if.rbus_lower, 8'h0);
      `CHECK_EQUAL(c_if.abus, 16'hBEEF);
      `CHECK_EQUAL(c_if.sbus_msb, 1'b1);
      `CHECK_EQUAL(mm_addr, 16'h0140);
      `CHECK_EQUAL(mm_dout, 16'hBEEF);
      `CHECK_EQUAL(of_din, 8'hEF);
    end
    `TEST_CASE("test_gpr4") begin
      c_if.rbus_source_selector     = RBUS_SOURCE_SELECTOR_LLT;
      c_if.gpr_destination_selector = GPR_DESTINATION_SELECTOR_GPR4;
      c_if.literal                  = 16'hBEEF;

      #CLOCK_PERIOD;

      c_if.rbus_source_selector     = RBUS_SOURCE_SELECTOR_NRB;
      c_if.lbus_source_selector     = LBUS_SOURCE_SELECTOR_R4;
      c_if.gpr_destination_selector = GPR_DESTINATION_SELECTOR_NONE;

      #CLOCK_PERIOD;

      `CHECK_EQUAL(c_if.ir, 16'h0);
      `CHECK_EQUAL(c_if.alu_cout, 16'h0);
      `CHECK_EQUAL(c_if.shifter_cout, 16'h0);
      `CHECK_EQUAL(c_if.lbus_msb, 1'b1);
      `CHECK_EQUAL(c_if.rbus_msb, 1'b0);
      `CHECK_EQUAL(c_if.rbus_lower, 8'h0);
      `CHECK_EQUAL(c_if.abus, 16'hBEEF);
      `CHECK_EQUAL(c_if.sbus_msb, 1'b1);
      `CHECK_EQUAL(mm_addr, 16'h0140);
      `CHECK_EQUAL(mm_dout, 16'hBEEF);
      `CHECK_EQUAL(of_din, 8'hEF);
    end
    `TEST_CASE("test_gpr5") begin
      c_if.rbus_source_selector     = RBUS_SOURCE_SELECTOR_LLT;
      c_if.gpr_destination_selector = GPR_DESTINATION_SELECTOR_GPR5;
      c_if.literal                  = 16'hBEEF;

      #CLOCK_PERIOD;

      c_if.rbus_source_selector     = RBUS_SOURCE_SELECTOR_NRB;
      c_if.lbus_source_selector     = LBUS_SOURCE_SELECTOR_R5;
      c_if.gpr_destination_selector = GPR_DESTINATION_SELECTOR_NONE;

      #CLOCK_PERIOD;

      `CHECK_EQUAL(c_if.ir, 16'h0);
      `CHECK_EQUAL(c_if.alu_cout, 16'h0);
      `CHECK_EQUAL(c_if.shifter_cout, 16'h0);
      `CHECK_EQUAL(c_if.lbus_msb, 1'b1);
      `CHECK_EQUAL(c_if.rbus_msb, 1'b0);
      `CHECK_EQUAL(c_if.rbus_lower, 8'h0);
      `CHECK_EQUAL(c_if.abus, 16'hBEEF);
      `CHECK_EQUAL(c_if.sbus_msb, 1'b1);
      `CHECK_EQUAL(mm_addr, 16'h0140);
      `CHECK_EQUAL(mm_dout, 16'hBEEF);
      `CHECK_EQUAL(of_din, 8'hEF);
    end
    `TEST_CASE("test_gpr6") begin
      c_if.rbus_source_selector     = RBUS_SOURCE_SELECTOR_LLT;
      c_if.gpr_destination_selector = GPR_DESTINATION_SELECTOR_GPR6;
      c_if.literal                  = 16'hBEEF;

      #CLOCK_PERIOD;

      c_if.rbus_source_selector     = RBUS_SOURCE_SELECTOR_NRB;
      c_if.lbus_source_selector     = LBUS_SOURCE_SELECTOR_R6;
      c_if.gpr_destination_selector = GPR_DESTINATION_SELECTOR_NONE;

      #CLOCK_PERIOD;

      `CHECK_EQUAL(c_if.ir, 16'h0);
      `CHECK_EQUAL(c_if.alu_cout, 16'h0);
      `CHECK_EQUAL(c_if.shifter_cout, 16'h0);
      `CHECK_EQUAL(c_if.lbus_msb, 1'b1);
      `CHECK_EQUAL(c_if.rbus_msb, 1'b0);
      `CHECK_EQUAL(c_if.rbus_lower, 8'h0);
      `CHECK_EQUAL(c_if.abus, 16'hBEEF);
      `CHECK_EQUAL(c_if.sbus_msb, 1'h1);
      `CHECK_EQUAL(mm_addr, 16'h0140);
      `CHECK_EQUAL(mm_dout, 16'hBEEF);
      `CHECK_EQUAL(of_din, 8'hEF);
    end
    `TEST_CASE("test_gpr7") begin
      c_if.rbus_source_selector     = RBUS_SOURCE_SELECTOR_LLT;
      c_if.gpr_destination_selector = GPR_DESTINATION_SELECTOR_GPR7;
      c_if.literal                  = 16'hBEEF;

      #CLOCK_PERIOD;

      c_if.rbus_source_selector     = RBUS_SOURCE_SELECTOR_NRB;
      c_if.lbus_source_selector     = LBUS_SOURCE_SELECTOR_R7;
      c_if.gpr_destination_selector = GPR_DESTINATION_SELECTOR_NONE;

      #CLOCK_PERIOD;

      `CHECK_EQUAL(c_if.ir, 16'h0);
      `CHECK_EQUAL(c_if.alu_cout, 16'h0);
      `CHECK_EQUAL(c_if.shifter_cout, 16'h0);
      `CHECK_EQUAL(c_if.lbus_msb, 1'b1);
      `CHECK_EQUAL(c_if.rbus_msb, 1'b0);
      `CHECK_EQUAL(c_if.rbus_lower, 8'h0);
      `CHECK_EQUAL(c_if.abus, 16'hBEEF);
      `CHECK_EQUAL(c_if.sbus_msb, 1'b1);
      `CHECK_EQUAL(mm_addr, 16'h0140);
      `CHECK_EQUAL(mm_dout, 16'hBEEF);
      `CHECK_EQUAL(of_din, 8'hEF);
    end
    `TEST_CASE("test_ra") begin
      c_if.rbus_source_selector     = RBUS_SOURCE_SELECTOR_LLT;
      c_if.gpr_destination_selector = GPR_DESTINATION_SELECTOR_GPR0;
      c_if.literal                  = 16'hBEEF;

      #CLOCK_PERIOD;

      c_if.rbus_source_selector     = RBUS_SOURCE_SELECTOR_RA;
      c_if.gpr_destination_selector = GPR_DESTINATION_SELECTOR_NONE;

      #CLOCK_PERIOD;

      `CHECK_EQUAL(c_if.ir, 16'h0000);
      `CHECK_EQUAL(c_if.alu_cout, 16'h0);
      `CHECK_EQUAL(c_if.shifter_cout, 16'h0);
      `CHECK_EQUAL(c_if.lbus_msb, 1'b0);
      `CHECK_EQUAL(c_if.rbus_msb, 1'b1);
      `CHECK_EQUAL(c_if.rbus_lower, 8'hEF);
      `CHECK_EQUAL(c_if.abus, 16'hBEEF);
      `CHECK_EQUAL(c_if.sbus_msb, 1'b1);
      `CHECK_EQUAL(mm_addr, 16'h0140);
      `CHECK_EQUAL(mm_dout, 16'h0);
      `CHECK_EQUAL(of_din, 8'h00);
    end
    `TEST_CASE("test_rap") begin
      c_if.rbus_source_selector     = RBUS_SOURCE_SELECTOR_LLT;
      c_if.gpr_destination_selector = GPR_DESTINATION_SELECTOR_GPR1;
      c_if.literal                  = 16'hBEEF;

      #CLOCK_PERIOD;

      c_if.rbus_source_selector     = RBUS_SOURCE_SELECTOR_RAP;
      c_if.gpr_destination_selector = GPR_DESTINATION_SELECTOR_NONE;

      #CLOCK_PERIOD;

      `CHECK_EQUAL(c_if.ir, 16'h0000);
      `CHECK_EQUAL(c_if.alu_cout, 16'h0);
      `CHECK_EQUAL(c_if.shifter_cout, 16'h0);
      `CHECK_EQUAL(c_if.lbus_msb, 1'b0);
      `CHECK_EQUAL(c_if.rbus_msb, 1'b1);
      `CHECK_EQUAL(c_if.rbus_lower, 8'hEF);
      `CHECK_EQUAL(c_if.abus, 16'hBEEF);
      `CHECK_EQUAL(c_if.sbus_msb, 1'b1);
      `CHECK_EQUAL(mm_addr, 16'h0140);
      `CHECK_EQUAL(mm_dout, 16'h0);
      `CHECK_EQUAL(of_din, 8'h00);
    end
    `TEST_CASE("test_rb") begin
      c_if.rbus_source_selector     = RBUS_SOURCE_SELECTOR_LLT;
      c_if.gpr_destination_selector = GPR_DESTINATION_SELECTOR_GPR2;
      c_if.literal                  = 16'hBEEF;

      #CLOCK_PERIOD;

      c_if.gpr_destination_selector = GPR_DESTINATION_SELECTOR_GPR4;
      c_if.literal                  = 16'h0200;

      #CLOCK_PERIOD;

      c_if.lbus_source_selector     = LBUS_SOURCE_SELECTOR_R4;
      c_if.rbus_source_selector     = RBUS_SOURCE_SELECTOR_NRB;
      c_if.gpr_destination_selector = GPR_DESTINATION_SELECTOR_NONE;
      c_if.ir_source_selector       = IR_SOURCE_SELECTOR_SET_IR;

      #CLOCK_PERIOD;

      c_if.lbus_source_selector     = LBUS_SOURCE_SELECTOR_RB;
      c_if.gpr_destination_selector = GPR_DESTINATION_SELECTOR_NONE;
      c_if.ir_source_selector       = IR_SOURCE_SELECTOR_NO_OPERATION;

      #CLOCK_PERIOD;

      `CHECK_EQUAL(c_if.ir, 16'h0200);
      `CHECK_EQUAL(c_if.alu_cout, 16'h0);
      `CHECK_EQUAL(c_if.shifter_cout, 16'h0);
      `CHECK_EQUAL(c_if.lbus_msb, 1'b1);
      `CHECK_EQUAL(c_if.rbus_msb, 1'b0);
      `CHECK_EQUAL(c_if.rbus_lower, 8'h0);
      `CHECK_EQUAL(c_if.abus, 16'hBEEF);
      `CHECK_EQUAL(c_if.sbus_msb, 1'b1);
      `CHECK_EQUAL(mm_addr, 16'h0140);
      `CHECK_EQUAL(mm_dout, 16'hBEEF);
      `CHECK_EQUAL(of_din, 8'hEF);
    end
    `TEST_CASE("test_rbp") begin
      c_if.rbus_source_selector     = RBUS_SOURCE_SELECTOR_LLT;
      c_if.gpr_destination_selector = GPR_DESTINATION_SELECTOR_GPR3;
      c_if.literal                  = 16'hBEEF;

      #CLOCK_PERIOD;

      c_if.gpr_destination_selector = GPR_DESTINATION_SELECTOR_GPR4;
      c_if.literal                  = 16'h0200;

      #CLOCK_PERIOD;

      c_if.lbus_source_selector     = LBUS_SOURCE_SELECTOR_R4;
      c_if.rbus_source_selector     = RBUS_SOURCE_SELECTOR_NRB;
      c_if.gpr_destination_selector = GPR_DESTINATION_SELECTOR_NONE;
      c_if.ir_source_selector       = IR_SOURCE_SELECTOR_SET_IR;

      #CLOCK_PERIOD;

      c_if.lbus_source_selector     = LBUS_SOURCE_SELECTOR_RBP;
      c_if.gpr_destination_selector = GPR_DESTINATION_SELECTOR_NONE;
      c_if.ir_source_selector       = IR_SOURCE_SELECTOR_NO_OPERATION;

      #CLOCK_PERIOD;

      `CHECK_EQUAL(c_if.ir, 16'h0200);
      `CHECK_EQUAL(c_if.alu_cout, 16'h0);
      `CHECK_EQUAL(c_if.shifter_cout, 16'h0);
      `CHECK_EQUAL(c_if.lbus_msb, 8'b1);
      `CHECK_EQUAL(c_if.rbus_msb, 8'b0);
      `CHECK_EQUAL(c_if.rbus_lower, 8'h0);
      `CHECK_EQUAL(c_if.abus, 16'hBEEF);
      `CHECK_EQUAL(c_if.sbus_msb, 1'b1);
      `CHECK_EQUAL(mm_addr, 16'h0140);
      `CHECK_EQUAL(mm_dout, 16'hBEEF);
      `CHECK_EQUAL(of_din, 8'hEF);
    end
    `TEST_CASE("test_io") begin
      c_if.lbus_source_selector     = LBUS_SOURCE_SELECTOR_IO;
      c_if.inbus_valid              = 1'b1;
      if_dout                        = 8'hFF;

      #CLOCK_PERIOD;

      `CHECK_EQUAL(c_if.ir, 16'h0000);
      `CHECK_EQUAL(c_if.alu_cout, 16'h0);
      `CHECK_EQUAL(c_if.shifter_cout, 16'h0);
      `CHECK_EQUAL(c_if.lbus_msb, 1'b0);
      `CHECK_EQUAL(c_if.rbus_msb, 1'b0);
      `CHECK_EQUAL(c_if.rbus_lower, 8'h00);
      `CHECK_EQUAL(c_if.abus, 16'h00FF);
      `CHECK_EQUAL(c_if.sbus_msb, 1'b0);
      `CHECK_EQUAL(mm_addr, 16'h0140);
      `CHECK_EQUAL(mm_dout, 16'h00FF);
      `CHECK_EQUAL(of_din, 8'hFF);
    end
    `TEST_CASE("test_add") begin
      c_if.rbus_source_selector     = RBUS_SOURCE_SELECTOR_LLT;
      c_if.gpr_destination_selector = GPR_DESTINATION_SELECTOR_GPR0;
      c_if.literal                  = 16'h79E0;

      #CLOCK_PERIOD;

      c_if.gpr_destination_selector = GPR_DESTINATION_SELECTOR_GPR1;
      c_if.literal                  = 16'hd4d5;

      #CLOCK_PERIOD;

      c_if.lbus_source_selector     = LBUS_SOURCE_SELECTOR_R0;
      c_if.rbus_source_selector     = RBUS_SOURCE_SELECTOR_R1;
      c_if.alu_operation            = ALU_OPERATION_ADD;
      c_if.gpr_destination_selector = GPR_DESTINATION_SELECTOR_GPR2;

      #CLOCK_PERIOD;

      `CHECK_EQUAL(c_if.ir, 16'h0);
      `CHECK_EQUAL(c_if.alu_cout, 16'h1);
      `CHECK_EQUAL(c_if.shifter_cout, 16'h0);
      `CHECK_EQUAL(c_if.lbus_msb, 1'b0);
      `CHECK_EQUAL(c_if.rbus_msb, 1'b1);
      `CHECK_EQUAL(c_if.rbus_lower, 8'hd5);
      `CHECK_EQUAL(c_if.abus, 16'h4eb5);
      `CHECK_EQUAL(c_if.sbus_msb, 1'b0);
      `CHECK_EQUAL(mm_addr, 16'h0140);
      `CHECK_EQUAL(mm_dout, 16'h79E0);
      `CHECK_EQUAL(of_din, 8'hE0);
    end
    `TEST_CASE("test_sub") begin
      c_if.rbus_source_selector     = RBUS_SOURCE_SELECTOR_LLT;
      c_if.gpr_destination_selector = GPR_DESTINATION_SELECTOR_GPR0;
      c_if.literal                  = 16'h54E8;

      #CLOCK_PERIOD;

      c_if.gpr_destination_selector = GPR_DESTINATION_SELECTOR_GPR1;
      c_if.literal                  = 16'h33BE;

      #CLOCK_PERIOD;

      c_if.lbus_source_selector     = LBUS_SOURCE_SELECTOR_R0;
      c_if.rbus_source_selector     = RBUS_SOURCE_SELECTOR_R1;
      c_if.alu_operation            = ALU_OPERATION_SUB;
      c_if.gpr_destination_selector = GPR_DESTINATION_SELECTOR_GPR2;

      #CLOCK_PERIOD;

      `CHECK_EQUAL(c_if.ir, 16'h0);
      `CHECK_EQUAL(c_if.alu_cout, 16'h0);
      `CHECK_EQUAL(c_if.shifter_cout, 16'h0);
      `CHECK_EQUAL(c_if.lbus_msb, 1'b0);
      `CHECK_EQUAL(c_if.rbus_msb, 1'b0);
      `CHECK_EQUAL(c_if.rbus_lower, 8'hBE);
      `CHECK_EQUAL(c_if.abus, 16'h212A);
      `CHECK_EQUAL(c_if.sbus_msb, 1'b0);
      `CHECK_EQUAL(mm_addr, 16'h0140);
      `CHECK_EQUAL(mm_dout, 16'h54E8);
      `CHECK_EQUAL(of_din, 8'hE8);
    end
    `TEST_CASE("test_and") begin
      c_if.rbus_source_selector     = RBUS_SOURCE_SELECTOR_LLT;
      c_if.gpr_destination_selector = GPR_DESTINATION_SELECTOR_GPR0;
      c_if.literal                  = 16'h8986;

      #CLOCK_PERIOD;

      c_if.gpr_destination_selector = GPR_DESTINATION_SELECTOR_GPR1;
      c_if.literal                  = 16'hF4F6;

      #CLOCK_PERIOD;

      c_if.lbus_source_selector     = LBUS_SOURCE_SELECTOR_R0;
      c_if.rbus_source_selector     = RBUS_SOURCE_SELECTOR_R1;
      c_if.alu_operation            = ALU_OPERATION_AND;
      c_if.gpr_destination_selector = GPR_DESTINATION_SELECTOR_GPR2;

      #CLOCK_PERIOD;

      `CHECK_EQUAL(c_if.ir, 16'h0);
      `CHECK_EQUAL(c_if.alu_cout, 16'h0);
      `CHECK_EQUAL(c_if.shifter_cout, 16'h0);
      `CHECK_EQUAL(c_if.lbus_msb, 1'b1);
      `CHECK_EQUAL(c_if.rbus_msb, 1'b1);
      `CHECK_EQUAL(c_if.rbus_lower, 8'hF6);
      `CHECK_EQUAL(c_if.abus, 16'h8086);
      `CHECK_EQUAL(c_if.sbus_msb, 1'b1);
      `CHECK_EQUAL(mm_addr, 16'h0140);
      `CHECK_EQUAL(mm_dout, 16'h8986);
      `CHECK_EQUAL(of_din, 8'h86);
    end
    `TEST_CASE("test_or") begin
      c_if.rbus_source_selector     = RBUS_SOURCE_SELECTOR_LLT;
      c_if.gpr_destination_selector = GPR_DESTINATION_SELECTOR_GPR0;
      c_if.literal                  = 16'h1F87;

      #CLOCK_PERIOD;

      c_if.gpr_destination_selector = GPR_DESTINATION_SELECTOR_GPR1;
      c_if.literal                  = 16'hB9EB;

      #CLOCK_PERIOD;

      c_if.lbus_source_selector     = LBUS_SOURCE_SELECTOR_R0;
      c_if.rbus_source_selector     = RBUS_SOURCE_SELECTOR_R1;
      c_if.alu_operation            = ALU_OPERATION_OR;
      c_if.gpr_destination_selector = GPR_DESTINATION_SELECTOR_GPR2;

      #CLOCK_PERIOD;

      `CHECK_EQUAL(c_if.ir, 16'h0);
      `CHECK_EQUAL(c_if.alu_cout, 16'h0);
      `CHECK_EQUAL(c_if.shifter_cout, 16'h0);
      `CHECK_EQUAL(c_if.lbus_msb, 1'b0);
      `CHECK_EQUAL(c_if.rbus_msb, 1'b1);
      `CHECK_EQUAL(c_if.rbus_lower, 8'hEB);
      `CHECK_EQUAL(c_if.abus, 16'hBFEF);
      `CHECK_EQUAL(c_if.sbus_msb, 1'b1);
      `CHECK_EQUAL(mm_addr, 16'h0140);
      `CHECK_EQUAL(mm_dout, 16'h1F87);
      `CHECK_EQUAL(of_din, 8'h87);
    end
    `TEST_CASE("test_xor") begin
      c_if.rbus_source_selector     = RBUS_SOURCE_SELECTOR_LLT;
      c_if.gpr_destination_selector = GPR_DESTINATION_SELECTOR_GPR0;
      c_if.literal                  = 16'h1166;

      #CLOCK_PERIOD;

      c_if.gpr_destination_selector = GPR_DESTINATION_SELECTOR_GPR1;
      c_if.literal                  = 16'h8482;

      #CLOCK_PERIOD;

      c_if.lbus_source_selector     = LBUS_SOURCE_SELECTOR_R0;
      c_if.rbus_source_selector     = RBUS_SOURCE_SELECTOR_R1;
      c_if.alu_operation            = ALU_OPERATION_XOR;
      c_if.gpr_destination_selector = GPR_DESTINATION_SELECTOR_GPR2;

      #CLOCK_PERIOD;

      `CHECK_EQUAL(c_if.ir, 16'h0);
      `CHECK_EQUAL(c_if.alu_cout, 16'h0);
      `CHECK_EQUAL(c_if.shifter_cout, 16'h0);
      `CHECK_EQUAL(c_if.lbus_msb, 1'b0);
      `CHECK_EQUAL(c_if.rbus_msb, 1'b1);
      `CHECK_EQUAL(c_if.rbus_lower, 8'h82);
      `CHECK_EQUAL(c_if.abus, 16'h95E4);
      `CHECK_EQUAL(c_if.sbus_msb, 1'b1);
      `CHECK_EQUAL(mm_addr, 16'h0140);
      `CHECK_EQUAL(mm_dout, 16'h1166);
      `CHECK_EQUAL(of_din, 8'h66);
    end
    `TEST_CASE("test_sll") begin
      c_if.rbus_source_selector     = RBUS_SOURCE_SELECTOR_LLT;
      c_if.shifter_operation        = SHIFTER_OPERATION_LEFT_LOGICALLY;
      c_if.literal                  = 16'hC7B0;

      #CLOCK_PERIOD;

      `CHECK_EQUAL(c_if.ir, 16'h0);
      `CHECK_EQUAL(c_if.alu_cout, 1'h0);
      `CHECK_EQUAL(c_if.shifter_cout, 1'h1);
      `CHECK_EQUAL(c_if.lbus_msb, 1'b0);
      `CHECK_EQUAL(c_if.rbus_msb, 1'b1);
      `CHECK_EQUAL(c_if.rbus_lower, 8'hB0);
      `CHECK_EQUAL(c_if.abus, 16'hC7B0);
      `CHECK_EQUAL(c_if.sbus_msb, 1'b1);
      `CHECK_EQUAL(mm_addr, 16'h0140);
      `CHECK_EQUAL(mm_dout, 16'h0);
      `CHECK_EQUAL(of_din, 8'h00);
    end
    `TEST_CASE("test_srl") begin
      c_if.rbus_source_selector     = RBUS_SOURCE_SELECTOR_LLT;
      c_if.shifter_operation        = SHIFTER_OPERATION_RIGHT_LOGICALLY;
      c_if.literal                  = 16'hA517;

      #CLOCK_PERIOD;

      `CHECK_EQUAL(c_if.ir, 16'h0);
      `CHECK_EQUAL(c_if.alu_cout, 1'h0);
      `CHECK_EQUAL(c_if.shifter_cout, 1'h1);
      `CHECK_EQUAL(c_if.lbus_msb, 1'b0);
      `CHECK_EQUAL(c_if.rbus_msb, 1'b1);
      `CHECK_EQUAL(c_if.rbus_lower, 8'h17);
      `CHECK_EQUAL(c_if.abus, 16'hA517);
      `CHECK_EQUAL(c_if.sbus_msb, 1'b0);
      `CHECK_EQUAL(mm_addr, 16'h0140);
      `CHECK_EQUAL(mm_dout, 16'h0);
      `CHECK_EQUAL(of_din, 8'h00);
    end
    `TEST_CASE("test_sla") begin
      c_if.rbus_source_selector     = RBUS_SOURCE_SELECTOR_LLT;
      c_if.shifter_operation        = SHIFTER_OPERATION_LEFT_ARITHMETICALLY;
      c_if.literal                  = 16'hAE61;

      #CLOCK_PERIOD;

      `CHECK_EQUAL(c_if.ir, 16'h0);
      `CHECK_EQUAL(c_if.alu_cout, 1'h0);
      `CHECK_EQUAL(c_if.shifter_cout, 1'h1);
      `CHECK_EQUAL(c_if.lbus_msb, 1'b0);
      `CHECK_EQUAL(c_if.rbus_msb, 1'b1);
      `CHECK_EQUAL(c_if.rbus_lower, 8'h61);
      `CHECK_EQUAL(c_if.abus, 16'hAE61);
      `CHECK_EQUAL(c_if.sbus_msb, 1'b1);
      `CHECK_EQUAL(mm_addr, 16'h0140);
      `CHECK_EQUAL(mm_dout, 16'h0);
      `CHECK_EQUAL(of_din, 8'h00);
    end
    `TEST_CASE("test_sra") begin
      c_if.rbus_source_selector     = RBUS_SOURCE_SELECTOR_LLT;
      c_if.shifter_operation        = SHIFTER_OPERATION_RIGHT_ARITHMETICALLY;
      c_if.literal                  = 16'h5393;

      #CLOCK_PERIOD;

      `CHECK_EQUAL(c_if.ir, 16'h0);
      `CHECK_EQUAL(c_if.alu_cout, 1'h0);
      `CHECK_EQUAL(c_if.shifter_cout, 1'h1);
      `CHECK_EQUAL(c_if.lbus_msb, 1'b0);
      `CHECK_EQUAL(c_if.rbus_msb, 1'b0);
      `CHECK_EQUAL(c_if.rbus_lower, 8'h93);
      `CHECK_EQUAL(c_if.abus, 16'h5393);
      `CHECK_EQUAL(c_if.sbus_msb, 1'b0);
      `CHECK_EQUAL(mm_addr, 16'h0140);
      `CHECK_EQUAL(mm_dout, 16'h0);
      `CHECK_EQUAL(of_din, 8'h00);
    end
    `TEST_CASE("test_snx") begin
      c_if.rbus_source_selector     = RBUS_SOURCE_SELECTOR_LLT;
      c_if.shifter_operation        = SHIFTER_OPERATION_EXTENSION;
      c_if.literal                  = 16'h32D5;

      #CLOCK_PERIOD;

      `CHECK_EQUAL(c_if.ir, 16'h0);
      `CHECK_EQUAL(c_if.alu_cout, 1'h0);
      `CHECK_EQUAL(c_if.shifter_cout, 1'h1);
      `CHECK_EQUAL(c_if.lbus_msb, 1'b0);
      `CHECK_EQUAL(c_if.rbus_msb, 1'b0);
      `CHECK_EQUAL(c_if.rbus_lower, 8'hD5);
      `CHECK_EQUAL(c_if.abus, 16'h32D5);
      `CHECK_EQUAL(c_if.sbus_msb, 1'b1);
      `CHECK_EQUAL(mm_addr, 16'h0140);
      `CHECK_EQUAL(mm_dout, 16'h0);
      `CHECK_EQUAL(of_din, 8'h00);
    end
    `TEST_CASE("test_swap") begin
      c_if.rbus_source_selector     = RBUS_SOURCE_SELECTOR_LLT;
      c_if.shifter_operation        = SHIFTER_OPERATION_SWAP;
      c_if.literal                  = 16'h1BC2;

      #CLOCK_PERIOD;

      `CHECK_EQUAL(c_if.ir, 16'h0);
      `CHECK_EQUAL(c_if.alu_cout, 1'h0);
      `CHECK_EQUAL(c_if.shifter_cout, 1'h0);
      `CHECK_EQUAL(c_if.lbus_msb, 1'b0);
      `CHECK_EQUAL(c_if.rbus_msb, 1'b0);
      `CHECK_EQUAL(c_if.rbus_lower, 8'hC2);
      `CHECK_EQUAL(c_if.abus, 16'h1BC2);
      `CHECK_EQUAL(c_if.sbus_msb, 1'b1);
      `CHECK_EQUAL(mm_addr, 16'h0140);
      `CHECK_EQUAL(mm_dout, 16'h0);
      `CHECK_EQUAL(of_din, 8'h00);
    end
  end

  `WATCHDOG(1ms);

  micro_alpha_veryl_datapath dut(.*);
endmodule
