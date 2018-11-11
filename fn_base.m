%RBF function


function [f]=base(r)
for i=1:3;
    for j=1:3;
        f(i,j)=sqrt((r(i,j))^2+1);
    end
end