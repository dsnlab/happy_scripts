#!/bin/bash

# This script extracts mean parameter estimates and SDs within an map or parcel
# from subject images (e.g. FX condition contrasts). Output is 
# saved as a text file in the output directory.

module load afni

echo -------------------------------------------------------------------------------
echo "${SUB}"
echo "Running ${SCRIPT}"
date
echo -------------------------------------------------------------------------------


# Set paths and variables
# ------------------------------------------------------------------------------------------
# variables
rx_models=(event_noderiv illbeing_self_change social_self_change wellbeing_self_change) #RX model names
maps=(con_0001 spmT_0001) #RX maps (without file format, specified below as .nii)
images=`echo $(printf "con_%04d.nii\n" {1..3}) $(printf "con_%04d.nii\n" {13..15})` #participant images to multiply with RX maps

# paths
image_dir=/projects/dsnlab/shared/FP/nonbids_data/fMRI/fx/models/svc/wave1/event_noderiv/sub-"${SUB}" #fx directory
map_dir=/projects/dsnlab/shared/FP/nonbids_data/fMRI/rx/svc/wave1 #expression map directory (e.g. RX dir)
output_dir=/projects/dsnlab/shared/FP/FP_scripts/fMRI/multivariate/expression_maps/dotProducts #parameter estimate output directory

if [ ! -d ${output_dir} ]; then
	mkdir -p ${output_dir}
fi

# Align images and calculate dot products for each contrast and model map
# ------------------------------------------------------------------------------------------
for model in ${rx_models[@]}; do
	for map in ${maps[@]}; do 
		3dAllineate -source "${map_dir}"/"${model}"/"${map}".nii -master "${image_dir}"/mask.nii -final NN -1Dparam_apply '1D: 12@0'\' -prefix "${map_dir}"/"${model}"/aligned_"${map}"
		for image in ${images[@]}; do 
		echo "${SUB}" "${image}" "${model}" "${map}" `3ddot -dodot "${map_dir}"/"${model}"/aligned_"${map}"+tlrc "${image_dir}"/"${image}"` >> "${output_dir}"/"${SUB}"_dotProducts.txt
		done
	done
done
