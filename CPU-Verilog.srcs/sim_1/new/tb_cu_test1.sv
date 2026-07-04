/*
Program under test:
00500093 , // addi x1, x0, 5
00A00113 , // addi x2, x0, 10
002081B3 , // add  x3, x1, x2
40118233 , // sub  x4, x3, x1
00402023 , // sw   x4, 0(x0)
00002283 , // lw   x5, 0(x0)
00000013 , // nop
00000013 , // nop
*/
`timescale 1ns / 1ps
module tb_cu_test1;

    logic clk, rst;

    top uut (
        .clk(clk),
        .rst(rst)
    );

    // ── clock ──────────────────────────────────────────
    initial clk = 0;
    always #5 clk = ~clk;

    // ── load program ───────────────────────────────────
    initial begin
        $readmemh("program.mem", uut.uut_imem.memory);
    end

    // ── test sequence ──────────────────────────────────
    initial begin
        rst = 1;

        @(posedge clk);   // t=5  rst=1, PC stays 0
        @(posedge clk);   // t=15 rst=1, PC stays 0
        #1;
        rst = 0;          // t=16, PC=0, fetch instr[0] begins

        $display("========================================");
        $display(" RISC-V RV32I CPU Testbench Results");
        $display("========================================");

        // ── instr 1: addi x1, x0, 5 ──────────────────────
        @(posedge clk); #1;
        $display("[cyc1] addi x1,x0,5   -> x1=%0d (expect 5)",
                   uut.uut_rb.rf[1]);

        // ── instr 2: addi x2, x0, 10 ─────────────────────
        @(posedge clk); #1;
        $display("[cyc2] addi x2,x0,10  -> x2=%0d (expect 10)",
                   uut.uut_rb.rf[2]);

        // ── instr 3: add x3, x1, x2 ──────────────────────
        @(posedge clk); #1;
        $display("[cyc3] add  x3,x1,x2  -> x3=%0d (expect 15)",
                   uut.uut_rb.rf[3]);

        // ── instr 4: sub x4, x3, x1 ──────────────────────
        @(posedge clk); #1;
        $display("[cyc4] sub  x4,x3,x1  -> x4=%0d (expect 10)",
                   uut.uut_rb.rf[4]);

        // ── instr 5: sw x4, 0(x0) ────────────────────────
        @(posedge clk); #1;
        $display("[cyc5] sw   x4,0(x0)  -> mem[0]=%0d (expect 10)",
                   uut.uut_mem.mem[0]);

        // ── instr 6: lw x5, 0(x0) ────────────────────────
        @(posedge clk); #1;
        $display("[cyc6] lw   x5,0(x0)  -> x5=%0d (expect 10)",
                   uut.uut_rb.rf[5]);

        // ── instr 7,8: nop ───────────────────────────────
        @(posedge clk); #1;
        @(posedge clk); #1;

        $display("========================================");
        $display(" FINAL STATE");
        $display("========================================");
        $display("  x1 = %0d  (expect 5)",  uut.uut_rb.rf[1]);
        $display("  x2 = %0d  (expect 10)", uut.uut_rb.rf[2]);
        $display("  x3 = %0d  (expect 15)", uut.uut_rb.rf[3]);
        $display("  x4 = %0d  (expect 10)", uut.uut_rb.rf[4]);
        $display("  x5 = %0d  (expect 10)", uut.uut_rb.rf[5]);
        $display("  mem[0] = %0d  (expect 10)", uut.uut_mem.mem[0]);
        $display("");

        if (uut.uut_rb.rf[1] == 5  && uut.uut_rb.rf[2] == 10 &&
            uut.uut_rb.rf[3] == 15 && uut.uut_rb.rf[4] == 10 &&
            uut.uut_rb.rf[5] == 10 && uut.uut_mem.mem[0] == 10)
            $display(">>> ALL TESTS PASSED <<<");
        else
            $display(">>> SOME TESTS FAILED <<<");

        #10;
        $finish;
    end

endmodule