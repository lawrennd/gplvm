function gplvmResultsFantasy(dataset, number, dataType, varargin)

% GPLVMRESULTFANTASY Load a results file and visualise the `fantasies'.

% GPLVM

[Y, lbls] = lvmLoadData(dataset);

dataset(1) = upper(dataset(1));
load(['dem' dataset num2str(number)])
model = ivmReconstruct(kern, noise, ivmInfo, X, Y);

% Visualise the results
if size(model.X, 2) ==1 
  error('not yet implemented fantasy 1-D visualisation')

elseif size(model.X, 2) == 2
  gplvmFantasyPlot(model, [dataType 'Visualise'], 0.05, 1.5, varargin{:});
else
  error('no visualisation code for data of of this latent dimension');
end