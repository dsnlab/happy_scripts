#!/bin/bash
#
# This batch file calls on your subject
# list (named subject_list.txt). And 
# runs the job_SUMA.sh file for 
# each subject. It saves the ouput
# and error files in their specified
# directories.
#
# Set your study
STUDY=/projects/dsnlab/FP

# Set subject list
SUBJLIST=`cat subject_list.txt`

# 
for SUBJ in $SUBJLIST
do
 sbatch --export SUBID=${SUBJ} --job-name SUMAprep --partition=long --mem-per-cpu=2G --cpus-per-task=1 -o "${STUDY}"/FP_scripts/sMRI/output/"${SUBJ}"_SUMAprep_output.txt -e "${STUDY}"/FP_scripts/sMRI/output/"${SUBJ}"_SUMAprep_error.txt job_SUMA.sh
done

