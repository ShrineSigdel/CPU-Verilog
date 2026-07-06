/*
    A simple testbench that runs for 8 cycles and checks value of 8 registers. 
*/
`timescale 1ns / 1ps
module tb_memory;

    logic clk, rst;

    cpu uut (
        .clk(clk),
        .rst(rst)
    );

    // ── clock ──────────────────────────────────────────
    initial clk = 0;
    always #5 clk = ~clk;


    // ── test sequence ──────────────────────────────────
    initial begin
        rst = 1;

        @(posedge clk);   // t=5  rst=1, PC stays 0
        @(posedge clk);   // t=15 rst=1, PC stays 0
        #1;
        rst = 0;          // t=16, PC=0, fetch instr[0] begins

        $display("========================================");
        $display(" RISC-V RV32I CPU Testbench Results of Memory");
        $display("========================================");

        @(posedge clk); #1;
        
        @(posedge clk); #1;
        
        @(posedge clk); #1;
        
        @(posedge clk); #1;
        
        @(posedge clk); #1;
        
        @(posedge clk); #1;
        
        @(posedge clk); #1;
        
        @(posedge clk); #1;

        $display("========================================");
        $display(" FINAL STATE");
        $display("========================================");
        $display("  x0 = %0d  ",  uut.uut_mem.mem[0][7:0]);
        $display("  x1 = %0d  ",  uut.uut_mem.mem[1][7:0]);
        $display("  x2 = %0d  ", uut.uut_mem.mem[2][7:0]);
        $display("  x3 = %0d  ", uut.uut_mem.mem[3][7:0]);
        $display("  x4 = %0d  ", uut.uut_mem.mem[4][7:0]);
        $display("  x5 = %0d  ", uut.uut_mem.mem[5][7:0]);
        $display("  x6 = %0d  ", uut.uut_mem.mem[6][7:0]);
        $display("  x7 = %0d  ", uut.uut_mem.mem[7][7:0]);
        $display("");

        #10;
        $finish;
    end

endmodule