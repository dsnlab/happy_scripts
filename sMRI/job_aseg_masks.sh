#!/bin/bash
#
# This scripts converts FreeSurfer aseg labels
# into volumetric masks. Adapted from
# http://brainybehavior.com/neuroimaging/2010/06/saving-individual-labels-from-freesurfers-aseg/
# RLudwig 08/17


echo "job_aseg2masks.sh ran on $(date) $line"

echo -e "\nSetting Up Freesurfer6.0"

source /projects/dsnlab/shared/FP/FP_scripts/sMRI/SetUpFreeSurfer.sh

echo -e "\nSetting up FSL"

#module use /projects/tau/packages/Modules/modulefiles/
module load fsl

templatedir="/projects/dsnlab/shared/FP/FP_scripts/sMRI/templates/"

echo -e "\nFreesurfer Home is $FREESURFER_HOME"
echo -e "\nThe Subject Directory is $SUBJECTS_DIR"
echo -e "\nThe Template Directory is $templatedir"
echo -e "\nThe Freesurfer output Directory is $freesurferdir"
#echo -e "\nThe Binarized ROI masks output Directory is $Maskdir"

cd $SUBJECTS_DIR/$SUBID/mri

#below will convert the aseg.mgz file first into T1 native space, then into a .nii.
#mri_convert -rl $SUBJECTS_DIR/$SUBID/mri/rawavg.mgz -rt nearest $SUBJECTS_DIR/$SUBID/mri/aseg.mgz $SUBJECTS_DIR/$SUBID/mri/fromannots/"$SUBID"_aseg2raw.nii.gz

pushd $templatedir/lists
#edit the below with the numbers matching your ROIs from the FreeSurfer Color Lookup Table (ColorLUT)
asegs=`cat aseg_labels.txt`
echo 1 $asegs
echo 2 ${asegs[@]}

#cd /projects/dsnlab/shared/FP/bids_data/derivatives/mvpa/$SUBID/ses-wave1 && mkdir masks
cd /projects/dsnlab/shared/FP/bids_data/derivatives/mvpa/$SUBID/ses-wave1/masks 

for aseg in $asegs; do
	echo $SUBJECTS_DIR/$SUBID/mri/fromannots/${SUBID}_aseg2raw.nii.gz	
	fslmaths $SUBJECTS_DIR/$SUBID/mri/fromannots/${SUBID}_aseg2raw.nii.gz -uthr "${aseg}" -thr "${aseg}" -bin segment"${aseg}"_freesurfer_rawavg.nii.gz  
done



