%%
data = load('data.txt');


fraq = 1000;
T = 60;
nfft = 60000;
x = 0:1/fraq:T-1/fraq;

figure(1)
plot(x,data)


nn=60000;
Y1=abs(fft(data,nn))/length(x)*2;
Yp=Y1.^2;

dw=2*pi/(T*length(Yp)/length(x)) % esta es la resolución en frecuencia angular
w=dw*(0:(length(Yp))-1); % este es el vector de frecuencias angulares
f=w/2/pi; % dividiendo por 2pi se obtiene la frecuencia

figure(2)
plot(f,Yp)
grid on
xlabel('Frecuencia [Hz]')
title('Transformada de los datos')