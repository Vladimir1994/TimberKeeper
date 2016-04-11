function points = FindWeakTimberInStack(img, chPointsX, chPointsY)   
    points = [];
    for y = floor(min(chPointsY)):10:floor(max(chPointsY))
        for x = floor(min(chPointsX)):10:floor(max(chPointsX))
            if inpolygon(x, y, chPointsX, chPointsY)
                points = [points; [x, y]];
            end
        end
    end
end

