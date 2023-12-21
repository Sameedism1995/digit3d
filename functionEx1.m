%% Clear Workspace and Figures
clc; % Clear command window
close all; % Close all open figures
clear all; % Clear workspace variables

%% Load Test Data
% Directory path must contain .mat files
dataDirectory = "data/digits_3d/training_data/";

locationdata = dir(dataDirectory + "*.mat"); % Load .mat files from the directory
testdata = 2; % Index of the test sample. This can be modified as needed and we can pass to calssify function
testdata = load([dataDirectory + string(locationdata(testdata).name)]); % Load a single file as a test sample
testdata = testdata.pos; % Extract the Nx3 array from the loaded data
testdata = awgn(testdata, 3); % Add noise to the data for uniqueness

%% Visualize Test Data in 3D
plot3(testdata(:,1), testdata(:,2), testdata(:,3), '-*'); % 3D plot of test sample

%% Classify Test Data
% Call digit_classify function to classify the test sample
%as said in moodle task description
C = digit_classify(testdata)
