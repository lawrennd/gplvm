% DEMOIL1 Model the oil data with a 2-D GPLVM using RBF kernel.

% GPLVM

%/~
importTool('ivm',0.221);
%~/

% Fix seeds
randn('seed', 1e5);
rand('seed', 1e5);

dataSetName = 'oil';
experimentNo = 1;

% load data
[Y, lbls] = gplvmLoadData(dataSetName);

% Set IVM active set size and iteration numbers.
numActive = 100;
kernIters = 100;
pointIters = 100;
extIters = 15;
display = 0;


% Initialise X with PCA.
X = gplvmPcaInit(Y, 2);

% Plot the intialisation.
symbol{1} = 'r+';
symbol{2} = 'bo';
symbol{3} = 'gx';
figure, hold on
for i = 1:size(X, 1)
  labelNo = find(lbls(i, :));
  plot(X(i, 1), X(i, 2), symbol{labelNo})
end

% Fit the GP latent variable model
noiseType = 'ngauss';
kernelType = {'rbf', 'bias', 'white'};
model = gplvmFit(X, Y, numActive, display, pointIters, ...
                 extIters, kernIters, noiseType, kernelType);


% Save the results.
X = model.X;  
[kern, noise, ivmInfo] = ivmDeconstruct(model);
capName = dataSetName;
capName(1) = upper(capName(1));
save(['dem' capName num2str experimentNo '.mat'], 'X', 'kern', 'noise', 'ivmInfo');

% Load the results and display dynamically.
gplvmResultsDynamic(dataSetName, experimentNo, 'vector3')

% Load the results and display statically.
% gplvmResultsStatic(dataSetName, experimentNo, 'vector')

% Load the results and display as scatter plot
% gplvmResultsStatic(dataSetName, experimentNo, 'none')
