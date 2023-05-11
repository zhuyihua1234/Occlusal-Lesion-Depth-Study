%Load multiwavelength images
raw_img1300 = load('38_1300_BP1550_OPR 22.dat')
raw_img1450 = load('38_1450_BP1550_OPR 22.dat')
%Image conversion to 16-bit
img1300 = uint16(raw_img1300*16);
img1450 = uint16(raw_img1450*16);
%Image subtraction to generate fusion image
img_fusion = img1450 - img1300;
%Flip image to match microCT
img_fusion = flip(img_fusion,2);
%clear memory
clear raw_img1300;
clear raw_img1450;
clear img1300;
clear img1450;
%Crop image
I = img_fusion
imshow(I)
h = imfreehand; % Place a closed ROI by dragging and double-click on the region.
position = round(wait(h));
min_values = min(position,[],1);
max_values = max(position,[],1);
Inew = I(min_values(2):max_values(2),min_values(1):max_values(1),:);
[X1,X2] = meshgrid(1:size(Inew,2),1:size(Inew,1));
in = inpolygon(X1,X2,position(:,1)-min_values(1)+1,position(:,2)-min_values(2)+1);
in =repmat(in,1,1,size(I,3));
Inew(~in) = 0; % If I is uint
%Normalize Fusion Image
norm_fusion = mat2gray(Inew);
%Display 3D surface profile
surf(norm_fusion);

