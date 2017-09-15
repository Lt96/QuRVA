function createModelWithMixedDataSets

readConfig

swiftVars = load(fullfile('../', 'trainingSetSwift.mat'),'data','res');

our20Vars = load(fullfile('../', 'trainingSet20ours.mat'),'data','res');

data = [swiftVars.data;our20Vars.data];
res = [swiftVars.res;our20Vars.res];

model = fitcdiscr(data,res,'DiscrimType','quadratic','Cost',tufts.classCost,'Prior','empirical');

save('model.mat','model','-v7.3')
save('/Volumes/EyeFolder/flatMounts/development/model.mat','model','-v7.3')