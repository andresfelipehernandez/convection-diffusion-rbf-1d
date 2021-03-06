%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%               Upwinding                                                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:2
Dsl(:,:,i)=funl(i,:,i);
end 
Ds2(1,1:7,1)=[d2(1,1:3,n-2),dx2p(1,1),dl(1,1:2,2),dxpl(1,1)];
for k=2:n-2
    for i=1:n-2
     for j=1:3
    Ds(1,1:8,k)=[d2(1,1:3,i),dx2p(1,j),d(1,1:3,k),dxp(1,j)];
     end 
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%          matrix U                                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for k=2:n-1
for i=1:3
    for j=1:3
    CU(:,:,k)=C(1:4,1:3,k)';
    end
end
end

for k=1:2
for i=1:3
    for j=1:2
        CUL(:,:,k)=Cl(1:3,1:2,k)';
    end
end
end

 for i=1:2
    ul(:,:,i)=CUL(:,:,i)*Dsl(1,:,i)';
    Ul(:,:,i)=ul(:,:,i)';
 end 
  
 U1=Ul(:,:,1);
 u22=Cl(:,:,2)';
 u2=[CU(:,:,n-1),u22]*Ds2';
 U2=u2';

for i=2:n-2
a(:,:,i)=[CU(:,:,i);zeros(1,4)];
a2(:,:,i)=[zeros(1,4);CU(:,:,i+1)];
u(:,:,i)=[a(:,:,i),a2(:,:,i)]*Ds(:,:,i)';
U(:,:,i)=u(:,:,i)';
end

u=zeros(n,n);
u(1,1:2)=Ul(:,:,1);
u(2,1:4)=U(:,:,2);
u(3,2:5)=U(:,:,3);
u(n-1,n-2:n)=U2;
u(n,n-1:n)=Ul(:,:,2);

for i=4:n-2
         u(i,i-1:i+2)=U(:,:,i);
end
 
U=inv(u)*b       
  


