module top_fpga(
    input logic CLK1,
    input logic RESET,
    input logic [7:0] dip_sw, 
    output logic [7:0] LED
);


cpu uut_cpu (
    .clk(CLK1),
    .rst(RESET)
);



// use dip_sw to see output of 8 registers

always_comb begin
   case (dip_sw[3:0])
       5'd0:  LED = uut_cpu.uut_rb.rf[0][7:0];
       5'd1:  LED = uut_cpu.uut_rb.rf[1][7:0];
       5'd2:  LED = uut_cpu.uut_rb.rf[2][7:0];
       5'd3:  LED = uut_cpu.uut_rb.rf[3][7:0];
       5'd4:  LED = uut_cpu.uut_rb.rf[4][7:0];
       5'd5:  LED = uut_cpu.uut_rb.rf[5][7:0];
       5'd6:  LED = uut_cpu.uut_rb.rf[6][7:0];
       5'd7:  LED = uut_cpu.uut_rb.rf[7][7:0];
       5'd8:  LED = uut_cpu.uut_rb.rf[8][7:0];
       default: LED = 8'h00;
   endcase
end


endmodule
    