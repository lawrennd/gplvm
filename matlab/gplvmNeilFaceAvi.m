% GPLVMNEILFACEAVI Make AVI files of NL faces data.

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

load gplvmNeilFace1D.mat

[K, invK] = computeKernel(X(activeSet, :), theta);



% Visualise the results
M = gplvmMakeAvi1D(X, Y, invK, theta, [], meanData, activeSet, 'imageTVisualise', ...
		   'imageTModify', 1191, [20 20]);
movie2avi(M, 'neilFaceFantasy.avi', 'compression', 'none', 'videoname', ...
	  'Fantasy images of NL Faces', 'FPS', 24)

M = gplvmDataMakeAvi1d(X, Y, invK, theta, [], meanData, activeSet, 'imageTVisualise', ...
		   'imageTModify', [20 20]); 
movie2avi(M, 'neilFaceData.avi', 'compression', 'none', 'videoname', ...
	  'Data aligned along latent variable', 'FPS', 24)
