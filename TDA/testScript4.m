%% Test4: Cloudy Lungs
% Nicholas von Turkovich

imageNum = 131;

p0 = [];
p1 = [];
pathHealthy = '/Users/nbv3/Desktop/Math_Projects/topoCAT/ctScans/84/Unnamed__0/unnamed_3211';




 for i = 1:5:imageNum
     
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

    % Need to condense the image

    smallerImage = imresize(image,0.0625);


    xcropAmount = 5;
    xstartCrop = xcropAmount;
    xendCrop = length(smallerImage) - xcropAmount;

    ycropAmount = 5;
    ystartCrop = ycropAmount;
    yendCrop = length(smallerImage) - ycropAmount;

    croppedImage = double(smallerImage(xstartCrop:xendCrop, ystartCrop:yendCrop));


    m = mean2(croppedImage);

    indicesToFloor = find(croppedImage < m);
    croppedImage(indicesToFloor) = 0;
    
    figure(1)
    imagesc(croppedImage);


    % compute topology features on a cloud composed of the nonzero 2D vertices

    [row col] = find(croppedImage);

    cloud = [row col];

    distances = pdist(cloud);

    dmat = squareform(distances);

    distanceBound = max(distances);

    init;
    [I, J] = rca1dm(dmat,distanceBound*0.2);
    
    p0 = horzcat(p0, std(J(:,2)));
    p1 = horzcat(p1, std(I(:,2)));
    

 end
