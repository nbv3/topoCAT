function [ vec ] = extractVector( profile )

% generate the vector of values to be used by classifier

raw1 = profile.oneDim;
raw0 = profile.zeroDim;

% oneDim and zeroDim are necessarily the same dimension
[row col] = size(profile.oneDim);

% 1000 rows and 15 columns (15 cycles)

% meanVals = mean(profile.oneDim);
% maxVals = max(profile.oneDim);
% minVals = min(profile.oneDim);
% stdVals = std(profile.oneDim);


vec = diff(profile.oneDim(:,1)');


% vec = horzcat(meanVals(1:5), maxVals(1:5), minVals(1:5), stdVals(1:5));



end

