% DEMRATEMAPSPROJECT3

% GPLVM

rand('seed', 1e5)
randn('seed', 1e5)
dataset = 'ratemaps';
[Y, lbls] = gplvmLoadData(dataset);
number = 3;
dataset(1) = upper(dataset(1));
load(['dem' dataset num2str(number)])
model = ivmReconstruct(kern, noise, ivmInfo, X, Y);

Ytest = loadRateMap('../data/ratemaps');
% THis is "The horse kicks the rider."
Ytest = Ytest(:, 20130:20620)';
options = foptions;
options(14) = 500;

prior.type = 'gaussian';
prior = priorParamInit(prior);
prior.precision = 1;
numData = size(Ytest, 1);
numSeed = 2;
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
[void, select] = max(mean(pointLlBin));
Yapprox = ivmOut(model, x{select});
playRateMap(Yapprox');
