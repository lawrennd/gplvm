% DEMOIL5 Model the oil data with probabilistic PCA.

% GPLVM

% Fix seeds
randn('seed', 1e5);
rand('seed', 1e5);

dataSetName = 'oil';
experimentNo = 5;

% load data
[Y, lbls] = lvmLoadData(dataSetName);

% Model with PPCA.
X = gplvmPpcaInit(Y, 2);

capName = dataSetName;
capName(1) = upper(capName(1));
save(['dem' capName num2str(experimentNo) '.mat'], 'X');
