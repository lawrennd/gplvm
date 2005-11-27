% DEMBRENDAN2 Model the face data with a 1-D RBF GPLVM.

% GPLVM

% Fix seeds
randn('seed', 1e5);
rand('seed', 1e5);

dataSetName = 'brendan';
experimentNo = 2;

% load data
[Y, lbls] = lvmLoadData(dataSetName);

% Set IVM active set size and iteration numbers.
options = gplvmOptions;
numActive = 100;

% Fit the GP latent variable model
noiseType = 'gaussian';
selectionCriterion = 'entropy';
kernelType = {'rbf', 'bias', 'white'};
model = gplvmFit(Y, 1, options, kernelType, noiseType, selectionCriterion, numActive, lbls);

% Save the results.
[X, kern, noise, ivmInfo] = gplvmDeconstruct(model);
capName = dataSetName;
capName(1) = upper(capName(1));
save(['dem' capName num2str(experimentNo) '.mat'], 'X', 'kern', 'noise', 'ivmInfo');

% Load the results and display dynamically.
gplvmResultsDynamic(dataSetName, experimentNo, 'image', [20 28], 1, 0, 1)

% Load the results and display statically.
% gplvmResultsStatic(dataSetName, experimentNo, 'image', [20 28], 1, 0, 1)

% Load the results and display as scatter plot
% gplvmResultsStatic(dataSetName, experimentNo, 'none')
