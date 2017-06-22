library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.std_logic_arith.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use work.myTypes.all;


    entity DCT_LLM_rotation is
      generic (    
        N_int : natural := DCT_ndec;
        N_float : natural := DCT_nfloat); 
      port (
    
    COS1: in std_logic_vector((N_float+N_int)-1 downto 0);
    --COS2: in std_logic_vector((N_float+N_int)-1 downto 0);
    diff_cos: in std_logic_vector((N_float+N_int)-1 downto 0); --difference between the 2 cosine constant
    n_sum_cos:in std_logic_vector((N_float+N_int)-1 downto 0); --zero minus the sum of the 2 cosine constants
    IN_A: in std_logic_vector((N_float+N_int)-1 downto 0);
    IN_B: in std_logic_vector((N_float+N_int)-1 downto 0);
    SUM1: out std_logic_vector((N_float+N_int)-1 downto 0);
    SUM2: out std_logic_vector((N_float+N_int)-1 downto 0)
      
		);

    end DCT_LLM_rotation;
    
architecture struct_dct_rot of DCT_LLM_rotation is
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
    

constant total_bit: natural :=N_int+N_float;    
    --store the sum and multiplications
    type m11 is array (0 to 2) of std_logic_vector(total_bit - 1 downto 0);
  signal m1 : m11;
    signal s1 : std_logic_vector(total_bit - 1 downto 0);
  signal c0,c1,c2:std_logic;
    
    begin
    --addition 
    
    add_0:P4adder 
			      generic map (total_bit, log2(total_bit)) 
            port map(IN_A, IN_B, '0', s1,c0);
    
    mult_0: booth_mul_red 
            generic map (total_bit)
            Port map(s1,cos1,m1(0));   

    mult_1: booth_mul_red 
            generic map (total_bit)
            Port map(diff_cos,IN_B,m1(1));
    
    mult_2: booth_mul_red 
            generic map (total_bit)
            Port map(n_sum_cos, IN_A, m1(2));
            
    add_1:P4adder 
			      generic map (total_bit, log2(total_bit)) 
            port map(m1(1), m1(0), '0', sum1,c1);
            
            
    add_2:P4adder 
			      generic map (total_bit, log2(total_bit)) 
            port map(m1(2), m1(0), '0', sum2,c2);
     
    end struct_dct_rot;