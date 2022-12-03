`include "timer.v"
`include "count.v"
`include "quaking_elimination.v"
`include "display.v"

// 顶层模块
module led_display_ctrl (
    input clk,
    input rst,
    input button,
    input counter,
    output [7:0] led_en,
    output [7:0] led_cx
    );

    wire counter_en;
    reg [99:0] q; // 存储输出字符
    wire [20:0] timer_out; // 现在是个流水灯
    wire [20:0] count_out;
    
    timer u_timer(
        .clk(clk),
        .rst(rst),
        .button(button),
        .timer_out(timer_out)
    );
    quaking_elimination u_quaking_elimination(
        .clk(clk),
        .counter(counter),
        .counter_en(counter_en)
    );
    count u_count(
        .clk(clk),
        .rst(rst),
        .counter_en(counter_en),
        .count_out(count_out)
    );
    display u_display(
        .clk(clk),
        .rst(rst),
        .button(button),
        .timer_out(timer_out),
        .count_out(count_out),
        .led_en(led_en),
        .led_cx(led_cx)
    );
    
endmodule
