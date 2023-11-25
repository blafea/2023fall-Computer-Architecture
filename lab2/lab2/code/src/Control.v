module Control(
    op_i,
    aluop_o,
    alusrc_o,
    regwrite_o,
    memtoreg_o,
    memread_o,
    memwrite_o,
    branch_o
);

input [6:0] op_i;
output [1:0] aluop_o;
output alusrc_o;
output regwrite_o;

assign aluop_o =    (op_i == 7'b0110011) ? 2'b10 : // R type
                    (op_i == 7'b0010011) ? 2'b00 : // I type
                    (op_i == 7'b0000011) ? 2'b00 : // lw
                    (op_i == 7'b0100011) ? 2'b00 : // sw
                    (op_i == 7'b1100011) ? 2'b01 : // beq
                    2'b00;
assign alusrc_o =   (op_i == 7'b0110011) ? 1'b0 : // R type
                    (op_i == 7'b0010011) ? 1'b1 : // I type
                    (op_i == 7'b0000011) ? 1'b1 : // lw
                    (op_i == 7'b0100011) ? 1'b1 : // sw
                    (op_i == 7'b1100011) ? 1'b0 : // beq
                    1'b0;
assign regwrite_o = (op_i == 7'b0110011) ? 1'b1 : // R type
                    (op_i == 7'b0010011) ? 1'b1 : // I type
                    (op_i == 7'b0000011) ? 1'b1 : // lw
                    (op_i == 7'b0100011) ? 1'b0 : // sw
                    (op_i == 7'b1100011) ? 1'b0 : // beq
                    1'b0;
assign memtoreg_o = (op_i == 7'b0000011) ? 1'b1 :
                    1'b0;
assign memread_o = (op_i == 7'b0000011) ? 1'b1 :
                    1'b0;
assign memwrite_o = (op_i == 7'b0100011) ? 1'b1 :
                    1'b0;
assign branch_o = (op_i == 7'b1100011) ? 1'b1 :
                    1'b0;


endmodule