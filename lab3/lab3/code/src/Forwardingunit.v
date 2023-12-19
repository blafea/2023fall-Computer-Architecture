module Forwardingunit(
    EX_rs1_i,
    EX_rs2_i,
    MEM_regwrite_i,
    MEM_rd_i,
    WB_rd_i,
    WB_regwrite_i,
    forward_A_o,
    forward_B_o
);


input [4:0] EX_rs1_i;
input [4:0] EX_rs2_i;
input MEM_regwrite_i;
input [4:0] MEM_rd_i;
input [4:0] WB_rd_i;
input WB_regwrite_i;

output [1:0] forward_A_o;
output [1:0] forward_B_o;

reg [1:0] forward_A_o;
reg [1:0] forward_B_o;


always @ (EX_rs1_i or EX_rs2_i or MEM_regwrite_i or MEM_rd_i or WB_regwrite_i or WB_rd_i) begin
    forward_A_o = 2'b00;
    forward_B_o = 2'b00;

    // EX hazard
    if (MEM_regwrite_i && (MEM_rd_i != 0) && (MEM_rd_i == EX_rs1_i)) begin
        forward_A_o = 2'b10;
    end
    if (MEM_regwrite_i && (MEM_rd_i != 0) && (MEM_rd_i == EX_rs2_i)) begin
        forward_B_o = 2'b10;
    end

    // MEM hazard
    if (WB_regwrite_i && (WB_rd_i != 0) && !(MEM_regwrite_i && (MEM_rd_i != 0) && (MEM_rd_i == EX_rs1_i)) && (WB_rd_i == EX_rs1_i)) begin
        forward_A_o = 2'b01;
    end
    if (WB_regwrite_i && (WB_rd_i != 0) && !(MEM_regwrite_i && (MEM_rd_i != 0) && (MEM_rd_i == EX_rs2_i)) && (WB_rd_i == EX_rs2_i)) begin
        forward_B_o = 2'b01;
    end
end

endmodule