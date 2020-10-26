function [bm8,bm9,bm10]=cytoplasm_size(bm7) %bm8,9,10
%labels each cytoplasm group with the number of pixels in that group
%labels each cytoplasm group with its perimiter
%labels each cytoplasm group with its perimiter to area ratio

%Written by Steven Nystrom 2/3/13

[B,L,N] = bwboundaries(bm7,4,'noholes'); %find boundries
%B=exterior boundries L=numbers each cluster N=number of clusters
perim=zeros(N,1,1); bc=zeros(N,1,1);
%assigns each unique nucli its permiter
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
Q=length(vv);bm8=zeros(Q,1); bm9=zeros(Q,1);bm10=zeros(Q,1);
%replace cluster number w/ cluster area,perimiter,perimiter2area ratio
for j=1:N
    for i=1:length(vv) %rows
        if vv(i)==j
            bm8(i)=bc(j);
            bm9(i)=perim(j);
            bm10(i)=p2a(j);
            continue %goes through all matrix search for values
        end
    end
end

end