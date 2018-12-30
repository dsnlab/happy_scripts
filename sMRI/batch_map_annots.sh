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
STUDY=/projects/dsnlab/shared/FP

# Set subject list
#SUBJLIST=`cat subject_list.txt`
SUBJLIST=`cat subject_list_test.txt`

# 
for SUBJ in $SUBJLIST
do
sbatch --export ALL,SUBID=${SUBJ} --job-name mapANNOTs --partition=short --mem-per-cpu=1G --cpus-per-task=1 -o "${STUDY}"/FP_scripts/sMRI/output/"${SUBJ}"_mapANNOTs_output.txt -e "${STUDY}"/FP_scripts/sMRI/output/"${SUBJ}"_mapANNOTs_error.txt job_map_annots.sh
done

