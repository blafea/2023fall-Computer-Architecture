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

assign funct7 = instr[31:25];
assign rs2 = instr[24:20];
assign rs1 = instr[19:15];
assign funct3 = instr[14:12];
assign rd = instr[11:7];
assign opcode = instr[6:0];
assign imm = instr[31:20];

wire [31:0] instr_0;
assign 


Control Control(
    .op_i(opcode),
    .aluop_o(aluop),
    .alusrc_o(alusrc),
    .regwrite_o(regwrite),
    .memtoreg_o(memtoreg),
    .memread_o(memread),
    .memwrite_o(memwrite),
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
    .RDaddr_i(rd), 
    .RDdata_i(alu_result),
    .RegWrite_i(regwrite), 
    .RS1data_o(rs1data), 
    .RS2data_o(rs2data) 
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
    .addr_i, 
    .MemRead_i,
    .MemWrite_i,
    .data_i,
    .data_o
);

MUX32 wb_source(
    .src_i,
    .data0_i,
    .data1_i,
    .data_o
);

IFID IFID(
    .instr_i(instr_0),
    .instr_o(instr)
);

IDEXE IDEXE(

);

EXEMEM EXEMEM(

);

MEMWB MEMWB(

);

endmodule

