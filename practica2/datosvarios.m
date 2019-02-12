v=0.05/dt; %velocidad
ev=ev=((1/dt^2)*0.5^2+((5/dt^2)^2)*err1^2)^(0.5);
eps=2.77;  %cte de decaimiento (origin)
erreps=0.19; %error cte de decaimiento
%%
Ke=pi/(200*2.776^2); %difu decai
eke=2*pi/(200*2.77^3)*0.19; %error
%%
Kv=(200*v^2)/(4*pi); %difu velocidad
ekv=2*v*200*0.31/(4*pi); %error
 %%
K=v/(2*2.77);
ek=((1/(2*eps)^2)*ev+((v/2*eps^2)^2)*erreps)^(0.5);
