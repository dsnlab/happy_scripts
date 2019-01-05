#!/bin/bash

# This script extracts voxe values within an ROI or parcel for every timepoint specified.
# Output is saved as a text file in the output directory.

module load afni
module load fsl

echo -------------------------------------------------------------------------------
echo "${SUB}"
echo "Running ${SCRIPT}"
date
echo -------------------------------------------------------------------------------


# Set paths and variables
# ------------------------------------------------------------------------------------------
# variables
rois=(pgACC vmPFC VS NAcc putamen)
#betas=`cat /projects/dsnlab/shared/FP/FP_scripts/fMRI/fx/mergebetas/subject_beta_info/self_"${SUB}".txt` #beta list to extract from
betas=`echo $(printf "beta_%04d.nii\n" {1..36}) $(printf "beta_%04d.nii\n" {43..78})`

# paths
beta_dir=/projects/dsnlab/shared/FP/nonbids_data/fMRI/fx/models/svc/wave1/betaseries/sub-"${SUB}" #beta directory
roi_dir=/projects/dsnlab/shared/FP/bids_data/derivatives/freesurfer/sub-"${SUB}"/mri/fromannots #roi directory 
output_dir=/projects/dsnlab/shared/FP/FP_scripts/fMRI/RSA/voxelValues #parameter estimate output directory

if [ ! -d ${output_dir} ]; then
	mkdir -p ${output_dir}
fi

# Merge task betas
# ------------------------------------------------------------------------------------------
cd ${beta_dir}
fslmerge -t task_betas.nii.gz ${betas[@]}

# Extract mean parameter estimates and SDs for each subject, wave, contrast, and roi/parcel
# ------------------------------------------------------------------------------------------
for roi in ${rois[@]}; do 
	3dAllineate -source "${roi_dir}"/"${roi}".nii.gz -master "${beta_dir}"/mask.nii -final NN -1Dparam_apply '1D: 12@0'\' -prefix "${roi_dir}"/aligned_"${roi}"
	3dmaskdump -noijk -xyz -mask "${roi_dir}"/aligned_"${roi}"+tlrc "${beta_dir}"/task_betas.nii.gz >> "${output_dir}"/"${SUB}"_"${roi}"_voxelValues.txt
done

