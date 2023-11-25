module MUX4 (
    src_i,
    data0_i,
    data1_i,
    data2_i,
    data3_i,
    data_o
);

input [31:0] data0_i, data1_i, data2_i, data3_i;
input [1:0] src_i;
output [31:0] data_o;
assign data_o = (src_i == 2'b00) ? data0_i :
                (src_i == 2'b01) ? data1_i :
                (src_i == 2'b10) ? data2_i :
                (src_i == 2'b11) ? data3_i :
                data1_i;
    
endmodule