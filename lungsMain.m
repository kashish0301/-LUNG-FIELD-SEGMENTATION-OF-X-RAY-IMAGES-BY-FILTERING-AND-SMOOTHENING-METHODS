%clc;
clear all
close all;
addpath('support');
cd IMAGES
[J,P]=uigetfile('.bmp','select the source Image');
cd ..
inputCXR=imread(strcat(P,J));
if size(inputCXR,3)>1
    inputCXR=rgb2gray(inputCXR);
end
%====
%load SED model
opts.trnGtDir = 'trnfold1';
opts.modelFnm = strcat('model_', opts.trnGtDir);
model = edgesTrain_CXRLungfield( opts );
%settings for SED prediction
model.opts.multiscale = 0;          
model.opts.sharpen = 0;            
model.opts.nTreesEval = 4;          
model.opts.nThreads = 4;      
model.opts.useParfor = 1;
model.opts.superpixel = 'mwt';  
model.opts.ribcageMasked = 1;
%====
tic;
%perform SEDUCM procedure for lung segmention
for iter=1:10
    [lungMask, boundaryMap, ucmMap, ~, ~] = sed_seg(inputCXR, model);
end
segTime = toc;
fprintf('size of input CXR: %d x %d\n', size(inputCXR,1), size(inputCXR,2));
fprintf('average running time of SEDUCM for one CXR: %2.4f second. \n', segTime/10);

figure,imshow(inputCXR);title('input Image');
figure,imshow(1-boundaryMap);title('SED Boundary Map');
%figure,imshow(inputCXR);hold on;contour(ucmMap,'r');title('With UCM contour');