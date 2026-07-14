`timescale 1ns / 1ps

module memory(
    input  logic        clk,
    input  logic        mem_write,
    input  logic [31:0] addr,
    input  logic [31:0] write_data,
    output logic [31:0] read_data
);

logic [31:0] mem [0:1023];
logic [9:0] mem_addr;


assign mem_addr = addr[11:2];

always @(posedge clk) begin
    if (mem_write)
        mem[mem_addr] <= write_data;
    read_data <= mem[mem_addr];
end

endmodule
