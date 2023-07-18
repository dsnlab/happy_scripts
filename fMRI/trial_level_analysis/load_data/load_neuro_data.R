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

# load parameter estimates
file_dir = "~/Documents/code/dsnlab/FP_scripts/fMRI/betaseries/svc/wave1/parameterEstimates"
file_pattern = "FP[0-9]{3}_parameterEstimates.txt"
file_list = list.files(file_dir, pattern = file_pattern)

betas = data.frame()

for (file in file_list) {
  temp = tryCatch(read.table(file.path(file_dir,file), fill = TRUE) %>%
                    rename("subjectID" = V1,
                           "roi" = V3,
                           "meanPE" = V4,
                           "sdPE" = V5) %>%
                    extract(V2, "trial", "beta_([0-9]{4}).nii") %>%
                    mutate(trial = as.integer(trial),
                           run = ifelse(trial > 36, "run2", "run1"),
                           trial = ifelse(trial > 36, trial - 42, trial)), error = function(e) message(file))

  betas = rbind(betas, temp)
  rm(temp)
}

# write csv files
write.csv(task, "../../../data/task_data.csv", row.names = FALSE)
write.csv(filter(betas, roi %in% c("pgACC", "vmPFC", "VS")), "../../../data/neuro_data.csv", row.names = FALSE)
