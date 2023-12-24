module ALU_Control(
    funct3_i,
    funct7_i,
    aluop_i,
    aluctr_o
);

input [2:0] funct3_i;
input [6:0] funct7_i;
input [1:0] aluop_i;
output [2:0] aluctr_o;
wire [9:0] funct;
reg [2:0] tmp;
assign funct = {funct7_i, funct3_i};
assign aluctr_o = tmp;
always @ (*) begin
    if (aluop_i == 2'b00)
        case(funct3_i)
        3'b000: tmp = 3'b110; //addi
        3'b101: tmp = 3'b111; //srai
        3'b010: tmp = 3'b011; //lw, sw
        endcase
    else if (aluop_i == 2'b01) begin
        tmp = 3'b100;
    end
    else
        case (funct)
        10'b0000000111: tmp = 3'b000; //and
        10'b0000000100: tmp = 3'b001; //xor
        10'b0000000001: tmp = 3'b010; //sll
        10'b0000000000: tmp = 3'b011; //add
        10'b0100000000: tmp = 3'b100; //sub
        10'b0000001000: tmp = 3'b101; //mul
        endcase

end

endmodule