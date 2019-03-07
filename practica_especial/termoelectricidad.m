%cd('C:\Users\publico.LABORATORIOS\Desktop\GRUPO3_PE\SensorDAQ\+sdaq')
%pause()
%% Acquire Data in the Foreground
%create session object
s = daq.createSession('ni');

%Set acquisition duration
s.DurationInSeconds = 60.0;

%Samples per second
s.Rate = 100;

%add analog input channels (temp1, temp2, volt, amps)
ch1=addAnalogInputChannel(s,'Dev4','ai1','Voltage')
ch2=addAnalogInputChannel(s,'Dev4','ai2','Voltage')
ch3=addAnalogInputChannel(s,'Dev4','ai3','Voltage')
%ch4=addAnalogInputChannel(s,'Dev4','ai4','Voltage')

ch1.InputType = 'SingleEnded'
ch2.InputType = 'SingleEnded'
ch3.InputType = 'SingleEnded'
%ch4.InputType = 'SingleEnded'
%s.inputSingleScan
%%
%get data
data = startForeground(s);

%%
%save data
save('dataPeltier_prueba2.txt','data','-ascii');

%%
data = load('dataPeltier_prueba2.txt');

temp1 = data(:,1);
temp2 = data(:,2);
volt = data(:,3);
%amps = data(:,4);


tiempo=(0:(length(temp1)-1))*(1/s.Rate);

figure(1)
ds1=smooth(temp1,30);
ds2=smooth(temp2,30);
plot(tiempo,ds1*100,tiempo,ds2*100 ,tiempo,(ds2-ds1)*100)
xlabel('tiempo (s)')
ylabel('Temp (C)')
title('Temp 1y2')

figure(2)
plot(tiempo,volt)
xlabel('tiempo (s)')
ylabel('Voltaje (v)')
title('Voltaje')

%%
figure(3)
plot(tiempo,amps)
xlabel('tiempo (s)')
ylabel('Amps (A)')
title('Corriente')



%%
%prueba
%vu = visa('ni', 'GPIB0');
vu = visa('ni', 'USB0::0x0957::0x8B18::MY51140178::INSTR');
% abre la sesi?n Visa de comunicacion
fopen(vu);

% query idn
disp(query(vu,'*IDN?'))


%create session object
s = daq.createSession('ni');

%Set acquisition duration
s.DurationInSeconds = 0.5;

%Samples per second
s.Rate = 100;

%add analog input channels (temp1, temp2, volt, amps)
ch1=addAnalogInputChannel(s,'Dev4','ai1','Voltage')
ch2=addAnalogInputChannel(s,'Dev4','ai2','Voltage')
ch3=addAnalogInputChannel(s,'Dev4','ai3','Voltage')
%ch4=addAnalogInputChannel(s,'Dev4','ai4','Voltage')

ch1.InputType = 'SingleEnded'
ch2.InputType = 'SingleEnded'
ch3.InputType = 'SingleEnded'
%ch4.InputType = 'SingleEnded'



%%
data=[];
tic
for i=1:3000
    %get data
    i
    T= startForeground(s);
    t1 = mean(T(:,1));
    t2 = mean(T(:,2));
    volt2 = mean(T(:,3));
    %%%%%
    datos='';
    n_err=0;
while(length(datos)<1)
 try
     pause(.2)
    datos=query(vu,':READ:SCALar?');
    %display(datos)
 catch
     datos='';
     fclose(vu)
     pause(.2)
     fopen(vu)
     pause(.2)
     n_err=n_err+1
     %display(datos)
 end
end
    tiempo=toc;
    %%%%%
    pause(.2)
    separador=find(datos==',');

    volt=str2num(datos(1:separador(1)-1));
    amp=str2num(datos(separador(1):separador(2)-1));

    datatemp = [tiempo t1 t2 volt2 amp];
    data = [data;datatemp];


    figure(1)
    hold on
    plot(tiempo,t1*100,'o',tiempo,t2*100,'o' ,tiempo,(t2-t1)*100,'o')
    xlabel('tiempo (s)')
    ylabel('Temp (C)')
    title('Temp 1y2')
        

    figure(2)
    hold on
    plot(tiempo,volt2,'o')
    xlabel('tiempo (s)')
    ylabel('Voltaje (v)')
    title('Voltaje')
    
    figure(3)
    hold on
    plot(tiempo,amp,'o')
    xlabel('tiempo (s)')
    ylabel('Amperes (A)')
    title('Corriente')
    
    
    figure(4)
    hold on
    plot(amp,volt2,'o')
    xlabel('Amperes (A)')
    ylabel('Voltaje')
    title('')

    save('data_peltier_celda2.txt','data','-ascii');
end
    
    


    
    
    
    
    
    
    
    
    
    
    
    
