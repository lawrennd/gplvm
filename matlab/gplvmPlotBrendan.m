% GPLVMPLOTDIGITS Generate a showing the scatter plot of the digits.

% set random seeds
randn('seed', 1e5)
rand('seed', 1e5)

colordef white 

% load data
load frey_rawface.mat
load gplvmBrendan
Y = double(ff)';
numData = size(Y, 1);
[K, invK] = computeKernel(X(activeSet, :), theta);

axesWidth = 0.02;

x1 = linspace(min(X(:, 1))*1.1, max(X(:, 1))*1.1, 30);
x2 = linspace(min(X(:, 2))*1.1, max(X(:, 2))*1.1, 30);
[X1, X2] = meshgrid(x1, x2);
XTest = [X1(:), X2(:)];
[testY, testYVar] = manifoldOutputs(XTest, X(activeSet, :), Y(activeSet, :), theta, invK);

testYPlot = testY;
testYPlot(find(testYVar>prctile(testYVar(:, 1), 25))) =NaN;
  
figure, hold on
% Create the plot for the data
visualiseInfo.plotAxes = subplot(1, 1, 1);

[c, h] = contourf(X1, X2, log10(reshape(1./testYVar, size(X1))), 128); 
shading flat
colormap gray;
colorbar

data = plot(X(:, 1), X(:, 2), 'rx');
set(gca, 'xlim', [-2.2 3.3])
set(gca, 'ylim', [-5.5 2.2])

plotAxes = gca;
xLim = get(plotAxes, 'xLim');
posit = get(plotAxes, 'position');
widthVal = axesWidth*(xLim(2) - xLim(1))/posit(3);

yLim = get(plotAxes, 'yLim');
posit = get(plotAxes, 'position');
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
    image(reshape(Y(i, :), 20, 28)'/4);
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
ticks = [-4 -2 0 2 4];
set(plotAxes, 'xtick', ticks)
set(plotAxes, 'ytick', ticks)
