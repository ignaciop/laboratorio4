%% accesos directos
% F5 ejecuta todo un archivo 
% F9 ejecuta lo seleccionado 
% ctrl+enter ejecuta una celda de codigo (separados por doble %%)
% ctrl+i smart indent

%% borro todo
clear all

%% variables que guardan enteros, cadenas de caracteres, vectores (arrays)
a=1 %asigno variables
b='hola'
c=1:10
c+2
d=1:5
c+d% esto da error

%% operaciones con arrays
d=2*c+1 %operaciones simples de vectores con numeros
c==5 %comparacion
c>5 %comparacion
d=2*(c>5) %operaciones simples de vectores con numeros
d(5) %extraccion de datos
d(4:7) %extraccion de datos
c' %transpongo
c+d % operaciones de vectores con vectores
try
    c*d %ESTO DA ERROR!!! operaciones de vectores con vectores, prod interno incorrecto
catch %si hay un error vengo aca
    disp('me dio error')
end

%%
whos %miro el tipo de datos que hay en cada variable
c*d'  %prod interno
c'*d %prod interno
c .* d %prod elemento a elemento
[c(3:8) 8] %concatenacion 
[c d] %concatenacion de vectores
[c ; d] %concatenacion de vectores

%% arrays de caracteres
b='hola'%defino un par
c='chau'
[b c] %concateno
[b;c] %concateno
c='chaucha' 
[b c]
[b;c]% ESTO DA ERROR %si los dos arrays no miden lo mismo no los puedo concatenar 
{b c} % para estas cosas es mejor este tipo de variables: CELDAS
{b;c} % para estas cosas es mejor este tipo de variables: CELDAS

%% otro tipo de variables: celdas: puedo poner cualquier cosa 
{b}%meto lo que hay en la variable b en una celda
{'b'} %meto un caracater en una celda
{1} %meto un numero en una celda
{1:10} %meto un array en una celda
{1:max(c)}
{'       '}

% arrays de celdas: como arrays, pero cada celda puede tener cualquier contenido (como excel)
d={1 '1' {1} {'1'} {'p' {1}} (3:7)} %meto muchas cosas en un array de celdas
d(1) %extraigo el contenido de la primera celda, en una celda
d{1} %extraigo el contenido de la primera celda, lo de adentro

%% estructuras y array de estructuras
e.nombre='hugo' %defino el contenido del campo de una estructura
e.edad=22 %otra
e(2).nombre='paco' %empiezo a construir un vector de estructuras
e(2).edad=20
e(3).nombre='luisito'
e(3).edad=21

%% recolecto info de array de estructuras
e %todo el array de estructuras 
e(3) %toda una estructura
e(3).edad %el contenido de un campo de una de las estructuras
e.edad %todos los contenidos de un dado campo 
[e.edad] %todos los contenidos de un dado campo 
{e.edad}
e.nombre
[e.nombre]
{e.nombre}


%% guardar, cargar, importar, exportar
data=[[1 2 3 4];[2.5 3.4 8.2 6.9]]';

csvwrite('data.csv',data)%exporto comma-separated
data=csvread('data.csv'); %importo un comma-separated

save('data.txt','data','-ascii') % exporto archivo de numeros
data=importdata('data.txt'); %importo un archivo de numeros
disp('Ojo con los signos decimales! (comas, puntos, origin, excel, etc) ')

save data data %guardo variables en un archivo de matlab
load data %leo un archivo de matlab

%% funciones: puede ser definida en otro archivo, o in-line

mifuncion = @(x) x.^2; %definicion in-line

mifuncion(5) % llamo a la funcion definida en otro archivo
mifuncion(1:10)

%% Control de flujo: FOR
for i=1:2:9
    fprintf('%d %2d %03d\n',i,i^2,i^3)
end

%% Control de flujo: while
tic %tiempo de inicio
while toc<1    
end
toc %cuanto paso desde el ultimo tic

%% Control de flujo: if else elseif
data=input('Ingrese un numero: ');
if data<0
    disp('  ingresaste negativo')
elseif data==0
    disp('  ingresaste cero')
else
    disp('  ingresaste positivo')
end

%% while break
% problema clasico 3N+1

fprintf('Problema cásico 3N+1:\n\t-Si es par, lo divido por dos\n\t-Si es impar, 3N+1\n')
while 1
    cont=0;
    n = input('Ingrese N, negativo o cero sale: ');
    if n <= 0 %si es negativo o cero
        break %sale
    end
    fprintf('%d',n)
    while n > 1
        if rem(n,2) == 0 % si es par
            n = n/2; % divido por dos
        else
            n = 3*n+1;
        end
        fprintf('-%d',n)
        cont=cont+1;
    end
    fprintf('\nSalió en %d pasos\n', cont)
end


%% algunas cosas simples de graficar
close all %cierro todas las figuras
figure(1); %abbro la figura 5
clf %borro todo lo que tenia de antes
a=randn(100,1);% defino un vector de numeritos con distribucion normal(0,1)
plot(a)%grafico
xlabel('Muestra')%pongo leyendas
ylabel('Velocidad [m/s]')%leyendas

figure(2)
hist(a)%histgrama
xlabel('Velocidad [m/s]')%pongo leyendas
ylabel('Cuentas')%leyendas

%% estadística basica t-test
a=randn(100,1);% defino un vector de numeritos con distribucion normal(0,1)
b=1+randn(50,1);%armo un nuevo vector con distribucion normal(1,1)
mean(a)%promedio
std(a)%desviacion estandar
X=-3:.1:3;
hist(a,X)%otro histograma
[h p ci s]=ttest2(a,b)%t-test de dos colas no apareado


