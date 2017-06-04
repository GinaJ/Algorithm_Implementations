library IEEE;
use IEEE.std_logic_1164.all;
use WORK.all;
use work.myTypes.all;

entity tb_sat is
end tb_sat;

architecture TEST of tb_sat is
    signal Clock: std_logic := '0';
    signal Reset: std_logic := '1';
    signal Data_out: std_logic_vector(COL_A_SIZE*ROW_A_SIZE*NBIT - 1 downto 0) := (others=>'0');
    signal Data_sum_out: std_logic_vector(COL_A_SIZE*ROW_A_SIZE*NBIT - 1 downto 0) := (others=>'0');
    
    
    component Matrix_A is
      generic (    
        COL_A : natural := COL_A_SIZE;
        ROW_A : natural := ROW_A_SIZE); 
      port (
        Rst  : in  std_logic;        
        Dout : out std_logic_vector(COL_A_SIZE*ROW_A_SIZE*NBIT - 1 downto 0)
        );

    end component Matrix_A;


component sat is --summed area table
    generic ( 
    COL_A : natural := COL_A_SIZE;
    ROW_A : natural := ROW_A_SIZE
    ); 
    port (
    clk : in std_logic;
    rst : in std_logic;
    IN_A : in   std_logic_vector(COL_A*NBIT*ROW_A - 1 downto 0);
    OUT_A: out  std_logic_vector(COL_A*NBIT*ROW_A-1 downto 0)
      
		);
end component sat;

component Matrix_sat is
      generic (    
        COL_A : natural := COL_A_SIZE;
        ROW_A : natural := ROW_A_SIZE); 
      port (
        Din : in std_logic_vector(COL_A*ROW_A*NBIT - 1 downto 0)
        );

    end component Matrix_sat;
    
    begin
        -- instance 
	A: Matrix_A
   Generic Map (COL_A_SIZE, ROW_A_SIZE)   
	Port Map (Reset, Data_out);
  
  sat_0: sat
  generic map(COL_A_SIZE, ROW_A_SIZE)
  port map(clock, reset, Data_out, Data_sum_out);
  
  sat_output: Matrix_sat
     Generic Map (COL_A_SIZE, ROW_A_SIZE)   
	Port Map (Data_sum_out);
  
  
  
  PCLOCK : process(Clock)
	begin
		Clock <= not(Clock) after 1 ns;	
	end process;
	
	Reset <= 'Z', '1' after 5 ns,'0' after 30 ns;
  
end TEST;
    