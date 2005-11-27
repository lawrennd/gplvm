% DEMOIL100 Model the oil data with a 2-D GPLVM using RBF kernel.

% Fix seeds
randn('seed', 1e5);
rand('seed', 1e5);

dataSetName = 'oil100';
experimentNo = 1;

% load data
[Y, lbls] = lvmLoadData(dataSetName);

% Set IVM active set size and iteration numbers.
options = gplvmOptions;

% Set all points as active
numActive = 100;

% Optimise kernel parameters and active set jointly.
options.gplvmKern = 1;
options.kernIters = 20;
options.extIters = 1;
% Display iterations
options.display = 1;

% Initialise X with PCA.
X = gplvmPcaInit(Y, 2);

% Plot the intialisation.
symbols = getSymbols(3);
figure, hold on
for i = 1:size(X, 1)
  labelNo = find(lbls(i, :));
  plot(X(i, 1), X(i, 2), symbols{labelNo})
end

% Fit the GP latent variable model
noiseType = 'gaussian';
kernelType = 'sqexp';%{'rbf', 'bias', 'white'};
model = gplvmFit(Y, 2, options, kernelType, noiseType, 'entropy', ...
                 numActive, lbls);

% Save the results.
X = model.X;  
[kern, noise, ivmInfo] = ivmDeconstruct(model);
capName = dataSetName;
capName(1) = upper(capName(1));
save(['dem' capName num2str(experimentNo) '.mat'], 'X', 'kern', 'noise', 'ivmInfo');

% Load the results and display dynamically.
gplvmResultsDynamic(dataSetName, experimentNo, 'vector')

% Load the results and display statically.
% gplvmResultsStatic(dataSetName, experimentNo, 'vector')

% Load the results and display as scatter plot
% gplvmResultsStatic(dataSetName, experimentNo, 'none')
