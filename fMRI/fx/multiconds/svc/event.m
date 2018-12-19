% This script pulls onsets and durations from the subject output files for
% SVC to create FX multicond files
%
% D.Cos 10/2018

%% Load data and intialize variables
inputDir = '~/Dropbox (PfeiBer Lab)/FreshmanProject/Tasks/SVC/output';
runName = {'run1', 'run2'}; % add runs names here
writeDir = '~/Documents/code/dsnlab/FP_scripts/fMRI/fx/multiconds/svc/wave1/event';

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
            names = {'selfWellbeing', 'selfIllbeing', 'selfSocial', 'changeWellbeing', 'changeIllbeing', 'changeSocial', 'instructions'}; % condition names

            %% Pull onsets for experimental conditions
            % Exclude trials where no response is given
            for b = 1:length(names)
                idxs = find(task.output.raw(:,2) == b & ~isnan(task.output.raw(:,4)));
                onsets(b)={task.output.raw(idxs,3)};
            end
            
            %% Create durations vector for experimental conditions
            for c = 1:length(names)
                idxs = find(task.output.raw(:,2) == c & ~isnan(task.output.raw(:,4)));
                durations(c)={task.output.raw(idxs,4)};
            end

            %% Pull onsets and durations for instructions
            % Every fifth trial - 4.7s
            onsets(7)={task.output.raw(1:6:36,3)-4.7};
            durations(7) = {repelem(4.7, length(1:6:36))};
            
            %% Pull onsets and durations for missed responses (if any)
            colNum = length(names) + 1;

            if(sum(isnan(task.output.raw(:,4))) > 0)
                names{colNum} = 'noResponse';
                idxs = find(isnan(task.output.raw(:,4)));
                onsets(colNum) = {task.output.raw(idxs,3)};
                durations(colNum) = {repelem(4.7, length(idxs))};
            end 
            
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