function [points] = tfaceParseFrame(sPath, sDatasetName, frame);

filename = tfaceParseGenerateFilename(sDatasetName, frame);
fid = fopen([sPath filename]);

line = fgets(fid); % skip the version

line = fgets(fid); % get the number of points in the first frame (assumed to be the same for all frames)
[uselessString, sNbOfPoints] = strtok(line);
nbOfPoints = sscanf(sNbOfPoints, '%i'); % looks like the frame count is wrong
points = zeros(1, 2*nbOfPoints);

line = fgets(fid); % skip the "{"
if (~strncmp(line, '{', 1))
    'parse error'
    return
end

line = fgets(fid);
j = 1;
while (j <= nbOfPoints)
    pair = sscanf(line, '%f %f');
    points(1, j) = pair(1, 1);
    points(1, nbOfPoints+j) = pair(2, 1);
    line = fgets(fid);
    j = j+1;
end
fclose(fid);

