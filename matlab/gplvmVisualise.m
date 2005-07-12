function gplvmVisualise(model, YLbls, ...
			visualiseFunction, visualiseModify, varargin)

% GPLVMVISUALISE Visualise the manifold.

% GPLVM

global visualiseInfo

figure(1)
clf
visualiseInfo.plotAxes = gplvmScatterPlot(model, YLbls);

%/~
%activeX = model.X(model.I, :);
%activeY = model.y(model.I, :);
%~/

%/~
%numData = size(model.y, 1);
%if nargin < 6
%  YLbls = ones(numData, 1);
%end
%~/

%/~
%dataSet(1) = plot(X(:, 1), X(:, 2), 'r.')
%set(visualiseInfo.dataSet(1), 'MarkerSize', 10)
%hold on
%~/
% Set up the X limits and Y limits of the main plot
xLim = [min(model.X(:, 1)) max(model.X(:, 1))];
xSpan = xLim(2) - xLim(1);
xLim(1) = xLim(1) - 0.05*xSpan;
xLim(2) = xLim(2) + 0.05*xSpan;
xSpan = xLim(2) - xLim(1);

yLim = [min(model.X(:, 2)) max(model.X(:, 2))];
ySpan = yLim(2) - yLim(1);
yLim(1) = yLim(1) - 0.05*ySpan;
yLim(2) = yLim(2) + 0.05*ySpan;
ySpan = yLim(2) - yLim(1);

set(visualiseInfo.plotAxes, 'XLim', xLim)
set(visualiseInfo.plotAxes, 'YLim', yLim)
visualiseInfo.digitAxes = [];
visualiseInfo.digitIndex = [];

% Set the callback function
set(gcf, 'WindowButtonMotionFcn', 'classVisualise(''move'')')

figure(2)
clf

if strcmp(visualiseFunction(1:5), 'image') & length(varargin)>0
  set(gcf, 'menubar', 'none')
  xPixels = 115;
  yPixels = 115;
  set(gcf, 'position', [232 572 xPixels yPixels/varargin{1}(1)*varargin{1}(2)])
  imageAxesa = subplot(1, 1, 1);
  xWidth = varargin{1}(1)/xPixels;
  yHeight = varargin{1}(2)/yPixels;
  set(imageAxesa, 'position', [0.5-xWidth/2 0.5-yHeight/2 xWidth yHeight])
else
  imageAxesa =subplot(1, 1, 1);
end
visData = zeros(1,size(model.y, 2));
if(strcmp(visualiseFunction(1:5), 'image'))
  visData(1) = min(min(model.y));
  visData(end) = max(max(model.y));
else
  visData = model.y(1, :);
end

visHandle = feval(visualiseFunction, visData, varargin{:});
set(visHandle, 'erasemode', 'xor')
colormap gray
set(imageAxesa, 'visible', 'off')

%/~
%imageAxesa = axes('position', [0.95 0.05 0.05 0.05]);
%visualiseInfo.visHandle = feval(visualiseFunction, Y(1, :), varargin{:});
%colorMap gray
%set(imageAxesa, 'visible', 'off')
%~/
% Pass the data to visualiseInfo
visualiseInfo.model = model;
%/~visualiseInfo.X = activeX;
%visualiseInfo.Y = activeY;
%visualiseInfo.theta = theta;
%visualiseInfo.invSigma= model.Sigma.Linv'*model.Sigma.Linv;
%~/
visualiseInfo.varargin = varargin;
visualiseInfo.visualiseModify = visualiseModify;
visualiseInfo.visHandle = visHandle;
hold off




