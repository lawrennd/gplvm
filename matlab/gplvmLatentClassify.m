function gplvmLatentClassify(dataset, experimentNo)

% GPLVMLATENTCLASSIFY Load a results file and visualise them dynamically.

% GPLVM

[Y, lbls] = gplvmLoadData(dataset);
lbls = lbls*2 - 1;
numLabels = size(lbls, 2);

randn('seed', 1e5)
rand('seed', 1e5)

numData = size(Y, 1);
dVal = min([300 numData]);

numTrainData = ceil(numData/2);
index = randperm(numData);

indexTrain = index(1:numTrainData);
indexTest = index(numTrainData+1:end);

if isempty(lbls)
  error(['No labels in ' dataset ' data-set.'])
end
dataset(1) = upper(dataset(1));
load(['dem' dataset num2str(experimentNo)])

XTrain = X(indexTrain, :);

yTrain = lbls(indexTrain, :);

XTest = X(indexTest, :);
yTest = lbls(indexTest, :);

options = ivmOptions;
kernelType = {'rbf', 'bias', 'white'};

noiseModel = 'probit';
selectionCriterion = 'entropy';

mu = zeros(size(yTest));
varSigma = zeros(size(yTest));

tic
% Learn an IVM for each digit
for trainData = 0:numLabels-1
  index = trainData+1;
  
  % Train the IVM.
  model = ivmRun(XTrain, yTrain(:, index), kernelType, ...
                 noiseModel, selectionCriterion, dVal, ...
                 options);
  
  % Make prediction for this digit.
  [mu(:, index), varSigma(:, index)] = ivmPosteriorMeanVar(model, XTest);
  mu(:, index) = mu(:, index) + model.noise.bias;
  yPred = sign(mu(:, index));
  testError(index) = 1-sum(yPred==yTest(:, index))/size(yTest, 1);
  fprintf('Label %d, test error %2.4f\n', trainData, testError(index));

  % Deconstruct IVM for saving.
  [kernStore{index}, noiseStore{index}, ...
   ivmInfoStore{index}] = ivmDeconstruct(model);
  save(['dem' dataset 'Classify' num2str(experimentNo)], 'testError', ...
       'ivmInfoStore', 'kernStore', 'noiseStore')
end
overallTime = toc;

% Make prediction for all digits.
[void, yPred] = max(mu, [], 2);
[void, yTest] = max(yTest, [], 2);
yPred = yPred - 1;
yTest = yTest - 1;
overallError = 1 - sum(yPred == yTest)/size(yTest, 1);

confusMat = zeros(numLabels);
for i = 1:length(yPred)
  confusMat(yPred(i)+1, yTest(i)+1) = confusMat(yPred(i)+1, yTest(i)+1) + 1;
end
save(['dem' dataset 'Classify' num2str(experimentNo)], 'testError', ...
     'ivmInfoStore', 'kernStore', ...
     'noiseStore', 'overallError', ...
     'confusMat', 'overallTime');
