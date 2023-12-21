%we have declared this function in main train generator for the function file
function [validationData, validationrawTrainingLabels, trainingData, trainingrawTrainingLabels] = DivisionSamplingData(trainingData, trainingrawTrainingLabels);

% This function sorts the data into two groups: one for training and one for validation.

% Let's identify all the different digits we're working with.
distinctrawTrainingLabels = unique(trainingrawTrainingLabels);

% We'll set up some empty variables to hold our two groups of data.
validationGroup = [];
validationGrouprawTrainingLabels = [];
trainingGroup = [];
trainingGrouprawTrainingLabels = [];

% Now, we'll go through each type of digit.
for labelIndex = 1:length(distinctrawTrainingLabels)
    % Let's grab all the samples that match this digit.
    [currentrawTrainingLabelsamples, ~] = find(trainingrawTrainingLabels == distinctrawTrainingLabels(labelIndex));
    
    % We're going to pick a few of these samples at random to test our model later.
    testSubset = unique(randi([min(currentrawTrainingLabelsamples), max(currentrawTrainingLabelsamples)], [1, floor(length(currentrawTrainingLabelsamples) * 0.15)]));
    
    % These picked samples go into the validation arrays.
    validationGroup = [validationGroup; trainingData(testSubset)];
    validationGrouprawTrainingLabels = [validationGrouprawTrainingLabels; trainingrawTrainingLabels(testSubset)];
    
    % The rest will be used to teach our model.
    trainingSubset = setdiff(currentrawTrainingLabelsamples, testSubset);
    trainingGroup = [trainingGroup; trainingData(trainingSubset)];
    trainingGrouprawTrainingLabels = [trainingGrouprawTrainingLabels; trainingrawTrainingLabels(trainingSubset)];
end

% Time to hand over what we've sorted!
validationData = validationGroup;
validationrawTrainingLabels = validationGrouprawTrainingLabels;
trainingData = trainingGroup;
trainingrawTrainingLabels = trainingGrouprawTrainingLabels;
end
