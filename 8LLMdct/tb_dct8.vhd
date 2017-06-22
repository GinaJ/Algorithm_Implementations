library IEEE;
use IEEE.std_logic_1164.all;
use WORK.all;
use work.myTypes.all;

entity tb_dct8 is
generic (    
        N_int : natural := DCT_ndec;
        N_float : natural := DCT_nfloat;
        N_size : natural := DCT_size); 
end tb_dct8;

architecture TEST_dct8 of tb_dct8 is
    signal Clock: std_logic := '0';
    signal Reset: std_logic := '1';
    signal X_vector : std_logic_vector((N_size*N_int)-1 downto 0);
    signal dct_res :  std_logic_vector((N_size*(N_int+N_float))-1 downto 0);
    
    
    component DCT8_TOP is
      generic (    
        N_int : natural := DCT_ndec;
        N_float : natural := DCT_nfloat;
        N_size : natural := DCT_size); 
      port (
    clk : in std_logic;
    rst : in std_logic;
    IN_X: in std_logic_vector((N_size*N_int)-1 downto 0);
    OUT_DCT: out std_logic_vector(N_size*(N_int+N_float)- 1 downto 0)
      
		);

    end component DCT8_TOP;


    component dct_result is
       generic (    
        N_int : natural := DCT_ndec;
        N_float : natural := DCT_nfloat;
        N_size : natural := DCT_size); 
      port (
        --We pass all the element in a single row
        --because at priori we don't know the size of the matrix, and i cannot create NxN port (N is generic)
        Din : in std_logic_vector(N_size*N_size*(N_int+N_float)- 1 downto 0)
        );

    end component dct_result;

   
    
    begin
        -- instance 
	
  
  DCT_0: DCT8_TOP
  generic map(DCT_ndec, DCT_nfloat, DCT_size)
  port map(clock, reset,X_vector, dct_res);
  
  DCT_r: dct_result
    generic map(DCT_ndec, DCT_nfloat, DCT_size)  
	Port Map (dct_res);
  
  
  
  PCLOCK : process(Clock)
	begin
		Clock <= not(Clock) after 1 ns;	
	end process;
	
	Reset <= 'Z', '1' after 5 ns,'0' after 30 ns;
  
  
  --X_vector<=x"00010002000300040001000200030004"; --output  
  --X_vector<=x"00110022003300440055006600770088"; --output  
    X_vector<=x"000300090006001000130004000400C7"; 
  
  
end TEST_dct8
;
    