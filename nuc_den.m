function [bm5,bm6]=nuc_den(bm1,nrows,ncols) %bm5,6
%this finds the area in a predesignted sized box
%6 finds the number of unique nucli in the same box

%Written by Steven Nystrom 2/3/13

Ibw=imfill(bm1,'holes'); %fills in image for better analysis
[B,L,N] = bwboundaries(Ibw,'holes'); %find boundries
numnuc=zeros(nrows,ncols,1); %preallocate memory
area=zeros(nrows,ncols,1);
bxsz=30; %Enter the size of box MUST BE EVEN!!
bxsz1=bxsz/2; bxsz2=bxsz1+1; bxsz3=bxsz1-1; %boundries
%takes nXn box and fills in the nucli area & number of unique nucli
%in the scorebox
for i=1:nrows %rows
    for j=1:ncols %columbs
        scrbx=zeros(bxsz,bxsz); %resets box
        if i<=bxsz2 && j<=bxsz2 
            scrbx=Ibw(1:i+bxsz3,1:j+bxsz3); %box
            area(i,j)=bwarea(scrbx); %area of 1's (the nucli part)
            scrbx=L(1:i+bxsz3,1:j+bxsz3); %box
            numnuc(i,j)=numel(unique(scrbx))-1; %finds unique values in box,(number of nucli cluster) and subtracts the 0 unique value
        elseif i<=bxsz2 && j>bxsz2 && j<=ncols-bxsz1
            scrbx=Ibw(1:i+bxsz3,j-bxsz3:j+bxsz1);
            area(i,j)=bwarea(scrbx);
            scrbx=L(1:i+bxsz3,j-bxsz3:j+bxsz1);
            numnuc(i,j)=numel(unique(scrbx))-1;
        elseif i<=bxsz2 && j>ncols-bxsz1
            scrbx=Ibw(1:i+bxsz3,j-bxsz3:ncols);
            area(i,j)=bwarea(scrbx);
            scrbx=L(1:i+bxsz3,j-bxsz3:ncols);
            numnuc(i,j)=numel(unique(scrbx))-1;
        elseif i>bxsz2 && i<=nrows-bxsz1 && j>=bxsz2 && j<=ncols-bxsz1
            scrbx=Ibw(i-bxsz3:i+bxsz1,j-bxsz3:j+bxsz1);
            area(i,j)=bwarea(scrbx);
            scrbx=L(i-bxsz3:i+bxsz1,j-bxsz3:j+bxsz1);
            numnuc(i,j)=numel(unique(scrbx))-1;
        elseif i>nrows-bxsz1 && j>=bxsz1 && j<ncols-bxsz1
            scrbx=Ibw(i-bxsz3:nrows,j-bxsz3:j+bxsz1);
            area(i,j)=bwarea(scrbx);
            scrbx=L(i-bxsz3:nrows,j-bxsz3:j+bxsz1);
            numnuc(i,j)=numel(unique(scrbx))-1;
        elseif i>nrows-bxsz1 && j>ncols-bxsz1
            scrbx=Ibw(i-bxsz3:nrows,i-bxsz3:ncols);
            area(i,j)=bwarea(scrbx);
            scrbx=L(i-bxsz3:nrows,i-bxsz3:ncols);
            numnuc(i,j)=numel(unique(scrbx))-1;
        end
    end
end
bm5=area(:); %vectorize matrix for kmeans
bm6=numnuc(:);
end