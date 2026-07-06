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



// use dip_sw to see output of memory registers

always_comb begin
   case (dip_sw[2:0])
       3'd0:  LED = uut_cpu.uut_mem.mem[0][7:0];
       3'd1:  LED = uut_cpu.uut_mem.mem[1][7:0];
       3'd2:  LED = uut_cpu.uut_mem.mem[2][7:0];
       3'd3:  LED = uut_cpu.uut_mem.mem[3][7:0];
       3'd4:  LED = uut_cpu.uut_mem.mem[4][7:0];
       3'd5:  LED = uut_cpu.uut_mem.mem[5][7:0];
       3'd6:  LED = uut_cpu.uut_mem.mem[6][7:0];
       3'd7:  LED = uut_cpu.uut_mem.mem[7][7:0];
       default: LED = 8'h00;
   endcase
end





logic [15:0] data;
logic [4:0] reg_count;

// For switch input to increment register count
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

assign sw_pulse = ~sw_stable & sw_stable_prev;  // one-cycle pulse on press

always_ff @(posedge CLK1) begin
    if(RESET) begin 
        reg_count <= 5'd0;
    end else if(sw_pulse) begin 
        reg_count <= reg_count + 1'b1;
    end
end

assign data = uut_cpu.uut_rb.rf[reg_count][15:0]; // Only lower bits of registers




// ── 7-segment display mux ───────────────────────────
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
    