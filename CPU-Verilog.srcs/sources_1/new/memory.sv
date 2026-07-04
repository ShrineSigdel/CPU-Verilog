// Data Memory: 8 x 32-bit data memory with byte/halfword/word access
// Uses funct3 to select access size and sign/zero extension for loads
// funct3 encoding: 000=lb, 001=lh, 010=lw, 100=lbu, 101=lhu | 000=sb, 001=sh, 010=sw
`timescale 1ns / 1ps

module memory(
    input  logic        clk,
    input  logic        rst,
    input  logic        mem_read,
    input  logic        mem_write,
    input  logic [31:0] addr,
    input  logic [2:0]  funct3,
    input  logic [31:0] write_data,
    output logic [31:0] read_data
);

logic [31:0] mem [0:7];

always_comb begin
    if (mem_read) begin
        case (funct3)
            3'b000:                                          // lb
                case (addr[1:0])
                    2'b00: read_data = {{24{mem[addr[4:2]][7]}},  mem[addr[4:2]][7:0]};
                    2'b01: read_data = {{24{mem[addr[4:2]][15]}}, mem[addr[4:2]][15:8]};
                    2'b10: read_data = {{24{mem[addr[4:2]][23]}}, mem[addr[4:2]][23:16]};
                    2'b11: read_data = {{24{mem[addr[4:2]][31]}}, mem[addr[4:2]][31:24]};
                endcase
            3'b001:                                          // lh
                read_data = addr[1] ? {{16{mem[addr[4:2]][31]}}, mem[addr[4:2]][31:16]}
                                     : {{16{mem[addr[4:2]][15]}}, mem[addr[4:2]][15:0]};
            3'b010:                                          // lw
                read_data = mem[addr[4:2]];
            3'b100:                                          // lbu
                case (addr[1:0])
                    2'b00: read_data = {24'b0, mem[addr[4:2]][7:0]};
                    2'b01: read_data = {24'b0, mem[addr[4:2]][15:8]};
                    2'b10: read_data = {24'b0, mem[addr[4:2]][23:16]};
                    2'b11: read_data = {24'b0, mem[addr[4:2]][31:24]};
                endcase
            3'b101:                                          // lhu
                read_data = addr[1] ? {16'b0, mem[addr[4:2]][31:16]}
                                     : {16'b0, mem[addr[4:2]][15:0]};
            default: read_data = 32'b0;
        endcase
    end else begin
        read_data = 32'b0;
    end
end

always_ff @(posedge clk) begin
    if (rst) begin
        for (int i = 0; i < 8; i++)
            mem[i] <= 32'b0;
    end else if (mem_write) begin
        case (funct3)
            3'b010: mem[addr[4:2]] <= write_data;            // sw
            3'b001:                                          // sh
                if (addr[1])
                    mem[addr[4:2]] <= {write_data[15:0], mem[addr[4:2]][15:0]};
                else
                    mem[addr[4:2]] <= {mem[addr[4:2]][31:16], write_data[15:0]};
            3'b000:                                          // sb
                case (addr[1:0])
                    2'b00: mem[addr[4:2]] <= {mem[addr[4:2]][31:8],  write_data[7:0]};
                    2'b01: mem[addr[4:2]] <= {mem[addr[4:2]][31:16], write_data[7:0], mem[addr[4:2]][7:0]};
                    2'b10: mem[addr[4:2]] <= {mem[addr[4:2]][31:24], write_data[7:0], mem[addr[4:2]][15:0]};
                    2'b11: mem[addr[4:2]] <= {write_data[7:0],       mem[addr[4:2]][23:0]};
                endcase
            default: mem[addr[4:2]] <= write_data;
        endcase
    end
end

endmodule
