module top_fpga(
    input logic CLK1,
    input logic RESET,
    input logic [7:0] dip_sw, 
    input logic [3:0] sw_in,
    output logic [7:0] LED,
    output logic [3:0] enable,
    output logic [7:0] seven_segment
    
);


cpu uut_cpu (
    .clk(CLK1),
    .rst(RESET)
);



logic [15:0] data;
logic [4:0] reg_count;

logic sw_pulse, sw_stable, sw_stable_prev;
logic [19:0] debounce_count; 

always_ff @(posedge CLK1) begin
    if(RESET) begin
        sw_stable <= 1'b1;
        debounce_count <= 20'd0;
    end
    else if (sw_stable != sw_in[0]) begin
        debounce_count <= debounce_count + 1'b1;
        if(debounce_count == 20'hFFFFF) 
            sw_stable <= sw_in[0]; 
    end
    else 
        debounce_count <= 20'd0;
end

always_ff @(posedge CLK1) begin
    if (RESET)
        sw_stable_prev <= 1'b0;
    else
        sw_stable_prev <= sw_stable;
end

assign sw_pulse = ~sw_stable & sw_stable_prev;

always_ff @(posedge CLK1) begin
    if(RESET) begin 
        reg_count <= 5'd0;
    end else if(sw_pulse) begin 
        reg_count <= reg_count + 1'b1;
    end
end

assign data = uut_cpu.uut_rb.rf[reg_count][15:0];



logic [16:0] clk_16;
logic [1:0] digit;
logic [3:0] digit_sel;

always_ff @(posedge CLK1) begin
    if(RESET) begin 
        clk_16 <= 17'd0;
        digit <= 2'd0;
    end else begin
        clk_16 <= clk_16 + 1'b1;
        if (clk_16 == 17'd0) 
            digit <= digit + 1'b1;
    end 
end 

always_comb begin
    case(digit)
        2'd0 : digit_sel = 4'b0001;
        2'd1 : digit_sel = 4'b0010;
        2'd2 : digit_sel = 4'b0100;
        2'd3 : digit_sel = 4'b1000;
        default : digit_sel = 4'b0001;
    endcase 
end

assign enable = ~(digit_sel);

seg_7 uut_seg7 (
    .digit_sel(digit_sel),
    .data(data),
    .seven_segment(seven_segment)
);

endmodule
