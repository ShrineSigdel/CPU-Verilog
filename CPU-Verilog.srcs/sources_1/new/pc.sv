// Program Counter: Sequential register that holds current instruction address
// Updates to pc_next on posedge clk; resets to 0

module pc (
    input  logic        clk,
    input  logic        rst,
    input  logic [31:0] pc_next,
    output logic [31:0] pc_reg
);

always_ff @(posedge clk or posedge rst) begin
    if (rst)
        pc_reg <= 32'b0;
    else
        pc_reg <= pc_next;
end

endmodule
