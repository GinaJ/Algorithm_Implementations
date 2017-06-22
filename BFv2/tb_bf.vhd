library IEEE;
use IEEE.std_logic_1164.all;
use WORK.all;
use work.myTypes.all;

entity tb_bf is
generic (    
        nbit : natural := BF_bits;
    size : natural := BF_size); 
end tb_bf;

architecture TEST_bf of tb_bf is
    signal Clock: std_logic := '0';
    signal Reset: std_logic := '1';
    signal bf_input :  std_logic_vector(size*size*NBIT - 1 downto 0);
    signal bf_res :  std_logic_vector(size*size*NBIT - 1 downto 0);
	
    component bf_v2_TOP is
     generic ( 
    nbit : natural := BF_bits;
    size : natural := BF_size
    ); 
    port (
    clk : in std_logic;
    rst : in std_logic;
    IN_BF : in   std_logic_vector(size*NBIT*size - 1 downto 0);
    OUT_BF: out  std_logic_vector(size*NBIT*size-1 downto 0)
      
		);

    end component bf_v2_TOP;


    component bf_result is
       generic (    
        nbit : natural := BF_bits;
    size : natural := BF_size); 
      port (
        --We pass all the element in a single row
        --because at priori we don't know the size of the matrix, and i cannot create NxN port (N is generic)
        Din : in std_logic_vector(size*size*NBIT - 1 downto 0)
        );

    end component bf_result;

component BF_Matrix is
      generic (    
        nbit : natural := BF_bits;
    size : natural := BF_size); 
      port (
        Rst  : in  std_logic;
        
        --We pass all the element in a single row
        --because at priori we don't know the size of the matrix, and i cannot create NxN port (N is generic)
        Dout : out std_logic_vector(size*size*NBIT - 1 downto 0)
        );

    end component BF_Matrix;
    
    
    begin
        -- instance 
	BF_values: BF_Matrix
   Generic Map (nbit, size)   
	Port Map (Reset, bf_input);
  
  bf_0: bf_v2_TOP
   Generic Map (nbit, size)
  port map(clock, reset,bf_input, bf_res);
  
  bf_r: bf_result
   Generic Map (nbit, size) 
	Port Map (bf_res);
  
  
  
  PCLOCK : process(Clock)
	begin
		Clock <= not(Clock) after 5 ns;	
	end process;
	
	Reset <= 'Z', '1' after 5 ns,'0' after 30 ns;
  
end TEST_bf;
    