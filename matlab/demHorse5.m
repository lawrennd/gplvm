% DEMHORSE1 Model the horse data with a 3-D GPLVM.

dataSetName = 'horse';
for experimentNo = 7:10

  % Fix seeds
  randn('seed', 1e5);
  rand('seed', 1e5);
  
  % load data
  [Y, lbls] = lvmLoadData(dataSetName);
  
  % Set IVM active set size and iteration numbers.
  numActive = 100;
  
  options = gplvmOptions;
  
  % because of small data-set, jointly optimise active points with kern params.
  options.gplvmKern = 1;
  options.kernIters = 50;
  
  % Because of ordered noise models, optimise noise too.
  options.noiseIters = 50;
  
  orderedIndex = [1, 2, 6, 7, 8, 9, 10, 11, 12, 13, 14, 16, 17, 20];
  gaussianIndex = [3, 4, 5, 15, 18, 19, 21];
  for i = orderedIndex;
    noiseType{i} = 'ordered';
  end
  for i = gaussianIndex
    noiseType{i} = 'mgaussian';
  end
  
  % Initialise X with PCA.
  tempY = Y;
  for i = orderedIndex;
    va = var(tempY(find(~isnan(tempY(:, i))), i));
    tempY(:, i) = tempY(:, i)/sqrt(va);
  end
  X = gplvmPcaInit(tempY, experimentNo - 2);
  
  
  kernelType = {'rbf', 'bias', 'white'};
  
  model = gplvmFit(X, Y, numActive, options, noiseType, kernelType, lbls);
  
  
  % Save the results.
  X = model.X;  
  [kern, noise, ivmInfo] = ivmDeconstruct(model);
  capName = dataSetName;
  capName(1) = upper(capName(1));
  save(['dem' capName num2str(experimentNo) '.mat'], 'X', 'kern', 'noise', 'ivmInfo');
  
  gplvmLatentClassify(dataSetName, experimentNo);
end
