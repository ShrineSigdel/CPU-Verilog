// Instruction Memory: Holds program instructions, loaded via $readmemh
// 8 x 32-bit words, byte-addressable (word-aligned access via addr[4:2])

module instruction_mem(
    input  wire  [31:0] addr,
    output logic [31:0] instruction
);

logic [31:0] memory [0:7];

initial begin
    $readmemh("program.mem", memory);
end

assign instruction = memory[addr[4:2]];

endmodule
