library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity SUB_P4adder is 
	generic (N : 	natural := 32;
		 PowerN:natural := 5);
	Port (	A:	In	std_logic_vector(N-1 downto 0);
		B:	In	std_logic_vector(N-1 downto 0);
		
		S:	Out	std_logic_vector(N-1 downto 0)
		
		);
end SUB_P4adder; 

architecture STRUCTURAL of SUB_P4adder is
 
component P4adder is 
	generic (
            N:		natural := 32; --number of bits, lenght of vectors
            PowerN:	natural := 5
            );
	Port (	
    		A:	In	std_logic_vector(N-1 downto 0);
		B:	In	std_logic_vector(N-1 downto 0);
		Ci:	In	std_logic;
		S:	Out	std_logic_vector(N-1 downto 0);
		Overf:	Out	std_logic
		);
end component P4adder;
 

  
  signal not_B : std_logic_vector(N-1 downto 0);
  signal c0 : std_logic;

begin

  not_B<=not(B);
	
  sub_0:P4adder 
			      generic map (N, PowerN) 
            port map(A, not_B, '1', S,c0);

end STRUCTURAL;


