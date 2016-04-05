function [timber, notTimber] = FindTimber(img, estimator)

    circles = CutCirclesFromImage(img);
    
    timber = [];
    notTimber = [];
    
    for i = 1:numel(circles)
        cutImg = circles(i).cutImg;
        metric = circles(i).metric;
        features = ComputeFeatures(cutImg);
        prediction = predict(estimator, ...
                             features);
        if(prediction)
            timber = [timber circles(i)];
        else
            notTimber = [notTimber circles(i)];
        end
    end
    
    timber = DeleteOverlapCircles(timber);
    timber = FindTimberStackArea(timber);
    
    %% Visualisation.
    VisImg(img, timber, 'b');
end

