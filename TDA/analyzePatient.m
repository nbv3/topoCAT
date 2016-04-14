% analyzePatient.m
function [zeroPers, onePers] = analyzePatient(patient)

% pid = patient.ID;
mov = patient.movie;

numFrames = length(mov);
numPersVals = 10;

zeroPers = repmat(zeros(numPersVals, 3), 1, 1, numFrames);
onePers  = repmat(zeros(numPersVals, 3), 1, 1, numFrames);

distfun = @(a,b) sqrt((a(:,1)-b(:,1)).^2 + (a(:,2)-b(:,2)).^2);

for i=1:numFrames
    % Get frame
    frame = mov(i);
    slice = rgb2gray(imresize(frame.cdata, 0.25));
    
    % Ignore zero points
    [row, col] = find(slice);
    
    % Triangulate to reduce dimensionality
    tri = delaunayTriangulation(row, col);
    
    % Compute edges and points from triangulation
    e = edges(tri);
    points = tri.Points;
    
    % Calculate radius at which each edge forms
    % R-balls between points A and B intersect when R = 0.5*dist(a,b)
    % That is, when R is half of the distance between A and B
    dists = 0.5 * distfun(points(e(:,1),:), points(e(:,2), :));

    clear tri row col frame slice;
    
    p = (1:length(points(:,1)))';
    numPoints = length(p(:,1));
    numEdges = length(e(:,1));
    sRows = numPoints + numEdges;
    
    %% Generate mfscm matrix
    s = zeros(sRows, 3);
    s(1:numPoints, :) = [p p zeros(size(p))];
    s((numPoints+1):end, :) = [e dists];
    
    %% Calculate persistence of this frame
    [I, J] = rca1mfscm(s, max(s(:,3)));
    
    %% Sort by persistence
    sortOneDim  = sortbypersistence(I);
    sortZeroDim = sortbypersistence(J);
    
    %% Store N most persistent zero/one cycles
    zeroPers(:, 1, i)  = sortZeroDim(1:numPersVals, 1);
    zeroPers(:, 2, i)  = sortZeroDim(1:numPersVals, 2);
    zeroPers(:, 3, i)  = sortZeroDim(1:numPersVals, 3);
    
    onePers(:, 1, i)   = sortOneDim(1:numPersVals, 1);
    onePers(:, 2, i)   = sortOneDim(1:numPersVals, 2);
    onePers(:, 3, i)   = sortOneDim(1:numPersVals, 3);
    
end


end
