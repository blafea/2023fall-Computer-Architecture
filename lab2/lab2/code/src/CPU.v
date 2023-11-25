module CPU
(
    clk_i, 
    rst_i,
);

// Ports
input               clk_i;
input               rst_i;

wire [31:0] instr_add;
wire [31:0] instr;
wire [31:0] pc;
wire [4:0] rs1, rs2, rd;
wire [6:0] opcode;
wire [6:0] funct7;
wire [2:0] funct3;
wire [11:0] imm;

wire [1:0] aluop;
wire alusrc;
wire regwrite;
wire memtoreg;
wire memread;
wire memwrite;
wire branch;
wire [2:0] aluctr;
wire zero;

wire [31:0] rs1data, rs2data;
wire [31:0] ext_imm;
wire [31:0] alu_sec;
wire [31:0] alu_result;

// assign funct7 = instr[31:25];
assign rs2 = instr[24:20];
assign rs1 = instr[19:15];
// assign funct3 = instr[14:12];
// assign rd = instr[11:7];
assign opcode = instr[6:0];
assign imm = instr[31:20];

// Data memory
wire [31:0] dm_addr;
wire [31:0] dm_w_data;
wire [31:0] dm_r_data;

// IF stage
wire [31:0] instr_0;

// ID stage
wire [1:0] aluop_1;
wire alusrc_1;
wire regwrite_1;
wire memtoreg_1;
wire memread_1;
wire memwrite_1;
wire [31:0] rs1data_1, rs2data_1;
wire [31:0] ext_imm_1;
wire [6:0] funct7_1;
wire [2:0] funct3_1;
wire [4:0] rd_1;

assign funct7_1 = instr[31:25];
assign funct3_1 = instr[14:12];
assign rd_1 = instr[11:7];

// EX stage
wire regwrite_2;
wire memtoreg_2;
wire memread_2;
wire memwrite_2;
wire [4:0] rs1addr_2;
wire [4:0] rs2addr_2;
wire [4:0] rd_2;
wire [31:0] alu_result_2;

// MEM stage
wire regwrite_3;
wire memtoreg_3;
wire [4:0] rd_3;

// WB stage
wire [31:0] dm_addr_4;
wire [31:0] dm_r_data_4;
wire [4:0] rd_4;
wire [31:0] wb_data;


Control Control(
    .op_i(opcode),
    .aluop_o(aluop_1),
    .alusrc_o(alusrc_1),
    .regwrite_o(regwrite_1),
    .memtoreg_o(memtoreg_1),
    .memread_o(memread_1),
    .memwrite_o(memwrite_1),
    .branch_o(branch)
);

Adder Add_PC(
    .data1_i(instr_add),
    .data2_i(32'd4),
    .data_o(pc)
);

PC PC(
    .rst_i(rst_i),
    .clk_i(clk_i),
    .pc_i(pc),
    .pc_o(instr_add)
);

Instruction_Memory Instruction_Memory(
    .addr_i(instr_add), 
    .instr_o(instr_0)
);

Registers Registers(
    .rst_i(rst_i),
    .clk_i(clk_i),
    .RS1addr_i(rs1),
    .RS2addr_i(rs2),
    .RDaddr_i(rd_4), 
    .RDdata_i(wb_data),
    .RegWrite_i(regwrite), 
    .RS1data_o(rs1data_1), 
    .RS2data_o(rs2data_1) 
);

MUX32 MUX_ALUSrc(
    .src_i(alusrc),
    .data0_i(rs2data),
    .data1_i(ext_imm),
    .data_o(alu_sec)
);

Sign_Extend Sign_Extend(
    .data_i(imm),
    .data_o(ext_imm)
);
  
ALU ALU(
    .data1_i(rs1data),
    .data2_i(alu_sec),
    .aluctr_i(aluctr),
    .data_o(alu_result),
    .zero_o(zero)
);

ALU_Control ALU_Control(
    .funct3_i(funct3),
    .funct7_i(funct7),
    .aluop_i(aluop),
    .aluctr_o(aluctr)
);

Data_Memory Data_Memory(
    .clk_i(clk_i), 
    .addr_i(dm_addr),
    .MemRead_i(memread),
    .MemWrite_i(memwrite),
    .data_i(dm_w_data),
    .data_o(dm_r_data)
);

IFID IFID(
    .clk_i(clk_i)
    .instr_i(instr_0),
    .instr_o(instr)
);

IDEX IDEX(
    .clk_i(clk_i),
    .aluop_i(aluop_1),
    .alusrc_i(alusrc_1),
    .regwrite_i(regwrite_1),
    .memtoreg_i(memtoreg_1),
    .memread_i(memread_1),
    .memwrite_i(memwrite_1),
    .rs1data_i(rs1data_1),
    .rs2data_i(rs2data_1),
    .ext_imm_i(ext_imm_1),
    .funct3_i(funct3_1),
    .funct7_i(funct7_1),
    .rs1addr_i(rs1),
    .rs2addr_i(rs2),
    .rd_i(rd_1),

    .aluop_o,
    .alusrc_o,
    .regwrite_o(regwrite_2),
    .memtoreg_o(memtoreg_2),
    .memread_o(memread_2),
    .memwrite_o(memwrite_2),
    .rs1data_o(rs1data),
    .rs2data_o(rs2data),
    .ext_imm_o(ext_imm),
    .funct3_o(funct3),
    .funct7_o(funct7),
    .rs1addr_o(rs1addr_2),
    .rs2addr_o(rs2addr_2),
    .rd_o(rd_2)
);

EXMEM EXMEM(
    .clk_i(clk_i),
    .regwrite_i(regwrite_2),
    .memtoreg_i(memtoreg_2),
    .memread_i(memread_2),
    .memwrite_i(memwrite_2),
    .alu_result_i(alu_result_2),
    .rs2data_i(rs2data),
    .rd_i(rd_2),
    .regwrite_o(regwrite_3),
    .memtoreg_o(memtoreg_3),
    .memread_o(memread),
    .memwrite_o(memwrite),
    .dm_addr_o(dm_addr),
    .dm_write_o(dm_w_data),
    .rd_o(rd_3)
);

MEMWB MEMWB(
    .clk_i(clk_i),
    .regwrite_i(regwrite_3),
    .memtoreg_i(memtoreg_3),
    .dm_addr_i(dm_addr),
    .dm_r_data_i(dm_r_data),
    .rd_i(rd_3),
    .regwrite_o(regwrite),
    .memtoreg_o(memtoreg),
    .dm_addr_o(dm_addr_4),
    .dm_r_data_o(dm_r_data_4),
    .rd_o(rd_4),
);

MUX32 wb_source(
    .src_i(memtoreg),
    .data0_i(dm_addr),
    .data1_i(dm_r_data),
    .data_o(wb_data)
);

Forwardingunit Forwardingunit(
    .EX_rs1_i(rs1addr_2),
    .EX_rs2_i(rs2addr_2),
    .MEM_regwrite_i(regwrite_3),
    .MEM_rd_i(rd_3),
    .WB_rd_i(rd_4),
    .WB_regwrite_i(regwrite),
    .forward_A_o,
    .forward_B_o
);


endmodule

