%-----------------------------------------------------------------------
% Job saved on 08-Jan-2019 21:20:35 by cfg_util (rev $Rev: 6942 $)
% spm SPM - SPM12 (7219)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------
matlabbatch{1}.spm.stats.fmri_est.spmmat = {'/projects/dsnlab/shared/FP/nonbids_data/fMRI/fx/models/svc/wave1/event_noderiv_session/sub-FP001/SPM.mat'};
matlabbatch{1}.spm.stats.fmri_est.write_residuals = 0;
matlabbatch{1}.spm.stats.fmri_est.method.Classical = 1;
matlabbatch{2}.spm.stats.con.spmmat(1) = cfg_dep('Model estimation: SPM.mat File', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
matlabbatch{2}.spm.stats.con.consess{1}.tcon.name = 'Self Wellbeing > Rest';
matlabbatch{2}.spm.stats.con.consess{1}.tcon.weights = [1 0 0 0 0 0];
matlabbatch{2}.spm.stats.con.consess{1}.tcon.sessrep = 'sess';
matlabbatch{2}.spm.stats.con.consess{2}.tcon.name = 'Self Social > Rest';
matlabbatch{2}.spm.stats.con.consess{2}.tcon.weights = [0 1 0 0 0 0];
matlabbatch{2}.spm.stats.con.consess{2}.tcon.sessrep = 'sess';
matlabbatch{2}.spm.stats.con.consess{3}.tcon.name = 'Self Illbeing > Rest';
matlabbatch{2}.spm.stats.con.consess{3}.tcon.weights = [0 0 1 0 0 0];
matlabbatch{2}.spm.stats.con.consess{3}.tcon.sessrep = 'sess';
matlabbatch{2}.spm.stats.con.consess{4}.tcon.name = 'Change Wellbeing > Rest';
matlabbatch{2}.spm.stats.con.consess{4}.tcon.weights = [0 0 0 1 0 0];
matlabbatch{2}.spm.stats.con.consess{4}.tcon.sessrep = 'sess';
matlabbatch{2}.spm.stats.con.consess{5}.tcon.name = 'Change Social > Rest';
matlabbatch{2}.spm.stats.con.consess{5}.tcon.weights = [0 0 0 0 1 0];
matlabbatch{2}.spm.stats.con.consess{5}.tcon.sessrep = 'sess';
matlabbatch{2}.spm.stats.con.consess{6}.tcon.name = 'Change Illbeing > Rest';
matlabbatch{2}.spm.stats.con.consess{6}.tcon.weights = [0 0 0 0 0 1];
matlabbatch{2}.spm.stats.con.consess{6}.tcon.sessrep = 'sess';
matlabbatch{2}.spm.stats.con.consess{7}.tcon.name = 'Instructions > Rest';
matlabbatch{2}.spm.stats.con.consess{7}.tcon.weights = [0 0 0 0 0 0 1];
matlabbatch{2}.spm.stats.con.consess{7}.tcon.sessrep = 'sess';
matlabbatch{2}.spm.stats.con.consess{8}.tcon.name = 'Self > Rest';
matlabbatch{2}.spm.stats.con.consess{8}.tcon.weights = [0.3333 0.3333 0.3333 0 0 0];
matlabbatch{2}.spm.stats.con.consess{8}.tcon.sessrep = 'sess';
matlabbatch{2}.spm.stats.con.consess{9}.tcon.name = 'Change > Rest';
matlabbatch{2}.spm.stats.con.consess{9}.tcon.weights = [0 0 0 0.3333 0.3333 0.3333];
matlabbatch{2}.spm.stats.con.consess{9}.tcon.sessrep = 'sess';
matlabbatch{2}.spm.stats.con.consess{10}.tcon.name = 'Self > Instructions';
matlabbatch{2}.spm.stats.con.consess{10}.tcon.weights = [0.3333 0.3333 0.3333 0 0 0 -1];
matlabbatch{2}.spm.stats.con.consess{10}.tcon.sessrep = 'sess';
matlabbatch{2}.spm.stats.con.consess{11}.tcon.name = 'Change > Instructions';
matlabbatch{2}.spm.stats.con.consess{11}.tcon.weights = [0 0 0 0.3333 0.3333 0.3333 -1];
matlabbatch{2}.spm.stats.con.consess{11}.tcon.sessrep = 'sess';
matlabbatch{2}.spm.stats.con.consess{12}.tcon.name = 'Self > Change';
matlabbatch{2}.spm.stats.con.consess{12}.tcon.weights = [0.3333 0.3333 0.3333 -0.3333 -0.3333 -0.3333];
matlabbatch{2}.spm.stats.con.consess{12}.tcon.sessrep = 'sess';
matlabbatch{2}.spm.stats.con.consess{13}.tcon.name = 'Self Wellbeing > Change Wellbeing';
matlabbatch{2}.spm.stats.con.consess{13}.tcon.weights = [1 0 0 -1 0 0];
matlabbatch{2}.spm.stats.con.consess{13}.tcon.sessrep = 'sess';
matlabbatch{2}.spm.stats.con.consess{14}.tcon.name = 'Self Social > Change Social';
matlabbatch{2}.spm.stats.con.consess{14}.tcon.weights = [0 1 0 0 -1 0];
matlabbatch{2}.spm.stats.con.consess{14}.tcon.sessrep = 'sess';
matlabbatch{2}.spm.stats.con.consess{15}.tcon.name = 'Self Illbeing > Change Illbeing';
matlabbatch{2}.spm.stats.con.consess{15}.tcon.weights = [0 0 1 0 0 -1];
matlabbatch{2}.spm.stats.con.consess{15}.tcon.sessrep = 'sess';
matlabbatch{2}.spm.stats.con.delete = 0;
