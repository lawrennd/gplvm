% DEMOILGTM For visualising oil data --- uses NETLAB toolbox.

% GPLVM

rand('state', 1e5);
randn('state', 1e5);


[Y, lbls] = lvmLoadData('oil');

dataDim = size(Y, 2);
latentDim = 2;


latentGridDims = [15 15]; 
numLatent = prod(latentGridDims);  % Number of latent points
numCentres = 16;


% Create and initialise GTM model
model = gtm(latentDim, numLatent, dataDim, numCentres, ...
   'gaussian', 0.1);

options = optOptions;
options(7) = 1;   
model = gtminit(model, options, Y, 'regular', latentGridDims, [4 4]);

options = optOptions;
options(14) = 1000;
options(1) = 1;

[model, options] = gtmem(model, Y, options);

% Plot posterior means
X = gtmlmean(model, Y);
symbols = getSymbols(3);
figure, hold on
for i = 1:size(X, 1)
  labelNo = find(lbls(i, :));
  plot(X(i, 1), X(i, 2), symbols{labelNo})
end
save('demOilGtm', 'model', 'X');
