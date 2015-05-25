% DEMRATEMAPS7 Do artificial level normalisation.

% Fix seeds
randn('seed', 1e5);
rand('seed', 1e5);

display = 0;

dataSetName = 'ratemaps';
experimentNo = 7;

% load data
[Y, lbls] = gplvmLoadData(dataSetName);
% Select a small subset of the data.
index = randperm(size(Y, 1));
index = index(1:2000);
Y = Y(index, :);

% Set average of each signal to zero.
levels = mean(Y, 2);
for i = 1:size(Y, 2);
  Y(i, :) = Y(i, :) - levels(i);
end

% Set IVM active set size and iteration numbers.
options = gplvmOptions;
% Optimise active set and kernel parameters jointly.
options.gplvmKern = 1;
numActive = 200;

% Fit the GP latent variable model
noiseType = 'gaussian';
selectionCriterion = 'entropy';
kernelType = {'mlp', 'bias', 'white'};
model = gplvmFit(Y, 2, options, kernelType, noiseType, selectionCriterion, numActive, lbls);

% Save the results.
[X, kern, noise, ivmInfo] = gplvmDeconstruct(model);
capName = dataSetName;
capName(1) = upper(capName(1));
save(['dem' capName num2str(experimentNo) '.mat'], 'X', 'kern', 'noise', 'ivmInfo');

demRateMaps7Project
% Load the results and display dynamically.
gplvmResultsDynamic(dataSetName, experimentNo, 'spectrum', 'flipud', ...
                    500);


% Load the results and display statically.
% gplvmResultsStatic(dataSetName, experimentNo, 'vector');

% Load the results and display as scatter plot
% gplvmResultsStatic(dataSetName, experimentNo, 'none')

