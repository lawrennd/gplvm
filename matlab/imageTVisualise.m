function handle = imageTVisualise(imageVals, imageSize)

% IMAGETVISUALISE Helper code for showing an image during 2-D visualisation.

handle = image(reshape(imageVals, imageSize(1), imageSize(2)));
