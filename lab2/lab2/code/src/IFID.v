module IFID(
    clk_i,
    stall_i,
    flush_i,
    pc_i,
    instr_i,
    pc_o,
    instr_o
);

input clk_i;
input stall_i;
input flush_i;
input [31:0] pc_i;
input [31:0] instr_i;
output [31:0] pc_o;
output [31:0] instr_o;
reg [31:0] instr_o;
reg [31:0] pc_o;

always @(posedge clk_i) begin
    if (stall_i !== 1'b1) begin
        instr_o = instr_i;
        pc_o = pc_i;
    end
    if (flush_i === 1'b1) begin
        pc_o = 0;
        instr_o = 0;
    end
    
end


endmodule
