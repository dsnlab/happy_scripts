#!/bin/bash
#
# This script uses fsl's fslmerge function
# to concatenante all the volumes from the
# participant's resting state scan.


module load fsl

echo "Running ${SUB}"

# Set path and cd into it
SUBDIR=/projects/dsnlab/shared/FP/nonbids_data/fMRI/fx/models/svc/wave1/betaseries/sub-"${SUB}"
cd $SUBDIR

# Merge betas
echo "Merging betas"
BETAS=`cat /projects/dsnlab/shared/FP/FP_scripts/fMRI/fx/mergebetas/subject_beta_info/self_${SUB}.txt`

fslmerge -t self_betas.nii.gz ${BETAS[@]}
echo "Gunzipping betas"
gunzip self_betas.nii.gz
