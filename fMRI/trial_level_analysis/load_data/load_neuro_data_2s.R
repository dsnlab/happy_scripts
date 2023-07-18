# This script merges the task and beta series data, and tidies it

# load packages
library(tidyverse)

# load parameter estimates
file_dir = "~/Documents/code/dsnlab/FP_scripts/fMRI/betaseries/svc/wave1/parameterEstimates_2s/"
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
write.csv(filter(betas, roi %in% c("pgACC", "vmPFC", "VS")), "../../../data/neuro_data_2s.csv", row.names = FALSE)
