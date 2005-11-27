% DEMRATEMAPS1 Do artificial level normalisation.

% Fix seeds
importTool('speech')

randn('seed', 1e5);
rand('seed', 1e5);

display = 0;

dataSetName = 'ratemaps';
experimentNo = 1;

% load data
[Y, lbls] = lvmLoadData(dataSetName);
% Select a small subset of the data.
Y = ratemap2Diffrep(Y);

% Set IVM active set size and iteration numbers.
options = gplvmOptions;
% Take advantage of temporal structure of data.
options.pointIters = 0;
options.temporalPointIters = 100;
% Optimise active set and kernel parameters jointly.
options.gplvmKern = 1;
% Increase number of kernel iterations.
options.kernIters = 400;
% Keep a smallish active set size.
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

demRateMaps1Project
% Load the results and display dynamically.
gplvmResultsDynamic(dataSetName, experimentNo, 'spectrum', 'prepSpectrum', ...
                    500);


% Load the results and display statically.
% gplvmResultsStatic(dataSetName, experimentNo, 'vector');

% Load the results and display as scatter plot
% gplvmResultsStatic(dataSetName, experimentNo, 'none')

