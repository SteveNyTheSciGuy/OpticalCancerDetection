function [bm1]=nucli(I,J,K,nrows,ncols)
%identifies the nucli

%Written by Steven Nystrom 2/3/13

siz=size(I); %length of indexed image
rul=90; %red upper limit
bul=90; %blue upper limit
gup=32; %green upper limit
for i=1:siz 
    if I(i)>=rul %red too strong, filter out
        I(i)=0;
    elseif I(i)<=rul && K(i)>=bul; %red correct range but blue beyond filter out
        I(i)=0;
    elseif I(i)<=rul && J(i)>=gup; %red correct range but green beyond filter out
        I(i)=0;
    end
end
for i=1:siz 
        if K(i)>=bul %blue too strong, filter out
            K(i)=0;
        elseif K(i)<=bul && I(i)>=rul; %blue correct range but red beyond filter out
            K(i)=0;
        elseif K(i)<=bul && J(i)>=gup; %blue correct range but green beyond filter out
            K(i)=0;
        end
end
for i=1:siz 
        if J(i)>=gup %green too strong, filter out
            J(i)=0;
        end
end
I1=reshape(I,nrows,ncols); J1=reshape(J,nrows,ncols); K1=reshape(K,nrows,ncols); 
he1=zeros(nrows,ncols,3);
he1(:,:,1)=I1; %new image matrix
he1(:,:,2)=J1;
he1(:,:,3)=K1;

%grey scale/binary
Igray= rgb2gray(he1);
threshold=0;  %relative intenisty
Ibw= Igray> threshold; %turns into binnary
bm1=imfill(Ibw,8,'holes'); %fills in small artifact holes
end

