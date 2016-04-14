function [] = viewScans( videoStructs )

%% Play entire sequence of videos
hf = figure(2);
set(hf, 'position', [400 400 videoStructs(1).width videoStructs(1).height]);
for i=1:length(videoStructs)
    movie(hf, videoStructs(i).movie, 1, videoStructs(i).framerate);
end
close(hf);
clear hf i mov

end
