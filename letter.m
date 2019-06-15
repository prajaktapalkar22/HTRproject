clear all;
% character segmentation
 load ('E:\BE_PROJECT\trained_net.mat');
 getnum=3;
 getimgnum=[5 6 6 ];
 for m=1:getnum
     for n=1:getimgnum(m)
        
         baseFileName = sprintf('image_%d%d.jpg',m,n);

fullFileName = fullfile('E:\BE_PROJECT\wordscollect', baseFileName);
I1=imread( fullFileName);
%  figure;imshow(I1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% lap = [1 1 1; 1 -8 1; 1 1 1];
% resp = uint8(filter2(lap, I1, 'same'));
% I= imsubtract(I1, resp);
% J = imadjust(I);
% threshold = graythresh(J);
% J=imbinarize(J,threshold);
% 
%  J = bwareaopen(J,10);
%  pause(1);
 p=zeros(1,300);

 
 
 
 
 J=imresize(I1,[300,300]);
%    figure;  imshow(J);   

  [r1, c1]=size(J);
 for i=1:r1
     count=0;
     for j=1:c1
     if J(i,j)==0
         count=count+1;
     end
     end
 y=0.7*c1;
     if count >= y
         p(1,i)=i;
         J(i,:)=1;
     end    
 
 end
 for k=1:15
J= medfilt2(J);
 end
% J=imresize(J,[300,300]);
 maxnum=max(p(1,:));
  minnum=min(p(p(1,:)>0));
% imshow(I); title('Original image');
%  figure;  imshow(J); 
J1=J(1:minnum-15,:);
J2=J(maxnum+15:300,:);
newImg = cat(1,J1,J2);
% imshow(newImg);
 newImg=imresize(newImg,[300,300]);
 threshold1 = graythresh( newImg);

 newImg = imbinarize(newImg, threshold1);
  for k=1:15
 newImg= medfilt2(newImg);
  end
%     figure;imshow(newImg);
 



 savearray=zeros(1,750);
 for j=1:300
     sum=0;
     for i=1:300
          sum=sum+newImg(i,j);
         if sum == 300
         savearray(1,j)=1;
         else
         savearray(1,j)=0;  
         end
     end
%        savearray(1,j)=sum;  
 end     
%  
j=1;
for i=4:299
if (savearray(1,i+1) ~= 0)&&(savearray(1,i) == 0)
    array_01(1,j)=i+1; 
    j=j+1;
end
end

 
j=1;
for i=4:299
if (savearray(1,i+1) == 0)&&(savearray(1,i) ~= 0)
    array_10(1,j)=i+1;  
    j=j+1;
end
end

x=length(array_01);
%  figure;
%  fullFileName1='C:\Users\lenovo\Desktop\page.docx';
%  fid=fopen(fullFileName1,'r+');
for hi=1:x
   bwPic= newImg(:,array_10(1,hi):array_01(1,hi));
%     figure;imshow(bwPic);
     bwPic=imresize(bwPic,[227,227]);
%  
% %     subplot(1,x,hi);imshow(bwPic); 
%    
% 
% %     baseFileName = sprintf('image_%d.jpg',hi);
% % 
% % %save individual words into specific folder
% % fullFileName = fullfile('E:\BE_PROJECT', baseFileName);
% % imwrite(bwPic , fullFileName);
% 
bwPicSize = size(bwPic);
rgbPic = zeros(bwPicSize(1),bwPicSize(2),3);
rgbPic(bwPic==1)=255;
rgbPic(:,:,2) = rgbPic(:,:,1);
rgbPic(:,:,3) = rgbPic(:,:,1);
rgbPic = im2uint8(rgbPic);

testpreds2 = classify(newnet,rgbPic ); 
disp(testpreds2);
%  testpreds2=char(testpreds2(1));
% %  clipboard('copy',testpreds2);
% %  str = clipboard('paste');
% % %  
% % % %  xlswrite(filename,testpreds,1,'E1');
% % % 
% %   imwrite(testpreds2, fullFileName1);
% % 
% %   fprintf(fid,str);
%  
 end    

% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% 
% 

   clear array_01;
   clear array_10;
     end
   clear array_01;
   clear array_10;
end    