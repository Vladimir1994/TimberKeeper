function [circles] = FindTimberStackArea(circles)
    addpath('dbscan/');
    
    [idx n] = dbscanCircles(circles, 2);
    clusterSize = sum(idx == 0);
    clusterSizes = clusterSize;
    counter = 1;
    while clusterSize ~= 0
        clusterSize = sum(idx == counter);
        counter = counter + 1;
        clusterSizes = [clusterSizes, clusterSize];
    end
    [~, argmax] = max(clusterSizes);
    biggestCluster = argmax - 1;
    circles = circles(idx == biggestCluster);
end

