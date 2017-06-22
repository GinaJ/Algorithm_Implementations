library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.std_logic_arith.all;
use work.myTypes.all;


    entity cell is
      generic (    
        bit : natural := nbits); 
      port (
    clk : in std_logic;
    rst : in std_logic;
    input: in std_logic_vector((N_size*N_int)-1 downto 0);
    output: out std_logic_vector(N_size*(N_int+N_float)- 1 downto 0)
      
		);
   end cell;