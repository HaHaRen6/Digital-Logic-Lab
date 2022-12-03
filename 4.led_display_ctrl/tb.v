
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

initial
begin
    #10 rst_n  =  1;
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

    $finish;
end

endmodule
