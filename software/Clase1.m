
%reconoce al generador y osciloscopio
gf = visa('ni','USB0::0x0699::0x0346::C034165::INSTR');
osc = visa('ni','USB0::0x0699::0x0363::C108013::INSTR');


%abre la sesión Visa de comunicación con el generador de funciones y
%osciloscopio
fopen(gf);
fopen(osc);

%%
fprintf(gf,'FREQ 200')
freq_gf = query(gf,'FREQ?')

fprintf(gf,'SOURce:PHASe:ADJust ')
query(gf,'PHAse?')


str=sprintf('DATA:SOURCE CH%d',1);
fprintf(osc,str);

freq_osc = query(osc,'MEASU:IMMED:VAL?')

query(osc,'MEASU:IMMed:TYPe?')

query(osc,'MEASUrement:MEAS1:VAL?')
fprintf(osc,'MEASUrement:MEAS2:TYPe {PHAse}')
query(osc,'MEASUrement:MEAS3:VAL?')
%%
%loop seteando la frecuencia

FREQ=100:0.1:110;
for i=1:(length(FREQ))
    str=sprintf('FREQ %f',FREQ(i));
    fprintf(gf,str);
    pause(0.1);
end

%cierra la sesión Visa de comunicación con el generador de funciones
fclose(gf);
fclose(osc);