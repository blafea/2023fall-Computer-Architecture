module IFID(
    clk_i,
    instr_i,
    instr_o
);

input clk_i;
input [31:0] instr_i;
output [31:0] instr_o;


assign instr_o = instr_i;

endmodule
