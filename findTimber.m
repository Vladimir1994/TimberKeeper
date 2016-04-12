function timber = findTimber(img, estimator)
    circles = cutCirclesFromImage(img);
    
    timber = [];
   
    for i = 1:numel(circles)
        cutImg = circles(i).cutImg;
        features = computeFeatures(cutImg);
        prediction = predict(estimator, ...
                             features);
        if prediction
            timber = [timber circles(i)];
        end
    end
  
    timber = deleteOverlapCircles(timber);
    [timber, chPointsX, chPointsY] = findTimberStackArea(timber);
    points = [];
    
    %% Visualisation.
    visImg(img, timber, chPointsX, chPointsY, points, 'b');
    
end

