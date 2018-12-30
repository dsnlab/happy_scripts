%-----------------------------------------------------------------------
% Job saved on 29-Dec-2018 16:53:10 by cfg_util (rev $Rev: 6942 $)
% spm SPM - SPM12 (7219)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------
matlabbatch{1}.spm.util.exp_frames.files = {'/projects/dsnlab/shared/FP/bids_data/derivatives/fmriprep/sub-FP001/ses-wave1/func/s6_sub-FP001_ses-wave1_task-SVC_acq-01_bold_space-MNI152NLin2009cAsym_preproc.nii,1'};
matlabbatch{1}.spm.util.exp_frames.frames = Inf;
matlabbatch{2}.spm.util.exp_frames.files = {'/projects/dsnlab/shared/FP/bids_data/derivatives/fmriprep/sub-FP001/ses-wave1/func/s6_sub-FP001_ses-wave1_task-SVC_acq-02_bold_space-MNI152NLin2009cAsym_preproc.nii,1'};
matlabbatch{2}.spm.util.exp_frames.frames = Inf;
matlabbatch{3}.spm.stats.fmri_spec.dir = {'/projects/dsnlab/shared/FP/nonbids_data/fMRI/fx/models/svc/wave1/event_noderiv/sub-FP001'};
matlabbatch{3}.spm.stats.fmri_spec.timing.units = 'secs';
matlabbatch{3}.spm.stats.fmri_spec.timing.RT = 2;
matlabbatch{3}.spm.stats.fmri_spec.timing.fmri_t = 72;
matlabbatch{3}.spm.stats.fmri_spec.timing.fmri_t0 = 36;
matlabbatch{3}.spm.stats.fmri_spec.sess(1).scans(1) = cfg_dep('Expand image frames: Expanded filename list.', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{3}.spm.stats.fmri_spec.sess(1).cond = struct('name', {}, 'onset', {}, 'duration', {}, 'tmod', {}, 'pmod', {}, 'orth', {});
matlabbatch{3}.spm.stats.fmri_spec.sess(1).multi = {'/projects/dsnlab/shared/FP/FP_scripts/fMRI/fx/multiconds/svc/wave1/event/FP001_wave1_SVC1.mat'};
matlabbatch{3}.spm.stats.fmri_spec.sess(1).regress = struct('name', {}, 'val', {});
matlabbatch{3}.spm.stats.fmri_spec.sess(1).multi_reg = {'/projects/dsnlab/shared/FP/FP_scripts/fMRI/fx/motion/auto-motion-fmriprep/rp_txt/rp_FP001_1_SVC_1.txt'};
matlabbatch{3}.spm.stats.fmri_spec.sess(1).hpf = 100;
matlabbatch{3}.spm.stats.fmri_spec.sess(2).scans(1) = cfg_dep('Expand image frames: Expanded filename list.', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{3}.spm.stats.fmri_spec.sess(2).cond = struct('name', {}, 'onset', {}, 'duration', {}, 'tmod', {}, 'pmod', {}, 'orth', {});
matlabbatch{3}.spm.stats.fmri_spec.sess(2).multi = {'/projects/dsnlab/shared/FP/FP_scripts/fMRI/fx/multiconds/svc/wave1/event/FP001_wave1_SVC2.mat'};
matlabbatch{3}.spm.stats.fmri_spec.sess(2).regress = struct('name', {}, 'val', {});
matlabbatch{3}.spm.stats.fmri_spec.sess(2).multi_reg = {'/projects/dsnlab/shared/FP/FP_scripts/fMRI/fx/motion/auto-motion-fmriprep/rp_txt/rp_FP001_1_SVC_2.txt'};
matlabbatch{3}.spm.stats.fmri_spec.sess(2).hpf = 100;
matlabbatch{3}.spm.stats.fmri_spec.fact = struct('name', {}, 'levels', {});
matlabbatch{3}.spm.stats.fmri_spec.bases.hrf.derivs = [0 0];
matlabbatch{3}.spm.stats.fmri_spec.volt = 1;
matlabbatch{3}.spm.stats.fmri_spec.global = 'None';
matlabbatch{3}.spm.stats.fmri_spec.mthresh = -Inf;
matlabbatch{3}.spm.stats.fmri_spec.mask = {'/projects/dsnlab/shared/SPM12/canonical/MNI152lin_T1_2mm_brain_mask.nii,1'};
matlabbatch{3}.spm.stats.fmri_spec.cvi = 'FAST';
