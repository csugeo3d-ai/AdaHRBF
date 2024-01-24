function [bool] = SavePotentialField(name,path,X,Y,Z,valueGrid)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
    if(size(valueGrid,1)==0||size(valueGrid,2)==0)
        bool=false;
        return;
    end
    bool=true;
    valueMartix=[X(:),Y(:),Z(:),valueGrid(:)];
    %name=strcat(name,".csv");
    path=strcat(path,name);
    csvwrite(path,valueMartix)
    clear valueMartix index_
end

