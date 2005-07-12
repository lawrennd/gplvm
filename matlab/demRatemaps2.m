% DEMRATEMAPS2 Do artificial level normalisation.

% Fix seeds
importTool('speech')

randn('seed', 1e5);
rand('seed', 1e5);

display = 0;

dataSetName = 'ratemaps';
experimentNo = 2;

% load data
[Y, lbls] = gplvmLoadData(dataSetName);
Y = ratemap2Diffrep(Y);
for i = 1:size(Y, 2);
  va(i) = var(Y(find(~isnan(Y(:, i))), i));
  Y(:, i) = Y(:, i)/sqrt(va(i));
end


% Set IVM active set size and iteration numbers.
options = gplvmOptions;
% Optimise active set and kernel parameters jointly.
options.gplvmKern = 1;
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
save(['dem' capName num2str(experimentNo) '.mat'], 'X', 'kern', ...
     'noise', 'ivmInfo', 'va');

% Load the results and display dynamically.
gplvmResultsDynamic(dataSetName, experimentNo, 'spectrum', 'prepSpectrum', ...
                    500);


% Load the results and display statically.
% gplvmResultsStatic(dataSetName, experimentNo, 'vector');

% Load the results and display as scatter plot
% gplvmResultsStatic(dataSetName, experimentNo, 'none')

