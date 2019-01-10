#!/bin/bash
#SBATCH --job-name=rois
#SBATCH --output=rois.log
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=8G

# This script creates binarized ROIs from parcellations

# freesurfer parcellations
# NAcc: 26 / 58
# Putamen: 12 / 51

# HCP parcellations
# pgACC	61
# sgACC	164
# sgACC	165
# vmPFC	64
# vmPFC	65
# mOFC	88

## define paths
roiDir=/projects/dsnlab/shared/FP/nonbids_data/fMRI/roi

## load FSL
module load fsl

# cd into directory with the default mask files
cd ${roiDir}

echo -e "\nFromAnnots folder is in $roiDir"

## create masks
echo "Creating masks"

echo "pgACC_61 mask"
fslmaths HCPMMP1_on_MNI152_ICBM2009a_nlin_hd.nii.gz -thr 61 -uthr 61 -bin pgACC_61.nii.gz

echo "sgACC_164 mask"
fslmaths HCPMMP1_on_MNI152_ICBM2009a_nlin_hd.nii.gz -thr 164 -uthr 164 -bin sgACC_164.nii.gz

echo "sgACC_165 mask"
fslmaths HCPMMP1_on_MNI152_ICBM2009a_nlin_hd.nii.gz -thr 165 -uthr 165 -bin sgACC_165.nii.gz

echo "vmPFC_64 mask"
fslmaths HCPMMP1_on_MNI152_ICBM2009a_nlin_hd.nii.gz -thr 64 -uthr 64 -bin vmPFC_64.nii.gz

echo "vmPFC_65 mask"
fslmaths HCPMMP1_on_MNI152_ICBM2009a_nlin_hd.nii.gz -thr 65 -uthr 65 -bin vmPFC_65.nii.gz

echo "mOFC mask"
fslmaths HCPMMP1_on_MNI152_ICBM2009a_nlin_hd.nii.gz -thr 88 -uthr 88 -bin mOFC.nii.gz

echo "NAcc mask"
fslmaths aseg.nii -thr 26 -uthr 26 r_NAcc.nii.gz
fslmaths aseg.nii -thr 58 -uthr 58 l_NAcc.nii.gz
fslmaths r_NAcc.nii.gz -add l_NAcc.nii.gz -bin NAcc.nii.gz

echo "putamen mask"
fslmaths aseg.nii -thr 12 -uthr 12 r_putamen.nii.gz
fslmaths aseg.nii -thr 51 -uthr 51 l_putamen.nii.gz
fslmaths r_putamen.nii.gz -add l_putamen.nii.gz -bin putamen.nii.gz

echo "pg/sgACC mask"
fslmaths pgACC_61.nii.gz -add sgACC_164.nii.gz -add sgACC_165.nii.gz -bin pgACC.nii.gz

echo "vmPFC mask"
fslmaths vmPFC_64.nii.gz -add vmPFC_65.nii.gz -add mOFC.nii.gz -bin vmPFC.nii.gz

echo "VS mask"
fslmaths NAcc.nii.gz -add putamen.nii.gz -bin VS.nii.gz

## remove right and left hemisphere rois
rm r_*.nii.gz
rm l_*.nii.gz
