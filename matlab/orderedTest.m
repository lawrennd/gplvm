% GPLVMOIL Model the oil data with a 2-D GPLVM.

% GPLVM

%/~
importTool('ivm');
%~/

% Fix seeds
randn('seed', 1e5);
rand('seed', 1e5);

display = 0;

load 3Class

Y = ceil(DataTrn);
lbls = DataTrnLbls;
% Extract data dimensions and set IVM active set size
numData = size(Y, 1);
dataDim = size(Y, 2);
numActive = 100;
kernIters = 100;
pointIters = 100;
extIters = 15;

% Initialise X with PCA
[v, u] = pca(Y);
v(find(v<0))=0;
X = Y*u(:, 1:2)*diag(1./sqrt(v(1:2)));


returnVal = [];

symbol{1} = 'r+';
symbol{2} = 'bo';
symbol{3} = 'mx';
figure, hold on
for i = 1:size(X, 1)
  labelNo = find(lbls(i, :));
  plot(X(i, 1), X(i, 2), symbol{labelNo})
end

% Fit the GP latent variable model
model = gplvmFit(X, Y, numActive, display, pointIters, extIters, kernIters);

% Visualise the results
gplvmVisualise(model, lbls, 'vectorVisualise', 'vectorModify');

X = model.X;  
[kern, noise, ivmInfo] = ivmDeconstruct(model);
%save('gplvmOil.mat', 'X', 'kern', 'noise', 'ivmInfo');