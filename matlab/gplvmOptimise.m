function model = gplvmOptimise(model, prior, display, pointIters, extIters, kernIters);

% GPLVMOPTIMISE Optimise the parameters and points of a GPLVM model.

% GPLVM
numData = size(model.X, 1);
for iterNum = 1:extIters

  % Fit a gaussian proces to the model using ivm algorithm to sparsify.
  % Update the noise parameters
  model = ivmOptimiseIVM(model, display);
  model = ivmOptimiseKernel(model, prior, display, kernIters);
  kernDisplay(model.kern);
  model = ivmOptimiseIVM(model, display);
  model = ivmOptimiseNoise(model, prior, display, kernIters);
  noiseDisplay(model.noise);

  % Update the noise
  
  % Update active set
  model = ivmOptimiseIVM(model, display);
  %/~  A = zeros(length(model.I), length(model.Sigma));
  %  for i = 1:length(model.Sigma)
  %    A(:, i) = model.Sigma(i).Linv'*model.Sigma(i).Linv*model.m(model.I, i);
  %  end
  %~/
  % Iterate through the data updating positions
  counter = 0;
  for i = model.J
    counter = counter + 1;
    model = gplvmOptimisePoint(model, i, 1, display, pointIters);
    if ~rem(counter, floor(numData/10))
      fprintf('Finished point %d\n', counter)
    end      
  end

end
model = ivmOptimiseIVM(model, display);
