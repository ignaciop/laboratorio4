cd('C:\Users\Publico\Desktop\Poggi-Rìos\SensorDAQ\+sdaq')
%% Acquire Data in the Foreground
%create session object
s = daq.createSession('ni');
%Set acquisition duration
s.DurationInSeconds = 60.0;
%add analog input channel
ch=addAnalogInputChannel(s,'Dev3','ai1','Voltage')
ch.TerminalConfig = 'SingleEnded'

%s.inputSingleScan
%%
%get data
data = startForeground(s);

%%
%save data
save('dataLatonFinoL7.txt','data','-ascii');