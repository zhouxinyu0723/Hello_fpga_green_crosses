`timescale 1 ns/100 ps
// Version: v12.1 12.600.0.14


module FlashFreeze_SB_CCC_0_FCCC(
       RCOSC_25_50MHZ,
       LOCK,
       PLL_ARST_N,
       PLL_POWERDOWN_N,
       GL0,
       GL1
    );
input  RCOSC_25_50MHZ;
output LOCK;
input  PLL_ARST_N;
input  PLL_POWERDOWN_N;
output GL0;
output GL1;

    wire gnd_net, vcc_net, GL0_net, GL1_net;
    
    CLKINT GL1_INST (.A(GL1_net), .Y(GL1));
    VCC vcc_inst (.Y(vcc_net));
    GND gnd_inst (.Y(gnd_net));
    CLKINT GL0_INST (.A(GL0_net), .Y(GL0));
    CCC #( .INIT(210'h0000007FB8000044164000F18C6309C231839DEC0404641801701)
        , .VCOFREQUENCY(600.000) )  CCC_INST (.Y0(), .Y1(), .Y2(), .Y3(
        ), .PRDATA({nc0, nc1, nc2, nc3, nc4, nc5, nc6, nc7}), .LOCK(
        LOCK), .BUSY(), .CLK0(vcc_net), .CLK1(vcc_net), .CLK2(vcc_net), 
        .CLK3(vcc_net), .NGMUX0_SEL(gnd_net), .NGMUX1_SEL(gnd_net), 
        .NGMUX2_SEL(gnd_net), .NGMUX3_SEL(gnd_net), .NGMUX0_HOLD_N(
        vcc_net), .NGMUX1_HOLD_N(vcc_net), .NGMUX2_HOLD_N(vcc_net), 
        .NGMUX3_HOLD_N(vcc_net), .NGMUX0_ARST_N(vcc_net), 
        .NGMUX1_ARST_N(vcc_net), .NGMUX2_ARST_N(vcc_net), 
        .NGMUX3_ARST_N(vcc_net), .PLL_BYPASS_N(vcc_net), .PLL_ARST_N(
        PLL_ARST_N), .PLL_POWERDOWN_N(PLL_POWERDOWN_N), .GPD0_ARST_N(
        vcc_net), .GPD1_ARST_N(vcc_net), .GPD2_ARST_N(vcc_net), 
        .GPD3_ARST_N(vcc_net), .PRESET_N(gnd_net), .PCLK(vcc_net), 
        .PSEL(vcc_net), .PENABLE(vcc_net), .PWRITE(vcc_net), .PADDR({
        vcc_net, vcc_net, vcc_net, vcc_net, vcc_net, vcc_net}), 
        .PWDATA({vcc_net, vcc_net, vcc_net, vcc_net, vcc_net, vcc_net, 
        vcc_net, vcc_net}), .CLK0_PAD(gnd_net), .CLK1_PAD(gnd_net), 
        .CLK2_PAD(gnd_net), .CLK3_PAD(gnd_net), .GL0(GL0_net), .GL1(
        GL1_net), .GL2(), .GL3(), .RCOSC_25_50MHZ(RCOSC_25_50MHZ), 
        .RCOSC_1MHZ(gnd_net), .XTLOSC(gnd_net));
    
endmodule
