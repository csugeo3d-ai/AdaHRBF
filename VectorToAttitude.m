% ====================================================================================
% 函数名：VectorToAttitud
% 功  能：矢量到产状
% 输  入：dipVct[x,y,z,dx,dy,dz]
% 返  回：graVct[x,y,z,dipOrin,dipAgl]
% 作  者：杜林泽
% 日  期：2022.8.30
% 版  本：ver1.0.0
% ====================================================================================

function [attitude]=VectorToAttitude(vector)

    dipOrin=rad2deg(atan2(vector(:,4),vector(:,5)));
    dipOrin=mod((dipOrin+360),360);
    dipAgl= rad2deg(atan2(-vector(:,6),sqrt(vector(:,4).^2+vector(:,5).^2)));
    dipAgl=mod((dipAgl+360),360);
    attitude=[vector(:,1:3),dipOrin,dipAgl];

end