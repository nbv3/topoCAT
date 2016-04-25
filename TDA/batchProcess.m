%% Total Study
clear; clc;

path = '../Videos/good/';
ext = 'avi';
vids = dir([path, strcat('*.', ext)]);

% videoStructs = readScans('../Videos/', 'avi');

nodeCounts = csvread('../nodeCounts.csv');
names = nodeCounts(:,1);
numNodes = nodeCounts(:,2);
numPatients = length(vids);
dataSet = struct('id', [], 'features', [], 'label', []);
dataSet = repmat(dataSet, [1 length(vids)]);


for i = 32:numPatients
    % Get patient video
    patientScan = readScans(strcat(path, vids(i).name));
    % Find patient diagnosis (ie. node count)
    patientIndex = (names == patientScan.id);
    patientNodeCount = numNodes(patientIndex);
    
    % Extract 4 most persistent topological features from CT scan
    profile = analyzePatient(patientScan, patientNodeCount, 15);
    % Interpolate data
    interpProfile = interpolatePersistence(profile);
    
    save('./temp.mat', 'interpProfile')
    movefile('temp.mat', sprintf('../topoData/%s.mat', num2str(patientScan.id)))
    
%     % Extract regression features
%     
%     
%     featureVector = extractVector(interpProfile);
%     
%     dataSet(i).id       = profile.id;
%     dataSet(i).features = featureVector;
%     dataSet(i).label    = patientNodeCount;
    
    clear patientScan patientIndex patientNodeCount profile interpProfile
    
end


