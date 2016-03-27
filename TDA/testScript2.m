%% Test2
% Nicholas von Turkovich

pathHealthy = '/Users/nbv3/Desktop/Math_Projects/topoCAT/ctScans/306/Ct_Lung_Screen__0/unnamed_0';
filenameHealthy = '/IM-0001-0070.jpg';

pathUnhealthy = '/Users/nbv3/Desktop/Math_Projects/topoCAT/ctScans/0571/Ct_Lung_Screen__0/unnamed_0';
filenameUnhealthy = '/IM-0001-0070.jpg';

image = rgb2gray(imread([pathHealthy filenameHealthy]));
image2 = rgb2gray(imread([pathUnhealthy filenameUnhealthy]));

figure(1)
subplot(2,1,1)
imagesc(image);
title('healthy');
colormap gray
subplot(2,1,2)
imagesc(image2);
title('unhealthy');
colormap gray

% Need to condense the image

smallerImage = imresize(image,0.0625);
smallerImage2 = imresize(image2,0.0625);

figure(2)
subplot(2,1,1)
mesh(smallerImage);

subplot(2,1,2)
mesh(smallerImage2);

% processing for image 1
xcropAmount = 10;
xstartCrop = xcropAmount;
xendCrop = length(smallerImage) - xcropAmount;

ycropAmount = 1;
ystartCrop = ycropAmount;
yendCrop = length(smallerImage) - ycropAmount;

croppedImage = double(smallerImage(xstartCrop:xendCrop, ystartCrop:yendCrop));

indicesToFloor = find(croppedImage < 30);
croppedImage(indicesToFloor) = 0;

% processing for image 2
xcropAmount = 5;
xstartCrop = xcropAmount;
xendCrop = length(smallerImage2) - xcropAmount;

ycropAmount = 5;
ystartCrop = ycropAmount;
yendCrop = length(smallerImage2) - ycropAmount;

croppedImage2 = double(smallerImage2(xstartCrop:xendCrop, ystartCrop:yendCrop));

indicesToFloor2 = find(croppedImage2 < 30);
croppedImage2(indicesToFloor2) = 0;

figure(3)
subplot(2,1,1)
imagesc(croppedImage);

subplot(2,1,2)
imagesc(croppedImage2);

% compute topology features on a cloud composed of the nonzero 2D vertices

[row col] = find(croppedImage);
[row2 col2] = find(croppedImage2);

figure(4)
subplot(2,1,1);
plot(row, col, 'k.');

subplot(2,1,2);
plot(row2, col2, 'k.');


cloud = [row col];
cloud2 = [row2 col2];

distances = pdist(cloud);
distances2 = pdist(cloud2);

dmat = squareform(distances);
dmat2 = squareform(distances2);

distanceBound = max(distances);
distanceBound2 = max(distances2);

init;
[I, J] = rca1dm(dmat,distanceBound*0.25);
[I2, J2] = rca1dm(dmat2, distanceBound2*0.25);

figure(5)
subplot(2,1,1)
plotpersistencediagram(J);
title('Dgm_{0} for Clear Lungs');
xlabel('Birth');
ylabel('Death');

subplot(2,1,2)
plotpersistencediagram(J2);
title('Dgm_{0} for Cloudy Lungs');
xlabel('Birth');
ylabel('Death');

figure(6)
subplot(2,1,1)
plotpersistencediagram(I);
title('Dgm_{1} for Clear Lungs');
xlabel('Birth');
ylabel('Death');

subplot(2,1,2)
plotpersistencediagram(I2);
title('Dgm_{1} for Cloudy Lungs');
xlabel('Birth');
ylabel('Death');







