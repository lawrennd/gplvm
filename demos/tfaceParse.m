function [points] = tfaceParse(sPath, sDatasetName, startFrame, endFrame, nbOfSamples);


deltaFrame = (endFrame - startFrame + 1) / (nbOfSamples);
if (deltaFrame < 1)
    'nb of samples too high for the range specified'
    return
end

[firstFrame] = tfaceParseFrame(sPath, sDatasetName, startFrame);
points = zeros(nbOfSamples, size(firstFrame, 2));
points(1, :) = firstFrame;

i = startFrame + deltaFrame;
j = 2;
while (j <= nbOfSamples)
    [frame] = tfaceParseFrame(sPath, sDatasetName, floor(i));
    points(j, :) = frame;
    i = i + deltaFrame;
    j = j + 1;
end