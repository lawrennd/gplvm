function gplvmStaticImageVisualise(model, imageSize)

% GPLVMSTATICIMAGEVISUALISE Generate a scatte rplot of the images without overlap.

% GPLVM 

% set random seeds
randn('seed', 1e5)
rand('seed', 1e5)

colordef white 

% Turn Y into grayscale

axesWidth = 0.015;

x1 = linspace(min(model.X(:, 1))*1, max(model.X(:, 1))*1, 30);
x2 = linspace(min(model.X(:, 2))*1, max(model.X(:, 2))*1, 30);
[X1, X2] = meshgrid(x1, x2);
XTest = [X1(:), X2(:)];
[mu, varsigma] = ivmPosteriorMeanVar(model, XTest);
varsigma = mean(varsigma, 2);
  
figure, hold on
% Create the plot for the data
visualiseInfo.plotAxes = subplot(1, 1, 1);
[c, h] = contourf(X1, X2, log10(reshape(1./varsigma, size(X1))), 128); 
shading flat
colormap gray;
colorbar

data = plot(model.X(:, 1), model.X(:, 2), 'rx');

plotAxes = gca;
xLim = get(plotAxes, 'xLim');
posit = get(plotAxes, 'position');
widthVal = axesWidth*(xLim(2) - xLim(1))/posit(3);

yLim = get(plotAxes, 'yLim');
posit = get(plotAxes, 'position');
heightVal = axesWidth*(yLim(2) - yLim(1))/posit(4);
numData = size(model.X, 1);
visitOrder = randperm(numData);
initVisitOrder = visitOrder;

% Plot the images
while ~isempty(visitOrder)
  i = visitOrder(1);
  if model.X(i, 1) > xLim(1) & model.X(i, 1) < xLim(2) ...
    & model.X(i, 2) > yLim(1) & model.X(i, 2) < yLim(2)
    point = invGetNormAxesPoint(model.X(i, :), plotAxes);
    x = point(1);
    y = point(2);
    
    digitAxes(i) =  axes('position', ...
			 [x - axesWidth/2 ...
		    y - axesWidth/2 ...
		    axesWidth ...
		    axesWidth]);
    handle = imageVisualise(-model.y(i, :), imageSize);
    colormap gray
    axis image
    axis off
    
    removePoints = find(abs(model.X(visitOrder, 1) - model.X(i, 1)) < widthVal ...
			&  abs(model.X(visitOrder, 2) - model.X(i, 2)) < heightVal);
    visitOrder(removePoints) = [];    
  else
    visitOrder(1) = [];
  end
end
set(plotAxes, 'fontname', 'times');
set(plotAxes, 'fontsize', 20);
set(plotAxes, 'xlim', xLim);
set(plotAxes, 'ylim', yLim);
set(data, 'visible', 'off');
ticks = [-4 -2 0 2 4];
set(plotAxes, 'xtick', ticks)
set(plotAxes, 'ytick', ticks)
