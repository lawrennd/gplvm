% DEMOIL2 Model the oil data with a 2-D GPLVM using MLP kernel.

% GPLVM

%/~
importTool('ivm', 0.221);
%~/

% Fix seeds
randn('seed', 1e5);
rand('seed', 1e5);

display = 0;

[Y, lbls] = gplvmLoadData('oil');

% Set IVM active set size and iteration numbers.
numActive = 100;
kernIters = 100;
pointIters = 100;
extIters = 15;

% Initialise X with PCA.
X = gplvmPcaInit(Y, 2);

% Plot the intialisation.
symbol{1} = 'r+';
symbol{2} = 'bo';
symbol{3} = 'mx';
figure, hold on
for i = 1:size(X, 1)
  labelNo = find(lbls(i, :));
  plot(X(i, 1), X(i, 2), symbol{labelNo})
end

% Fit the GP latent variable model
noiseType = 'ngauss';
kernelType = {'mlp', 'bias', 'white'};
model = gplvmFit(X, Y, numActive, display, pointIters, ...
                 extIters, kernIters, noiseType, kernelType);

% Visualise the results
gplvmVisualise(model, lbls, 'vectorVisualise', 'vectorModify');

X = model.X;  
[kern, noise, ivmInfo] = ivmDeconstruct(model);
save('demOil2.mat', 'X', 'kern', 'noise', 'ivmInfo');