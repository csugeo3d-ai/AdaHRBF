

function [valueGrid,meshgrid_X,meshgrid_Y,meshgrid_Z] = RBFGetModel(attributesPoints,solution,k,baseFuncType)

dataMax=max(attributesPoints(:,[1,2,3]));
dataMin=min(attributesPoints(:,[1,2,3]));
[meshgrid_X,meshgrid_Y,meshgrid_Z] = meshgrid(dataMin(1,1):solution(1,1):dataMax(1,1),dataMin(1,2):solution(1,2):dataMax(1,2),dataMin(1,3):solution(1,3):dataMax(1,3));
[alph,~,charlie]=GetParameters(k,baseFuncType,attributesPoints);%插值函数参数计算
valueGrid=GetValueGrid(k,baseFuncType,meshgrid_X,meshgrid_Y,meshgrid_Z,attributesPoints,alph,charlie);

end

