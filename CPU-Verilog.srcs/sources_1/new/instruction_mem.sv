module instruction_mem(
    input  wire  [31:0] addr,
    output logic [31:0] instruction
);

(* ram_style = "distributed" *) logic [31:0] memory [0:7];

initial begin
    memory[0] = 32'h00500093;  // addi x1, x0, 5
    memory[1] = 32'h00000013;  // nop
    memory[2] = 32'h00000013;
    memory[3] = 32'h00000013;
    memory[4] = 32'h00000013;
    memory[5] = 32'h00000013;
    memory[6] = 32'h00000013;
    memory[7] = 32'h00000013;
end

assign instruction = memory[addr[4:2]];

endmodule
