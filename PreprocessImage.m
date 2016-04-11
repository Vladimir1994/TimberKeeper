function [imgPrerocessed] = preprocessImage(img)
    imgGray = rgb2gray(img);
    
    imgGray = medfilt2(imgGray);
    imgGray = imadjust(imgGray);
    PSF = fspecial('gaussian', 5, 10);
    imgBlurred = imfilter(imgGray, PSF, 'symmetric', 'conv');
    imgPrerocessed = imgBlurred;
end

