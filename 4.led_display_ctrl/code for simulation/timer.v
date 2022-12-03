// 计时模块:间隔0.2s，从0到20循环计数
module timer (
    input clk,
    input rst,
    input button,
    output reg [20:0] timer_out
    );

    reg [25:0] cnt_max;
    wire cnt_end;
    reg [25:0]cnt;
    reg cnt_inc;

    assign cnt_end = (cnt == cnt_max - 1);	// 计数结束条件

    always @ (posedge clk or posedge rst) begin
        if (rst)    begin 
            cnt_inc <= 0;
            cnt_max <= 25'd20;
        end
        else if (button)  begin
            cnt_inc <= 1;
        end
    end

    always @ (posedge clk or posedge rst) begin
        if (rst | cnt_end)  cnt <= 27'h0;          // 判断何时复位
        else if (cnt_inc)   cnt <= cnt + 27'h1;    // 判断是否继续加1
    end
    
    always @ (posedge clk or posedge rst) 
        if (rst) timer_out <= 21'b1;
        else if (cnt == cnt_max - 1) begin
            timer_out <= {timer_out[19:0],timer_out[20]};
    end
endmodule