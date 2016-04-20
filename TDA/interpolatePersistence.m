function [ interpAnalysis ] = interpolatePersistence( analysis )


% extract the raw zero and one dim persistence data
% each an nxm matrix where n is the number of images in the deck and m is
% the number of saved cycles

interpAnalysis = analysis;

zeroDim = analysis.zeroDim;
oneDim = analysis.oneDim;

zeroSize = size(zeroDim);
oneSize = size(oneDim);

newZeroDim = zeros(1000, zeroSize(2));
newOneDim = zeros(1000, zeroSize(2));

sampleSpanZero = linspace(1,zeroSize(1), 1000);
sampleSpanOne = linspace(1,oneSize(1), 1000);

for i = 1:zeroSize(2)

sampleValuesZero = interp1(1:1:zeroSize(1), zeroDim(:,i), sampleSpanZero);
sampleValuesOne = interp1(1:1:oneSize(1), oneDim(:,i), sampleSpanOne);

newZeroDim(:,i) = sampleValuesZero;
newOneDim(:,i) = sampleValuesOne;

end

interpAnalysis.zeroDim = newZeroDim;
interpAnalysis.oneDim = newOneDim;

end

