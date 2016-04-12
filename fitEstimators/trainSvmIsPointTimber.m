function [svmModel] = trainSvmIsPointTimber(features, labels)
    svmModel = fitcsvm(features, labels, 'Standardize', true, ...
                       'KernelFunction', 'rbf');
end

