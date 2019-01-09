%-----------------------------------------------------------------------
% Job saved on 29-Dec-2018 16:53:10 by cfg_util (rev $Rev: 6942 $)
% spm SPM - SPM12 (7219)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------
matlabbatch{1}.spm.util.exp_frames.files = {'/projects/dsnlab/shared/FP/bids_data/derivatives/fmriprep/sub-FP001/ses-wave1/func/s2_sub-FP001_ses-wave1_task-SVC_acq-01_bold_space-T1w_preproc.nii,1'};
matlabbatch{1}.spm.util.exp_frames.frames = Inf;
matlabbatch{2}.spm.util.exp_frames.files = {'/projects/dsnlab/shared/FP/bids_data/derivatives/fmriprep/sub-FP001/ses-wave1/func/s2_sub-FP001_ses-wave1_task-SVC_acq-01_bold_space-T1w_preproc.nii,1'};
matlabbatch{2}.spm.util.exp_frames.frames = Inf;
matlabbatch{3}.cfg_basicio.file_dir.file_ops.cfg_gunzip_files.files = {'/projects/dsnlab/shared/FP/bids_data/derivatives/fmriprep/sub-FP001/ses-wave1/func/sub-FP001_ses-wave1_task-SVC_acq-01_bold_space-T1w_brainmask.nii.gz'};
matlabbatch{3}.cfg_basicio.file_dir.file_ops.cfg_gunzip_files.outdir = {''};
matlabbatch{3}.cfg_basicio.file_dir.file_ops.cfg_gunzip_files.keep = true;
matlabbatch{4}.spm.stats.fmri_spec.dir = {'/projects/dsnlab/shared/FP/nonbids_data/fMRI/fx/models/svc/wave1/event_noderiv_session/sub-FP001'};
matlabbatch{4}.spm.stats.fmri_spec.timing.units = 'secs';
matlabbatch{4}.spm.stats.fmri_spec.timing.RT = 2;
matlabbatch{4}.spm.stats.fmri_spec.timing.fmri_t = 72;
matlabbatch{4}.spm.stats.fmri_spec.timing.fmri_t0 = 36;
matlabbatch{4}.spm.stats.fmri_spec.sess(1).scans(1) = cfg_dep('Expand image frames: Expanded filename list.', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{4}.spm.stats.fmri_spec.sess(1).cond = struct('name', {}, 'onset', {}, 'duration', {}, 'tmod', {}, 'pmod', {}, 'orth', {});
matlabbatch{4}.spm.stats.fmri_spec.sess(1).multi = {'/projects/dsnlab/shared/FP/FP_scripts/fMRI/fx/multiconds/svc/wave1/event/FP001_wave1_SVC1.mat'};
matlabbatch{4}.spm.stats.fmri_spec.sess(1).regress = struct('name', {}, 'val', {});
matlabbatch{4}.spm.stats.fmri_spec.sess(1).multi_reg = {'/projects/dsnlab/shared/FP/FP_scripts/fMRI/fx/motion/auto-motion-fmriprep/rp_txt/rp_FP001_1_SVC_1.txt'};
matlabbatch{4}.spm.stats.fmri_spec.sess(1).hpf = 100;
matlabbatch{4}.spm.stats.fmri_spec.sess(2).scans(1) = cfg_dep('Expand image frames: Expanded filename list.', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{4}.spm.stats.fmri_spec.sess(2).cond = struct('name', {}, 'onset', {}, 'duration', {}, 'tmod', {}, 'pmod', {}, 'orth', {});
matlabbatch{4}.spm.stats.fmri_spec.sess(2).multi = {'/projects/dsnlab/shared/FP/FP_scripts/fMRI/fx/multiconds/svc/wave1/event/FP001_wave1_SVC2.mat'};
matlabbatch{4}.spm.stats.fmri_spec.sess(2).regress = struct('name', {}, 'val', {});
matlabbatch{4}.spm.stats.fmri_spec.sess(2).multi_reg = {'/projects/dsnlab/shared/FP/FP_scripts/fMRI/fx/motion/auto-motion-fmriprep/rp_txt/rp_FP001_1_SVC_2.txt'};
matlabbatch{4}.spm.stats.fmri_spec.sess(2).hpf = 100;
matlabbatch{4}.spm.stats.fmri_spec.fact = struct('name', {}, 'levels', {});
matlabbatch{4}.spm.stats.fmri_spec.bases.hrf.derivs = [0 0];
matlabbatch{4}.spm.stats.fmri_spec.volt = 1;
matlabbatch{4}.spm.stats.fmri_spec.global = 'None';
matlabbatch{4}.spm.stats.fmri_spec.mthresh = -Inf;
matlabbatch{4}.spm.stats.fmri_spec.mask(1) = cfg_dep('Gunzip Files: Gunzipped Files', substruct('.','val', '{}',{3}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('()',{':'}));
matlabbatch{4}.spm.stats.fmri_spec.cvi = 'FAST';
