library IEEE;
use IEEE.std_logic_1164.all;
use WORK.all;
use work.myTypes.all;

entity tb_dct is
generic (    
        N_int : natural := DCT_ndec;
        N_float : natural := DCT_nfloat;
        N_size : natural := DCT_size); 
end tb_dct;

architecture TEST_dct of tb_dct is
    signal Clock: std_logic := '0';
    signal Reset: std_logic := '1';
    signal DCT_cosine_matrix :  std_logic_vector(N_size*N_size*(N_int+N_float)- 1 downto 0);
    signal X_vector : std_logic_vector((N_size*N_int)-1 downto 0);
    signal dct_res :  std_logic_vector((N_size*(N_int+N_float))-1 downto 0);
    component DCT_TOP is
      generic (    
        N_int : natural := DCT_ndec;
        N_float : natural := DCT_nfloat;
        N_size : natural := DCT_size); 
      port (
    clk : in std_logic;
    rst : in std_logic;
    IN_X: in std_logic_vector((N_size*N_int) downto 0);
    IN_DCT : in   std_logic_vector(N_size*N_size*(N_int+N_float)- 1 downto 0);
    OUT_DCT: out std_logic_vector(N_size*N_size*(N_int+N_float)- 1 downto 0)
      
		);

    end component DCT_TOP;


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

component Matrix_cosine is
      generic (    
        N_int : natural := DCT_ndec;
        N_float : natural := DCT_nfloat;
        N_size : natural := DCT_size); 
      port (
        Rst  : in  std_logic;
        
        --We pass all the element in a single row
        --because at priori we don't know the size of the matrix, and i cannot create NxN port (N is generic)
        Dout : out std_logic_vector(N_size*N_size*(N_int+N_float)- 1 downto 0)
        );

    end component Matrix_cosine;
    
    
    begin
        -- instance 
	cosine: Matrix_cosine
   Generic Map (DCT_ndec, DCT_nfloat, DCT_size)   
	Port Map (Reset, DCT_cosine_matrix);
  
  DCT_0: DCT_TOP
  generic map(DCT_ndec, DCT_nfloat, DCT_size)
  port map(clock, reset,X_vector,DCT_cosine_matrix, dct_res);
  
  DCT_r: dct_result
    generic map(DCT_ndec, DCT_nfloat, DCT_size)  
	Port Map (dct_res);
  
  
  
  PCLOCK : process(Clock)
	begin
		Clock <= not(Clock) after 1 ns;	
	end process;
	
	Reset <= 'Z', '1' after 5 ns,'0' after 30 ns;
  --X_vector<=x"0099004201030AB4";  --output 1609; -1742.3;  1284; -574
  
  X_vector<=x"0001000200030004"; --output  5.0000   -2.2304         0   -0.1585
  
end TEST_dct;
    