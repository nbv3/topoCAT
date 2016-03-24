function [ sMat ] = generateS( mat )

% This function performs triangulation and generates S matrix

dim = size(mat);
dim = dim(1);
numPixels = dim^2;

% below is the vertex row array for the S matrix, initialized
vertices = zeros(numPixels, 3);

% filling the vertices array with each pixel of mat
for i = 1:numPixels
    vertexRow = [i, i, mat(i)];
    vertices(i,:) = vertexRow; 
end

% now have all the vertex rows that contain their filtration values
% (intenisty vals)

% find the edge rows

edges = [];
edgeRelations = [1 dim (dim + 1)];



% iterate through all points

for i = 1:numPixels
    
    % generate all the possible edge pairs (not lower left and upper right
    % diagonals)
    
    for j = 1:length(edgeRelations)
        neighborIndex = i + edgeRelations(j);
        if neighborIndex < 1 || neighborIndex > numPixels
            continue;
        end
        newEntry = [i, neighborIndex, max(mat(i), mat(neighborIndex))];
        edges = [edges; newEntry]; 
    end
    
end

sMat = vertcat(vertices, edges);



end



