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
noiseType = 'probit';
kernelType = {'rbf', 'bias', 'white'};
model = gplvmInit(X, Y, kernelType, noiseType, 'entropy', numActive);
% turn probit into a step (noise is in the kernel here)
model.noise.sigma2 = 1e-6;
prior = 0;
model = gplvmOptimise(model, prior, display, pointIters, extIters, kernIters);

% Visualise the results
gplvmVisualise(model, [], 'imageVisualise', ...
               'imageModify', [8 8]);

X = model.X;  
[kern, noise, ivmInfo] = ivmDeconstruct(model);
save('demTwos2.mat', 'X', 'kern', 'noise', 'ivmInfo');