posic=[4.1 8.6 13.4 17.1 22 29.2 36.4]/100;
T = [91.60 88.43 85.53 82.65 80.86 77.64 75.64];

error=1.5*ones(1,length(posic));
errorbar(posic,T,error,'o','MarkerSize',5,...
    'MarkerEdgeColor','blue','MarkerFaceColor','blue')
hold on
ft=fit(posic',T','exp2')
plot(ft,posic,T')