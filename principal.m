clc
clear
n=input('Enter the number of nodes:');
b(1,1)=input('Write the left boundary condition value:');
b(n,1)=input('Write the right boundary condition value:');
te=input('Write the Peclets number value (K):');
dx=1/(n-1);
for i=1:n
p(i)=struct('x',(i-1)*dx,'y',(i-1)*dx);
end
for i=1:n-2
      s(i+1).miembros=[p(i),p(i+1),p(i+2)];
end
s(1).miembros=[p(1),p(2)];
s(n).miembros=[p(n-1),p(n)];
for i=1:n;
 v(i)=s(1,i).miembros(1,2);
end       
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%        Creates the polynomial and functions from Stencil  2 to n-1       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for k=1:n-2;
    for i=0:2
         pol2(i+1,1)=[1];
        for j=0:2;
           
            r(i+1,j+1,k+1)=fn_norma([p(i+k).x,p(i+k).y],[p(j+k).x,p(j+k).y]);
            end
        end
    end
for k=2:n-1;
    f(:,:,k)=fn_base(r(:,:,k));
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%            Creates the polynomial and functions from Stencil 1 y n              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for k=1;
    for i=0:1
         pol1(i+1,1)=[1];
        for j=0:1;
           
            rl(i+1,j+1,1)=fn_norma([p(i+k).x,p(i+k).y],[p(j+k).x,p(j+k).y]);
        end
    end
end
fl(:,:,1)=fn_basel(rl(:,:,1));
for k=n-1;
    for i=0:1
         pol1(i+1,1)=[1];
        for j=0:1;
           
            rl(i+1,j+1,2)=fn_norma([p(i+k).x,p(i+k).y],[p(j+k).x,p(j+k).y]);
            end
        end
end
 fl(:,:,2)=fn_basel(rl(:,:,2));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%          Matrix Fi of every stencil                                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=2:n-1
fun(:,:,i)=[f(:,:,i),pol2;pol2',zeros(1,1)];%
end
for i=1:2
funl(:,:,i)=[fl(:,:,i),pol1;pol1',zeros(1,1)];%
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inverse of matrix fi to find alfa(U)        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=2:n-1
C(:,:,i)=inv(fun(:,:,i));%
end
for i=1:2
Cl(:,:,i)=inv(funl(:,:,i));%
end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    derivatives for Stencil 2 to n-1                          %                                                                                                           
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for k=1:n-2
  for i=1
    for j=0:2
    if v(i+k).x==p(k+j).x
     d2(i,j+1,k)=0;
     else
        rd2(i,j+1,k)=fn_norma([v(i+k).x,v(i+k).y],[p(j+k).x,p(j+k).y]);
        d2(i,j+1,k)= -((v(i+k).x-p(k+j).x)^2)/( rd2(i,j+1,k)*((rd2(i,j+1,k))^2+1)^(3/2));
        dx2p(j+1)=[0];
    end 
    end
  end
end 
primerap
if te>=1
positivo
else 
negativo
end

z=zeros(n,1);
for i=1:n
    z(i)=p(1,i).x;
end
plot(z,U)


%mcc -m principal