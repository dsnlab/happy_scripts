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
# * Recode incorrectly named constructs
# * Recode negative responses (e.g. no on reversed item = yes) in the social facet

task_tidy = task %>%
  extract(subjectID, "subNum", "FP([0-9]{3})", remove = FALSE) %>%
  mutate(construct = ifelse(item == "lonely", "social",
                            ifelse(item == "angry", "ill-being", construct)),
         reversed = ifelse(item == "lonely", 1,
                           ifelse(item == "angry", 0, reversed)),
         instruction = as.factor(instruction),
         construct = as.factor(construct),
         item = as.character(item),
         RT = ifelse(RT == "NaN", NA, RT),
         RT_original= RT,
         RT = log(RT) - mean(log(RT), na.rm = TRUE),
         response = ifelse(response == 1, "yes",
                           ifelse(response == 2, "no", NA)),
         responseNum = ifelse(response == "yes" & reversed == 0, 1,
                              ifelse(response == "yes" & reversed == 1, 0,
                                     ifelse(response == "no" & reversed == 0, 0,
                                            ifelse(response == "no" & reversed == 1, 1, response)))),
         responseNum = as.integer(responseNum),
         responseYN = ifelse(responseNum == 1, "yes",
                             ifelse(responseNum == 0, "no", responseNum)),
         valence = ifelse(construct %in% c("well-being", "social") & reversed == 0, "positive",
                          ifelse(construct %in% c("well-being", "social") & reversed == 1, "negative",
                                 ifelse(construct %in% "ill-being" & reversed == 0, "negative",
                                        ifelse(construct %in% "ill-being" & reversed == 1, "positive", NA))))) %>%
  ungroup()

# write csv files
write.csv(task_tidy, "../../data/task_data.csv", row.names = FALSE)
