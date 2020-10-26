function [red,green,blue,grey]=RGB(he)
red=he(:,:,1); red=red(:);%heightXlengthX3 color rgb
green=he(:,:,2); green=green(:);
blue=he(:,:,3); blue=blue(:);
grey=rgb2gray(he); grey=grey(:);
end