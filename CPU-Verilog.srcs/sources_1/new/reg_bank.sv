// Register Bank: 32 x 32-bit register file for RV32I
// Combinational read, sequential write on posedge clk; x0 is hardwired to 0
`timescale 1ns / 1ps

module reg_bank(
    input  logic        clk,
    input  logic        rst,
    input  logic        reg_write,
    input  logic [4:0]  rs1,
    input  logic [4:0]  rs2,
    input  logic [4:0]  rd,
    input  logic [31:0] write_data,
    output logic [31:0] read_data1,
    output logic [31:0] read_data2
);

logic [31:0] rf [31:0];

assign read_data1 = (rs1 == 5'b0) ? 32'b0 : rf[rs1];
assign read_data2 = (rs2 == 5'b0) ? 32'b0 : rf[rs2];

always_ff @(posedge clk) begin
    if (rst) begin
        for (int i = 0; i < 32; i++)
            rf[i] <= 32'b0;
    end else if (reg_write && rd) begin
        rf[rd] <= write_data;
    end
end

endmodule
