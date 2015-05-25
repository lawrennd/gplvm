% DEMRATEMAPSPROJECT8

% GPLVM

rand('seed', 1e5)
randn('seed', 1e5)
dataset = 'ratemaps';
[Y, lbls] = gplvmLoadData(dataset);
% Select a small subset of the data.
index = randperm(size(Y, 1));
index = index(1:2000);
Y = Y(index, :);
% Set average of each signal to zero.
levels = mean(Y, 2);
for i = 1:size(Y, 2);
  Y(i, :) = Y(i, :) - levels(i);
end

number = 8
dataset(1) = upper(dataset(1));
load(['dem' dataset num2str(number)])
model = ivmReconstruct(kern, noise, ivmInfo, X, Y);

Ytest = loadRateMap('../data/ratemaps');
% THis is "The horse kicks the rider."
Ytest = Ytest(:, 20130:20620)';
% Set average of each signal to zero.
testLevels = mean(Ytest, 2);
for i = 1:size(Ytest, 2);
  Ytest(i, :) = Ytest(i, :) - testLevels(i);
end
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
[void, ind] = max(mean(pointLlBin));
Yapprox = ivmOut(model, x{ind});
for i = 1:size(Ytest, 2);
  Ytest(i, :) = Ytest(i, :) + testLevels(i);
  Yapprox(i, :) = Yapprox(i, :) + testLevels(i);
end

save(['dem' dataset num2str(experimentNo) 'Project.mat'], 'x', ...
     'pointLlBin', 'ind', 'Yapprox', 'Ytest');
