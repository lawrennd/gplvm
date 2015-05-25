sixImage = double(imread('br1561_6.3.pgm'));
rows = size(sixImage, 1);
sixImage = uint8(-sixImage+255);
sixImage = [zeros(rows, 3) sixImage zeros(rows, 4)];
dimOne = size(sixImage);
sixAngles = [260:5:360 0:5:35];
nineAngles = 85:5:215; 

angles = 0:1:360;
i = 0;
Y = zeros(length(angles), prod(dimOne));
for i = 1:length(angles);
  angle = angles(i);
  rotImage = imrotate(sixImage, angle);
  dimTwo = size(rotImage);
  start = round((dimTwo - dimOne)/2);
  cropImage = imcrop(rotImage, [start+1 dimOne-1]);
  Y(i, :) = cropImage(:)';
  
end 

[u, v] = eig(cov(Y'));
v = diag(v);

[void, order] = sort(v);
order = order(end:-1:1);
v = v(order);
u = u(:, order);
X = u*diag(sqrt(v));
save demManifold X Y

