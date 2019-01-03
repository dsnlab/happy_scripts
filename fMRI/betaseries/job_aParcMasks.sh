#!/bin/bash

# freesurfer parcellations
# NAcc: 26 / 58
# Putamen: 12 / 51

# HCP parcellations
# pgACC	61	L_a24_ROI
# sgACC	164	L_25_ROI
# sgACC	165	L_s32_ROI
# vmPFC	64	L_p32_ROI
# vmPFC	65	L_10r_ROI
# mOFC	88	L_10v_ROI

## define paths
fromannotsDir=/projects/dsnlab/shared/FP/bids_data/derivatives/freesurfer/$SUB/mri/fromannots/

## load FSL
module load fsl

# cd into directory with the default mask files
cd ${fromannotsDir}

echo -e "\nFromAnnots folder is in $fromannotsDir"

echo -------------------------------------------------------------------------------
echo "$SUB"
echo -------------------------------------------------------------------------------


## create masks
echo "Creating masks"

echo "pg/sgACC mask"
fslmaths lh.L_a24_ROI.nii.gz -add rh.L_a24_ROI.nii.gz -add lh.L_25_ROI.nii.gz -add rh.L_25_ROI.nii.gz -add lh.L_s32_ROI.nii.gz -add rh.L_s32_ROI.nii.gz pgACC.nii.gz
gunzip pgACC.nii.gz

echo "vmPFC mask"
fslmaths lh.L_p32_ROI.nii.gz -add rh.L_p32_ROI.nii.gz -add lh.L_10r_ROI.nii.gz -add rh.L_10r_ROI.nii.gz -add lh.L_10v_ROI.nii.gz -add rh.L_10v_ROI.nii.gz vmPFC.nii.gz
gunzip vmPFC.nii.gz

echo "VS mask"
fslmaths segment26_freesurfer_rawavg -add segment58_freesurfer_rawavg -add segment12_freesurfer_rawavg -add segment51_freesurfer_rawavg VS.nii.gz
gunzip VS.nii.gz

echo "NAcc mask"
fslmaths segment26_freesurfer_rawavg -add segment58_freesurfer_rawavg NAcc.nii.gz
gunzip NAcc.nii.gz

echo "putamen mask"
fslmaths segment12_freesurfer_rawavg -add segment51_freesurfer_rawavg putamen.nii.gz
gunzip putamen.nii.gz

# remove .gz files
rm *.gz