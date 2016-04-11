%% Test3: Clear Lungs
% Nicholas von Turkovich
clear;


imageNum = 123;

pers0 = [];
pers1 = [];
pathHealthy = '/Users/nbv3/Desktop/Math_Projects/topoCAT/ctScans/306/Ct_Lung_Screen__0/unnamed_0';

index = [];

 for i = 1:10:imageNum
     
    i
    
    string = '';
    
    if i < 10
        string = sprintf('000%d', i);
    end
    
    if i >= 10 && i < 100
        string = sprintf('00%d',i);
    end
    
    if i >= 100
        string = sprintf('0%d',i);
    end
    
    
    filenameHealthy = strcat('/IM-0001-', string , '.jpg');

    image = rgb2gray(imread([pathHealthy filenameHealthy]));

    croppedImage = double(imresize(image,0.04));

    [row col] = find(croppedImage);

    cloud = [row col];

    distances = pdist(cloud);

    dmat = squareform(distances);

    distanceBound = max(distances);

    init;
    [I, J] = rca1dm(dmat,distanceBound*0.2);
    
    pers0 = horzcat(pers0, std(J(:,2)));
    pers1 = horzcat(pers1, std(I(:,2)));
    index = horzcat(index, i);
 end
 
 figure(1)
 plot(index, pers1, 'o');
 
 
 
