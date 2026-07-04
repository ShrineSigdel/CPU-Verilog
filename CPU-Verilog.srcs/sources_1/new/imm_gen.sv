// Immediate Generator: Extracts and sign-extends immediates for RV32I
// Supports I-type, S-type, and R-type (zero) immediates
`timescale 1ns / 1ps

module imm_gen(
    input  logic [31:0] instruction,
    output logic [31:0] imm_out
);

always_comb begin
    case (instruction[6:0])
        7'b0010011,                                    // I-type arithmetic
        7'b0000011:                                    // Load
            imm_out = {{20{instruction[31]}}, instruction[31:20]};

        7'b0100011:                                    // Store (S-type)
            imm_out = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};

        7'b0110011:                                    // R-type
            imm_out = 32'b0;

        default:
            imm_out = 32'b0;
    endcase
end

endmodule
