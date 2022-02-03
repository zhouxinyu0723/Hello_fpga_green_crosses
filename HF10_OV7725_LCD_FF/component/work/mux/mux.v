//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Thu Dec 30 10:36:35 2021
// Version: v2021.2 2021.2.0.11
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// mux
module mux(
    // Inputs
    mux5_0_pin_IN0,
    mux5_1_pin_IN0,
    mux5_1_pin_SEL,
    mux6_0_pin_IN0,
    // Outputs
    mux5_0_pin_O,
    mux5_1_pin_O,
    mux6_0_pin_O
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input  [4:0] mux5_0_pin_IN0;
input  [4:0] mux5_1_pin_IN0;
input        mux5_1_pin_SEL;
input  [5:0] mux6_0_pin_IN0;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output [4:0] mux5_0_pin_O;
output [4:0] mux5_1_pin_O;
output [5:0] mux6_0_pin_O;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire   [4:0] mux5_0_pin_IN0;
wire   [4:0] mux5_0_pin_O_net_0;
wire   [4:0] mux5_1_pin_IN0;
wire   [4:0] mux5_1_pin_O_net_0;
wire         mux5_1_pin_SEL;
wire   [5:0] mux6_0_pin_IN0;
wire   [5:0] mux6_0_pin_O_net_0;
wire   [4:0] mux5_0_pin_O_net_1;
wire   [5:0] mux6_0_pin_O_net_1;
wire   [4:0] mux5_1_pin_O_net_1;
//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire   [4:0] IN1_const_net_0;
wire   [4:0] IN1_const_net_1;
wire   [5:0] IN1_const_net_2;
//--------------------------------------------------------------------
// Constant assignments
//--------------------------------------------------------------------
assign IN1_const_net_0 = 5'h1F;
assign IN1_const_net_1 = 5'h00;
assign IN1_const_net_2 = 6'h3F;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign mux5_0_pin_O_net_1 = mux5_0_pin_O_net_0;
assign mux5_0_pin_O[4:0]  = mux5_0_pin_O_net_1;
assign mux6_0_pin_O_net_1 = mux6_0_pin_O_net_0;
assign mux6_0_pin_O[5:0]  = mux6_0_pin_O_net_1;
assign mux5_1_pin_O_net_1 = mux5_1_pin_O_net_0;
assign mux5_1_pin_O[4:0]  = mux5_1_pin_O_net_1;
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------mux5
mux5 mux5_0(
        // Inputs
        .SEL ( mux5_1_pin_SEL ),
        .IN0 ( mux5_0_pin_IN0 ),
        .IN1 ( IN1_const_net_0 ),
        // Outputs
        .O   ( mux5_0_pin_O_net_0 ) 
        );

//--------mux5
mux5 mux5_1(
        // Inputs
        .SEL ( mux5_1_pin_SEL ),
        .IN0 ( mux5_1_pin_IN0 ),
        .IN1 ( IN1_const_net_1 ),
        // Outputs
        .O   ( mux5_1_pin_O_net_0 ) 
        );

//--------mux6
mux6 mux6_0(
        // Inputs
        .SEL ( mux5_1_pin_SEL ),
        .IN0 ( mux6_0_pin_IN0 ),
        .IN1 ( IN1_const_net_2 ),
        // Outputs
        .O   ( mux6_0_pin_O_net_0 ) 
        );


endmodule
