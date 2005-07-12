function handle = imageModify(handle, imageValues, imageSize, transpose, negative, ...
		     scale)

% IMAGEMODIFY Helper code for visualisation of image data.

% GPLVM

if nargin < 4
  transpose = 1;
end
if nargin< 5
  negative = 0;
end
if negative
  imageValues = -imageValues;
end
if transpose
  set(handle, 'CData', reshape(imageValues, imageSize(1), imageSize(2))');
else
  set(handle, 'CData', reshape(imageValues, imageSize(1), imageSize(2)));
end
