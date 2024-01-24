% ====================================================================================
% 函数名：GetPartialDerivative
% 功  能：计算一阶偏导数
% 输  入：k（float）：微分计算时近似极小值的变化量（目前没有作用）
%         baseFuncType（int）：基函数类型（目前没有作用）
%         X：自变量X
%         Y：自变量Y
%         Z：自变量Z
%         X_：插值采样点常数项目X
%         Y_：插值采样点常数项目Y
%         Z_：插值采样点常数项目Z
% 返  回：x_partialDerivative:自变量X与各个插值采样点一阶偏导矩阵
%         y_partialDerivative:自变量Y与各个插值采样点一阶偏导矩阵
%         z_partialDerivative:自变量Z与各个插值采样点一阶偏导矩阵
% 作  者：杜林泽
% 日  期：2022.9.10
% 版  本：ver1.0.0
% ====================================================================================
function [x_partialDerivative,y_partialDerivative,z_partialDerivative]=GetPartialDerivative(X,Y,Z,X_,Y_,Z_,k,baseFuncType)

grandg_x = @(b1,b2,b3,x,y,z)  (3*(2*b1 - 2*x).*((b1 - x).^2 + (b2 - y).^2 + (b3 - z).^2).^(1/2))./2;%原来的方程的导数
grandg_y = @(b1,b2,b3,x,y,z)  (3*(2*b2 - 2*y).*((b1 - x).^2 + (b2 - y).^2 + (b3 - z).^2).^(1/2))./2;
grandg_z = @(b1,b2,b3,x,y,z)  (3*(2*b3 - 2*z).*((b1 - x).^2 + (b2 - y).^2 + (b3 - z).^2).^(1/2))./2;

x_partialDerivative=grandg_x(X,Y,Z,X_,Y_,Z_);
y_partialDerivative=grandg_y(X,Y,Z,X_,Y_,Z_);
z_partialDerivative=grandg_z(X,Y,Z,X_,Y_,Z_);

% basefunValue=BaseFunc(X,Y,Z,X_,Y_,Z_,baseFuncType);
% x_partialDerivative=(basefunValue-BaseFunc(X-k,Y,Z,X_,Y_,Z_,baseFuncType))./k;
% y_partialDerivative=(basefunValue-BaseFunc(X,Y-k,Z,X_,Y_,Z_,baseFuncType))./k;
% z_partialDerivative=(basefunValue-BaseFunc(X,Y,Z-k,X_,Y_,Z_,baseFuncType))./k;

end