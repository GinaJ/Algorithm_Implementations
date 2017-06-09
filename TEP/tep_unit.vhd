library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.std_logic_arith.all;
use work.myTypes.all;


    entity TEP_unit is
      generic (    
        Nbit : natural := TEP_bit); 
      port (
    
    t0 : std_logic_vector(Nbit-1 downto 0);
    tdx : std_logic_vector(Nbit-1 downto 0);
    tup : std_logic_vector(Nbit-1 downto 0);
    tsx : std_logic_vector(Nbit-1 downto 0);
    tdown : std_logic_vector(Nbit-1 downto 0);
    alpha : std_logic_vector(Nbit-1 downto 0);
    res: out std_logic_vector(Nbit-1 downto 0)
      
		);

    end TEP_unit;
    
architecture struct_tep of TEP_unit is
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

component booth_mul_red is 
	generic (
		Nbit: 	natural := 16);
	Port (	
    		A:	In	std_logic_vector(Nbit-1 downto 0);
		B:	In	std_logic_vector(Nbit-1 downto 0);
		Res:	Out	std_logic_vector(Nbit-1 downto 0)
		);
end component booth_mul_red; 

component SUB_P4adder is 
	generic (N : 	natural := 32;
		 PowerN:natural := 5);
	Port (	A:	In	std_logic_vector(N-1 downto 0);
		B:	In	std_logic_vector(N-1 downto 0);
		
		S:	Out	std_logic_vector(N-1 downto 0)
		
		);
end component SUB_P4adder;

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
    
    
    --store the sum and multiplications
    type s11 is array (0 to 2) of std_logic_vector(nbit - 1 downto 0);
  signal s : s11;
    signal m1 : std_logic_vector(nbit - 1 downto 0);
  signal c0,c1,c2:std_logic;
    
    begin
    --addition 
    
    add_0:P4adder 
			      generic map (Nbit, log2(Nbit)) 
            port map(tsx, tdown, '0', s(0),c0);
            
    add_1:P4adder 
        generic map (Nbit, log2(Nbit)) 
        port map(tdx, tup, '0', s(1),c1);
        
    sub_0:SUB_P4adder    
        generic map (nbit, log2(nbit)) 
        port map(s(0),s(1), s(2));
        
    mult_0: booth_mul_red 
            generic map (nbit)
            Port map(s(2),alpha,m1);   

    
            
    add_3:P4adder 
			      generic map (nbit, log2(nbit)) 
            port map(m1,t0, '0', res,c2);
            
            
    
     
    end struct_tep;