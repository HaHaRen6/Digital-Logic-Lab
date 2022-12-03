// ����ģ��
module quaking_elimination (
    input clk,
    input counter,
    output reg counter_en
    );
    reg [4:0] cnt_max = 5'd3;
    reg [4:0] cnt;
    wire cnt_end;

    assign cnt_end = (cnt >= cnt_max);	// ������������

    always @ (posedge clk) begin 
        if (!counter) cnt <= 5'b0;
        else if (!cnt_end) cnt <= cnt + 5'b1;
    end

    always @ (posedge clk) begin
        if (!counter) counter_en <= 0;
        else if (cnt >= cnt_max) counter_en <= 1;
    end
endmodule
