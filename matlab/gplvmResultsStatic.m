function gplvmResultsStatic(dataset, number, dataType, varargin)

% GPLVMRESULTSSTATIC Load a results file and visualise them dynamically.

% GPLVM

[Y, lbls] = gplvmLoadData(dataset);

dataset(1) = upper(dataset(1));
load(['dem' dataset num2str(number)])
model = ivmReconstruct(kern, noise, ivmInfo, X, Y);

% Visualise the results
if size(model.X, 2) ==1 
  error('not yet implemented static 1-D visualisation')

elseif size(model.X, 2) == 2
  if strcmp(dataType, 'none')
    gplvmScatterPlot(model, lbls);
  else
    gplvmStaticImageVisualise(model, [dataType 'Visualise'], 0.015, varargin{:});
  end

else
  error('no visualisation code for data of of this latent dimension');
end