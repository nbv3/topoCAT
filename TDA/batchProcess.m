%% Total Study
clear;
videoStructs = readScans('../Videos/', 'avi');

nodeCounts = csvread('../nodeCounts.csv');
names = nodeCounts(:,1);
numNodes = nodeCounts(:,2);

numPatients = length(videoStructs);

dataSet = cell(1,numPatients);


for i = 1:numPatients
    
   index = find(names == videoStructs(i).ID);
    
   profile = analyzePatient(videoStructs(i), numNodes(index), 4);
   
   interpProfile = interpolatePersistence(profile);
   
   featureVector = extractVector(interpProfile);
   
   dataSet(i) = featureVector;
   
   
   
end


