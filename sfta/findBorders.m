function Im = findBorders(I)
    Im = false(size(I));
    
    I = padarray(I, [1, 1], 1);
    [h, w] = size(Im);
    
    bkgFound = false;
    for row = 1 : h
        for col = 1 : w
            if I(row + 1, col + 1)
                bkgFound = false;
                for i = 0:2
                    for j = 0:2
                        if ~I(row + i, col + j)
                            Im(row, col) = 1;
                            bkgFound = true;
                            break;
                        end;
                    end;
                    if bkgFound
                        break;
                    end;
                end;
            end;
        end;
    end;
end

