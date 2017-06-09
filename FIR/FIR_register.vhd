library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use WORK.all;
use work.myTypes.all;

entity FIR_reg is
generic (N    :  integer :=(FIR_bits));
Port (		
		CK            :		In	std_logic;
		RESET         :	In	std_logic;
    
     input  : in std_logic_vector(n-1 downto 0);
    output   : out std_logic_vector(n-1 downto 0)
    );
		
end FIR_reg;


architecture Behavioral of FIR_reg is 

begin 
	process(CK)
	begin
	  if CK'event and CK='1' then -- positive edge triggered:
    if RESET='1' then
    output<=(others=>'0');
    else
    output<=input;
    end if;
    end if;
    	end process;

end Behavioral;