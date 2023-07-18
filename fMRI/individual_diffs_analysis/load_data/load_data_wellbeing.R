# This script merges the task and beta series data, and tidies it

# load packages
library(tidyverse)

# load task files
file_dir = "~/Dropbox (University of Oregon)/UO-DSN Lab/FreshmanProject/Tasks/SVC/output/"
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

# tidy task data
# * 1 = yes, 2 = no
# * recode negative responses (e.g. no on reversed item = yes)
task_tidy = task %>%
  mutate(instruction = as.factor(instruction),
         construct = as.factor(construct),
         item = as.character(item),
         RT = ifelse(RT == "NaN", NA, RT),
         response = ifelse(response == 1, "yes",
                           ifelse(response == 2, "no", NA)),
         responseNum = ifelse(response == "yes" & reversed == 0, 1,
                              ifelse(response == "yes" & reversed == 1, 0,
                                     ifelse(response == "no" & reversed == 0, 0,
                                            ifelse(response == "no" & reversed == 1, 1, response)))),
         responseNum = as.integer(responseNum),
         valence = ifelse(construct %in% c("well-being", "social") & reversed == 0, "positive",
                          ifelse(construct %in% c("well-being", "social") & reversed == 1, "negative",
                                 ifelse(construct %in% "ill-being" & reversed == 0, "negative",
                                        ifelse(construct %in% "ill-being" & reversed == 1, "positive", NA)))),
         valence = as.factor(valence)) %>%
  group_by(construct, instruction, subjectID) %>%
  summarize(sum = sum(responseNum, na.rm = TRUE),
            n = n()) %>%
  mutate(percent = (sum / n) * 100) %>%
  ungroup()

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

# write csv files
write.csv(task_tidy, "../../data/task_percent_data.csv", row.names = FALSE)
write.csv(filter(rois, roi %in% c("pgACC", "vmPFC", "VS")), "../../data/neuro_average_data.csv", row.names = FALSE)
