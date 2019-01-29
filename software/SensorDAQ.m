%%inicializa un sensor conectado en un canal
sensores = sdaq.Sensors;
s = sdaq.createSession();
s.Rate=10000;
s.DurationInSeconds=1;
canal=2;
sdaq.addSensor(s,canal,sensores.Thermocouple); % sensor channel 1 
scale = sdaq.getScaleFun(sensores.Thermocouple);%para que la medida me de en las unidades del sensor

%% mide un sensor
[data,time]=s.startForeground;
data = scale(data); %convierto voltaje en la medida correspondiente del sensor
plot(time,data)
xlabel('Time [s]')
ylabel('Voltaje [V]')

%% inicializa una entrada analogica
s = sdaq.createSession();
s.Rate=10000;
s.DurationInSeconds=1;
sdaq.addAnalogInput(s,0);

%% mide analog input
[data,time]=s.startForeground;
plot(time,data)
xlabel('Time [s]')
ylabel('Voltaje [V]')

