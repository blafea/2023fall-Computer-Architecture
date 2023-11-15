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
    if (aluop_i == 2'b01)
        if (funct3_i == 3'b000)
            tmp = 3'b110;
        else
            tmp = 3'b111;
    else
        case (funct)
        10'b0000000111: tmp = 3'b000;
        10'b0000000100: tmp = 3'b001;
        10'b0000000001: tmp = 3'b010;
        10'b0000000000: tmp = 3'b011;
        10'b0100000000: tmp = 3'b100;
        10'b0000001000: tmp = 3'b101;
        endcase

end

endmodule