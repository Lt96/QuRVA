%Training a model using several swift images from Bertan
function testSwiftTraining(train)

if ismac
    basePath = '/Volumes/EyeFolder/';
%     basePath = '/Users/javimazzaf/';
elseif isunix
    basePath = '~/';
end

imPath = fullfile(basePath,'Dropbox (Biophotonics)/Deep_learning_Images/OIR/raw/');

maskFiles = dir(fullfile(imPath,'Masks','*.mat'));
maskFiles = {maskFiles(:).name};

allFiles = cellfun(@(x) x(1:end-4),maskFiles,'UniformOutput',false);

if train
    trainPath = fullfile(basePath,'Dropbox (Biophotonics)/Deep_learning_Images/OIR/swift/');

    modelDir = fullfile(basePath, 'Dropbox (Biophotonics)/Deep_learning_Images/OIR/trainingSwift/');
    
    if ~exist(modelDir,'dir')
        mkdir(modelDir);
    end
    
    trainQuRVA(imPath,trainPath,allFiles(1:50),fullfile(modelDir,'trainingSet.mat'),fullfile(modelDir,'model.mat'))
else
    %    processFolder(imPath,allFiles(51:23:end));
%     processFolder(imPath,allFiles(51:end));
     processFolder(imPath,allFiles(1:50));
end
