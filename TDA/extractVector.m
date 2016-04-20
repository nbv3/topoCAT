function [ featureVector ] = extractVector( profile )

% profile is struct: id, patientDiagnosis, numframes, zeroDim (mxn), oneDim
% (mxn)

pid = profile.id;
patientDiagnosis = profile.diagnosis;

% generate the vector of values to be used by classifier

raw1 = profile.oneDim;
raw0 = profile.zeroDim;

vec1 = raw1(:);
vec0 = raw0(:);

vec = horzcat(vec0', vec1');
vecLength = length(vec);



featureVector = struct('id',        pid, ...                
                 'diagnosis',  patientDiagnosis, ...
                 'vector',  vec, 'vectorLength', vecLength);


end

