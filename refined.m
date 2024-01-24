lith_seq={'./Data/NorthDicengPoint1.xls','./Data/NorthDicengPoint2.xls','./Data/NorthDicengPoint3.xls'};
attributes_fault = xlsread('./Data/FaultChange2.xls');
DEM = xlsread('./Data/DEM100m.xlsx');
attitude_north = xlsread('./Data/NFattitude.xlsx');
attributes_north = xlsread('./Data/NorthDicengPoint.xls');
attitude_north=AttitudeToVector(attitude_north);
gradient_north=DipvectorToGradientvector(attitude_north);
%Set basefunction type(useless in current version) 
basefunctype=1;
k=1e-4;
% dataMax=max([attributes_north(:,[1,2,3]);attitude_north(:,[1,2,3])]);
% dataMin=min([attributes_north(:,[1,2,3]);attitude_north(:,[1,2,3])]);

[meshgrid_NX_base,meshgrid_NY_base,meshgrid_NZ_base] = meshgrid(662000:100:677000,2568000:100: 2582000,0:25:1150);
i=0;
[alph,~,charlie]=GetParameters(1e-4,1,attributes_fault);
valueGrid_fault=GetValueGrid(k,basefunctype,meshgrid_NX_base,meshgrid_NY_base,meshgrid_NZ_base,attributes_fault,alph,charlie);
[alph_n,bravo_n,charlie_n]=GetParameters(1e-4,1,attributes_north,gradient_north);
valueGrid_north_org=GetValueGrid(k,basefunctype,meshgrid_NX_base,meshgrid_NY_base,meshgrid_NZ_base,attributes_north,alph_n,charlie_n,gradient_north,bravo_n);
base_grid=valueGrid_north_org;
index_n=find(valueGrid_fault>=0);
index=find(meshgrid_NY_base<=-1.21*meshgrid_NX_base+3379598.04 | meshgrid_NY_base>=-1.21*meshgrid_NX_base+3389045.69 | meshgrid_NY_base>=0.83*meshgrid_NX_base+2028031.65 | meshgrid_NY_base<=0.83*meshgrid_NX_base+2011701.6);


valueGrid_north_org(index_n)=nan;
valueGrid_north_org(index)=nan;
value_list=[4872,7233,8429,9145,9674,10602,11717,8429,9145,9674,10602,11142];
color_list={'#ffe7ff','#fedfff','#ecffb0','#e2e2e2','#d0cfe1','#c5c4ca','#ffdfc0','#ecffb0','#e2e2e2','#d0cfe1','#c5c4ca','#ffe7cf'};
area=[662000 677000 2568000 2582000 0 1150];
color_axis=[4000,13000];
fig0=figure('Name','HRBFscatters');
figure(fig0);
%With optimized gradient magnitude
caxis(color_axis)
colorbar;
axis(area);
axis equal;
set(gca,'XLim',[area(1) area(2)]);
set(gca,'YLim',[area(3) area(4)]);
set(gca,'ZLim',[area(5) area(6)]);
scatter3(meshgrid_NX_base(:),meshgrid_NY_base(:),meshgrid_NZ_base(:),25,valueGrid_north_org(:),'.');





while i<size(lith_seq,2)
   i=i+1;
   attributes_north = xlsread(lith_seq{i});
   [alph_n,bravo_n,charlie_n]=GetParameters(1e-4,1,attributes_north,gradient_north);
   top_proper=max(attributes_north(:,4));
   valueGrid_north=GetValueGrid(k,basefunctype,meshgrid_NX_base,meshgrid_NY_base,meshgrid_NZ_base,attributes_north,alph_n,charlie_n,gradient_north,bravo_n);
   index_=find(valueGrid_north<=top_proper);
   base_grid(index_)=valueGrid_north(index_);
%    base_grid(index_n)=nan;
%    base_grid(index)=nan;
%    valueGrid_north(index_)=valueGrid_north(index_);
%    valueGrid_north(index_n)=nan;
%    valueGrid_north(index)=nan;
   
    %Dsiplay scalar field in the northern subdomain
    fig1=figure('Name','HRBFscatters');
    figure(fig1);
    %With optimized gradient magnitude
    subplot(1,2,1);
    caxis(color_axis)
    colorbar;
    axis(area);
    axis equal;
    set(gca,'XLim',[area(1) area(2)]);
    set(gca,'YLim',[area(3) area(4)]);
    set(gca,'ZLim',[area(5) area(6)]);
    scatter3(meshgrid_NX_base(:),meshgrid_NY_base(:),meshgrid_NZ_base(:),25,base_grid(:),'.');
    subplot(1,2,2);
    caxis(color_axis)
    colorbar;
    axis(area);
    axis equal;
    set(gca,'XLim',[area(1) area(2)]);
    set(gca,'YLim',[area(3) area(4)]);
    set(gca,'ZLim',[area(5) area(6)]);
    scatter3(meshgrid_NX_base(:),meshgrid_NY_base(:),meshgrid_NZ_base(:),25,valueGrid_north(:),'.');
    hold on;
end





 