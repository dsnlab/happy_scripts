% This script pulls onsets and durations from the subject output files for
% SVC to create FX multicond files for the betaseries analysis
%
% D.Cos 12/2018

%% Load data and intialize variables
inputDir = '~/Dropbox (PfeiBer Lab)/FreshmanProject/Tasks/SVC/output';
runName = {'run1', 'run2'}; % add runs names here
writeDir = '~/Documents/code/dsnlab/FP_scripts/fMRI/fx/multiconds/svc/wave1/betaseries';

% list files in input directory
files = dir(sprintf('%s/FP*/*svc*.mat',inputDir));
filesCell = struct2cell(files);

% extract subject IDs
subjectID = unique(extractBetween(filesCell(1,:), 1,5));

% exclude test responses
subjectID = subjectID(~cellfun(@isempty,regexp(subjectID, 'FP[0-2]{1}[0-9]{2}')));

%% Loop through subjects and runs and save names, onsets, and durations as .mat files
for i = 1:numel(subjectID)
    for a = 1:numel(runName)
        %% Load text file
        sub = subjectID{i};
        run = runName{a};
        subFile = fullfile(inputDir, sub, sprintf('%s_wave_1_svc_%s.mat', sub, run));
        if exist(subFile)
            load(subFile);

            %% Initialize names
            for b = 1:length(task.output.raw)
                names{b} = strcat('trial',num2str(b));
            end
            
            %% Pull onsets for experimental conditions
            % Exclude trials where no response is given
            for b = 1:length(task.output.raw)
                onsets{b} = task.output.raw(b,3);
            end
            
            %% Create durations vector for experimental conditions
            for b = 1:length(task.output.raw)
                durations{b} = task.output.raw(b,4);
            end

            %% Pull names, onsets and durations for instructions
            % Every fifth trial - 4.7s
            names{length(task.output.raw)+1} = 'instructions';
            onsets{length(task.output.raw)+1} = (task.output.raw(1:6:36,3)-4.7);
            durations{length(task.output.raw)+1} = (repelem(4.7, length(1:6:36))');
            
            %% Define output file name
            outputName = sprintf('FP%s_wave1_SVC%s.mat', sub(3:5), run(4));

            %% Save as .mat file and clear
            if ~exist(writeDir); mkdir(writeDir); end

            save(fullfile(writeDir,outputName),'names','onsets','durations');

            clear names onsets durations b c idxs colNum;
        else
            warning(sprintf('Unable to load %s', subFile));
        end
    end
end