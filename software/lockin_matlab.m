daqreset
s = daq.createSession('ni');%inicializo la comunicacion
%Set acquisition duration
s.DurationInSeconds = .1;
s.Rate = 100000;

devname='Dev2';%el nombre del device
ch0=addAnalogInputChannel(s,devname,'ai0','Voltage');%ai0: pines 15-16. Señal
ch0.TerminalConfig='Differential';
ch1=addAnalogInputChannel(s,devname,'ai1','Voltage');%ai1: pines 17-18. Referencia TTL
ch1.TerminalConfig='Differential';

%% Medicion
[data,time] = startForeground(s);%empieza la medicion

figure(1);clf
plot(time,data)
xlabel('Time [s]')
ylabel('Voltage [V]')

ref_sq=data(:,2)>2;%binarizacion referencia

index=find(diff(ref_sq)==1);%indices flancos de subida
t0=time(index(1));%tiempo del primer flanco
frec=1./mean(diff(index))*s.Rate;%Frecuencia de la referencia

ref1=sin(2*pi*frec*(time-t0));%Referencia en fase
ref2=cos(2*pi*frec*(time-t0));%Referencia en cuadratura

signal=data(:,1);%señal

PSD1=2*ref1.*signal;%Phase Sensiive Detector 1
PSD2=2*ref2.*signal;%Phase Sensiive Detector 2


filtro='butter';
% filtro='ellip';
% filtro='fir1';
% filtro='none';
tau=0.02;%[s]
fc = 1/tau;%[Hz] Frecuencia de corte

switch filtro
    case 'butter'% %Filtro con butter
        order = 5;                  %el orden del filtro        
        [b,a] = butter(order,fc/(s.Rate/2)); 
        PSD1FILTRADA = filter(b,a,PSD1);
        PSD2FILTRADA = filter(b,a,PSD2);

    case 'ellip' % %filtro con ellip. elliptic filter
        order = 5;                  %el orden del filtro
        bandpassripple=5;%with 5 dB of passband ripple
        stopbandattenuation=40;%40 dB of stopband attenuation
        [b,a] = ellip(order,bandpassripple,stopbandattenuation,fc/(s.Rate/2));
        PSD1FILTRADA = filter(b,a,PSD1);
        PSD2FILTRADA = filter(b,a,PSD2);
    
    case 'fir1' % filtro con fir1. Window-based FIR filter design
        order=400;
        b = fir1(order,fc/(s.Rate/2),'low');
        a=1;
        PSD1FILTRADA = filter(b,a,PSD1);
        PSD2FILTRADA = filter(b,a,PSD2);
        
    otherwise
        %none
        a=1;
        b=1;        
        PSD1FILTRADA = filter(b,a,PSD1);
        PSD2FILTRADA = filter(b,a,PSD2);

end

figure(2);clf
% plot(time,signal,time,ref1/500)
% plot(time,PSD1)
plot(time,PSD1FILTRADA,time,PSD2FILTRADA)
% plot(time,PSD1,time, signal)
% plot(time,smooth(PSD1,10000))
xlabel('Time [s]')
ylabel('Voltage [V]')

X=PSD1FILTRADA;
Y=PSD2FILTRADA;
R=sqrt(X.^2+Y.^2);%[V]
THETA=atan2(Y,X);%[rad]
fprintf('Valores medios:\nX= %e V\nY= %e V\nR= %e V\nTHETA= %e rad\n',mean(X),mean(Y),mean(R),mean(THETA))
