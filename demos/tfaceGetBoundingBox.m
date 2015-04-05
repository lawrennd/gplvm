function [bb] = tfaceGetBoundingBox(points)

numPoints = floor(size(points, 2)/2);
bb(1, 1) = min(min(points(:, 1:numPoints))); % minX
bb(2, 1) = min(min(points(:, numPoints+1:2*numPoints))); % minY 
bb(1, 2) = max(max(points(:, 1:numPoints))); % maxX
bb(2, 2) = max(max(points(:, numPoints+1:2*numPoints))); % maxY
