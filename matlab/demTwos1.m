% DEMDIGITS1 Model the digits data with a 2-D GPLVM.

% GPLVM

%/~
importTool('ivm', 0.221);
%~/

% Fix seeds
randn('seed', 1e5);
rand('seed', 1e5);

% load data
Y = gplvmLoadData('twos');

% Set IVM active set size and iteration numbers.
numActive = 100;
kernIters = 100;
pointIters = 100;
extIters = 15;
display = 0;

% Initialise X with PCA
X = gplvmPcaInit(Y, 2);

% Fit the GP latent variable model
noiseType = 'ngauss';
kernelType = {'rbf', 'bias', 'white'};
model = gplvmFit(X, Y, numActive, display, pointIters, ...
                 extIters, kernIters, noiseType, kernelType);

% Visualise the results
gplvmVisualise(model, [], 'imageVisualise', ...
               'imageModify', [8 8]);

X = model.X;  
[kern, noise, ivmInfo] = ivmDeconstruct(model);
save('demTwos1.mat', 'X', 'kern', 'noise', 'ivmInfo');