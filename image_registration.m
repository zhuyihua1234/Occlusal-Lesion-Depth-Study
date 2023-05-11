reflectance = imread('b4_1300_BP1550_OPR 22.tif');
transillumination = imread('b4_1450_BP1550_OPR 22.tif');
%resize the images
resize_ref = imresize(reflectance,[500 500])
resize_trans = imresize(transillumination,[500 500])
imwrite(resize_ref,'ref.tiff');
imwrite(resize_trans,'trans.tiff');
cpselect(resize_ref,resize_trans);
pause;
%apply affine transformation
tform = cp2tform(input_points, base_points, 'affine');
%register the the reflectance image with affine transformation
registered = imtransform(resize_ref, tform);
%shift the reflectance image
meanbase = mean(base_points);
meaninput = mean(input_points);
ref_reg = imtranslate(registered,[meanbase - meaninput]);
targetSize = [500 500];
win1 = centerCropWindow2d(size(ref_reg),targetSize);
ref_final = imcrop(ref_reg,win1);
imwrite(ref_final,'final.tiff');
%generate fusion image
ref_dual = 0.5*ref_final;
trans_dual = resize_trans*0.5;
dual_img = ref_dual + trans_dual;
imshow(dual_img);
imwrite(dual_img,'dual_mode.tiff');
