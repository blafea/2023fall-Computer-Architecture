module PC
(
    rst_i,
    clk_i,
    PCWrite_i,
    pc_i,
    pc_o
);

// Ports
input               rst_i;
input               clk_i;
input               PCWrite_i;
input   [31:0]      pc_i;
output  [31:0]      pc_o;

// Wires & Registers
reg     [31:0]      pc_o;


always@(posedge clk_i or negedge rst_i) begin
    if(~rst_i) begin
        pc_o <= 32'b0;
    end
    else if (PCWrite_i) begin
        pc_o <= pc_i;
    end
end

endmodule
