% DEMKPCAOIL1 Model the oil data with kernel PCA.

% Fix seeds

dataSetName = 'oil';
experimentNo = 1;

% load data
[Y, lbls] = lvmLoadData(dataSetName);

kernelType = 'mlp';

kern=kernCreate(Y, kernelType);
kern.weightVariance=10;
kern.biasVariance=1000000;
kern.inverseWidth=0.01;
[X, lambda]=kernPca(kern, Y, 3);
symbs=getSymbols(3);
for i=1:3
  plot(X(find(lbls(:, i)), 1), X(find(lbls(:,i)), 2), symbs{i})
  hold on
end
disp(diag(lambda))