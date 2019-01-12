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
rois=(pgACC vmPFC VS pgACC_61 sgACC_164 sgACC_165 vmPFC_64 vmPFC_65 mOFC NAcc putamen)
cons=`echo $(printf "con_%04d.nii\n" {1..6}) $(printf "con_%04d.nii\n" {25..30})`

# paths
con_dir=/projects/dsnlab/shared/FP/nonbids_data/fMRI/fx/models/svc/wave1/event_noderiv_session/sub-"${SUB}" #con directory
roi_dir=/projects/dsnlab/shared/FP/bids_data/derivatives/freesurfer/sub-"${SUB}"/mri/fromannots #roi directory 
output_dir=/projects/dsnlab/shared/FP/FP_scripts/fMRI/RSA/voxelValuesCons #parameter estimate output directory

if [ ! -d ${output_dir} ]; then
	mkdir -p ${output_dir}
fi

# Merge task cons
# ------------------------------------------------------------------------------------------
cd ${con_dir}
fslmerge -t rsa_cons.nii.gz ${cons[@]}

# Extract mean parameter estimates and SDs for each subject, wave, contrast, and roi/parcel
# ------------------------------------------------------------------------------------------
for roi in ${rois[@]}; do 
	3dAllineate -source "${roi_dir}"/"${roi}".nii.gz -master "${con_dir}"/mask.nii -final NN -1Dparam_apply '1D: 12@0'\' -prefix "${roi_dir}"/aligned_"${roi}"
	3dmaskdump -noijk -xyz -mask "${roi_dir}"/aligned_"${roi}"+tlrc "${con_dir}"/rsa_cons.nii.gz >> "${output_dir}"/"${SUB}"_"${roi}"_voxelValues.txt
done

