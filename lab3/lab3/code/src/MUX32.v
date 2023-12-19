module MUX32(
    src_i,
    data0_i,
    data1_i,
    data_o
);

input [31:0] data0_i, data1_i;
input src_i;
output [31:0] data_o;
assign data_o = (src_i) ? data1_i : data0_i;

endmodule