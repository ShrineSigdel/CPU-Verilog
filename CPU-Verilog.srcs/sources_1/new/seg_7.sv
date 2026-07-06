module seg_7(
    input  logic [3:0]  digit_sel,
    input  logic [15:0] data,
    output logic [7:0]  seven_segment
);

logic [3:0] nibble;

always_comb begin
    case (digit_sel)
        4'b0001: nibble = data[15:12];
        4'b0010: nibble = data[11:8];
        4'b0100: nibble = data[7:4];
        4'b1000: nibble = data[3:0];
        default: nibble = 4'd8;
    endcase
end

always_comb begin

    $display("15:12=%h 11:8=%h 7:4=%h 3:0=%h",
         data[15:12], data[11:8], data[7:4], data[3:0]);
            
    case (nibble)
        4'h0: seven_segment = 8'b00010001; // 0
        4'h1: seven_segment = 8'b11010111; // 1
        4'h2: seven_segment = 8'b00110010; // 2
        4'h3: seven_segment = 8'b10010010; // 3
        4'h4: seven_segment = 8'b11010100; // 4
        4'h5: seven_segment = 8'b10011000; // 5
        4'h6: seven_segment = 8'b00011000; // 6
        4'h7: seven_segment = 8'b11010011; // 7
        4'h8: seven_segment = 8'b00010000; // 8
        4'h9: seven_segment = 8'b10010000; // 9
        4'hA: seven_segment = 8'b01010000; // A
        4'hB: seven_segment = 8'b00011100; // b
        4'hC: seven_segment = 8'b00111001; // C
        4'hD: seven_segment = 8'b00010110; // d
        4'hE: seven_segment = 8'b00111000; // E
        4'hF: seven_segment = 8'b01111000; // F
        default: seven_segment = 8'b11111111;
    endcase 
end

endmodule