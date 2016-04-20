function [ videoStructs ] = readScans(path)
% Compute topology on each frame of a sequence of CT scan slides. Track how
% topology changes as we move vertically upwards through the lung. This
% sequence of statistics on the topology of the volumetric scan will be
% used to compute features for classification and regression.

%% Get video directory
vids = dir([path, '\*.avi']);

videoStructs = struct('ID', 0, 'framerate', 0, 'movie', [], 'width', 0, 'height', 0);

for i=1:length(vids)
    fprintf('Patient %s ', vids(i).name(1:end-4));
    vidFile = strcat(path, vids(i).name);
    vidReader = VideoReader(vidFile);
    vidFrames = read(vidReader);
    framerate = vidReader.FrameRate;
    numFrames = get(vidReader, 'NumberOfFrames');
    w = vidReader.Width;
    h = vidReader.Height;
    
    videoStructs(i).ID = uint8(str2double(vidFile(end-7:end-4)));
    videoStructs(i).framerate = framerate;
    videoStructs(i).width = w;
    videoStructs(i).height = h;
    mov = struct('cdata', zeros(size(vidFrames(1))), 'colormap', zeros(1, numFrames));
    %% Read frames from current video file
    percent = 0;
    for k=1:numFrames
        mov(k).cdata = vidFrames(:,:,:, k);
        mov(k).colormap = [];
        percent = percent + 1./numFrames;
        if percent > 0.1
            fprintf('.');
            percent = 0;
        end
    end
    fprintf(' Done\n');
    videoStructs(i).movie = mov;
    
end

clear vidFile vidReader vidFrames framerate numFrames w h vids path percent dirname scantype slide i k ans