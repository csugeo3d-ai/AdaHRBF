
% ====================================================================================
% 函数名：GradientvectorToDipvector
% 功  能：梯度矢量转换到产状矢量
% 输  入：gradVct[x,y,z,gx,gy,gz]（dx,dy,dz为梯度矢量）
% 返  回：dipVct[x,y,z,dx,dy,dz]
% 作  者：杜林泽
% 日  期：2022.7.24
% 版  本：ver1.0.0
% ====================================================================================

function [dipVct]=GradientvectorToDipvector(graVct)

    stkVct= GradientvectorToStrikvector(graVct);%走向矢量
    stkVct=stkVct(:,4:6);
    dipVct=graVct;
    dipVct(:,4:6)=cross(stkVct,graVct(:,4:6));%倾角矢量

end

