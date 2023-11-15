module ALU(
    data1_i,
    data2_i,
    aluctr_i,
    data_o,
    zero_o
);

input signed [31:0] data1_i;
input signed [31:0] data2_i;
input [2:0] aluctr_i;
output [31:0] data_o;
output zero_o;
reg signed [31:0] tmp;
assign data_o = tmp;
assign zero_o = 0;

always @ (*) begin
    case (aluctr_i)
    3'b000: tmp = data1_i & data2_i;  //and
    3'b001: tmp = data1_i ^ data2_i;  //xor
    3'b010: tmp = data1_i << data2_i;  //sll
    3'b011: tmp = data1_i + data2_i;  //add
    3'b100: tmp = data1_i - data2_i;  //sub
    3'b101: tmp = data1_i * data2_i;  //mul
    3'b110: tmp = data1_i + data2_i;  //addi
    3'b111: tmp = data1_i >>> data2_i[4:0];  //srai
    
    endcase

end

endmodule