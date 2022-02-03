//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Thu Dec 30 13:34:45 2021
// Version: v2021.2 2021.2.0.11
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

//////////////////////////////////////////////////////////////////////
// Component Description (Tcl) 
//////////////////////////////////////////////////////////////////////
/*
# Exporting Component Description of DPSRAM_C0 to TCL
# Family: SmartFusion2
# Part Number: M2S010-1VF256I
# Create and Configure the core component DPSRAM_C0
create_and_configure_core -core_vlnv {Actel:SgCore:DPSRAM:1.0.102} -component_name {DPSRAM_C0} -params {\
"A_BLK_POLARITY:2"  \
"A_CLK_EDGE:RISE"  \
"A_DEPTH:20480"  \
"A_DOUT_ARST_PN:A_DOUT_ARST_N"  \
"A_DOUT_ARST_POLARITY:2"  \
"A_DOUT_EN_PN:A_DOUT_EN"  \
"A_DOUT_EN_POLARITY:2"  \
"A_DOUT_SRST_PN:A_DOUT_SRST_N"  \
"A_DOUT_SRST_POLARITY:2"  \
"A_PMODE:1"  \
"A_WIDTH:8"  \
"A_WMODE:0"  \
"ADDRESSA_PN:A_ADDR"  \
"ADDRESSB_PN:B_ADDR"  \
"ARST_N_POLARITY:2"  \
"B_BLK_POLARITY:2"  \
"B_CLK_EDGE:RISE"  \
"B_DEPTH:20480"  \
"B_DOUT_ARST_PN:B_DOUT_ARST_N"  \
"B_DOUT_ARST_POLARITY:2"  \
"B_DOUT_EN_PN:B_DOUT_EN"  \
"B_DOUT_EN_POLARITY:2"  \
"B_DOUT_SRST_PN:B_DOUT_SRST_N"  \
"B_DOUT_SRST_POLARITY:2"  \
"B_PMODE:1"  \
"B_WIDTH:8"  \
"B_WMODE:0"  \
"BLKA_PN:A_BLK"  \
"BLKB_PN:B_BLK"  \
"CASCADE:0"  \
"CLK_EDGE:RISE"  \
"CLKA_PN:A_CLK"  \
"CLKB_PN:B_CLK"  \
"CLKS:1"  \
"CLOCK_PN:CLK"  \
"DATAA_IN_PN:A_DIN"  \
"DATAA_OUT_PN:A_DOUT"  \
"DATAB_IN_PN:B_DIN"  \
"DATAB_OUT_PN:B_DOUT"  \
"IMPORT_FILE:"  \
"INIT_RAM:F"  \
"LPMTYPE:LPM_RAM"  \
"PTYPE:2"  \
"RESET_PN:ARST_N"  \
"RWA_PN:A_WEN"  \
"RWB_PN:B_WEN"   }
# Exporting Component Description of DPSRAM_C0 to TCL done
*/

// DPSRAM_C0
module DPSRAM_C0(
    // Inputs
    A_ADDR,
    A_DIN,
    A_WEN,
    B_ADDR,
    B_DIN,
    B_WEN,
    CLK,
    // Outputs
    A_DOUT,
    B_DOUT
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input  [14:0] A_ADDR;
input  [7:0]  A_DIN;
input         A_WEN;
input  [14:0] B_ADDR;
input  [7:0]  B_DIN;
input         B_WEN;
input         CLK;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output [7:0]  A_DOUT;
output [7:0]  B_DOUT;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire   [14:0] A_ADDR;
wire   [7:0]  A_DIN;
wire   [7:0]  A_DOUT_net_0;
wire          A_WEN;
wire   [14:0] B_ADDR;
wire   [7:0]  B_DIN;
wire   [7:0]  B_DOUT_net_0;
wire          B_WEN;
wire          CLK;
wire   [7:0]  A_DOUT_net_1;
wire   [7:0]  B_DOUT_net_1;
//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire          GND_net;
//--------------------------------------------------------------------
// Constant assignments
//--------------------------------------------------------------------
assign GND_net = 1'b0;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign A_DOUT_net_1 = A_DOUT_net_0;
assign A_DOUT[7:0]  = A_DOUT_net_1;
assign B_DOUT_net_1 = B_DOUT_net_0;
assign B_DOUT[7:0]  = B_DOUT_net_1;
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------DPSRAM_C0_DPSRAM_C0_0_DPSRAM   -   Actel:SgCore:DPSRAM:1.0.102
DPSRAM_C0_DPSRAM_C0_0_DPSRAM DPSRAM_C0_0(
        // Inputs
        .A_WEN  ( A_WEN ),
        .B_WEN  ( B_WEN ),
        .CLK    ( CLK ),
        .A_DIN  ( A_DIN ),
        .A_ADDR ( A_ADDR ),
        .B_DIN  ( B_DIN ),
        .B_ADDR ( B_ADDR ),
        // Outputs
        .A_DOUT ( A_DOUT_net_0 ),
        .B_DOUT ( B_DOUT_net_0 ) 
        );


endmodule
