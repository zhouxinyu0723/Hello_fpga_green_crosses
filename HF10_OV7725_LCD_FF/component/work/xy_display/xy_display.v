//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Fri Dec 31 00:18:04 2021
// Version: v2021.2 2021.2.0.11
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// xy_display
module xy_display(
    // Inputs
    RAM_ADDR,
    V_SYNC,
    clk_i,
    data_valid,
    resetn,
    x,
    xy_refresh,
    xy_valid,
    y,
    // Outputs
    INDEX,
    sel
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input  [9:0]  RAM_ADDR;
input         V_SYNC;
input         clk_i;
input         data_valid;
input         resetn;
input  [8:0]  x;
input         xy_refresh;
input         xy_valid;
input  [8:0]  y;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output [17:0] INDEX;
output        sel;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire           clk_i;
wire           COREFIFO_C0_0_EMPTY;
wire   [17:0]  COREFIFO_C0_0_Q;
wire           data_valid;
wire   [7:0]   DPSRAM_C0_0_A_DOUT;
wire   [7:0]   DPSRAM_C0_0_B_DOUT;
wire   [17:0]  INDEX_net_0;
wire   [9:0]   RAM_ADDR;
wire           resetn;
wire           ROW_PTR_0_v_sync_re;
wire   [14:0]  RPOINTS_0_b_addr_o;
wire   [17:0]  RPOINTS_0_next_index_base17to0;
wire           sel_net_0;
wire           V_SYNC;
wire   [14:0]  WPOINTS_0_a_addr_o;
wire   [7:0]   WPOINTS_0_a_d_o;
wire           WPOINTS_0_a_we_o;
wire           WPOINTS_0_fifo_re_o;
wire   [8:0]   x;
wire   [17:0]  xy_fifo_control_0_data_o;
wire           xy_fifo_control_0_we;
wire           xy_refresh;
wire           xy_valid;
wire   [8:0]   y;
wire           sel_net_1;
wire   [17:0]  INDEX_net_1;
wire   [19:18] next_index_base_slice_0;
wire   [19:0]  next_index_base_net_0;
//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire           GND_net;
wire   [7:0]   B_DIN_const_net_0;
//--------------------------------------------------------------------
// Constant assignments
//--------------------------------------------------------------------
assign GND_net           = 1'b0;
assign B_DIN_const_net_0 = 8'h00;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign sel_net_1   = sel_net_0;
assign sel         = sel_net_1;
assign INDEX_net_1 = INDEX_net_0;
assign INDEX[17:0] = INDEX_net_1;
//--------------------------------------------------------------------
// Slices assignments
//--------------------------------------------------------------------
assign RPOINTS_0_next_index_base17to0 = next_index_base_net_0[17:0];
assign next_index_base_slice_0        = next_index_base_net_0[19:18];
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------COREFIFO_C0
COREFIFO_C0 COREFIFO_C0_0(
        // Inputs
        .CLK     ( clk_i ),
        .RESET_N ( resetn ),
        .WE      ( xy_fifo_control_0_we ),
        .RE      ( WPOINTS_0_fifo_re_o ),
        .DATA    ( xy_fifo_control_0_data_o ),
        // Outputs
        .FULL    (  ),
        .EMPTY   ( COREFIFO_C0_0_EMPTY ),
        .Q       ( COREFIFO_C0_0_Q ) 
        );

//--------DPSRAM_C0
DPSRAM_C0 DPSRAM_C0_0(
        // Inputs
        .A_WEN  ( WPOINTS_0_a_we_o ),
        .B_WEN  ( GND_net ),
        .CLK    ( clk_i ),
        .A_DIN  ( WPOINTS_0_a_d_o ),
        .A_ADDR ( WPOINTS_0_a_addr_o ),
        .B_DIN  ( B_DIN_const_net_0 ),
        .B_ADDR ( RPOINTS_0_b_addr_o ),
        // Outputs
        .A_DOUT ( DPSRAM_C0_0_A_DOUT ),
        .B_DOUT ( DPSRAM_C0_0_B_DOUT ) 
        );

//--------ROW_PTR
ROW_PTR ROW_PTR_0(
        // Inputs
        .RESETN_I     ( resetn ),
        .SYS_CLK_I    ( clk_i ),
        .DATA_VALID_I ( data_valid ),
        .V_SYNC_I     ( V_SYNC ),
        .RAM_ADDR     ( RAM_ADDR ),
        // Outputs
        .init         (  ),
        .v_sync_re    ( ROW_PTR_0_v_sync_re ),
        .ROW_PTR_O    (  ),
        .INDEX        ( INDEX_net_0 ) 
        );

//--------RPOINTS
RPOINTS RPOINTS_0(
        // Inputs
        .sys_clock_i     ( clk_i ),
        .resetn_i        ( resetn ),
        .v_sync_re       ( ROW_PTR_0_v_sync_re ),
        .data_valid_i    ( data_valid ),
        .b_out_in        ( DPSRAM_C0_0_B_DOUT ),
        // Outputs
        .sel             ( sel_net_0 ),
        .b_addr_o        ( RPOINTS_0_b_addr_o ),
        .next_index_base ( next_index_base_net_0 ) 
        );

//--------WPOINTS
WPOINTS WPOINTS_0(
        // Inputs
        .SYS_CLK_I       ( clk_i ),
        .RESETN_I        ( resetn ),
        .fifo_empty      ( COREFIFO_C0_0_EMPTY ),
        .fifo_i          ( COREFIFO_C0_0_Q ),
        .a_i             ( DPSRAM_C0_0_A_DOUT ),
        .next_index_base ( RPOINTS_0_next_index_base17to0 ),
        // Outputs
        .a_addr_o        ( WPOINTS_0_a_addr_o ),
        .a_we_o          ( WPOINTS_0_a_we_o ),
        .a_d_o           ( WPOINTS_0_a_d_o ),
        .fifo_re_o       ( WPOINTS_0_fifo_re_o ) 
        );

//--------xy_fifo_control
xy_fifo_control xy_fifo_control_0(
        // Inputs
        .sys_clk_i  ( clk_i ),
        .resetn_i   ( resetn ),
        .xy_valid   ( xy_valid ),
        .xy_refresh ( xy_refresh ),
        .x          ( x ),
        .y          ( y ),
        // Outputs
        .we         ( xy_fifo_control_0_we ),
        .data_o     ( xy_fifo_control_0_data_o ) 
        );


endmodule
