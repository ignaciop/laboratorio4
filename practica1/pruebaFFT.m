%T=10
%t=0:0.01:T-0.01
%w=10
%x=sin(w*t)+0.5*sin(3*w*t)

%figure(1);plot(t,x)

%X=abs(fft(x))

%dk=1/T

%k=0:dk:dk*length(t)-dk
%figure(2),plot(k,X)

Fs = 150; %frecuencia de sampleo en Hz
t = 0:1/Fs:1; %vector tiempo de 1 seg
f = 10; %frecuencia de la onda senoidal
x = sin(2*pi*f*t); %onda senoidal

nfft = 1024; %numero de puntos de la FFT
Y = fft(x,nfft); %tomar la FFT y llenar de ceros de manera que el largo de la FFT sea nfft
Y = Y(1:nfft/2); %la FFT es simetrica, tiro la mitad
my = abs(Y).^2; %potencia espectral
f = (0:nfft/2-1)*Fs/nfft; %vector de frecuencias

figure(1)
plot(t,x)
title('se�al');
xlabel('Tiempo (s)')
ylabel('Amplitud')

figure(2)
plot(f,my)
title('Espectro de potencia')
xlabel('Frecuencia (Hz)')
ylabel('Potencia')
