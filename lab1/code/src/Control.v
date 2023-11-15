module Control(
    op_i,
    aluop_o,
    alusrc_o,
    regwrite_o
);

input [6:0] op_i;
output [1:0] aluop_o;
output alusrc_o;
output regwrite_o;

assign aluop_o = (op_i == 7'b0110011) ? 2'b10 : (op_i == 7'b0010011) ? 2'b01 : 2'b00;
assign alusrc_o = (op_i == 7'b0110011)? 1'b0: (op_i == 7'b0010011)? 1'b1: 1'b0;
assign regwrite_o = 1'b1;


endmodule