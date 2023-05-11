%This program reads image average intensity inside 3 selected ROIs
%This program only works with Image Labeler addon
%Load TIF image with Image Labeler
%Use ROI label to create 3 lesion ROIs (l1,l2,l3)
%Export the session into both a file and workspace (GroundTruth)
%Written by Yihua Zhu

filepath = string(gTruth.DataSource.Source);
img = imread(filepath);
grayimg = rgb2gray(img);

l1 = cell2mat(gTruth.LabelData.l1);
l2 = cell2mat(gTruth.LabelData.l2);
l3 = cell2mat(gTruth.LabelData.l3);

img_l1 = imcrop(grayimg,l1);
img_l2 = imcrop(grayimg,l2);
img_l3 = imcrop(grayimg,l3);

mean_l1 = mean2(img_l1);
mean_l2 = mean2(img_l2);
mean_l3 = mean2(img_l3);

fprintf('l1 = %f\n', mean_l1);
fprintf('l2 = %f\n', mean_l2);
fprintf('l3 = %f\n', mean_l3);

