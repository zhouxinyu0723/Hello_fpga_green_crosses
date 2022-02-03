quietly set ACTELLIBNAME SmartFusion2
quietly set PROJECT_DIR "D:/time_eternity/desktop_download_doc_pic_vid_music/Desktop/industrie_and_space/pro/Image_Processing_with_low_power_demo/HF10_OV7725_LCD_FF"
source "${PROJECT_DIR}/simulation/CM3_compile_bfm.tcl";


if {[file exists presynth/_info]} {
   echo "INFO: Simulation library presynth already exists"
} else {
   file delete -force presynth 
   vlib presynth
}
vmap presynth presynth
vmap SmartFusion2 "C:/Microsemi/Libero_SoC_v2021.2/Designer/lib/modelsimpro/precompiled/vlog/SmartFusion2"
if {[file exists COREFFT_LIB/_info]} {
   echo "INFO: Simulation library COREFFT_LIB already exists"
} else {
   file delete -force COREFFT_LIB 
   vlib COREFFT_LIB
}
vmap COREFFT_LIB "COREFFT_LIB"
if {[file exists COREFIR_LIB/_info]} {
   echo "INFO: Simulation library COREFIR_LIB already exists"
} else {
   file delete -force COREFIR_LIB 
   vlib COREFIR_LIB
}
vmap COREFIR_LIB "COREFIR_LIB"
if {[file exists CORESYSSERVICES_LIB/_info]} {
   echo "INFO: Simulation library CORESYSSERVICES_LIB already exists"
} else {
   file delete -force CORESYSSERVICES_LIB 
   vlib CORESYSSERVICES_LIB
}
vmap CORESYSSERVICES_LIB "CORESYSSERVICES_LIB"

vlog -vlog01compat -work presynth "${PROJECT_DIR}/hdl/FF_EXT.v"
vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/hdl/FF_GENERATOR.vhd"
vlog -vlog01compat -work presynth "${PROJECT_DIR}/hdl/coreresetp_pcie_hotreset.v"
vlog -vlog01compat -work presynth "${PROJECT_DIR}/hdl/coreresetp.v"
vlog -vlog01compat -work presynth "${PROJECT_DIR}/hdl/CORERESETP_0.v"
vlog -vlog01compat -work presynth "${PROJECT_DIR}/component/work/FlashFreeze_SB/CCC_0/FlashFreeze_SB_CCC_0_FCCC.v"
vlog -vlog01compat -work presynth "${PROJECT_DIR}/component/work/FlashFreeze_SB_MSS/FlashFreeze_SB_MSS.v"
vlog -vlog01compat -work presynth "${PROJECT_DIR}/component/work/FlashFreeze_SB/FlashFreeze_SB.v"
vlog -vlog01compat -work presynth "${PROJECT_DIR}/component/work/OSC_C0/OSC_C0_0/OSC_C0_OSC_C0_0_OSC.v"
vlog -vlog01compat -work presynth "${PROJECT_DIR}/component/work/OSC_C0/OSC_C0.v"
vlog -vlog01compat -work presynth "${PROJECT_DIR}/component/work/COREUART_C0/COREUART_C0_0/rtl/vlog/core_obfuscated/Rx_async.v"
vlog -vlog01compat -work presynth "${PROJECT_DIR}/component/work/COREUART_C0/COREUART_C0_0/rtl/vlog/core_obfuscated/Tx_async.v"
vlog -vlog01compat -work presynth "${PROJECT_DIR}/component/work/COREUART_C0/COREUART_C0_0/rtl/vlog/core_obfuscated/fifo_256x8_g4.v"
vlog -vlog01compat -work presynth "${PROJECT_DIR}/component/work/COREUART_C0/COREUART_C0_0/rtl/vlog/core_obfuscated/Clock_gen.v"
vlog -vlog01compat -work presynth "${PROJECT_DIR}/component/work/COREUART_C0/COREUART_C0_0/rtl/vlog/core_obfuscated/CoreUART.v"
vlog -vlog01compat -work presynth "${PROJECT_DIR}/component/work/COREUART_C0/COREUART_C0.v"
vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/hdl/addr_decoder.vhd"
vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/hdl/receive_data.vhd"
vlog -vlog01compat -work presynth "${PROJECT_DIR}/component/work/UART_interface/UART_interface.v"
vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/hdl/apb3_if.vhd"
vlog -vlog01compat -work presynth "${PROJECT_DIR}/hdl/led_blink.v"
vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/hdl/Image_Enhancement.vhd"
vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/hdl/LCD_FSM.vhd"
vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/hdl/Write_LSRAM.vhd"
vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/hdl/double_flop.vhd"
vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/hdl/RamDualPort.vhd"
vlog -vlog01compat -work presynth "${PROJECT_DIR}/component/work/line_write_read/line_write_read.v"
vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/hdl/mux_2_1.vhd"
vlog -vlog01compat -work presynth "${PROJECT_DIR}/component/work/TOP/TOP.v"
vlog "+incdir+${PROJECT_DIR}/component/Actel/Simulation/RESET_GEN/1.0.1" "+incdir+${PROJECT_DIR}/component/work/RESET_GEN_C0" "+incdir+${PROJECT_DIR}/component/work/test" -vlog01compat -work presynth "${PROJECT_DIR}/component/Actel/Simulation/RESET_GEN/1.0.1/RESET_GEN.v"
vlog "+incdir+${PROJECT_DIR}/component/Actel/Simulation/RESET_GEN/1.0.1" "+incdir+${PROJECT_DIR}/component/work/RESET_GEN_C0" "+incdir+${PROJECT_DIR}/component/work/test" -vlog01compat -work presynth "${PROJECT_DIR}/component/work/RESET_GEN_C0/RESET_GEN_C0.v"
vlog "+incdir+${PROJECT_DIR}/component/Actel/Simulation/RESET_GEN/1.0.1" "+incdir+${PROJECT_DIR}/component/work/RESET_GEN_C0" "+incdir+${PROJECT_DIR}/component/work/test" -vlog01compat -work presynth "${PROJECT_DIR}/component/work/test/test.v"

vsim -L SmartFusion2 -L presynth -L COREFFT_LIB -L COREFIR_LIB -L CORESYSSERVICES_LIB  -t 1fs presynth.test
add wave /test/*
run 1000ns
