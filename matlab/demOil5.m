% DEMOIL4 Model the oil data with a 2-D GPLVM using RBF kernel and normal uniform latent prior.

% GPLVM

% Fix seeds
randn('seed', 1e5);
rand('seed', 1e5);

dataSetName = 'oil';
experimentNo = 5;

% load data
[Y, lbls] = gplvmLoadData(dataSetName);

% Set IVM active set size and iteration numbers.
options = gplvmOptions;
options.prior.type = 'normuni';
options.prior = priorParamInit(options.prior);
numActive = 100;

% Initialise X with PCA.
X = gplvmPcaInit(Y, 2);

capName = dataSetName;
capName(1) = upper(capName(1));
save(['dem' capName num2str(experimentNo) '.mat'], 'X');
