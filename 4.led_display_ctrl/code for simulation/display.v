// 数码管显示模块
module display (
    input clk,
    input rst,
    input button,
    input [20:0] timer_out,
    input [20:0] count_out,
    output reg [7:0] led_en,
    output reg [7:0] led_cx
    );
    reg [63:0] q;
    reg [17:0]cnt_max;
    wire cnt_end;
    reg [17:0]cnt;
    reg cnt_inc;
    reg [7:0] timer;
    integer i,j;

    assign cnt_end = (cnt == cnt_max - 1);	// 计数结束条件

    // 复位
    always @ (posedge clk or posedge rst) begin
        if (rst) begin 
            cnt_inc <= 0;
            cnt_max <= 18'd10;
        end
        else if (button) cnt_inc <= 1;
    end

    always @ (posedge clk or posedge rst) begin
        if (rst | cnt_end)  cnt <= 18'h0;          // 判断何时复位
        else if (cnt_inc)   cnt <= cnt + 18'h1;    // 判断是否继续加1
    end
    
    // flowing_water timer
    always @ (posedge clk or posedge rst) 
        if (rst) timer <= 8'b0;
        else if (button) timer <= 8'b1;
        else if (cnt == cnt_max - 1) begin
            timer <= {timer[6:0],timer[7]};
    end

    // (timer_out and count_out) to q
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            q[63:56] <= 8'b0000_0011; // 0
            q[55:48] <= 8'b0000_0011; // 0
            q[47:40] <= 8'b0000_0011; // 0
            q[39:32] <= 8'b0000_0011; // 0
            q[31:24] <= 8'b0000_0011; // 0
            q[23:16] <= 8'b1001_1001; // 4
            q[15:8]  <= 8'b0000_0011; // 0
            q[7:0]   <= 8'b1001_1001; // 4
        end 
        else begin
            for (i = 0; i < 21; i = i + 1) begin 
                if (timer_out[i] == 1) begin 
                    case(i / 10)
                        0: q[63:56] <= 8'b0000_0011;
                        1: q[63:56] <= 8'b1001_1111;
                        2: q[63:56] <= 8'b0010_0101;
                        default: q[63:56] <= 8'b0000_0011;
                    endcase
                    case(i % 10)
                        0: q[55:48] <= 8'b0000_0011;
                        1: q[55:48] <= 8'b1001_1111;
                        2: q[55:48] <= 8'b0010_0101;
                        3: q[55:48] <= 8'b0000_1101;
                        4: q[55:48] <= 8'b1001_1001;
                        5: q[55:48] <= 8'b0100_1001;
                        6: q[55:48] <= 8'b0100_0001;
                        7: q[55:48] <= 8'b0001_1111;
                        8: q[55:48] <= 8'b0000_0001;
                        9: q[55:48] <= 8'b0000_1001;
                        default:q[55:48] <= 8'b0000_0011;
                    endcase
                end
                if (count_out[i] == 1) begin 
                    case(i / 10)
                        0: q[47:40] <= 8'b0000_0011;
                        1: q[47:40] <= 8'b1001_1111;
                        2: q[47:40] <= 8'b0010_0101;
                        default: q[47:40] <= 8'b0000_0011;
                    endcase
                    case(i % 10)
                        0: q[39:32] <= 8'b0000_0011;
                        1: q[39:32] <= 8'b1001_1111;
                        2: q[39:32] <= 8'b0010_0101;
                        3: q[39:32] <= 8'b0000_1101;
                        4: q[39:32] <= 8'b1001_1001;
                        5: q[39:32] <= 8'b0100_1001;
                        6: q[39:32] <= 8'b0100_0001;
                        7: q[39:32] <= 8'b0001_1111;
                        8: q[39:32] <= 8'b0000_0001;
                        9: q[39:32] <= 8'b0000_1001;
                        default:q[39:32] <= 8'b0000_0011;
                    endcase
                end
            end
        end
    end

    // timer to led_en
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            led_en <= 8'b1;
        end
        else begin
            led_en[7:0] <= ~timer[7:0];
        end
    end

    // q to led_cx
    always @ (posedge clk or posedge rst) begin
        if (rst) begin
            led_cx <= 8'b1;
        end
        else begin
            case (timer)
                8'b0000_0001: led_cx <= q[7:0];
                8'b0000_0010: led_cx <= q[15:8];
                8'b0000_0100: led_cx <= q[23:16];
                8'b0000_1000: led_cx <= q[31:24];
                8'b0001_0000: led_cx <= q[39:32];
                8'b0010_0000: led_cx <= q[47:40];
                8'b0100_0000: led_cx <= q[55:48];
                8'b1000_0000: led_cx <= q[63:56];
            endcase
        end
    end

endmodule