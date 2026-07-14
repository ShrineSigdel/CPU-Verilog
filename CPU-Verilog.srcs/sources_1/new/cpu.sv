module cpu(
    input logic clk,
    input logic rst
);

logic [31:0] pc_reg, pc_next, instr;
logic [6:0]  opcode;
logic [2:0]  funct3;
logic [6:0]  funct7;
logic [4:0]  rs1, rs2, rd;

logic        reg_write, mem_write, mem_read, alu_src, mem_to_reg;
logic [3:0]  alu_ctrl;

logic [31:0] read_data1, read_data2;
logic [31:0] imm_out;
logic [31:0] alu_b;
logic [31:0] alu_result;
logic [31:0] mem_read_data;
logic [31:0] write_data;
logic        alu_zero;

assign opcode = instr[6:0];
assign funct3 = instr[14:12];
assign funct7 = instr[31:25];
assign rs1    = instr[19:15];
assign rs2    = instr[24:20];
assign rd     = instr[11:7];

assign pc_next = pc_reg + 32'd4;

assign alu_b = alu_src ? imm_out : read_data2;

assign write_data = mem_to_reg ? mem_read_data : alu_result;

pc uut_pc (
    .clk(clk),
    .rst(rst),
    .pc_next(pc_next),
    .pc_reg(pc_reg)
);

instruction_mem uut_imem (
    .addr(pc_reg),
    .instruction(instr)
);

cu uut_cu (
    .opcode(opcode),
    .funct3(funct3),
    .funct7(funct7),
    .reg_write(reg_write),
    .mem_write(mem_write),
    .mem_read(mem_read),
    .alu_src(alu_src),
    .alu_ctrl(alu_ctrl),
    .mem_to_reg(mem_to_reg)
);

imm_gen uut_imm_gen (
    .instruction(instr),
    .imm_out(imm_out)
);

reg_bank uut_rb (
    .clk(clk),
    .rst(rst),
    .reg_write(reg_write),
    .rs1(rs1),
    .rs2(rs2),
    .rd(rd),
    .write_data(write_data),
    .read_data1(read_data1),
    .read_data2(read_data2)
);

alu uut_alu (
    .a(read_data1),
    .b(alu_b),
    .alu_ctrl(alu_ctrl),
    .alu_result(alu_result),
    .alu_zero(alu_zero)
);

memory uut_mem (
    .clk(clk),
    .mem_write(mem_write),
    .addr(alu_result),
    .write_data(read_data2),
    .read_data(mem_read_data)
);

endmodule
