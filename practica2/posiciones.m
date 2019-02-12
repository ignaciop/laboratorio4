T;
realposic=[4 9 13.5 17.5 22 29 37]/100;%en metros
posiciones = nan(length(T),length(realposic)); %matriz de nans de las posiciones de las termocuplas
    for j = 1:length(T)
        posiciones(j,:)=[realposic];%creo la matriz de posiciones 
        %ft(j)=fit(posiciones(j,:)',T(j,:)','exp1');
        %plot(ft(j),posiciones(j,:)',T(j,:)')
        %plot(posiciones(j,:),T(j,:),'.')
        %xlabel('Posición(m)')
        %ylabel('Temperatura(ºC)')
        %hold on
    end
    
%% or simply, choose whatever data point u like, i.e 20, then

error=1.5*ones(1,length(realposic));%las termocuplas tipo j y k tienen un error de 1.5ºC aprox
errorbar(posiciones(100,:),T(100,:),error,'o','MarkerSize',10,...
    'MarkerEdgeColor','red','MarkerFaceColor','red')
hold on
ft=fit(posiciones(100,:)',T(100,:)','exp1');
plot(ft,posiciones(100,:)',T(100,:)')


    
    
    