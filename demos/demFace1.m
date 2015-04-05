% STICKMANGPLVMSCRIPT3 Original stick man script.
%
%
% Copyright (c) 2005 Neil D. Lawrence
% File version 1.4, Sun Jan  2 17:48:50 2005
% MOCAP toolbox version 0.001



% Keep results consistent each time run
rand('seed', 1e5)
randn('seed', 1e5)

colordef white
numData = 400;

Y = tfaceParse('data/','franck', 0, 1000, numData);
connect = tfaceLoadConnectivity('data/franck.parts');
bb = tfaceGetBoundingBox(Y);
%[Y, connect] = mocapLoadData('run1');
latentDim = 2;

% Select data
%numData = 100;
%indices = randperm(size(points, 1));
%indices = indices(1:numData);
%Y = points(indices, :);
Y = Y(1:4:end, :);

numData = size(Y, 1);
fprintf('Num Data %d\n', numData);
meanData = mean(Y);

Y = Y - repmat(meanData, numData, 1);
dataDim = size(Y, 2);
lbls = ones(size(Y, 1), 1);

% Initialise X with PCA - just for fun let's do it with the eigenvalue
% problem
[Lambda, U] = pca(Y');
beta = 1/Lambda(3);
L(1, 1) = sqrt(Lambda(1) -1/beta);
L(2, 2) = sqrt(Lambda(2) -1/beta);
X(:, 1) = U(:, 1);
X(:, 2) = U(:, 2);
X = X*L;
invK = pdinv(X*X'+1/beta*eye(numData));
theta = [1 1 beta];

returnVal = [];

symbol{1} = 'r+';
symbol{2} = 'bo';
symbol{3} = 'mx';
plot(X(:, 1), X(:, 2), 'rx');


% initialise kernel parameters
theta = [1 1 beta];
lntheta = log(theta);

params = [X(:)' lntheta];

options = zeros(1, 18);
options(2) = 1e-6;
options(3) = 1e-6;
options(1) = 1;
options(9) = 0;
options(14) = 500;

% by not passing X to scg it is automatically optimised
params = scg('gplvmlikelihood', params, options, 'gplvmgradient', Y);

X = reshape(params(1:numData*latentDim), numData, latentDim);
lntheta = params(numData*latentDim+1:end);
theta = exp(lntheta);

[K, invK] = computeKernel(X, theta);

% Visualise the results
mocapVisualise(X, Y, invK, theta, ones(size(Y, 1), 1), meanData, ...
               1:numData, 'cootesVisualise', 'cootesModify', connect, bb);

