
//~ `New testbench
`timescale  1ns / 1ps

module tb_led_display_ctrl;

// led_display_ctrl Inputs
reg   clk        = 0 ;
reg   rst        = 0 ;
reg   button     = 0 ;
reg   counter    = 0 ;

// led_display_ctrl Outputs
wire  [7:0]  led_en  ;
wire  [7:0]  led_cx  ;

initial
begin
    forever #5 clk=~clk;
end

led_display_ctrl  u_led_display_ctrl (
    .clk     ( clk       ),
    .rst     ( rst       ),
    .button  ( button    ),
    .counter ( counter   ),

    .led_en  ( led_en    ),
    .led_cx  ( led_cx    )
);

initial
begin
    #12 rst  =  1;
    #3 rst = 0;
    #5 button = 1;
    #10 button = 0;
    #500 counter = 1;
    #5 counter = 0;
    #5 counter = 1;
    #5 counter = 0;
    #1000 counter = 1;
    #5 counter = 0;
    #5 counter = 1;
    #5 counter = 0;
    #5 counter = 1;
    #500 counter = 0;
    #5 counter = 1;
    #5 counter = 0;
    #600 counter = 1;
    #100 counter = 0;
    #600 counter = 1;
    #100 counter = 0;
    #6502 rst = 1;
    #33 rst = 0;
    #100 rst = 0;
    $finish;
end

endmodule
