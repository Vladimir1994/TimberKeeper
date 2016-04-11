function [svmModel, kFoldLoss] = TrainSvmIsCircleTimber(features, labels)
    svmModel = fitcsvm(features, labels, 'Standardize', true);
    cvSvmModel = crossval(svmModel);
    kFoldLoss = kfoldLoss(cvSvmModel);
end

