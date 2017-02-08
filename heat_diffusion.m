clc
clear all
clear all hidden
close all
dx = 1E-4;
alpha = 1E-6;
dt_max = (dx)^2/(2*alpha);
dt = 1E-4;
if dt_max<dt
    dt_max
    dt = input('enter the value');
end
n =1E3;
m =1E4;
T = ones(n,1,m);
for l = 1:n
    T(l,:,1) = -((-450+520)/(1-(n/2))^2)*(l-n/2)^2+2E2;
    if T(l,:,1)<0
        T(l,:,1)=0;
    end
end
% for l =1:m/2
%     T(l,:,1) = l;
% end
% for l =m/2:m-1
%     T(l,:,1) = m-l;
% end
% T(1,:,1:m)=1E11;
% T(end,:,1:m)=1E11;
figure,plot(1:n,T(:,:,1))

% T(1,:,1:m)=1;
% T(end,:,1:m)=1;

e1 = ones(n,1)./dx^2;
A = spdiags([e1 -2*e1 e1],[-1 0 1],n,n);
A(1,1) =1;
A(1,2:n) = 0;
A(n,n) = 1;
A(n,1:n-1) = 0;
T(1,:,:) = 450;
T(n,:,:) = 450;
for t = 1:m
%     T(1,:,:) = 450;
%     T(n,:,:) = 450;
    T(:,:,t+1) = (T(:,:,t)+ ((alpha*dt)).*(A*T(:,:,t)))...
        +1100*1E6*dt/(217*180);
end
T(n/2,1,1:m)
% for i = 3500:3550
%     figure,plot(1:m,T(:,:,i))
% end
Temp = squeeze(T(:,:,m/2));
figure,plot(1:n,Temp(1:n,1))