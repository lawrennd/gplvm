function model = gplvmOptimiseActiveSet(model, prior, display, iters)

% GPLVMOPTIMISEACTIVESET Optimise the location of the active points.

% GPLVM

if nargin < 4
  iters = 500;
  if nargin < 3
    display = 1;
    if nargin < 2
      prior = [];
    end
  end
end



xVals = model.X(model.I, :);
xVals = xVals(:)';

options = foptions;
if display
  options(1) = 1;
  if length(xVals) <= 20
    options(9) = 1;
  end
end
options(14) = iters;

xVals = scg('gplvmActiveSetObjective', xVals,  options, ...
		    'gplvmActiveSetGradient', model, prior);
model.X(model.I, :) = reshape(xVals, length(model.I), size(model.X, 2));
