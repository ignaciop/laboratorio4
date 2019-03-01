%cd('C:\Users\publico.LABORATORIOS\Desktop\GRUPO3_PE\SensorDAQ\+sdaq')
%% Acquire Data in the Foreground
%create session object
s = daq.createSession('ni');
%Set acquisition duration
s.DurationInSeconds = 1800.0;
%add analog input channel
ch1=addAnalogInputChannel(s,'Dev4','ai1','Voltage')
ch2=addAnalogInputChannel(s,'Dev4','ai2','Voltage')
ch3=addAnalogInputChannel(s,'Dev4','ai3','Voltage')
ch1.InputType = 'SingleEnded'
ch2.InputType = 'SingleEnded'
ch3.InputType = 'SingleEnded'
%s.inputSingleScan
%%
%get data
data = startForeground(s);

%%
%save data
save('dataPeltier1.txt','data','-ascii');

%%
data = load('dataPeltier1.txt');

temp1 = data(:,1);
temp2 = data(:,2);
volt = data(:,3);


tiempo=(0:(length(temp1)-1))*(1/s.Rate);

figure(1)
ds1=smooth(temp1,300);
ds2=smooth(temp2,300);
plot(tiempo,ds1*100,tiempo,ds2*100 ,tiempo,(ds2-ds1)*100)
%ylabel('Tiempo (seg)')
xlabel('tiempo (s)')
ylabel('Temp (C)')
title('Temp 1y2')


figure(2)

plot(tiempo,volt)
%ylabel('Tiempo (seg)')
xlabel('tiempo (s)')
ylabel('Voltaje (v)')
title('Voltaje')






