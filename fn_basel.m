%Rbf function


function [f]=basel(r)
for i=1:2;
    for j=1:2;
        f(i,j)=sqrt((r(i,j))^2+1);
    end
end