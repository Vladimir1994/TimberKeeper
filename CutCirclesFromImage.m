function [circles] = CutCirclesFromImage(img)
    minrad = 20;
    maxrad = 80;
    HoughSens = .965;
    HoughEdgeThreshold = 0.1;
      
    [imgPrerocessed] = PreprocessImage(img);
    
    addpath('findcircles/');
                                                  
   [centers, radiuses, metrics] = findCircles(imgPrerocessed, ...
                                                [minrad, maxrad], ...
                                                 HoughEdgeThreshold, ...
                                                'bright', ...
                                                 HoughSens);
    
    circles = struct('center', num2cell(centers, 2), ...
                     'radius', num2cell(radiuses), ...
                     'metric', num2cell(metrics));

    imgSize = size(img);
    imgHeight = imgSize(1);
    imgWidth = imgSize(2);
    
    for i = 1:length(centers)      
        left = floor(max(centers(i, 1) - radiuses(i), 1));
        right = floor(min(centers(i, 1) + radiuses(i), imgWidth));
        top = floor(max(centers(i, 2) - radiuses(i), 1));
        bottom = floor(min(centers(i, 2) + radiuses(i), imgHeight));
        
        cutImg = img(top:bottom, left:right, :); 
        circles(i).cutImg = cutImg; 
    end
end

