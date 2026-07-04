// CU: Control unit for RV32I single-cycle CPU
// Decodes opcode/funct3/funct7 to generate control signals
// Supports: R-type, I-type (arithmetic), loads, stores (no branches)
`timescale 1ns / 1ps

module cu(
    input  logic [6:0] opcode,
    input  logic [2:0] funct3,
    input  logic [6:0] funct7,
    output logic        reg_write,
    output logic        mem_write,
    output logic        mem_read,
    output logic        alu_src,
    output logic        mem_to_reg,
    output logic [3:0]  alu_ctrl
);

always_comb begin
    reg_write  = 0;
    mem_read   = 0;
    mem_write  = 0;
    mem_to_reg = 0;
    alu_ctrl   = 4'b0;
    alu_src    = 1'b0;

    case (opcode)
        7'b0110011: begin                            // R-type
            reg_write = 1;
            alu_src   = 0;
            case (funct3)
                3'b000: alu_ctrl = funct7[5] ? 4'b0001 : 4'b0000; // sub/add
                3'b001: alu_ctrl = 4'b0010;                       // sll
                3'b010: alu_ctrl = 4'b0011;                       // slt
                3'b011: alu_ctrl = 4'b0100;                       // sltu
                3'b100: alu_ctrl = 4'b0101;                       // xor
                3'b101: alu_ctrl = funct7[5] ? 4'b0111 : 4'b0110; // sra/srl
                3'b110: alu_ctrl = 4'b1000;                       // or
                3'b111: alu_ctrl = 4'b1001;                       // and
            endcase
        end

        7'b0010011: begin                            // I-type arithmetic
            reg_write = 1;
            alu_src   = 1;
            case (funct3)
                3'b000: alu_ctrl = 4'b0000;                       // addi
                3'b001: alu_ctrl = 4'b0010;                       // slli
                3'b010: alu_ctrl = 4'b0011;                       // slti
                3'b011: alu_ctrl = 4'b0100;                       // sltiu
                3'b100: alu_ctrl = 4'b0101;                       // xori
                3'b101: alu_ctrl = funct7[5] ? 4'b0111 : 4'b0110; // srai/srli
                3'b110: alu_ctrl = 4'b1000;                       // ori
                3'b111: alu_ctrl = 4'b1001;                       // andi
            endcase
        end

        7'b0000011: begin                            // Load (lw, lh, lb, lhu, lbu)
            reg_write  = 1;
            mem_read   = 1;
            alu_src    = 1;
            mem_to_reg = 1;
            alu_ctrl   = 4'b0000;                   // add for address calc
        end

        7'b0100011: begin                            // Store (sw, sh, sb)
            mem_write = 1;
            alu_src   = 1;
            alu_ctrl  = 4'b0000;                    // add for address calc
        end

        default: begin end
    endcase
end

endmodule
