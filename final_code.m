clc;
clear all;
close all;
%read input image of handwritten text
I = imread('E:\BE_PROJECT\Input_Images\IMG_45.jpg');
imshow(I);
title('Input image of handwritten text');
% RGB to gray image conversion
I=rgb2gray(I);  
lap = [1 1 1; 1 -8 1; 1 1 1];    %laplacian filter
resp = uint8(filter2(lap, I, 'same'));
I= imsubtract(I, resp);
I = imadjust(I);

%Convert to binary image and calculate global threshold
threshold = graythresh(I);
I=~imbinarize(I,threshold);
I=imresize(I,[1000 1000]);

% Remove all object containing fewer than 30 pixels
 I = bwareaopen(I,10);
 pause(1);
figure;imshow(I);
 
%calculate horizontal and vertical profile of the image
 horizontalProjection = mean(I, 2);
verticalProjection = mean(I, 1);
 figure; barh( horizontalProjection);title('horizontal profile of image');
 
 %segment the lines from image
 nonzero=zeros(1,1000);
 horizontalProjection=horizontalProjection.*100;
for i=1:1000
if horizontalProjection(i,1)<1.8
    nonzero(1,i)=0;  
else
     nonzero(1,i)=1;
end
end
j=1;
for i=1:999
if (nonzero(1,i+1) ~= 0)&&(nonzero(1,i) == 0)
    arrzero(1,j)=i+1;  
    j=j+1;
end
end
j=1;
for i=1:999
if (nonzero(1,i+1) == 0)&&(nonzero(1,i) ~= 0)
    arrzero1(1,j)=i;  
    j=j+1;
end
end

% figure;
%for loop for line segmentation
for i=1:length(arrzero1)
   I1=I((arrzero(i):arrzero1(i)),:); 
   I1=imresize(I1,[1000 1000]);
%   subplot(5,1,i);imshow(I1);
%    baseFileName = sprintf('image %d.png',i);
% %save individual words into specific folder
% fullFileName = fullfile('E:\BE_PROJECT\wordscollect', baseFileName);
% imwrite( I1, fullFileName);

%vertical projection of line
verticalProjection1 = mean(I1, 1);
figure; bar(verticalProjection1);

%segment words from line
nonzero1=zeros(1,1000);
verticalProjection1=verticalProjection1.*100;
for k=1:1000
if verticalProjection1(1,k)<0.5
    nonzero1(1,k)=0;  
else
     nonzero1(1,k)=1;
end
end

j=1;
for k=1:999
if (nonzero1(1,k+1) ~= 0)&&(nonzero1(1,k) == 0)
    arrzero10(1,j)=k+1;  
    j=j+1;
end
end

h=1;
for k=1:999
if (nonzero1(1,k+1) == 0)&&(nonzero1(1,k) == 1)
    arrzero11(1,h)=k;  
    h=h+1;
end
end

%for loop for word segmentation
% figure;
for c=1:length(arrzero11)
%    figure;
   I2=I1(:,(arrzero10(c):arrzero11(c)));
   I2=imresize(I2,[1000 1000]);
   I2=~I2;
%   subplot(1,6,p);imshow(I2);
    baseFileName = sprintf('image_%d%d.jpg',i,c);

%save individual words into specific folder
fullFileName = fullfile('E:\BE_PROJECT\wordscollect', baseFileName);
imwrite( I2, fullFileName);




%%letter segment

end     %loop end for word segment
  
getnum=length(arrzero1);
getimgnum(i)=length(arrzero11);
%  I1=I((arrzero(1):arrzero1(1)),:); 
%  figure;imshow(I1);

end %loop end for line segment


