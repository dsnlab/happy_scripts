
#!/bin/bash
#--------------------------------------------------------------
# This script executes $SHELL_SCRIPT for $SUB and matlab $SCRIPT
#	
# D.Cos 2018.11.06
#--------------------------------------------------------------

# Set your study
STUDY=/projects/dsnlab/shared/FP/FP_scripts

# Set shell script to execute
SHELL_SCRIPT=3dClustSim.sh

# FP the results files
RESULTS_INFIX=3dclustsim

# Set output dir and make it if it doesn't exist
OUTPUTDIR=${STUDY}/fMRI/fx/thresholding/output

if [ ! -d ${OUTPUTDIR} ]; then
	mkdir -p ${OUTPUTDIR}
fi

# Set model dir and specify RX models
MODELDIR=/projects/dsnlab/shared/FP/nonbids_data/fMRI/rx/svc/wave1
MODELS=(event_noderiv illbeing_self_change social_self_change wellbeing_self_change)

# Set job parameters
cpuspertask=1
mempercpu=8G

# Create and execute batch job
for MODEL in ${MODELS[@]}; do
	 	sbatch --export ALL,MODEL=$MODEL,MODELDIR=$MODELDIR,OUTPUTDIR=$OUTPUTDIR \
		 	--job-name=${RESULTS_INFIX} \
		 	-o ${OUTPUTDIR}/${MODEL}_${RESULTS_INFIX}.log \
		 	--cpus-per-task=${cpuspertask} \
		 	--mem-per-cpu=${mempercpu} \
		 	${SHELL_SCRIPT}
	 	sleep .25
done
