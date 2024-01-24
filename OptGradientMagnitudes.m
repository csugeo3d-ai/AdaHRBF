% name：OptGradientMagnitudes.m
% description：interpolate a 3D scalar field function in southern sub-domain 
% input：k（float）：approximate minima in calculation(useless in current version) 
%         baseFuncType（int）：set basefunction type(useless in current version) 
%         attribute_points[x,y,z,attribute] relatively butial depth for RBF,(ada)HRBFc
%         gradient_points[x,y,z,gx,gy,gz] gradient magnitude for (ada)HRBF
%         e：iteration stopping accuracy
%         times：max iteration times
% return：optGradientPoints（x,y,z,gx,gy,gz）：optimized gradient magnitude
%         alph：weight coefficients a
%         charlie：weight coefficients c
%         bravo：weight coefficients b
% author：
% version：ver1.0.0[2022.9.23]

function [optGradientPoints,alph,bravo,charlie] = OptGradientMagnitudes(attribute_points,gradient_points,initial_lambda,e,times)
num=size(attribute_points,1);
m=size(gradient_points,1);
meanYuValue=realmax;

optGradientPoints=gradient_points;
golf_k=gradient_points(:,end-2:end)';
golf_k=golf_k(1:end);
lambda=ones(m,1)*initial_lambda;%initialize lambda
l_i=ones(m,1);%initialize magnitude
foxtra=attribute_points(:,end);
Unit=zeros(3*m,3*m);
Unit(1:(3*m+1):end)=1;
A=GetMatrixA(1e-4,1,attribute_points,gradient_points);  
B=GetMatrixB(attribute_points,gradient_points);
i=1;

while meanYuValue>e||i<times
    %construct matrix lambda
    Lambda=diag(kron( lambda , [1;1;1] ))*Unit;
    
    Ai=A;
    Ai((num+1:num+3*m),(num+1:num+3*m))=A((num+1:num+3*m),(num+1:num+3*m))-Lambda;
    
    Bi=B;
    Bi(1:num)=foxtra;
    Bi(num+1:num+3*m)=golf_k;
    Xi=Ai\Bi;
    
    Bi=A*Xi;
    foxtra=Bi(1:num);
    golf_k=Bi(num+1:num+3*m);
    golf_i=reshape(golf_k,3,[]);
    golf_i=golf_i';
    l_k=l_i;
    l_i=sqrt((golf_i(:,1)).^2+(golf_i(:,2)).^2+(golf_i(:,3)).^2);
    dValue=l_i-l_k;
    meanYuValue=mean (dValue);
    max_dValue=max(abs(dValue));
    lambda=lambda- dValue/max_dValue;
    i=i+1;
end
optGradientPoints(:,end-2:end)=diag(l_i)*gradient_points(:,end-2:end);
alph=Xi(1:num,1);
bravo=Xi((num+1):(num+3*m),1);
charlie=Xi((num+3*m+1):(num+3*m+4),1);
end
