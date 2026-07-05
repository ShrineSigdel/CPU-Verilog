module instruction_mem(
    input  wire  [31:0] addr,
    output logic [31:0] instruction
);

(* ram_style = "distributed" *) logic [31:0] memory [0:7];

initial begin
    $readmemh("program.mem", memory);
end

assign instruction = memory[addr[4:2]];

endmodule
