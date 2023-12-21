%as first we did using testsample for all the files, but later on realised
 %about the mandotary of 'testdata' to use in the function said in moodle
 %description file

function C = digit_classify(testdata)
%% Load Training Data and Labels
if exist('trainStackData.mat') && exist('trainStacklbl.mat') % Verify existence of training files
    
    load('trainStackData'); % Load training data
    load('trainStacklbl'); % Load training labels
else
    disp('No Train Label and Stack .mat files found!')
    return % Exit if training files are not found
end

%% Preprocess Test Data
inputSize = size(testdata); % Dimensions of input data
trainingSampleLength = size(cell2mat(trainingData(1)), 1); % Length of training samples for consistency
resampledData = zeros(trainingSampleLength, inputSize(2)); % Placeholder for resampled test data
[resampleP, resampleQ] = rat(trainingSampleLength / inputSize(1)); % Ratios for resampling

% Resample input test data here
for dim = 1:3
    resampledData(:, dim) = resample(testdata(:, dim), resampleP, resampleQ);
end

%% Initialize Prediction Process
closestDistance = [];
for i = 1:length(trainingData) % Iterate over training samples for K-NN using Mean of Eucledean Distance (L2 Norm)
    distance = mean(sqrt(sum((cell2mat(trainingData(i)) - resampledData).^2, 2))); % Euclidean distance
    closestDistance = [closestDistance; distance];
end

[minDistance, minIndex] = min(closestDistance); % Find minimum distance and index
predictedLabelIndex = trainingLabels(minIndex); % Corresponding label for minimum distance

%% Return Predicted Label
C = predictedLabelIndex;
end

