#!/bin/bash
#--------------------------------------------------------------
# This script executes $SHELL_SCRIPT for $SUB
#	
# D.Cos 2018.11.06
#--------------------------------------------------------------

# Set your study
STUDY=/projects/sanlab/shared/study/study_scripts

# Set subject list
SUBJLIST=`cat subject_list.txt`

# Set shell script to execute
SHELL_SCRIPT=extract_parameterEstimates.sh

# study the results files
RESULTS_INFIX=extract

# Set output dir and make it if it doesn't exist
OUTPUTDIR=${STUDY}/fMRI/betaseries/output

if [ ! -d ${OUTPUTDIR} ]; then
	mkdir -p ${OUTPUTDIR}
fi

# Set job parameters
cpuspertask=1
mempercpu=8G

# Create and execute batch job
for SUB in $SUBJLIST; do
	 	sbatch --export ALL,SUB=$SUB,  \
		 	--job-name=${RESULTS_INFIX} \
		 	-o ${OUTPUTDIR}/${SUB}_${RESULTS_INFIX}.log \
		 	--cpus-per-task=${cpuspertask} \
		 	--mem-per-cpu=${mempercpu} \
		 	${SHELL_SCRIPT}
	 	sleep .25
done
