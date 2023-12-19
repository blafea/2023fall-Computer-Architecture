module Hazard_Detection (
    EX_memread_i,
    EX_rd_i,
    ID_rs1_i,
    ID_rs2_i,
    no_op_o,
    Stall_o,
    pcwrite_o
);

input EX_memread_i;
input [4:0] EX_rd_i;
input [4:0] ID_rs1_i;
input [4:0] ID_rs2_i;

output no_op_o;
output Stall_o;
output pcwrite_o;

reg no_op_o;
reg Stall_o;
reg pcwrite_o;

always@(ID_rs1_i or ID_rs2_i or EX_memread_i or EX_rd_i) begin
    no_op_o = 1'b0;
    Stall_o = 1'b0;
    pcwrite_o = 1'b1;
    if (EX_memread_i && ((EX_rd_i == ID_rs1_i) || (EX_rd_i == ID_rs2_i))) begin
        no_op_o = 1'b1;
        Stall_o = 1'b1;
        pcwrite_o = 1'b0;
    end
end

endmodule