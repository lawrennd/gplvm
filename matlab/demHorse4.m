% DEMHORSE4 Try horse classification for latent spaces from 2 dims to 8.

dataSetName = 'horse';
for experimentNo = 4:10

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
  
  options.initX = 'sppca';
  kernelType = {'rbf', 'bias', 'white'};
  selectionCriterion = 'entropy';
  model = gplvmFit(Y, experimentNo - 2, options, kernelType, noiseType, selectionCriterion, numActive, lbls);
  
  % Save the results.
  [X, kern, noise, ivmInfo] = gplvmDeconstruct(model);
  capName = dataSetName;
  capName(1) = upper(capName(1));
  save(['dem' capName num2str(experimentNo) '.mat'], 'X', 'kern', 'noise', 'ivmInfo');
end
for experimentNo = 4:10
  for seedStem = 1:10
    gplvmLatentClassify(dataSetName, experimentNo, seedStem*1e5);
  end
end
