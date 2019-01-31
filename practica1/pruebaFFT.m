T=10
t=0:0.01:T-0.01
w=10
x=sin(w*t)+0.5*sin(3*w*t)

figure(1);plot(t,x)

X=abs(fft(x))

dk=1/T

k=0:dk:dk*length(t)-dk
figure(2),plot(k,X)

