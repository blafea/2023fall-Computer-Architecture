module EXMEM(
    clk_i,
    regwrite_i,
    memtoreg_i,
    memread_i,
    memwrite_i,
    alu_result_i,
    mux_B_data_i,
    rd_i,
    regwrite_o,
    memtoreg_o,
    memread_o,
    memwrite_o,
    alu_result_o,
    dm_write_o,
    rd_o
);


input clk_i;
input regwrite_i;
input memtoreg_i;
input memread_i;
input memwrite_i;
input [31:0] alu_result_i;
input [31:0] mux_B_data_i;
input [4:0] rd_i;

output regwrite_o;
output memtoreg_o;
output memread_o;
output memwrite_o;
output [31:0] alu_result_o;
output [31:0] dm_write_o;
output [4:0] rd_o;

reg regwrite_o;
reg memtoreg_o;
reg memread_o;
reg memwrite_o;
reg [31:0] alu_result_o;
reg [31:0] dm_write_o;
reg [4:0] rd_o;

always@(posedge clk_i) begin
    regwrite_o <= regwrite_i;
    memtoreg_o <= memtoreg_i;
    memread_o <= memread_i;
    memwrite_o <= memwrite_i;
    alu_result_o <= alu_result_i;
    dm_write_o <= mux_B_data_i;
    rd_o <= rd_i;
end



endmodule