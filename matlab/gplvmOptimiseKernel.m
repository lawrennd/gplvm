function model = gplvmOptimiseKernel(model, prior, display, iters);

% GPLVMOPTIMISEKERNEL Jointly optimise the kernel parameters and active set positions.

% GPLVM


if nargin < 3
  iters = 500;
  if nargin < 2
    display = 1;
  end
end

options = foptions;
if display
  options(1) = 1;
end
options(14) = iters;


xVals = model.X(model.I, :);
xVals = xVals(:)';

kernParams = kernExtractParam(model.kern);

params = [kernParams xVals];

options = foptions;
if display
  options(1) = 1;
  if length(params) <= 20
    options(9) = 1;
  end
end
options(14) = iters;

params = scg('gplvmKernelObjective', params,  options, ...
            'gplvmKernelGradient', model, prior);

kernParams = params(1:model.kern.nParams);
xVals = params(model.kern.nParams+1:end);

model.X(model.I, :) = reshape(xVals, length(model.I), size(model.X, 2));
model.kern = kernExpandParam(model.kern, kernParams);  