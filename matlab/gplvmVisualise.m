function gplvmVisualise(model, YLbls, ...
			visualiseFunction, visualiseModify, varargin)

% GPLVMVISUALISE Visualise the manifold.

% GPLVM

global visualiseInfo

symbol{1} = 'r+';
symbol{2} = 'bo';
symbol{3} = 'gx';
symbol{4} = 'm*';
symbol{5} = 'ys';
symbol{6} = 'rd';
symbol{7} = 'bV';
symbol{8} = 'g^';
symbol{9} = 'm<';
symbol{10} = 'y>';

activeX = model.X(model.I, :);
activeY = model.y(model.I, :);

numData = size(model.y, 1);
%/~%if nargin < 6
%  YLbls = ones(numData, 1);
%~/%end

x1 = linspace(min(model.X(:, 1))*1.1, max(model.X(:, 1))*1.1, 30);
x2 = linspace(min(model.X(:, 2))*1.1, max(model.X(:, 2))*1.1, 30);
[X1, X2] = meshgrid(x1, x2);
XTest = [X1(:), X2(:)];
[mu, varsigma] = ivmPosteriorMeanVar(model, XTest);
testY = noiseOut(model.noise, mu, varsigma);
testYPlot = testY;
testYPlot(find(varsigma>prctile(varsigma(:, 1), 25))) =NaN;
  
figure(1)
clf
% Create the plot for the data
clf
visualiseInfo.plotAxes = axes('position', [0.05 0.05 0.9 0.9]);
hold on
[c, h] = contourf(X1, X2, log10(reshape(1./varsigma(:, 1), size(X1))), 128); 
shading flat
colormap gray;
colorbar
gplvmtwoDPlot(model.X, YLbls, symbol);

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
if length(varargin)>0
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
visData(1) = min(min(model.y));
visData(end) = max(max(model.y));
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




function returnVal = gplvmtwoDPlot(X, label, symbol)

% GPLVMTWODPLOT Helper function for plotting the labels in 2-D.

returnVal = [];

if ~isempty(label)
  for i = 1:size(X, 1)
    labelNo = find(label(i, :));
    try 
      returnVal = [returnVal; plot(X(i, 1), X(i, 2), symbol{labelNo})];
    catch
      if strcmp(lasterr, 'Index exceeds matrix dimensions.')
	error(['Only ' num2str(length(symbol)) ' labels supported (it''s easy to add more!)'])
      end
    end
  end
else
  returnVal = plot(X(:, 1), X(:, 2), 'rx');
end