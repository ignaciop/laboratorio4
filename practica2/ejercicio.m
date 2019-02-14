clear all

x = 1:1000;
y = sin(x/5) + rand(1,1000)/70;

yy = 110*exp(-0.001*x) +exp(-0.0005*x).* y;
dyy = diff(yy);
 

p = [];

for c = 1:(length( dyy )-1)
    if dyy(c)>0 & dyy(c+1)<0
           prom=(x(c+1)-x(c))/2;
           promm=x(c)+prom;
           p = [p promm];
    end
end


figure(1)
hold on
plot(yy)
plot(dyy)
plot(p, 0,'r.')
grid on
axis auto
hold off


format long
TT = [];
for qq = 1:(length(p)-1)
    tt=p(qq+1)-p(qq);
    TT = [TT tt];
end
%TT

ttt=0;
for i=1:(length(p)-1)
    ttt=ttt+TT(i);
end
T=ttt/length(p) %periodo

f=1/T %% frecuencia
w=2*pi*f %frecuencia angular

er = abs(1/5 - w)/(1/5) %error relativo


%%%%Ya tenemos la frecuencia, ahora vamos a calcular el valor medio del seno de cada
%%%%oscilacion, para así obtener el perfil de la envolvente y aproximarlo a
%%%%una exponencial. (calular el factor de decaimiento)
S=[]
VM=[]
for i=1:(fix(length(yy)-T)-1)
    UU=[];
    for ii=1:(fix(T)-1)
        s=sin(x(i+ii-1));
        UU = [UU s];
        m = mean(UU);
        x
    end
    VM = [VM m];
end
VMX=[]
for iii=1:(fix(length(yy)-T)-1)
    tm=T/2;
    tms=T(iii)+tm;
    VMX = [VMX tms];
end
figure(4)
plot(VM,VMX)

    
    
    











