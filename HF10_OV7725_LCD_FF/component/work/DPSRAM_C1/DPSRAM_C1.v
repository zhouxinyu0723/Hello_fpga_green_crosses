//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Thu Dec 30 10:44:24 2021
// Version: v2021.2 2021.2.0.11
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

//////////////////////////////////////////////////////////////////////
// Component Description (Tcl) 
//////////////////////////////////////////////////////////////////////
/*
# Exporting Component Description of DPSRAM_C1 to TCL
# Family: SmartFusion2
# Part Number: M2S010-1VF256I
# Create and Configure the core component DPSRAM_C1
create_and_configure_core -core_vlnv {Actel:SgCore:DPSRAM:1.0.102} -component_name {DPSRAM_C1} -params {\
"A_BLK_POLARITY:2"  \
"A_CLK_EDGE:RISE"  \
"A_DEPTH:15000"  \
"A_DOUT_ARST_PN:A_DOUT_ARST_N"  \
"A_DOUT_ARST_POLARITY:2"  \
"A_DOUT_EN_PN:A_DOUT_EN"  \
"A_DOUT_EN_POLARITY:2"  \
"A_DOUT_SRST_PN:A_DOUT_SRST_N"  \
"A_DOUT_SRST_POLARITY:2"  \
"A_PMODE:0"  \
"A_WIDTH:18"  \
"A_WMODE:0"  \
"ADDRESSA_PN:A_ADDR"  \
"ADDRESSB_PN:B_ADDR"  \
"ARST_N_POLARITY:2"  \
"B_BLK_POLARITY:2"  \
"B_CLK_EDGE:RISE"  \
"B_DEPTH:15000"  \
"B_DOUT_ARST_PN:B_DOUT_ARST_N"  \
"B_DOUT_ARST_POLARITY:2"  \
"B_DOUT_EN_PN:B_DOUT_EN"  \
"B_DOUT_EN_POLARITY:2"  \
"B_DOUT_SRST_PN:B_DOUT_SRST_N"  \
"B_DOUT_SRST_POLARITY:2"  \
"B_PMODE:0"  \
"B_WIDTH:18"  \
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
# Exporting Component Description of DPSRAM_C1 to TCL done
*/

// DPSRAM_C1
module DPSRAM_C1(
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
input  [13:0] A_ADDR;
input  [17:0] A_DIN;
input         A_WEN;
input  [13:0] B_ADDR;
input  [17:0] B_DIN;
input         B_WEN;
input         CLK;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output [17:0] A_DOUT;
output [17:0] B_DOUT;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire   [13:0] A_ADDR;
wire   [17:0] A_DIN;
wire   [17:0] A_DOUT_net_0;
wire          A_WEN;
wire   [13:0] B_ADDR;
wire   [17:0] B_DIN;
wire   [17:0] B_DOUT_net_0;
wire          B_WEN;
wire          CLK;
wire   [17:0] A_DOUT_net_1;
wire   [17:0] B_DOUT_net_1;
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
assign A_DOUT[17:0] = A_DOUT_net_1;
assign B_DOUT_net_1 = B_DOUT_net_0;
assign B_DOUT[17:0] = B_DOUT_net_1;
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------DPSRAM_C1_DPSRAM_C1_0_DPSRAM   -   Actel:SgCore:DPSRAM:1.0.102
DPSRAM_C1_DPSRAM_C1_0_DPSRAM DPSRAM_C1_0(
        // Inputs
        .A_DIN  ( A_DIN ),
        .A_ADDR ( A_ADDR ),
        .B_DIN  ( B_DIN ),
        .B_ADDR ( B_ADDR ),
        .A_WEN  ( A_WEN ),
        .B_WEN  ( B_WEN ),
        .CLK    ( CLK ),
        // Outputs
        .A_DOUT ( A_DOUT_net_0 ),
        .B_DOUT ( B_DOUT_net_0 ) 
        );


endmodule
