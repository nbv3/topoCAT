% analyzePatient.m
% INPUT
% ctVid              VideoStruct returned from readScans(dir, ext);
% patientDiagnosis   integer label (0 = healthy, 1 = cancer)
% N                  retain the N most-persistent 0/1 dim intervals
% 
% OUTPUT
% analysis           Struct with ID, diagnosis, and top N% 0/1 dim persistence
function [analysis] = analyzePatient(ctVid, patientDiagnosis, N)

pid = ctVid.ID;
mov = ctVid.movie;

numFrames = length(mov);

analysis = struct('id',        pid, ...                
                 'diagnosis',  patientDiagnosis, ...
                 'numFrames',  numFrames, ...
                 'zeroDim',    zeros(numFrames, N), ...
                 'oneDim',     zeros(numFrames, N) );
             
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
    
    analysis.zeroDim(i, 1:N) = sortZeroDim(1:N, 3)';
    analysis.oneDim (i, 1:N) = sortOneDim (1:N, 3)';
     
end



end
