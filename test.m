% 等高线没有标高程，按照地地形推断
% 产状点高程值是估计的
% 坐标不对应，使用局部坐标

% 界线点坐标为手动记录的
% 没有使用柱状图埋深数据，是直接赋值的
% 局部，如果范围更广一些形态会还原
% 没有按照高程裁切区域

attributes_north = xlsread('attitude.xlsx');
attitude_north = xlsread('attribute.xlsx');

k=1e-4;%微分计算时近似极小值（目前没有作用）
basefunctype=1;%基函数类型,1为cubic（目前没有作用）

%将产状数据转换成模长为一的梯度矢量
attitude_north=AttitudeToVector(attitude_north);
gradient_north=DipvectorToGradientvector(attitude_north);
[meshgrid_NX,meshgrid_NY,meshgrid_NZ] = meshgrid(1516:5:1966,1160:5:1560,200:5:330);

[alph_n,bravo_n,charlie_n]=GetParameters(1e-4,1,attributes_north,gradient_north);
valueGrid_north=GetValueGrid(k,basefunctype,meshgrid_NX,meshgrid_NY,meshgrid_NZ,attributes_north,alph_n,charlie_n,gradient_north,bravo_n);

[opt_gradient_north,opt_alph_n,opt_bravo_n,opt_charlie_n]=OptGradientMagnitudes(attributes_north,gradient_north,1,1e-4,500);
opt_valueGrid_north=GetValueGrid(k,basefunctype,meshgrid_NX,meshgrid_NY,meshgrid_NZ,attributes_north,opt_alph_n,opt_charlie_n,opt_gradient_north,opt_bravo_n);

%图片显式
value_list=[150,200];
color_list={'#c5c4ca','#ffe7cf'};
area=[1516 1966 1160 1560 200 250];
color_axis=[0,300];

%展示标量场图片
fig1=figure('Name','HRBFscatters');
figure(fig1);
subplot(1,2,1);
caxis(color_axis)
colorbar;
axis(area);
axis equal;
set(gca,'XLim',[area(1) area(2)]);%X轴的数据显示范围
set(gca,'YLim',[area(3) area(4)]);%Y轴的数据显示范围
set(gca,'ZLim',[area(5) area(6)]);%Z轴的数据显示范围
scatter3(meshgrid_NX(:),meshgrid_NY(:),meshgrid_NZ(:),25,valueGrid_north(:),'.');
hold on;
subplot(1,2,2);
caxis(color_axis)
colorbar;
axis(area);
axis equal;
set(gca,'XLim',[area(1) area(2)]);%X轴的数据显示范围
set(gca,'YLim',[area(3) area(4)]);%Y轴的数据显示范围
set(gca,'ZLim',[area(5) area(6)]);%Z轴的数据显示范围
scatter3(meshgrid_NX(:),meshgrid_NY(:),meshgrid_NZ(:),25,opt_valueGrid_north(:),'.');
hold off;

%显示地层界面
fig2=figure('Name','HRBFisosurfaces');         
figure(fig2);
subplot(1,2,1);
light('position',[-0.5,-0.5,0.5],'style','local','color','[0.5,0.5,0.5]')
grid on; box on;
axis(area);
axis equal;
set(gca,'XLim',[area(1) area(2)]);%X轴的数据显示范围
set(gca,'YLim',[area(3) area(4)]);%Y轴的数据显示范围bv 
set(gca,'ZLim',[area(5) area(6)]);%Z轴的数据显示范围
%等值面提取
for i=1:2
    pic = patch(isosurface(meshgrid_NX,meshgrid_NY,meshgrid_NZ,valueGrid_north,value_list(i)));
    isonormals(meshgrid_NX,meshgrid_NY,meshgrid_NZ,valueGrid_north,pic)
    set(pic,'FaceColor',color_list{i},'EdgeColor','none');
    hold on;
end    

subplot(1,2,2);
light('position',[-0.5,-0.5,0.5],'style','local','color','[0.5,0.5,0.5]')
grid on; box on;
axis(area);
axis equal;
set(gca,'XLim',[area(1) area(2)]);%X轴的数据显示范围
set(gca,'YLim',[area(3) area(4)]);%Y轴的数据显示范围
set(gca,'ZLim',[area(5) area(6)]);%Z轴的数据显示范围
for i=1:2
    pic = patch(isosurface(meshgrid_NX,meshgrid_NY,meshgrid_NZ,opt_valueGrid_north,value_list(i)));
    isonormals(meshgrid_NX,meshgrid_NY,meshgrid_NZ,opt_valueGrid_north,pic)
    set(pic,'FaceColor',color_list{i},'EdgeColor','none');
    hold on;
end
hold off;