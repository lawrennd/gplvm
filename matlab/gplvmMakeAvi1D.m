function M = gplvmmakeavi1D(X, Y, invK, theta, YLbls, meanData, activeSet, ...
			visualiseFunction, visualiseModify, numFrames, varargin)

% GPLVMMAKEAVI1D Create a movie of the fantasies along a line (as a movie).

activeX = X(activeSet, :);
activeY = Y(activeSet, :);

numData = size(Y, 1);
if nargin < 6
  YLbls = ones(numData, 1);
end

XTest = linspace(min(X(:, 1)), max(X(:, 1)), numFrames)';
[testY, testYVar] = manifoldOutputs(XTest, activeX, activeY, theta, invK);
vars = sort(testYVar);
pickPoint = ceil(0.75*numFrames);
maxVar = vars(pickPoint);
figure(1)
set(gcf, 'menubar', 'none')
set(gcf, 'position', [232 572 115 115/varargin{1}(1)*varargin{1}(2)])
imageAxesa = subplot(1, 1, 1);
set(imageAxesa, 'position', [0 0 varargin{1}(1)/115  varargin{1}(1)/115]);
visHandle = image(reshape(Y(1, :), [varargin{1}(1) varargin{1}(2)]));
set(visHandle, 'erasemode', 'xor')
colorMap gray
testY = testY + repmat(meanData, numData, 1);
testY = testY - min(min(testY));
testY = testY/max(max(testY));
testY = testY*64;
set(imageAxesa, 'visible', 'off')
for i = 1:size(testY, 1)
  feval(visualiseModify, visHandle, ...
	testY(i, :), varargin{:});
  M(i) = getframe;
end
