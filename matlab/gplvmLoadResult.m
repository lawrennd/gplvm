function [model, lbls] = gplvmLoadResult(dataSet, number)

% GPLVMLOADRESULT Load a previously saved result.

% GPLVM

[Y, lbls] = lvmLoadData(dataSet);

dataSet(1) = upper(dataSet(1));
load(['dem' dataSet num2str(number)])
model = ivmReconstruct(kern, noise, ivmInfo, X, Y);
