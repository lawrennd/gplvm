% DEMRATEMAPSPROJECT1

% GPLVM

rand('seed', 1e5)
randn('seed', 1e5)
dataset = 'ratemaps';
[Y, lbls] = gplvmLoadData(dataset);
number = 1;
dataset(1) = upper(dataset(1));
load(['dem' dataset num2str(number)])
model = ivmReconstruct(kern, noise, ivmInfo, X, Y);

Ytest = loadRateMap('../data/ratemaps');
Ytest = Ytest(:, 1:130)';
options = foptions;
options(14) = 500;

prior.type = 'gaussian';
prior = priorParamInit(prior);
prior.precision = 1;
numData = size(Ytest, 1);
numSeed = 5;
for j = 1:numSeed

  randn('seed', j*1e5);
  rand('seed', j*1e5);
  initX = randn(1, 2);
  x{j} = zeros(numData, 2);
  for i = 1:numData;
    x{j}(i, :) = scg('pointNegLogLikelihood', initX,  options, ...
                  'pointNegGradX', Ytest(i, :), model, prior);
    initX=x{j}(i, :);
    pointLlBin(i, j) = - pointNegLogLikelihood(x{j}(i, :), Ytest(i, ...
                                                      :), model, prior);
    fprintf(['Finished %d, Ll %2.4f\n'], i, mean(pointLlBin(i, j)));
  end
end