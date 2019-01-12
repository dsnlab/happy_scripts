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
maps=(con_0001 spmT_0001) #map masks (without file format, specified below as .nii)
images=`echo $(printf "con_%04d.nii\n" {1..3}) $(printf "con_%04d.nii\n" {13..15})` #images to extract parameter estimates from (alt. example: images=`echo $(printf "beta_%04d.nii\n" {1..36}) $(printf "beta_%04d.nii\n" {43..78})`)

# paths
image_dir=/projects/dsnlab/shared/FP/nonbids_data/fMRI/fx/models/svc/wave1/event_noderiv/sub-"${SUB}" #fx directory
map_dir=/projects/dsnlab/shared/FP/nonbids_data/fMRI/rx/svc/wave1/event_noderiv #expression map directory (e.g. RX dir)
output_dir=/projects/dsnlab/shared/FP/FP_scripts/fMRI/multivariate/expression_maps/dotProducts #parameter estimate output directory

if [ ! -d ${output_dir} ]; then
	mkdir -p ${output_dir}
fi

# Align images and extract mean parameter estimates and SDs for each contrast and map/parcel
# ------------------------------------------------------------------------------------------
for map in ${maps[@]}; do 
	3dAllineate -source "${map_dir}"/"${map}".nii.gz -master "${image_dir}"/mask.nii -final NN -1Dparam_apply '1D: 12@0'\' -prefix "${map_dir}"/aligned_"${map}"
	for image in ${images[@]}; do 
	echo "${SUB}" "${image}" "${map}" `3ddot -dodot "${map_dir}"/aligned_"${map}"+tlrc "${image_dir}"/"${image}"` >> "${output_dir}"/"${SUB}"_dotProducts.txt
	done
done

