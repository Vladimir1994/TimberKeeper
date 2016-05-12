function timber = findTimber(img, estimatorCircles)
    circles = cutCirclesFromImage(img);
  
    timber = [];
   
    for i = 1:numel(circles)
        cutImg = circles(i).cutImg;
        features = computeFeatures(cutImg);
        prediction = predict(estimatorCircles, ...
                             features);
        if prediction
            timber = [timber circles(i)];
        end
    end

    timber = deleteOverlapCircles(timber);
    
    timber = findTimberStackArea(timber);
    

    %% Visualisation.
    visImg(img, timber, 'b');
    
end

