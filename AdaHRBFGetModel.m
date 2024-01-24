
function [valueGrid,meshgrid_X,meshgrid_Y,meshgrid_Z] = AdaHRBFGetModel(attributesPoints,gradientPoints,solution,k,baseFuncType,initialLambda,e,times)

dataMax=max([attributesPoints(:,[1,2,3]);gradientPoints(:,[1,2,3])]);
dataMin=min([attributesPoints(:,[1,2,3]);gradientPoints(:,[1,2,3])]);
[optGradientPoints] = OptGradientMagnitudes(attributesPoints,gradientPoints,initialLambda,e,times);
[meshgrid_X,meshgrid_Y,meshgrid_Z] = meshgrid(dataMin(1,1):solution(1,1):dataMax(1,1),dataMin(1,2):solution(1,2):dataMax(1,2),dataMin(1,3):solution(1,3):dataMax(1,3));
[alph,bravo,charlie]=GetParameters(k,baseFuncType,attributesPoints,optGradientPoints);%插值函数参数计算
valueGrid=GetValueGrid(k,baseFuncType,meshgrid_X,meshgrid_Y,meshgrid_Z,attributesPoints,alph,charlie,optGradientPoints,bravo);

end