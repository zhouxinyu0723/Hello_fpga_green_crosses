new_project \
         -name {IGL2_FIR_FILTER} \
         -location {D:\G5_SOC\DSP\FIR_FILTER\DSP_FIR_FILTER\designer\IGL2_FIR_FILTER\IGL2_FIR_FILTER_fp} \
         -mode {chain} \
         -connect_programmers {FALSE}
add_actel_device \
         -device {M2S010} \
         -name {M2S010}
enable_device \
         -name {M2S010} \
         -enable {TRUE}
save_project
close_project
