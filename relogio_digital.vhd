LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
USE work.bcd_decoder.all;--chama o codigo no outro arquivo
ENTITY relogio_digital IS
GENERIC (SEG: INTEGER := 49999999); --generico para alteração do clock
PORT(
        --ENTRADAS E SAIDAS
 HEX0  :OUT STD_LOGIC_VECTOR (6 downto 0);--displays 7 segmentos
 HEX1  :OUT STD_LOGIC_VECTOR (6 downto 0);
 HEX2  :OUT STD_LOGIC_VECTOR (6 downto 0);
 HEX3  :OUT STD_LOGIC_VECTOR (6 downto 0);
 CLOCK_50 :IN STD_LOGIC -- clock 50 MHz
);
END relogio_digital;

ARCHITECTURE relog OF relogio_digital IS 
 SIGNAL counter: INTEGER RANGE 0 TO SEG; --define a variavel do contador entre 0 e SEG

 SIGNAL M0: INTEGER RANGE 0 TO 9 := 0; --variaveis para cada digito
 SIGNAL M1: INTEGER RANGE 0 TO 5 := 0; 
 SIGNAL S0: INTEGER RANGE 0 TO 9 := 0; 
 SIGNAL S1: INTEGER RANGE 0 TO 5 := 0; 
 
BEGIN
        -- Exibe nos displays fazendo a conversão usando o codigo no outro arquivo
 HEX0 <= conviseg(S0);
 HEX1 <= conviseg(S1);
 HEX2 <= conviseg(M0);
 HEX3 <= conviseg(M1);
 
 PROCESS(CLOCK_50) 
 BEGIN
  IF rising_edge(CLOCK_50) THEN -- identifica a borda de subido do clock
                        
   IF(counter /= SEG) THEN -- se counter for diferente de SEG	
    counter <= counter + 1;  --adiciona 1 a counter
                        
   ELSE --senao
    counter <= 0; -- reinicia counter
     S0 <= S0 + 1; -- adiciona 1 ao digito 0 do segundo
     IF(S0 = 9) THEN -- se digito 0 do segundo igual a 9
      S0 <= 0; -- reinicia dig 0 seg
      S1 <= S1 + 1; -- adiciona 1 ao digito 1 do segundo
      IF(S1 = 5) THEN -- se digito 1 do segundo igual a 5
       S1 <= 0;-- reinicia dig 1 seg
       M0 <= M0 + 1;-- adiciona 1 ao digito 0 do minuto
       IF(M0 = 9) THEN -- se digito 0 do minuto igual a 9
        M0 <= 0;-- reinicia dig 0 min
        M1 <= M1 + 1; -- adiciona 1 ao digito 1 do minuto
       IF (M1 = 5) THEN -- se digito 1 do minuto igual a 5
         M1 <= 0;--reinicia todos os digitos
         M0 <= 0;
         S1 <= 0;
         S0 <= 0;
       END IF;
		 END IF;
      END IF;
     END IF;
    END IF;
   END IF;
 END PROCESS;
END relog;