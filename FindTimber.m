function [timber] = FindTimber(img, estimator)

    circles = CutCirclesFromImage(img);
    
    timber = [];
   
    for i = 1:numel(circles)
        cutImg = circles(i).cutImg;
        features = ComputeFeatures(cutImg);
        prediction = predict(estimator, ...
                             features);
        if (prediction)
            timber = [timber circles(i)];
        end
    end
  
    %chPointsX = []; 
    %chPointsY = [];
    timber = DeleteOverlapCircles(timber);
    [timber, chPointsX, chPointsY] = FindTimberStackArea(timber);
    
    %% Visualisation.
    VisImg(img, timber, chPointsX, chPointsY, 'b');
end

