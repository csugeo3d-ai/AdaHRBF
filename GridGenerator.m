function [meshgrid_X,meshgrid_Y,meshgrid_Z] = GridGenerator(attitude,attributes,solution)
%GRIDGENERATOR 此处显示有关此函数的摘要
%   此处显示详细说明
dataMax=max([attributes(:,[1,2,3]);attitude(:,[1,2,3])]);
dataMin=min([attributes(:,[1,2,3]);attitude(:,[1,2,3])]);
[meshgrid_X,meshgrid_Y,meshgrid_Z] = meshgrid(dataMin(1,1):solution(1):dataMax(1,1),dataMin(1,2):solution(2):dataMax(1,2),dataMin(1,3):solution(3):dataMax(1,3));
end

