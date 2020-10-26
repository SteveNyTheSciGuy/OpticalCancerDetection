% H&E Optical Cancer Analysis
% By: Steven Nystrom, Dr. James Coe
% How to use: Type image name below that is to be analized
% These are the main functions:
% RGB-Creates R&G&B&Grey image planes
% nucli-Uses color ratios to determin nucli
% nucli_a_p_r-Finds the area, perimiter and the ratio(a:p)for each nucli
% nuc_den-Finds the density of nucli in a predetemined box size
% cytoplasm-Finds mucinus regions
% cytoplasm_a_p_r-Finds the area, perimiter and ratio (a:p) for each group
% white-Finds white regions
% white_a_p_r-Finds the area, perimiter and ratio (a:p) for each group
%
% Outputs: Figure(1): Kmeans (random color scheme)
%   Saves: Each biomarker
%   Saves: Each Kmean group and its outlined regions on orginal image          

%**************************Obtain Biomarkers*******************************
clear; clc; %close all;
nclusters=5; % Number of kmean groups
% Read in image
[he,map]=imread('RS12_001_2_2.jpg');
sc=1; % Scaling factor for metrics with very large outputs
% Find size of image
[nrows,ncols,ndem]=size(he);
str=sprintf('Obtaining Biomarkers from image\nPlease refrain from touching computer'); disp(str)
[bm15,bm16,bm17,bm18]=RGB(he); % Red,Green,Blue,Grey
bm1=nucli(bm15,bm16,bm17,nrows,ncols);
[bm2,bm3,bm4]=nucli_a_p_r(bm1); % Area, Permimeter, Ratio
[bm5,bm6]=nuc_den(bm1,nrows,ncols);
bm7=cytoplasm(bm15,bm16,bm17,nrows,ncols);
[bm8,bm9,bm10]=cytoplasm_a_p_r(bm7);
bm11=white(bm15,bm16,bm17,nrows,ncols);
[bm12,bm13,bm14]=white_a_p_r(bm11);
% Create biomarker matrix, then transform from unit 8 to double
str=sprintf('Saving Biomarkers & Converting to X file'); disp(str)
X=[bm1(:),bm2,bm3,bm4,bm5,bm6,bm7(:),bm8./sc,bm9./sc,bm10,bm11(:),bm12./sc,bm13./sc,bm14,bm15./sc,bm16./sc,bm17./sc,bm18./sc];
X=double(X);

% Writes each biomarker as an image 
% *not all BM images appear meaningful in .jpg*
for i=1:18
    bm=reshape(X(:,i),nrows,ncols);
    str=sprintf('BM%i.jpg',i); imwrite(bm,str)
end
%*********************End Obtaining Biomarkers*****************************

%**************************K Means*****************************************
% Cluster_idx-vector of each pixles final group
str=sprintf('Starting Kmeans'); disp(str)
opts=statset('Display','final','MaxIter',200);
[cluster_idx,cluster_center] = kmeans(X,nclusters,'distance','city','Replicates',4,'Options',opts);

% Reshape results back into image format
pixel_labels = reshape(cluster_idx,nrows,ncols);
figure(1),imagesc(pixel_labels),axis off,title('Optical Kmeans (random color)')

segmented_images = cell(1,3);
rgb_label = repmat(pixel_labels,[1 1 3]);
% For each group, blacken the pixels not in the group
for k = 1:nclusters
    color = he;
    color(rgb_label ~= k) = 0;
    segmented_images{k} = color;
end

% Turn vector into nrowsXncols
pixel_labels1=zeros(nrows,ncols,nclusters);
% Loop creats binary where the groups are 1 else 0
for i=1:nrows %rows
    for j=1:ncols %columbs
        for k=1:nclusters %groups
            if pixel_labels(i,j) == k
                pixel_labels1(i,j,k)=1;
            elseif pixel_labels(i,j) ~= k
                pixel_labels1(i,j,k)=0;
            end
        end
    end
end

% Preallocate mem, loop finds perm in each group to show interactivly
perm=zeros(nrows,ncols,nclusters);
for i=1:nclusters
    perm(:,:,i)=bwperim(pixel_labels1(:,:,i));
end

% Turn RGB vectors into image matrix
I=reshape(bm15,nrows,ncols); J=reshape(bm16,nrows,ncols); K=reshape(bm17,nrows,ncols);
neww=cell(1,nclusters); % Preallocate mem

% Makes biomarker superimposed on origianl image
for ii=1:nclusters
    % Saves binary image
    neww{ii}=double(segmented_images{ii});
    imwrite(neww{ii},sprintf('KG%i.bmp',ii))
    
    % Resets image to highlight
    [I,J,K]=RGB(he);
    I=reshape(I,nrows,ncols); J=reshape(J,nrows,ncols); K=reshape(K,nrows,ncols);
    
    % If pixel is part of perm turn that pixel to bright orange
    for i=1:nrows %rows
        for j=1:ncols %columbs
            if perm(i,j,ii)==1
                I(i,j)=255; J(i,j)=0; K(i,j)=90;
            end
        end
    end
    he1=cat(3,I,J,K); % New image matrix
    imwrite(he1,sprintf('KG%i_Overlay.bmp',ii)) % Saves Image
end
