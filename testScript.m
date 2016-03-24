%% Test Script to Load and Examine CT Scan Jpegs
% Nicholas von Turkovich

path = '/Users/nbv3/Desktop/Math_Projects/LIDC-IDRI/Unnamed/Unnamed__0/unnamed_3000563/';
filename = 'IM-0001-0080.jpg';

image = rgb2gray(imread([path filename]));
cropAmount = 499;
startCrop = cropAmount;
endCrop = length(image) - cropAmount;

croppedImage = double(image(startCrop:endCrop, startCrop:endCrop));

indicesToFloor = find(croppedImage < 120);
croppedImage(indicesToFloor) = 0;

figure(1)
mesh(croppedImage);


% Cropped image ready in uni-valued intensity grayscale
start = tic;
S = generateS(croppedImage);
stop = toc(start);

stop

% compute persistence diagrams

[I, J] = rca1mfscm(S, 270);

