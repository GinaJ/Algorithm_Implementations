library IEEE;
use IEEE.std_logic_1164.all; 

entity rst_delay is
Port (		
		CK            :		In	std_logic;
		RESET         :	In	std_logic;
    
    rst : out std_logic
    );
		
end rst_delay;
 
architecture Behavioral of rst_delay is 

begin
          
	process(CK)
	begin
	  if CK'event and CK='1' then -- positive edge triggered:
	    rst<=RESET;
      
	   
    end if;
	end process;
end Behavioral;
