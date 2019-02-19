lockin = visa('ni','GPIB0::10::INSTR');
set(lockin,'InputBufferSize',20000)
fopen(lockin);

gf = visa('ni','USB::0x0699::0x0346::C036492::INSTR');
%abre la sesión Visa de comunicación con el generador de funciones
fopen(gf);

%%
s=[2e-9;5e-9;10e-9;20e-9;50e-9;100e-9;200e-9;500e-9;1e-6;2e-6;5e-6;10e-6;20e-6;50e-6;100e-6;200e-6;500e-6;1e-3;2e-3;5e-3;10e-3;20e-3;50e-3;100e-3;200e-3;500e-3;1];
%esto es la tabla del manual
FREQ=[50.2:0.0005:50.4]*1e03;
%FREQ=[49:0.1:49.9 50:0.001:50.08 50.085:0.00005:50.101 50.101:0.001:50.25 50.25:0.0001:50.964]*1e03;
data=[];

for i=(1:length(FREQ))
    str=sprintf('FREQ %f',FREQ(i));
    fprintf(gf,str);
    pause(1.5);


%         for i=1:length(s)
%             s_in=s(i)%da un valor numerico 1--27 a cada elemento de s
%             str=sprintf('SENS %d',i); %te devuelve el valor de ese i
%             fprintf(lockin,str)% lo stremea
            se=str2num(query(lockin,'SENS?'))+1
            
            R=str2double(query(lockin,'outp ?3')); %pregunta la amplitud R

                if R>0.8*s(se) %si la escala es mas que el 80% de la medicion.. subo de escala
                    sen=se+1;
                    str=sprintf('SENS %d',sen);
                    fprintf(lockin,str)

                else if R<0.3*s(se) %si la escala es menor que el 20% de la medicion.. bajo de escala
                    sen=se-1;
                    str=sprintf('SENS %d',sen);
                    fprintf(lockin,str)
                    end
                end

        %end % setea sensibilidad
        
     %not_ready=true   
%      %while not_ready
%          medida=medir
%          switch measure
%             case < 0.2 range
%              set range -1
%             case measure >0.8 range
%              set range +1
%             case r in ranve
%              measure in range
%              not_ready=false;
%             otherwise 
%              print('error')
%              
%          end
%      end % mejorado by chris   
        
    data(i,:)=str2num(query(lockin, 'SNAP ? 1,2,3,4'));
    %figure(7), plot(FREQ(i),data(i,3),'o')
    figure(1)
    plot(FREQ(i),data(i,3),'*')
    xlabel('f(Hz)')
    ylabel('Amp(V)')
    hold on
    figure(2)
    plot(FREQ(i),data(i,4),'o')
    xlabel('f(Hz)')
    ylabel('fase(º)')
    hold on
    
    
end