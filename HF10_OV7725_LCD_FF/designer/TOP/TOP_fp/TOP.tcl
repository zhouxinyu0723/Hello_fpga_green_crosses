open_project -project {D:\time_eternity\desktop_download_doc_pic_vid_music\Desktop\industrie_and_space\pro\Image_Processing_with_low_power_demo\HF10_OV7725_LCD_FF\designer\TOP\TOP_fp\TOP.pro}\
         -connect_programmers {FALSE}
load_programming_data \
    -name {M2S010} \
    -fpga {D:\time_eternity\desktop_download_doc_pic_vid_music\Desktop\industrie_and_space\pro\Image_Processing_with_low_power_demo\HF10_OV7725_LCD_FF\designer\TOP\TOP.map} \
    -header {D:\time_eternity\desktop_download_doc_pic_vid_music\Desktop\industrie_and_space\pro\Image_Processing_with_low_power_demo\HF10_OV7725_LCD_FF\designer\TOP\TOP.hdr} \
    -envm {D:\time_eternity\desktop_download_doc_pic_vid_music\Desktop\industrie_and_space\pro\Image_Processing_with_low_power_demo\HF10_OV7725_LCD_FF\designer\TOP\TOP.efc} \
    -spm {D:\time_eternity\desktop_download_doc_pic_vid_music\Desktop\industrie_and_space\pro\Image_Processing_with_low_power_demo\HF10_OV7725_LCD_FF\designer\TOP\TOP.spm} \
    -dca {D:\time_eternity\desktop_download_doc_pic_vid_music\Desktop\industrie_and_space\pro\Image_Processing_with_low_power_demo\HF10_OV7725_LCD_FF\designer\TOP\TOP.dca}
export_single_ppd \
    -name {M2S010} \
    -file {D:\time_eternity\desktop_download_doc_pic_vid_music\Desktop\industrie_and_space\pro\Image_Processing_with_low_power_demo\HF10_OV7725_LCD_FF\designer\TOP\export\TOP.ppd}

export_single_dat \
    -name {M2S010} \
    -file {D:\time_eternity\desktop_download_doc_pic_vid_music\Desktop\industrie_and_space\pro\Image_Processing_with_low_power_demo\HF10_OV7725_LCD_FF\designer\TOP\export\TOP.dat} \
    -secured

save_project
close_project
