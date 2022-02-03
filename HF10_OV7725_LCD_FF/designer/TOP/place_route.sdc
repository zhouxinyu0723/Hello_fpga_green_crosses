# Microsemi Corp.
# Date: 2022-Jan-04 12:41:56
# This file was generated based on the following SDC source files:
#   D:/time_eternity/desktop_download_doc_pic_vid_music/Desktop/industrie_and_space/pro/Image_Processing_with_low_power_demo/HF10_OV7725_LCD_FF/constraint/TOP_derived_constraints.sdc
#

create_clock -name {OSC_C0_0/OSC_C0_0/I_RCOSC_25_50MHZ/CLKOUT} -period 20 [ get_pins { OSC_C0_0/OSC_C0_0/I_RCOSC_25_50MHZ/CLKOUT } ]
create_generated_clock -name {FlashFreeze_SB_0/CCC_0/GL0} -multiply_by 24 -divide_by 12 -source [ get_pins { FlashFreeze_SB_0/CCC_0/CCC_INST/INST_CCC_IP/RCOSC_25_50MHZ } ] -phase 0 [ get_pins { FlashFreeze_SB_0/CCC_0/CCC_INST/INST_CCC_IP/GL0 } ]
create_generated_clock -name {FlashFreeze_SB_0/CCC_0/GL1} -multiply_by 24 -divide_by 50 -source [ get_pins { FlashFreeze_SB_0/CCC_0/CCC_INST/INST_CCC_IP/RCOSC_25_50MHZ } ] -phase 0 [ get_pins { FlashFreeze_SB_0/CCC_0/CCC_INST/INST_CCC_IP/GL1 } ]
set_false_path -through [ get_pins { FlashFreeze_SB_0/FlashFreeze_SB_MSS_0/MSS_ADLIB_INST/INST_MSS_010_IP/CONFIG_PRESET_N } ]
set_false_path -through [ get_pins { SYSRESET_0/INST_SYSRESET_FF_IP/POWER_ON_RESET_N } ]
