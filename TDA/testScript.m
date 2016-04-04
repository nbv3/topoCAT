%% Test Script to Load and Examine CT Scan Jpegs
% Nicholas von Turkovich

pathHealthy = '/Users/nbv3/Desktop/Math_Projects/topoCAT/ctScans/306/Ct_Lung_Screen__0/unnamed_0/';
filenameHealthy = 'IM-0001-0060.jpg';

pathUnhealthy = '/Users/nbv3/Desktop/Math_Projects/topoCAT/ctScans/321/Ct_Chest_Wo_Contrast__0/unnamed_2/';
filenameUnhealthy = 'IM-0001-0060.jpg';

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

smallerImage = imresize(image,0.125);
smallerImage2 = imresize(image2,0.125);

figure(2)
subplot(2,1,1)
mesh(smallerImage);

subplot(2,1,2)
mesh(smallerImage2);

% processing for image 1

croppedImage = double(smallerImage);

indicesToFloor = find(croppedImage < mean(croppedImage(:)));
croppedImage(indicesToFloor) = 0;

% processing for image 2

croppedImage2 = double(smallerImage2);

indicesToFloor2 = find(croppedImage2 < mean(croppedImage2(:)));
croppedImage2(indicesToFloor2) = 0;

figure(3)
subplot(2,1,1)
imagesc(croppedImage);

subplot(2,1,2)
imagesc(croppedImage2);



% Cropped image ready in uni-valued intensity grayscale
start = tic;
S1 = generateS(croppedImage);
S2 = generateS(croppedImage2);
% 
stop = toc(start)

% compute persistence diagrams

[I, J] = rca1mfscm(S1, 270);
[I2, J2] = rca1mfscm(S2, 270);
figure(4)
subplot(2,1,1)
plotpersistencediagram(I);
title('Healthy');

subplot(2,1,2)
plotpersistencediagram(I2);
title('Unhealthy');

figure(5)
subplot(2,1,1)
plotpersistencediagram(J);
title('Healthy');

subplot(2,1,2)
plotpersistencediagram(J2);
title('Unhealthy');


% figure(4)
% I = sortbypersistence(I)
% plot(I(:,3));