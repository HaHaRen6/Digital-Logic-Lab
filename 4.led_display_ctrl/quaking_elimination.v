// 消抖模块
module quaking_elimination (
    input clk,
    input counter,
    output reg counter_en
    );
    reg [19:0] cnt_max = 20'd100_0000;
    reg [19:0] cnt;
    wire cnt_end;

    assign cnt_end = (cnt >= cnt_max);	// 计数结束条件

    always @ (posedge clk) begin 
        if (!counter) begin
            cnt <= 20'b0;
            counter_en <= 0;
        end
        else if (!cnt_end) cnt <= cnt + 20'b1;
    end

    always @ (posedge clk) begin
        if (cnt >= cnt_max) counter_en <= 1;
    end
endmodule
