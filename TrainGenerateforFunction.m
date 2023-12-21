% for smooth run of this file, 'dataGen_functions.m' should be in same directory
% and donot change the code piece of that file

%% Clear Workspace and Figures
clc; % Clear command window
clear all; % Clear workspace variables
close all; % Close all open figures

%% Define Data Directory Path
% Ensure the directory contains .mat files
dataDirectory = "data/digits_3d/training_data/";

%% Set Uniform Sample Length
% Data samples vary in size (Nx3). Uniform sample size is required.
% In this case, we set N = 50, but this can be adjusted.
uniformSampleLength = 50;

%% Generate Training Data
% Provide training .mat files path for uniform data processing
% The generate_data function returns uniformly processed data and labels
[rawTrainingData, rawTrainingLabels] = dataGen_functions(dataDirectory, uniformSampleLength);
distinctLabels = unique(rawTrainingLabels); % Check unique classes in the training set

%% Split Data into Training and Validation Sets
% Split raw data into training and validation sets
[validationData, validationLabels, trainingData, trainingLabels] = DivisionSamplingData(rawTrainingData, rawTrainingLabels);

%% Save Training files
save('trainStackData.mat','trainingData')
save('trainStacklbl.mat','trainingLabels')
save('validateStackData.mat','validationData')
save('validateStackLbl.mat','validationLabels')

%% Run Validation Tests
% Note: Validation accuracy may vary on each run due to different feature sets in samples.
load('validateStackData.mat') % load files
load('validateStackLbl.mat')% load files
predictedLabels = []; % Initialize array for storing predicted labels
correctPredictions = 0; % Counter for correct predictions

% Perform classification on validation samples and compare with true labels
for i = 1:length(validationLabels)
    classification = digit_classify(cell2mat(validationData(i)));
    predictedLabels = [predictedLabels; classification];
    if classification == validationLabels(i)
       correctPredictions = correctPredictions + 1; 
    end
end

%% Calculate and display the accuracy of the classification
accuracyPercentage = (correctPredictions / length(validationLabels)) * 100;
disp("So the Accuracy is  = " + num2str(accuracyPercentage) + "%");