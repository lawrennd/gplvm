% GPLVMRESULTSNEILFACE Load and visualise the 2-D results of NL faces.

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

load gplvmNeilFace.mat

[K, invK] = computeKernel(X(activeSet, :), theta);

% Visualise the results
gplvmvisualise(X, Y, invK, theta, [], meanData, activeSet, 'imageTVisualise', ...
	       'imageTModify', [20 20]);
