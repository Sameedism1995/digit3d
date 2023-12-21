%% Clear Workspace and Figures
clc; % Clear command window
clear all; % Clear workspace variables
close all; % Close all open figures

%% Load Test Data File
% Specify path to a test data file
testFilePath = "data/digits_3d/training_data/stroke_6_0069.mat"; % Path to a sample test file

% Load the test data from the specified file
testData = load(testFilePath); % Load file data
testdata = testData.pos; % Extract position data from the file

%% Visualize Test Data
% Plot the test data in 3D space
plot3(testdata(:,1), testdata(:,2), testdata(:,3), '^-'); % 3D plot of test sample

%% Classify Test Data
% Use the digit_classify function to classify the test data
C = digit_classify(testdata);
%as said in moodle task description
%here only the mat file is differently used for test