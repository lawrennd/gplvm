% GPLVRESULTSMOIL Load and visualise the results for the oil algorithm.

load 3class

Y = DataTrn;
lbls = DataTrnLbls;

% Centre the data
meanData = mean(Y);
Y = Y  - repmat(meanData, size(Y, 1), 1);

load gplvmOil
model = ivmReconstruct(kern, noise, ivmInfo, X, Y);

% Visualise the results
gplvmVisualise(model, lbls, 'vectorVisualise', 'vectorModify');

