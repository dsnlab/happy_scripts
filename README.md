# happy-scripts
This repository contains code for the analyses reported in the following manuscript:

[Cosme, D., Mobasser, A., & J. H. Pfeifer. If you’re happy and you know it: Neural correlates of self-evaluated psychological health and well-being](https://psyarxiv.com/86n3b/)


## Compiled analysis files

Trial-level analyses are reported [here](https://dsnlab.github.io/happy_scripts/fMRI/betaseries/trial_level_analysis)

## Directory structure

* `behavioral` = R code to run the factor analysis used to generate the stimuli
* `betaseries` = R code and supporting files to run the trial-level analyses
* `fx` = code used to estimate first-level fMRI models
* `ppc` = code used to preprocess the MRI data using fMRIPrep and smooth the fMRI data
* `roi` = code used to create the ROIs
* `RSA` = R code and supporting files to run the representational similarity analyses
* `rx` = code used to estimate group-level fMRI models

```
├── behavioral
├── fMRI
│	├── betaseries
│	├── fx
│	│	├── mergebetas
│	│	├── models
│	│	├── motion
│	│	├── multiconds
│	│	└── thresholding
│	├── ppc
│	│	└── smooth
│	├── roi
│	├── RSA
│	└── rx
├── org
│	└── bidsQC
└── sMRI
    └── templates
```
