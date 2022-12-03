// 计数模块
module count (
    input clk,
    input rst,
    input counter_en,
    output reg [20:0] count_out
    );
    reg sig_r0,sig_r1;

    always @ (posedge clk or posedge rst) begin
        if (rst)
            count_out <= 21'b1;
        else if (~sig_r1 & sig_r0) begin
            count_out <= {count_out[19:0],count_out[20]};
        end
    end

    always @ (posedge clk or posedge rst) begin
        if (rst)
            sig_r0 <= 1'b0;
        else 
            sig_r0 <= counter_en;
    end

    always @ (posedge clk or posedge rst) begin
        if (rst)
            sig_r1 <= 1'b0;
        else 
            sig_r1 <= sig_r0;
    end
endmodule
