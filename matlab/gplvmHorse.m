% GPLVMOIL Model the oil data with a 2-D GPLVM.

% GPLVM

%/~
importTool('ivm');
%~/

% Fix seeds
randn('seed', 1e5);
rand('seed', 1e5);

display = 1;

load horse.dat;
horse([133, 309], :) = [];
ordinalAtr = [1 2 7 8 9 10 11 12 13 14 15 17 18 21];
horse(:, ordinalAtr) = horse(:, ordinalAtr) - 1;
lbls = zeros(size(horse, 1), 3);
for i = 1:size(horse, 1)
  lbls(i, horse(i, 23)) = 1;
end

horse(:, 23:28) = [];
horse(:, 3) = [];
Y = horse;

noiseType = {'ordered', 'ordered', 'mgaussian', ...
              'mgaussian', 'mgaussian', 'ordered', ...
              'ordered', 'ordered', 'ordered', ...
              'ordered', 'ordered', 'ordered', ...
              'ordered', 'ordered', 'mgaussian', ...
              'ordered', 'ordered', 'mgaussian', ...
              'mgaussian', 'ordered', 'mgaussian'};
% Extract data dimensions and set IVM active set size
numData = size(Y, 1);
dataDim = size(Y, 2);
numActive = 100;
kernIters = 100;
pointIters = 100;
extIters = 5;

% Initialise X with PCA
X = randn(numData, 2)*0.1;
kernelType = 'lin';
% Fit the GP latent variable model
model = gplvmFit(X, Y, numActive, display, pointIters, ...
                 extIters, kernIters, noiseType, kernelType);
[kern, noise, ivmInfo] = ivmDeconstruct(model);
save('gplvmHorseInit.mat', 'X', 'kern', 'noise', 'ivmInfo');
extIters = 15;
X = model.X
returnVal = [];

symbol{1} = 'r+';
symbol{2} = 'bo';
symbol{3} = 'mx';
figure, hold on
for i = 1:size(X, 1)
  labelNo = find(lbls(i, :));
  plot(X(i, 1), X(i, 2), symbol{labelNo})
end
% Fit the GP latent variable model
kernelType = {'mlp'};
model = gplvmFit(X, Y, numActive, display, pointIters, ...
                 extIters, kernIters, noiseType, kernelType);

% Visualise the results
gplvmVisualise(model, lbls, 'vectorVisualise', 'vectorModify');

X = model.X;  
[kern, noise, ivmInfo] = ivmDeconstruct(model);
save('gplvmHorse.mat', 'X', 'kern', 'noise', 'ivmInfo');