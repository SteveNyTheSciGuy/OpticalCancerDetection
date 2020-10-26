function [bm12,bm13,bm14]=white_size(bm11) %bm12,13,14
%labels each 'white stuff' with the number of pixels in that group
%labels each 'white stuff' with its perimiter
%labels each 'white stuff' with its perimiter to area ratio

%Written by Steven Nystrom 2/3/13

[B,L,N] = bwboundaries(bm11,'noholes'); %find boundries
%B=exterior boundries L=numbers each cluster N=number of clusters
perim=zeros(N,1,1); bc=zeros(N,1,1);
for i=1:N
    perim(i)=length(B{i});
end
vv=L( : ); %vectorises matrix
cc = vv(vv~=0); %removes 0 for faster iterations
%finds how many pixels are in each cluster
for i=1:N
    bc(i)=length(cc(cc==i));
end
%perimiter to area ratio
p2a=perim./bc;
%allocate mem
Q=length(vv);bm12=zeros(Q,1); bm13=zeros(Q,1);bm14=zeros(Q,1);
%replace cluster number w/ cluster area,perimiter,perimiter2area ratio
for j=1:N
    for i=1:length(vv) %rows
        if vv(i)==j
            bm12(i)=bc(j);
            bm13(i)=perim(j);
            bm14(i)=p2a(j);
            continue %goes through all matrix search for values
        end
    end
end
end
