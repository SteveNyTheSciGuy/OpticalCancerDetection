function [bm11]=white(I,J,K,nrows,ncols) %bm11
%finds cytoplasm

%Written by Steven Nystrom 2/3/13

siz=size(I); %length indexed image
for i=1:siz 
    if I(i)<=220 %red too weak, filter out
        I(i)=0;
    end
end
for i=1:siz 
    if K(i)<=220 %blue too weak, filter out
        K(i)=0;
    end
end
for i=1:siz 
    if J(i)<=220 %green too weak, filter out
        J(i)=0;
    end
end

I=reshape(I,nrows,ncols); J=reshape(J,nrows,ncols); K=reshape(K,nrows,ncols); 
he1(:,:,1)=I; %new image matrix
he1(:,:,2)=J;
he1(:,:,3)=K;

%grey scale/binary
Igray= rgb2gray(he1);
threshold= 60;  %relative intenisty
Ibw= Igray> threshold; %turns into binnary
bm11=Ibw; %vectorize matrix for kmeans
end

