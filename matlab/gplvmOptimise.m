function model = gplvmOptimise(model, prior, display, pointIters, extIters, kernIters);

% GPLVMOPTIMISE Optimise the parameters and points of a GPLVM model.

% GPLVM
for iterNum = 1:extIters

  % Fit a gaussian proces to the model using ivm algorithm to sparsify.
  % Update the noise parameters
  % Update active set.
  model = ivmOptimiseIVM(model, display);
  % Update the kernel.
  model = ivmOptimiseKernel(model, prior, display, kernIters);
  kernDisplay(model.kern);
  % Update active set.
  model = ivmOptimiseIVM(model, display);
  % Update the noise.
  model = ivmOptimiseNoise(model, prior, display, kernIters);
  noiseDisplay(model.noise);  
  % Update active set.
  model = ivmOptimiseIVM(model, display);
  % Iterate through the data updating X positions.
  counter = 0;
  for i = model.J
    counter = counter + 1;
    model = gplvmOptimisePoint(model, i, 1, display, pointIters);
    if ~rem(counter, floor(length(model.J)/10))
      fprintf('Finished point %d\n', counter)
    end      
  end

end
% Update active set.
model = ivmOptimiseIVM(model, display);
