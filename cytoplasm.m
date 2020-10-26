function [bm7]=cytoplasm(I,J,K,nrows,ncols) %bm7
%finds cytoplasm section

%Written by Steven Nystrom 2/3/13
siz=size(I); 
for i=1:siz 
    if I(i)<=100 || I(i)>=200%red too strong/weak, filter out
        I(i)=0;
    elseif K(i)<=100 || K(i)>=200; %red correct range but blue beyond filter out
        I(i)=0;
    end
end
for i=1:siz %rows
    if K(i)<=100 || K(i)>=200; %blue too strong/weak filter out
        K(i)=0;
    elseif I(i)<=100 || I(i)>=200% correct blue but red too strong/weak, filter out
        K(i)=0;
    end
end
for i=1:siz %rows
    if J(i)>=28 %green too strong, filter out
        J(i)=0;
    end
end
I=reshape(I,nrows,ncols); J=reshape(J,nrows,ncols); K=reshape(K,nrows,ncols); 
he1(:,:,1)=I; %makes new image matrix
he1(:,:,2)=J;
he1(:,:,3)=K;

%grey scale/binary
Igray= rgb2gray(he1);
threshold= 30;  %relative intenisty
bm7= Igray> threshold; %turns into binnary
end