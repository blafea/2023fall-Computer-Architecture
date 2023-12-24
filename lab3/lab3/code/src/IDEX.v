module IDEX(
    clk_i,
    rst_i,
    aluop_i,
    alusrc_i,
    regwrite_i,
    memtoreg_i,
    memread_i,
    memwrite_i,
    rs1data_i,
    rs2data_i,
    ext_imm_i,
    funct3_i,
    funct7_i,
    rs1addr_i,
    rs2addr_i,
    rd_i,
    flush_i,
    branch_i,
    pc_next_i,
    beq_tar_i,
    prev_pred_i,

    aluop_o,
    alusrc_o,
    regwrite_o,
    memtoreg_o,
    memread_o,
    memwrite_o,
    rs1data_o, 
    rs2data_o,
    ext_imm_o,
    funct3_o,
    funct7_o,
    rs1addr_o,
    rs2addr_o,
    rd_o,
    Branch_o,
    pc_next_o,
    beq_tar_o,
    prev_pred_o
);

input clk_i;
input rst_i;
input [1:0] aluop_i;
input alusrc_i;
input regwrite_i;
input memtoreg_i;
input memread_i;
input memwrite_i;

input [31:0] rs1data_i;
input [31:0] rs2data_i;
input [31:0] ext_imm_i;
input [2:0] funct3_i;
input [6:0] funct7_i;
input [4:0] rs1addr_i;
input [4:0] rs2addr_i;
input [4:0] rd_i;

input flush_i;
input branch_i;
input [31:0] pc_next_i;
input [31:0] beq_tar_i;
input prev_pred_i;

output [1:0] aluop_o;
output alusrc_o;
output regwrite_o;
output memtoreg_o;
output memread_o;
output memwrite_o;

output [31:0] rs1data_o;
output [31:0] rs2data_o;
output [31:0] ext_imm_o;
output [2:0] funct3_o;
output [6:0] funct7_o;
output [4:0] rs1addr_o;
output [4:0] rs2addr_o;
output [4:0] rd_o;

output Branch_o;
output [31:0] pc_next_o;
output [31:0] beq_tar_o;
output prev_pred_o;

reg [1:0] aluop_o;
reg alusrc_o;
reg regwrite_o;
reg memtoreg_o;
reg memread_o;
reg memwrite_o;

reg [31:0] rs1data_o;
reg [31:0] rs2data_o;
reg [31:0] ext_imm_o;
reg [2:0] funct3_o;
reg [6:0] funct7_o;
reg [4:0] rs1addr_o;
reg [4:0] rs2addr_o;
reg [4:0] rd_o;

reg Branch_o;
reg [31:0] pc_next_o;
reg [31:0] beq_tar_o;
reg prev_pred_o;

always@(posedge clk_i or rst_i) begin
    aluop_o <= aluop_i;
    alusrc_o <= alusrc_i;
    regwrite_o <= regwrite_i;
    memtoreg_o <= memtoreg_i;
    memread_o <= memread_i;
    memwrite_o <= memwrite_i;

    rs1data_o <= rs1data_i;
    rs2data_o <= rs2data_i;
    ext_imm_o <= ext_imm_i;
    funct3_o <= funct3_i;
    funct7_o <= funct7_i;
    rs1addr_o <= rs1addr_i;
    rs2addr_o <= rs2addr_i;
    rd_o <= rd_i;

    Branch_o <= branch_i;
    pc_next_o <= pc_next_i;
    beq_tar_o <= beq_tar_i;
    prev_pred_o <= prev_pred_i;
    if (flush_i) begin
        aluop_o <= 0;
        alusrc_o <= 0;
        regwrite_o <= 0;
        memtoreg_o <= 0;
        memread_o <= 0;
        memwrite_o <= 0;

        rs1data_o <= 0;
        rs2data_o <= 0;
        ext_imm_o <= 0;
        funct3_o <= 0;
        funct7_o <= 0;
        rs1addr_o <= 0;
        rs2addr_o <= 0;
        rd_o <= 0;

        Branch_o <= 0;
        pc_next_o <= 0;
        beq_tar_o <= 0;
        prev_pred_o <= 0;
    end
end


endmodule