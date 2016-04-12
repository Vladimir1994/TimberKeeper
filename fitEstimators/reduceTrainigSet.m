function [features, labels] = reduceTrainigSet(features, labels, newSize)
    if length(features) < newSize
        error('Set length must be bigger than newSize')
    end
    
    rs = randsample(length(features), newSize);
    features = features(rs, :);
    labels = labels(rs);
end

