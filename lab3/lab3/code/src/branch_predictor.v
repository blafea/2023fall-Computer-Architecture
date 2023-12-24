module branch_predictor (
    clk_i,
    rst_i,
    update_i,
    result_i,
    predict_o 
);

input clk_i;
input rst_i;
input update_i;
input result_i;

output predict_o;

reg [1:0] state;
assign predict_o = !state[1];

always @(posedge clk_i or posedge rst_i) begin
    if (update_i) begin
        if (result_i) begin
            if (state != 2'b00) begin
                state <= state - 1;
            end
        end
        else begin
            if (state != 2'b11) begin
                state <= state + 1;
            end
        end
    end
end

endmodule