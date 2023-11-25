module MEMWB(
    clk_i,
    regwrite_i,
    memtoreg_i,
    dm_addr_i,
    dm_r_data_i,
    rd_i,
    regwrite_o,
    memtoreg_o,
    dm_addr_o,
    dm_r_data_o,
    rd_o,
)

input clk_i,
input regwrite_i,
input memtoreg_i,
input [31:0] dm_addr_i,
input [31:0] dm_r_data_i,
input [4:0] rd_i,

output regwrite_o,
output memtoreg_o,
output [31:0] dm_addr_o,
output [31:0] dm_r_data_o,
output [4:0] rd_o,

reg regwrite_o,
reg memtoreg_o,
reg [31:0] dm_addr_o,
reg [31:0] dm_r_data_o,
reg [4:0] rd_o,


always@(posedge clk_i) begin
    regwrite_o <= regwrite_i;
    memtoreg_o <= memtoreg_i;
    dm_addr_o <= dm_addr_i;
    dm_r_data_o <= dm_r_data_i;
    rd_o <= rd_i;
end

endmodule