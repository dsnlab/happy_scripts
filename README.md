This repository contains code for the analyses reported in the following manuscript:

[Cosme, D., Mobasser, A., & J. H. Pfeifer. If you’re happy and you know it: Neural correlates of self-evaluated psychological health and well-being](https://psyarxiv.com/86n3b/)


## Compiled analysis files

Trial-level analyses from the main manuscript are reported [here](https://dsnlab.github.io/happy_scripts/fMRI/trial_level_analysis/trial_level_analysis)

Supplementary analyses:
* [Individual difference analyses](https://dsnlab.github.io/happy_scripts/fMRI/individual_diffs_analysis/individual_diffs_analysis)
* [Trial-level analyses using a 2s event duration](https://dsnlab.github.io/happy_scripts/fMRI/trial_level_analysis/trial_level_analysis_2s)
* [Trial-level analyses using valence](https://dsnlab.github.io/happy_scripts/fMRI/trial_level_analysis/trial_level_analysis_valence)
* [Trial-level analyses modeling instruction](https://dsnlab.github.io/happy_scripts/fMRI/trial_level_analysis/trial_level_analysis_change)

## Directory structure

* `behavioral` = R code to run the factor analysis used to generate the stimuli
* `data` = task and brain data files
* `fx` = code used to estimate first-level fMRI models
* `individual_diffs_analyses` = R code and supporting files to run the individual difference analyses
* `ppc` = code used to preprocess the MRI data using fMRIPrep and smooth the fMRI data
* `roi` = code used to create the ROIs
* `RSA` = R code and supporting files to run the representational similarity analyses
* `rx` = code used to estimate group-level fMRI models
* `trial_level_analyses` = R code and supporting files to run the trial-level analyses

```
├── behavioral
├── data
├── fMRI
│	├── betaseries
│	├── fx
│	│	├── mergebetas
│	│	├── models
│	│	├── motion
│	│	├── multiconds
│	│	└── thresholding
│   ├── individual_diffs_analysis
│	├── ppc
│	│	└── smooth
│	├── roi
│	├── RSA
│   ├── rx
│   └── trial_level_analysis
├── org
│	└── bidsQC
└── sMRI
    └── templates
```
