data = load('data_peltier.txt');

tiempo = data(:,1);
temp1 = data(:,2);
temp2 = data(:,3);
volt = data(:,4);
amps = data(:,5);


figure(1)
plot(tiempo,temp1*100,tiempo,temp2*100 ,tiempo,(temp2-temp1)*100)
xlabel('tiempo (s)')
ylabel('Temp (C)')
title('Temp 1y2')

figure(2)
plot(tiempo,volt)
xlabel('tiempo (s)')
ylabel('Voltaje (v)')
title('Voltaje')

figure(3)
plot(tiempo,amps)
xlabel('tiempo (s)')
ylabel('Amps (A)')
title('Corriente')

figure(4)
plot(amps,volt,'o')
xlabel('Amperes (A)')
ylabel('Voltaje')
title('')