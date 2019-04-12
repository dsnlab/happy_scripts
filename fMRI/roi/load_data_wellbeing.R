# This script merges the task and beta series data, and tidies it

# load packages
library(tidyverse)

# load task files
file_dir = "~/Dropbox (PfeiBer Lab)/FreshmanProject/Tasks/SVC/output/"
file_pattern = "FP[0-9]{3}_wave_1_svc_run[1-2]{1}_output.txt"
file_list = list.files(file_dir, pattern = file_pattern, recursive = TRUE)

task = data.frame()

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
  task = rbind(task, temp)
  rm(temp)
}

# load parameter estimates
file_dir = "~/Documents/code/dsnlab/FP_scripts/fMRI/roi/parameterEstimates"
file_pattern = "FP[0-9]{3}_parameterEstimates.txt"
file_list = list.files(file_dir, pattern = file_pattern)

rois = data.frame()

for (file in file_list) {
  temp = tryCatch(read.table(file.path(file_dir,file), fill = TRUE) %>%
                    rename("subjectID" = V1,
                           "roi" = V3,
                           "meanPE" = V4, 
                           "sdPE" = V5) %>%
                    extract(V2, "con", "con_([0-9]{4}).nii") %>%
                    mutate(construct = ifelse(con %in% c("0001", "0013"), "well-being",
                                   ifelse(con %in% c("0002", "0014"), "social",
                                   ifelse(con %in% c("0003", "0015"), "ill-being", NA))),
                           instruction = "self",
                           contrast = ifelse(con %in% c("0001", "0002", "0003"), "self", "self_change")) %>%
                    select(-con), error = function(e) message(file))
  
  rois = rbind(rois, temp)
  rm(temp)
}

# load dot products
file_dir = "~/Documents/code/dsnlab/FP_scripts/fMRI/multivariate/expression_maps/dotProducts/"
file_pattern = "FP[0-9]{3}_dotProducts.txt"
file_list = list.files(file_dir, pattern = file_pattern)

dots = data.frame()

for (file in file_list) {
  temp = tryCatch(read.table(file.path(file_dir,file), fill = TRUE) %>%
                    rename("subjectID" = V1,
                           "model" = V3,
                           "map" = V4, 
                           "dotProduct" = V5) %>%
                    extract(V2, "con", "con_([0-9]{4}).nii") %>%
                    mutate(construct = ifelse(con %in% c("0001", "0013"), "well-being",
                                   ifelse(con %in% c("0002", "0014"), "social",
                                   ifelse(con %in% c("0003", "0015"), "ill-being", NA))),
                           instruction = "self",
                           contrast = ifelse(con %in% c("0001", "0002", "0003"), "self", "self_change"),
                           map = ifelse(map == "con_0001", "con",
                                 ifelse(map == "spmT_0001", "tmap", NA))) %>%
                    select(-con), error = function(e) message(file))
  
  dots = rbind(dots, temp)
  rm(temp)
}
