% vids = readScans();
image = rgb2gray((vids(1).movie(125).cdata));
image = double(imresize(image,0.1));
[row, col] = find(image);


del = delaunayTriangulation(row, col);
E = edges(del);
points = del.Points;
newMat = zeros(length(points), length(points));
% 
% E = edges(del);
% 
% points = del.Points;

x = 1:1:length(points);
y = zeros(1,length(points));
sPoints = horzcat(x', x', y');

sEdges = [];

for k = 1:length(E)
    elem = E(k,:);
    firstPointIndex = elem(1);
    secondPointIndex = elem(2);
    firstPoint = points(firstPointIndex, :);
    secondPoint = points(secondPointIndex, :);
    
    distance = dist(firstPoint, secondPoint');
    row = [firstPointIndex, secondPointIndex, distance];
    
    sEdges = [sEdges; row];
    
    
end

sMat = vertcat(sPoints, sEdges);



distanceBound = max(sMat(:,3));

init;
[I, J] = rca1mfscm(sMat,distanceBound);



p1lifetime = I(:,2) - I(:,1);
p1lifetime = sort(p1lifetime, 'descend');
currp1Max2 = [p1lifetime(1) p1lifetime(2)];

p1max2 = horzcat(p1max2, currp1Max2');
%         p1lifetimes = horzcat(p1lifetimes, p1lifetime);
p1stds = horzcat(p1stds, std(p1lifetime));
p1means = horzcat(p1means, mean(p1lifetime));

p0lifetime = J(:,2) - J(:,1);
p0lifetime = sort(p0lifetime, 'descend');
currp0Max2 = [p0lifetime(1) p0lifetime(2)];

p0max2 = horzcat(p0max2, currp0Max2');
%         p0lifetimes = horzcat(p0lifetimes, p0lifetime);
p0stds = horzcat(p0stds, std(p0lifetime));
p0means = horzcat(p0means, mean(p0lifetime));




index = linspace(1,100,j);
% filename = strcat(filename, '.mat');
% save(char(filename), 'p1max2', 'p1stds', 'p1means', 'p0max2', 'p0stds', 'p0means', 'index');

