function [bm2,bm3,bm4]=nucli_a_p_r(bm1) %bm2,3,4
%finds area of each unique nucli
%finds perm of each unique nucli
%perm/area ratio for each nucli

%Written by Steven Nystrom 2/3/13

[B,L,N] = bwboundaries(bm1,'noholes'); %find boundries
%B=exterior boundries L=numbers each cluster N=number of clusters
%A=holefilling descripancies,trivial
perim=zeros(N); bc=zeros(N);
for i=1:N
    perim(i)=length(B{i});
end
vv=L(:); %vectorises matrix
cc=vv(vv~=0); %removes 0 for faster iterations
%finds how many pixels are in each cluster
for i=1:N
    bc(i)=length(cc(cc==i));
end
%perimiter to area ratio
p2a=perim./bc;
%allocate mem
Q=length(vv);bm2=zeros(Q,1); bm3=zeros(Q,1);bm4=zeros(Q,1);
%replace cluster number w/ cluster area,perimiter,perimiter2area ratio
for j=1:N
    for i=1:length(vv) %rows
        if vv(i)==j
            bm2(i)=bc(j);
            bm3(i)=perim(j);
            bm4(i)=p2a(j);
            continue %goes through all matrix search for values
        end
    end
end
end