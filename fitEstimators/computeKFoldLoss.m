function kFoldLoss = computeKFoldLoss(model)
    cvSvmModel = crossval(model);
    kFoldLoss = kfoldLoss(cvSvmModel);
end

