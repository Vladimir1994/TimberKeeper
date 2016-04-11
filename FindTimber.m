function timber = findTimber(img, estimator)
    circles = CutCirclesFromImage(img);
    
    timber = [];
   
    for i = 1:numel(circles)
        cutImg = circles(i).cutImg;
        features = ComputeFeatures(cutImg);
        prediction = predict(estimator, ...
                             features);
        if prediction
            timber = [timber circles(i)];
        end
    end
  
    timber = DeleteOverlapCircles(timber);
    [timber, chPointsX, chPointsY] = FindTimberStackArea(timber);
    points = findWeakTimberInStack(img, chPointsX, chPointsY);
    
    %% Visualisation.
    VisImg(img, timber, chPointsX, chPointsY, points, 'b');
    
end

