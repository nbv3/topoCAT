function [ vec ] = extractVector( profile )

% generate the vector of values to be used by classifier

raw1 = profile.oneDim;
raw0 = profile.zeroDim;

vec1 = raw1(:);
vec0 = raw0(:);

vec = horzcat(vec0', vec1');

end

