# This script merges the task and beta series data, and tidies it

# load packages
library(tidyverse)

# load task files
file_dir = "~/Dropbox (PfeiBer Lab)/FreshmanProject/Tasks/SVC/output/"
file_pattern = "FP[0-9]{3}_wave_1_svc_run[1-2]{1}_output.txt"
file_list = list.files(file_dir, pattern = file_pattern, recursive = TRUE)

task.temp = data.frame()

for (file in file_list){
  temp = tryCatch(read.csv(paste0(file_dir,file), header = FALSE) %>%
                    mutate(file = file) %>%
                    extract(file, c("subjectID", "run"), "(FP[0-9]{3}).*(run[1-2]{1}).*") %>%
                    rename("trial" = V1,
                           "condition" = V2,
                           "onset" = V3,
                           "RT" = V4,
                           "response" = V5,
                           "reversed" = V6,
                           "syllables" = V7,
                           "item" = V8) %>%
                    mutate(instruction = ifelse(condition %in% 1:3, "self", "change"),
                           construct = ifelse(condition %in% c(1,4), "well-being",
                                   ifelse(condition %in% c(2,5), "social", "ill-being"))), error = function(e) message(file))
  task.temp = rbind(task.temp, temp)
  rm(temp)
}

task = task.temp %>%
  mutate(response = ifelse(response == 1, "yes",
                    ifelse(response == 2, "no", NA)),
         responseNum = ifelse(response == "yes" & reversed == 0, 1,
                       ifelse(response == "yes" & reversed == 1, 0,
                       ifelse(response == "no" & reversed == 0, 0,
                       ifelse(response == "no" & reversed == 1, 1, response)))),
         responseNum = as.integer(responseNum))

# load voxel values
file_dir = "~/Documents/code/dsnlab/FP_scripts/fMRI/RSA/voxelValues"
file_pattern = "(FP[0-9]{3})_(.*)_voxelValues.txt"
file_list = list.files(file_dir, pattern = file_pattern)
csv_file = "~/Documents/code/dsnlab/FP_scripts/fMRI/RSA/voxelValues.csv"

vox.vals = data.frame()

if (!file.exists(csv_file)) {
  for (file in file_list) {
    temp = tryCatch(read.table(file.path(file_dir,file), fill = TRUE) %>%
                      `colnames<-`(c("x", "y", "z", sprintf("run%s_%s", rep(1:2, each = 36), rep(1:36, 2)))) %>%
                      gather(trial, value, starts_with("run")) %>%
                      extract(trial, c("run","trial"), "(run[1-2]{1})_([0-9]+)") %>%
                      unite(voxel, x, y, z, sep = "_") %>%
                      mutate(file = file,
                             trial = as.integer(trial)) %>%
                      extract(file, c("subjectID", "roi"), file_pattern) %>%
                      group_by(trial, run) %>%
                      mutate(voxelNum = row_number()) %>%
                      ungroup(), error = function(e) message(file))
    
    vox.vals = rbind(vox.vals, temp)
    rm(temp)
  }
  
  write.csv(vox.vals, csv_file, row.names = FALSE)
} else vox.vals = read.csv(csv_file)


# tidy
# merge datasets, and standardize within subject and roi
# * 1 = yes, 2 = no
# * recode negative responses (e.g. no on reversed item = yes)

data = left_join(task, vox.vals, by = c("subjectID", "trial", "run"))
