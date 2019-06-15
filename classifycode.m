clc;
clear all;
close all;

%include folder as dataset to train the network
ds = imageDatastore('E:\BE_PROJECT\dataset22598','IncludeSubfolders',true,'LabelSource','foldernames');
numClasses = numel(categories(ds.Labels));

%load pretrained network
net = alexnet;

%modify layers f the network
layers = net.Layers;
layers(end-2) = fullyConnectedLayer(numClasses);
layers(end) = classificationLayer;

  %decide learning rate 
 options = trainingOptions('sgdm','InitialLearnRate', 0.001);
 disp( options);
 
 %train new network as per our requirement
 [newnet,info] = trainNetwork(ds, layers, options);
save('E:\BE_PROJECT\trained_net1.mat','newnet');
