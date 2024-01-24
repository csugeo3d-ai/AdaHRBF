% name£ºGetValueGrid.m
% description£ºinterpolate a 3D scalar field function in southern sub-domain 
% input£ºk£¨float£©£ºapproximate minima in calculation(useless in current version) 
%         baseFuncType£¨int£©£ºset basefunction type(useless in current version) 
%         grid_X£ºmeshgrid X
%         grid_Y£ºmeshgrid Y
%         grid_Z£ºmeshgrid Z
%         attribute_points[x,y,z,attribute] relatively butial depth for RBF,(ada)HRBF
%         varargin{1}£ºweight coefficients a
%         varargin{2}£ºcharlie£ºweight coefficients c
%         varargin{3}£º[x,y,z,gx,gy,gz]gradient magnitude for (ada)HRBF
%         varargin{4}£ºweight coefficients b
% return£ºvalueGrid
% author£º
% version£ºver1.0.0[2022.9.23]
function [valueGrid]=GetValueGrid(k,baseFuncType,grid_X,grid_Y,grid_Z,attribute_points,varargin)

if nargin == 8  
    %RBF
    alph = varargin{1};
    charlie= varargin{2};
    %number of gradient points
    m=0;
    clear varargin;
elseif nargin == 10  
    %HRBF
    alph = varargin{1};
    charlie= varargin{2};
    gradient_points=varargin{3};
    bravo=varargin{4};
    m=size(gradient_points,1);
    clear varargin;
else
   error('HRBFGetPara:Please enter the correct number of parameters.')
end

bar = waitbar(0,'interpolating...'); 

num=size(attribute_points,1);%%number of attribute points
firstPart=zeros(size(grid_X));%first monomial of interpolation function
for i=1:num
   Xi=ones(size(grid_X)).*attribute_points(i,1);
   Yi=ones(size(grid_Y)).*attribute_points(i,2);
   Zi=ones(size(grid_Z)).*attribute_points(i,3);
   baseFunc=BaseFunc(grid_X,grid_Y,grid_Z,Xi,Yi,Zi,1);
   firstPart=firstPart+alph(i,1).*baseFunc;
   waitbar(i/(num+m),bar,'interpolating...')    
end

%second monomial of interpolation function
secondPart=ones(size(grid_X))*charlie(1,1)+charlie(2,1)*grid_X+charlie(3,1)*grid_Y+charlie(4,1)*grid_Z;

%RBF
if nargin == 8
    valueGrid=-(firstPart+secondPart);
    close(bar)
    return
end

%thrid monomial of interpolation function
thridPart=zeros(size(grid_X));
for i=1:m
    Xi=ones(size(grid_X))*gradient_points(i,1);
    Yi=ones(size(grid_Y))*gradient_points(i,2);
    Zi=ones(size(grid_Z))*gradient_points(i,3);
    [delta_TX,delta_TY,delta_TZ]=GetPartialDerivative(grid_X,grid_Y,grid_Z,Xi,Yi,Zi,k,baseFuncType);
    betaUsed=bravo(3*(i-1)+(1:3),1);
    thridPart=thridPart+(betaUsed(1,1)*delta_TX+betaUsed(2,1)*delta_TY+betaUsed(3,1)*delta_TZ);
    waitbar((i+num)/(num+m),bar,'interpolating...')  
end

%HRBF
if nargin == 10
    valueGrid=-(firstPart+thridPart+secondPart);
    close(bar)
    return
end
end
