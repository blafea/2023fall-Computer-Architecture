module Branchunit (
    rs1data_i,
    rs2data_i,
    branch_i,
    pc_i,
    ext_imm_i,
    flush_o,
    beq_tar_o
);

input [31:0] rs1data_i;
input [31:0] rs2data_i;
input branch_i;
input [31:0] pc_i;
input [31:0] ext_imm_i;

output flush_o;
output [31:0] beq_tar_o;

reg flush_o;

assign beq_tar_o = pc_i + (ext_imm_i << 1);

always @ (rs1data_i or rs2data_i or branch_i or pc_i or ext_imm_i) begin
    flush_o = 1'b0;
    if ((rs1data_i == rs2data_i) && branch_i) begin
        flush_o = 1'b1;
    end
end

    
endmodule