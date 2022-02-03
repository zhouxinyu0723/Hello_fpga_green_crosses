//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Wed May 29 12:35:52 2019
// Version: v12.1 12.600.0.14
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// test
module test(
    // Inputs
    RX,
    Wake_On_Change_SW,
    ff_trig,
    pb0,
    // Outputs
    INIT_DONE,
    MSS_READY,
    SW_output,
    TX,
    dout,
    led
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input        RX;
input        Wake_On_Change_SW;
input        ff_trig;
input        pb0;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output       INIT_DONE;
output       MSS_READY;
output       SW_output;
output       TX;
output       dout;
output [1:0] led;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire         dout_net_0;
wire         ff_trig;
wire         INIT_DONE_net_0;
wire   [1:0] led_net_0;
wire         MSS_READY_net_0;
wire         pb0;
wire         RESET_GEN_C0_0_RESET;
wire         RX;
wire         SW_output_net_0;
wire         TX_net_0;
wire         Wake_On_Change_SW;
wire         MSS_READY_net_1;
wire   [1:0] led_net_1;
wire         INIT_DONE_net_1;
wire         dout_net_1;
wire         SW_output_net_1;
wire         TX_net_1;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign MSS_READY_net_1 = MSS_READY_net_0;
assign MSS_READY       = MSS_READY_net_1;
assign led_net_1       = led_net_0;
assign led[1:0]        = led_net_1;
assign INIT_DONE_net_1 = INIT_DONE_net_0;
assign INIT_DONE       = INIT_DONE_net_1;
assign dout_net_1      = dout_net_0;
assign dout            = dout_net_1;
assign SW_output_net_1 = SW_output_net_0;
assign SW_output       = SW_output_net_1;
assign TX_net_1        = TX_net_0;
assign TX              = TX_net_1;
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------RESET_GEN_C0
RESET_GEN_C0 RESET_GEN_C0_0(
        // Outputs
        .RESET ( RESET_GEN_C0_0_RESET ) 
        );

//--------TOP
TOP TOP_0(
        // Inputs
        .DEVRST_N_0        ( RESET_GEN_C0_0_RESET ),
        .RX                ( RX ),
        .pb0               ( pb0 ),
        .Wake_On_Change_SW ( Wake_On_Change_SW ),
        .ff_trig           ( ff_trig ),
        // Outputs
        .TX                ( TX_net_0 ),
        .dout              ( dout_net_0 ),
        .SW_output         ( SW_output_net_0 ),
        .led               ( led_net_0 ),
        .INIT_DONE         ( INIT_DONE_net_0 ),
        .MSS_READY         ( MSS_READY_net_0 ) 
        );


endmodule
