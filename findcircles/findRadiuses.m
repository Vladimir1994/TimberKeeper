function r_estimated = findRadiuses(centers, accumMatrix, radiusRange)
%% Check if accumulator array is complex
if (isreal(accumMatrix))
    warning(message('images:imfindcircles:realAccumArrayForPhaseCode'));
end

%% Decode the phase to get the radius estimate
cenPhase = angle(accumMatrix(sub2ind(size(accumMatrix), ...
                 round(centers(:, 2)), round(centers(:, 1)))));
lnR = log(radiusRange);
r_estimated = exp(((cenPhase + pi) / (2 * pi) * ...
              (lnR(end) - lnR(1))) + lnR(1)); 

end