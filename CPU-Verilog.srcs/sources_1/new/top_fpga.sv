module top_fpga(
    input logic CLK1,
    input logic RESET,
    input logic [7:0] dip_sw, 
    output logic [7:0] LED
);


cpu uut_cpu (
    .clk(CLK1),
    .rst(~RESET)
);

assign LED[7] = 1;

endmodule
    