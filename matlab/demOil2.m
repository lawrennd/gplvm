% DEMOIL2 Model the oil data with a 2-D GPLVM using MLP kernel.

% GPLVM

% Fix seeds
randn('seed', 1e5);
rand('seed', 1e5);

dataSetName = 'oil';
experimentNo = 2;

% load data
[Y, lbls] = gplvmLoadData(dataSetName);

% Set IVM active set size and iteration numbers.
options = gplvmOptions;
numActive = 100;

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
kernelType = {'mlp', 'bias', 'white'};
model = gplvmFit(X, Y, numActive, options, noiseType, kernelType, lbls);


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
