// ALU: Implements RV32I arithmetic and logic operations
// Supports: add, sub, sll, slt, sltu, xor, srl, sra, or, and
`timescale 1ns / 1ps

module alu(
    input  logic [31:0] a,
    input  logic [31:0] b,
    input  logic [3:0]  alu_ctrl,
    output logic [31:0] alu_result,
    output logic        alu_zero
);

always_comb begin
    case (alu_ctrl)
        4'b0000: alu_result = a + b;                    // add
        4'b0001: alu_result = a - b;                    // sub
        4'b0010: alu_result = a << b[4:0];              // sll
        4'b0011: alu_result = $signed(a) < $signed(b);  // slt
        4'b0100: alu_result = a < b;                    // sltu
        4'b0101: alu_result = a ^ b;                    // xor
        4'b0110: alu_result = a >> b[4:0];              // srl
        4'b0111: alu_result = $signed(a) >>> b[4:0];    // sra
        4'b1000: alu_result = a | b;                    // or
        4'b1001: alu_result = a & b;                    // and
        default: alu_result = 32'b0;
    endcase
end

assign alu_zero = (alu_result == 32'b0);

endmodule
