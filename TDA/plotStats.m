function [  ] = plotStats( array )


iter = 1;

for i = 1:length(array)
    data = load(char(array(i)));
    
    index = length(data.p0max2);
    index = linspace(1,100,index);
    
    % Plot p0 first
    
    % Plot p0 max 2
    
    figure(iter)
    subplot(2,2,1)
    plot(index, data.p0max2);
    title(strcat('Max 2 0-cycles for: ', array(i)));
    
    subplot(2,2,2)
    plot(index,data.p0stds);
    title(strcat('0-cycle Stds for: ' , array(i)));
    
    subplot(2,2,3)
    plot(index, data.p1max2);
    title(strcat('Max 2 1-cycles for: ' , array(i)));
    
    subplot(2,2,4)
    plot(index,data.p1stds);
    title(strcat('1-cycle Stds for: ' , array(i)));
    
    iter = iter + 1;



end

