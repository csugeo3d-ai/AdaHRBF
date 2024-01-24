% ====================================================================================
% 函数名：BsaeFunc
% 功  能：基函数计算
% 输  入：meshgrid (n,3)
%         orin[x,y,z,dip_orin,dip_angle](n,5)
% 返  回：basefunc[vlue](n,1)
% 作  者：杜林泽
% 日  期：2022.9.2
% 版  本：ver1.0.0
% ====================================================================================
% name：BsaeFunc.m
% description：calculating bsaefuncton value
% input：k（float）：approximate minima in calculation(useless in current version) 
%         meshgrid [X,Y,Z]
%         X_：constants points
%         Y_：constants points
%         Z_：constants points
%         type（int）：set basefunction type(useless in current version)
% return：basefunction value
% author：
% version：ver1.0.0[2022.9.23]
function basefunc=BaseFunc(X,Y,Z,X_,Y_,Z_,type)

basefunc=((sqrt((X-X_).^2 + (Y-Y_).^2 +(Z-Z_).^2 )).^3);
% Gaussian
% MQ
% IMQ
end