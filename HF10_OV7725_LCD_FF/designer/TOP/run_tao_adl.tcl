set_device -family {SmartFusion2} -die {M2S010} -speed {-1}
read_adl {D:\time_eternity\desktop_download_doc_pic_vid_music\Desktop\industrie_and_space\pro\Image_Processing_with_low_power_demo\HF10_OV7725_LCD_FF\designer\TOP\TOP.adl}
read_afl {D:\time_eternity\desktop_download_doc_pic_vid_music\Desktop\industrie_and_space\pro\Image_Processing_with_low_power_demo\HF10_OV7725_LCD_FF\designer\TOP\TOP.afl}
map_netlist
read_sdc {D:\time_eternity\desktop_download_doc_pic_vid_music\Desktop\industrie_and_space\pro\Image_Processing_with_low_power_demo\HF10_OV7725_LCD_FF\constraint\TOP_derived_constraints.sdc}
check_constraints {D:\time_eternity\desktop_download_doc_pic_vid_music\Desktop\industrie_and_space\pro\Image_Processing_with_low_power_demo\HF10_OV7725_LCD_FF\constraint\placer_sdc_errors.log}
write_sdc -mode layout {D:\time_eternity\desktop_download_doc_pic_vid_music\Desktop\industrie_and_space\pro\Image_Processing_with_low_power_demo\HF10_OV7725_LCD_FF\designer\TOP\place_route.sdc}
