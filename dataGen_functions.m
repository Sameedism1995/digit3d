% this will pass to 'TrainGenerateforFunction.m' file
function [uniformDataStack, uniformLabelStack] = dataGen_functions(dataDirectory, uniformLength)
% Function to generate uniformly sampled data for training purposes.
xData=[];
%% Load Data from Directory
% Retrieve a list of .mat files from the specified directory
xData = dir([dataDirectory + '*.mat']);

%% Initialize Variables for Data Stacking
stackedData = [];
stackedLabels = [];

%% Process and Stack Data
for fileIndex = 1:length(xData)
    fileData = load(dataDirectory + xData(fileIndex).name); % Load file data
    fileNameParts = strsplit(xData(fileIndex).name, '_');  % Split filename to extract label
    digitLabel = str2num(cell2mat(fileNameParts(2))); % Convert label part to numeric
    stackedLabels = [stackedLabels; digitLabel];     % Stack label corresponding to data

    rawData = fileData.pos;                          % Extract data from file
    rawDataSize = size(rawData);                     % Get dimensions of raw data (Nx3)
    resampledData = zeros(uniformLength, rawDataSize(2)); % Placeholder for resampled data
    [resampleP, resampleQ] = rat(uniformLength / rawDataSize(1)); % Calculate resampling ratios

    % Resample data to uniform length
    for dim = 1:3
        resampledData(:, dim) = resample(rawData(:, dim), resampleP, resampleQ);
    end

    stackedData = [stackedData; {resampledData}]; % Add resampled data to the stack
end

%% Return Stacked Data and Labels
uniformDataStack = stackedData;
uniformLabelStack = stackedLabels;
end