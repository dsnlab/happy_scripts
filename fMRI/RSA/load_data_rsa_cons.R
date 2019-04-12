# This script merges the task and beta series data, and tidies it

# load packages
library(tidyverse)

# load voxel values
file_dir = "~/Documents/code/dsnlab/FP_scripts/fMRI/RSA/voxelValuesCons"
file_pattern = "(FP[0-9]{3})_(.*)_voxelValues.txt"
file_list = list.files(file_dir, pattern = file_pattern)
csv_file = "~/Documents/code/dsnlab/FP_scripts/fMRI/RSA/voxelValuesCons.csv"

vox.vals = data.frame()

if (!file.exists(csv_file)) {
  for (file in file_list) {
    temp = tryCatch(read.table(file.path(file_dir,file), fill = TRUE) %>%
                      `colnames<-`(c("x", "y", "z", sprintf("run%s_%s", rep(1:2, 3), rep(c("self_well-being", "self_social", "self_ill-being", "self_change_well-being", "self_change_social", "self_change_ill-being"), each = 2)))) %>%
                      gather(trial, value, starts_with("run")) %>%
                      extract(trial, c("run","contrast", "construct"), "(run[1-2]{1})_(.*)_(.*)") %>%
                      unite(voxel, x, y, z, sep = "_") %>%
                      mutate(file = file,
                             instruction = "self") %>%
                      extract(file, c("subjectID", "roi"), file_pattern) %>%
                      group_by(instruction, construct, run) %>%
                      mutate(voxelNum = row_number()) %>%
                      ungroup(), error = function(e) message(file))
    
    vox.vals = rbind(vox.vals, temp)
    rm(temp)
  }
  
  write.csv(vox.vals, csv_file, row.names = FALSE)
} else vox.vals = read.csv(csv_file)
