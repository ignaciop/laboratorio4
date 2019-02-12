figure(1) %vamos a plotear los picos
findpeaks(T(:,1),t(:,1),'MinPeakDistance',100);%100 es la minima cantidad de puntos entre maximos locales (a ojo)
hold on
findpeaks(T(:,2),t(:,2),'MinPeakDistance',100);
xlabel('Tiempo(seg)')
ylabel('Temperatura(ºC)')

%%
[pks1,locs1]=findpeaks(T(:,1),t(:,1),'MinPeakDistance',100)% quiero las 2 coordenadas de los picos. Es más, solo me interesa la cooredenada temporal
[pks2,locs2]=findpeaks(T(:,2),t(:,2),'MinPeakDistance',100)

resta1=abs(locs2-locs1); %estos son los deltat's
dt1=mean(resta1); %le hago la media
err1=std(resta1); % error estandar
%%