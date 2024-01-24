% ====================================================================================
% 函数名：GradientvectorToStrikvector 
% 功  能：梯度矢量转换到切线（走向）
% 输  入：graVct[x,y,z,gx,gy,gz]（gx,gy,gz为梯度矢量）
% 返  回：stkVct[x,y,z,sx,sy,sz]（sx,sy,sz为切线矢量）
% 作  者：杜林泽
% 日  期：2022.7.25
% 版  本：ver1.0.0
% ====================================================================================

function stkVct= GradientvectorToStrikvector(graVct)

    stkVct=graVct(:,4:6);
    zaxisVct=zeros(size(stkVct));
    zaxisVct(:,end)=zaxisVct(:,end)+1;%Z轴方向单位矢量
    stkVct=cross(zaxisVct,stkVct);
    stkVct=[graVct(:,1:3),stkVct];

end

