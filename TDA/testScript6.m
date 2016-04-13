%% Batch Test: Multiple Scans and Different Metrics Tested
% Patiens: Nodules:
% Patient: nodule count: num slides
% 306: 0: 123
% 101: 8
% 571: 5
% 1005: 20
% 321: 23
% Batch2
% 866: 29
% 713: 16
% 573: 0
% 694: 2

init;
path694 = '/Users/nbv3/Desktop/Math_Projects/topoCAT/ctScans/batch2/694/Ct_Lung_Screen__0/unnamed_0';
num694 = 137;
path573 = '/Users/nbv3/Desktop/Math_Projects/topoCAT/ctScans/batch2/573/Ct_Lung_Screen__0/unnamed_0';
num573 = 127;
path713 = '/Users/nbv3/Desktop/Math_Projects/topoCAT/ctScans/batch2/713/Unnamed__0/ThoraxRoutine_30_B31s_5183';
num713 = 116;
path866 = '/Users/nbv3/Desktop/Math_Projects/topoCAT/ctScans/batch2/866/Ct_Chest_O_Contr__0/unnamed_0';
num866 = 241;
path306 = '/Users/nbv3/Desktop/Math_Projects/topoCAT/ctScans/batch1/306/Ct_Lung_Screen__0/unnamed_0';
num306 = 123;
path101 = '/Users/nbv3/Desktop/Math_Projects/topoCAT/ctScans/batch1/101/Unnamed__0/ThoraxRoutine_30_B31s_3192';
num101 = 150;
path571 = '/Users/nbv3/Desktop/Math_Projects/topoCAT/ctScans/batch1/571/Ct_Lung_Screen__0/unnamed_0';
num571 = 121;
path1005 = '/Users/nbv3/Desktop/Math_Projects/topoCAT/ctScans/batch1/1005/Unnamed__0/unnamed_3000657';
num1005 = 312;
path321 = '/Users/nbv3/Desktop/Math_Projects/topoCAT/ctScans/batch1/321/Ct_Chest_Wo_Contrast__0/unnamed_2';
num321 = 265;

paths = {path306, path101, path571, path1005, path321, path694, path573, path713, path866};
slideCounts = [num306 num101 num571 num1005 num321 num694 num573 num713 num866];
filenames = {'306', '101', '571', '1005', '321', '694', '573', '713', '866'};

iter = 1;

for i = 1:length(paths)
    filename = filenames(iter);
    p1stds = [];
    p1lifetimes = [];
    p1means = [];
    p1max2 = [];
    p0stds = [];
    p0lifetimes = [];
    p0means = [];
    p0max2 = [];
    
    
    for j = 1:2:slideCounts(i)
        string = '';

        if j < 10
            string = sprintf('000%d', j);
        end

        if j >= 10 && j < 100
            string = sprintf('00%d',j);
        end

        if j >= 100
            string = sprintf('0%d',j);
        end
        
        file = strcat('/IM-0001-', string , '.jpg');
        toRead = char(strcat(paths(i), file));
        image = rgb2gray(imread(toRead));
        image = double(imresize(image,0.1));
        [row col] = find(image);
        intensities = [];

        for k = 1:length(row)
            intensities = vertcat(intensities, smallerImage(row(k),col(k)));
        end
        
        
        
        del = delaunayTriangulation(row, col, intensities);
        E = edges(del);
        points = del.Points;
        newMat = zeros(length(points), length(points));
  
        E = edges(del);

        points = del.Points;

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
        
        

    end
    index = linspace(1,100,j);
    filename = strcat(filename, '.mat');
    save(char(filename), 'p1max2', 'p1stds', 'p1means', 'p0max2', 'p0stds', 'p0means', 'index');
    
    iter = iter + 1;
    
end
