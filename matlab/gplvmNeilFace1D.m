% GPLVMNEILFACE Model the face data from NL with a 2-D GPLVM.

% Fix seeds
randn('seed', 1e5);
rand('seed', 1e5);

% load data
load c:\datasets\faces\neilFaceData.mat
Y = double(X);


% Extract data dimensions and set IVM active set size
numData = size(Y, 1);
dataDim = size(Y, 2);
numActive = 100;
extIters = 15;

% Don't centre the data so that when there is no Brendan there is no Brendan.
meanData = mean(Y);
Y = Y  - repmat(meanData, size(Y, 1), 1);

% Initialise X with PCA
[v, u] = pca(Y);
v(find(v<0))=0;
X = Y*u(:, 1)*diag(1./sqrt(v(1)));

% Initialise theta
theta(1) = 1;
theta(2) = 1;
theta(3) = 1;

% Options for optimisation in latent space
options = foptions;
options(1) = 0;
options(9) = 0;
options(14) = 100;

% options for kernel optimisation
optionsKernel = foptions;
optionsKernel(1) = 0;
optionsKernel(9) = 0;
optionsKernel(14) = 100;

% Fit the GP latent variable model
[X, theta, activeSet] = gplvmFit(X, Y, theta, numActive, optionsKernel, ...
		      options, extIters)
  
% compute the kernel from results
[K, invK] = computeKernel(X(activeSet, :), theta);

% Visualise the results
gplvmVisualise1D(X, Y, invK, theta, [], meanData, activeSet, 'imageTVisualise', ...
	       'imageTModify', [20 20]);
%save gplvmNeilFace1D.mat X theta activeSet