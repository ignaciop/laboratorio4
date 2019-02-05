cd('C:\Users\Publico\Desktop\Poggi-Rìos\SensorDAQ\+sdaq')

%% Acquire Data in the Foreground
%create session object
s = daq.createSession('ni');
%Set acquisition duration
s.DurationInSeconds = 60.0;
%add analog input channel
ch=addAnalogInputChannel(s,'Dev3','ai1','Voltage')
%s.inputSingleScan
%get data
data = startForeground(s);

%vector de tiempos
fraq=1000
x=0:1/fraq:60-1/fraq

%plot data
figure(1),plot(x,data)


%% Acquire Counter Input Data, single data
%create session object
s = daq.createSession('ni');
%add counter input channel
ch = addCounterInputChannel(s,'Dev6', 'ctr0', 'EdgeCount');%if type is 'pulsewidth', it will wait until pulse is detected
%reset counters
resetCounters(s);
%read counter status
c=inputSingleScan(s)

%% Acquire Counter Input Data, with internal clock
%create session object
s=daq.createSession('ni');
%add counter input channel
ch=addCounterInputChannel(s,'dev3','ctr0','edgecount');
%add analog input channel, required to set clock and rate
addAnalogInputChannel(s,'dev3', 'ai1', 'Voltage');

%set duration and rate
s.DurationInSeconds = 2;
s.Rate = 10000;

%get data
data =  startForeground(s);
%plot measured data
plot (diff(data(:,1)))