function options = gplvmOptions

% GPLVMOPTIONS Initialise an options stucture.

% GPLVM

options.display = 0;
options.kernIters = 100;
options.noiseIters = 0;
options.pointIters = 100;
options.activeIters = 0;
options.extIters = 15;

% Set to 1 to optimise active set with jointly with kernel parameters.
options.gplvmKern = 0;

options.reverseMap = ivmOptions;

options.reverseMap.extIters = 0;

% Set up prior over latent space.
options.prior.type = 'gaussian';
options.prior = priorParamInit(options.prior);
options.prior.precision = 1;
