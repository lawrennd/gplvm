% DEMRATEMAPS4 Model the face data with a 2-D MLP GPLVM.

% Fix seeds
randn('seed', 1e5);
rand('seed', 1e5);

display = 0;

dataSetName = 'ratemaps';
experimentNo = 4;

% load data
[Y, lbls] = gplvmLoadData(dataSetName);

% Set default gplvm iteration numbers.
options = gplvmOptions;

% Take advantage of temporal structure of data.
options.pointIters = 0;
options.temporalPointIters = 100;
% Optimise the active set with the kernel.
options.gplvmKern = 1;

% Set size of active set.
numActive = 100;

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

% Load the results and display dynamically.
gplvmResultsDynamic(dataSetName, experimentNo, 'spectrum', 'flipud', ...
                    500);

% Load the results and display statically.
% gplvmResultsStatic(dataSetName, experimentNo, 'vector');

% Load the results and display as scatter plot
% gplvmResultsStatic(dataSetName, experimentNo, 'none')

