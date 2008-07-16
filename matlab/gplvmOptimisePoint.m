function model = gplvmOptimisePoint(model, i, prior, display, iters);

% GPLVMOPTIMISEPOINT Optimise the postion of a non-active point.

% GPLVM

if nargin < 5
  iters = 500;
  if nargin < 4
    display = 1;
    if nargin < 3
      prior = [];
    end
  end
end


options = optOptions;
if display
  options(1) = 1;
  options(9) = 1;
end
options(14) = iters;


model.X(i, :) = scg('pointNegLogLikelihood', model.X(i, :),  options, ...
		    'pointNegGradX', model.y(i, :), model, prior);

