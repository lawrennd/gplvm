function gplvmStaticData(X, Y, invK, theta, YLbls, meanData, activeSet, ...
			visualiseFunction, varargin)

% GPLVMSTATICDATA Plot positions of data on manifold using small plots of data.


numData = size(Y, 1);
axesWidth = 0.03;

% Plot confidence contours
x1 = linspace(min(X(:, 1))*1, max(X(:, 1))*1, 30);
x2 = linspace(min(X(:, 2))*1, max(X(:, 2))*1, 30);
[X1, X2] = meshgrid(x1, x2);
XTest = [X1(:), X2(:)];
[testY, testYVar] = manifoldOutputs(XTest, X(activeSet, :), Y(activeSet, :), theta, invK);
  
figure, hold on
% Create the plot for the data
visualiseInfo.plotAxes = subplot(1, 1, 1);
[c, h] = contourf(X1, X2, log10(reshape(1./testYVar, size(X1))), 128); 
shading flat
colormap gray;
colorbar

data = plot(X(:, 1), X(:, 2), 'rx');
xLim = get(gca, 'xlim');
yLim = get(gca, 'yLim');

plotAxes = gca;
posit = get(plotAxes, 'position');
widthVal = axesWidth*(xLim(2) - xLim(1))/posit(3);
heightVal = axesWidth*(yLim(2) - yLim(1))/posit(4);

visitOrder = randperm(numData);
initVisitOrder = visitOrder;

% Plot the real digits
while ~isempty(visitOrder)
  i = visitOrder(1);
  if X(i, 1) > xLim(1) & X(i, 1) < xLim(2) ...
    & X(i, 2) > yLim(1) & X(i, 2) < yLim(2)
    point = invGetNormAxesPoint(X(i, :), plotAxes);
    x = point(1);
    y = point(2);
    
    digitAxes(i) =  axes('position', ...
			 [x - axesWidth/2 ...
		    y - axesWidth/2 ...
		    axesWidth ...
		    axesWidth]);
    feval(visualiseFunction, Y(i, :), varargin{:});
    colormap gray
    axis image
    axis off
    
    removePoints = find(abs(X(visitOrder, 1) - X(i, 1)) < widthVal ...
			&  abs(X(visitOrder, 2) - X(i, 2)) < heightVal);
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
