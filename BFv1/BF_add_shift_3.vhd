library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity BF_add_shift_3 is 
	generic (
		Nbit: 	natural := 16);
	Port (	
    A:	In	std_logic_vector(Nbit-1 downto 0);
		B:	In	std_logic_vector(Nbit-1 downto 0);
    C:	In	std_logic_vector(Nbit-1 downto 0);
		Res:	Out	std_logic_vector(Nbit-1 downto 0)
		);
end BF_add_shift_3; 

architecture STRUCTURAL of BF_add_shift_3 is
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

signal res1 : std_logic_vector(Nbit-1 downto 0);
signal twiceB : std_logic_vector(Nbit-1 downto 0);
signal c1,c2 : std_logic;

function Log2( input:integer ) return integer is
 variable temp,log:integer;
 begin
  temp:=input;
  log:=0;
   while (temp /= 0) loop
    temp:=temp/2;
    log:=log+1;
   end loop;
  return log-1;
end function log2;

begin
twiceB(Nbit-1 downto 1)<=B(Nbit-2 downto 0);
twiceB(0)<='0';

sum1:  P4adder 
			generic map (Nbit, log2(Nbit))
			port map(A,twiceB, '0', res1, c1);

sum2:  P4adder 
			generic map (Nbit, log2(Nbit))
			port map(C,res1, '0', res, c2);
end STRUCTURAL;