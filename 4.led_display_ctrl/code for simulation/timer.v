// ��ʱģ��:���0.2s����0��20ѭ������
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

    assign cnt_end = (cnt == cnt_max - 1);	// ������������

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
        if (rst | cnt_end)  cnt <= 27'h0;          // �жϺ�ʱ��λ
        else if (cnt_inc)   cnt <= cnt + 27'h1;    // �ж��Ƿ������1
    end
    
    always @ (posedge clk or posedge rst) 
        if (rst) timer_out <= 21'b1;
        else if (cnt == cnt_max - 1) begin
            timer_out <= {timer_out[19:0],timer_out[20]};
    end
endmodule