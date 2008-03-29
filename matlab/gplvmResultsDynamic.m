function gplvmResultsDynamic(dataSet, number, dataType, varargin)

% GPLVMRESULTSDYNAMIC Load a results file and visualise them.

% GPLVM
  
[model, lbls] = gplvmLoadResult(dataSet, number);

% Visualise the results
switch size(model.X, 2) 
 case 1
  gplvmVisualise1D(model, [dataType 'Visualise'], [dataType 'Modify'], ...
		   varargin{:});
  
 case 2
  gplvmVisualise(model, lbls, [dataType 'Visualise'], [dataType 'Modify'], ...
                 varargin{:});
  
 otherwise 
  error('No visualisation code for data of this latent dimension.');
end