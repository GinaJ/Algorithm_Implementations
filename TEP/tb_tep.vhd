library IEEE;
use IEEE.std_logic_1164.all;
use WORK.all;
use work.myTypes.all;

entity tb_tep is
end tb_tep;

architecture TEST of tb_tep is
    signal Clock: std_logic := '0';
    signal Reset: std_logic := '1';
    signal Data_in: std_logic_vector(tep_size*tep_size*TEP_BIT - 1 downto 0) := (others=>'0');
    signal Data_out: std_logic_vector((tep_size+1)*(tep_size+1)*TEP_BIT - 1 downto 0);


component TEP_TOP is 
  generic (    
        size : natural := tep_size;
        Nbit : natural := TEP_bit
        ); 
  port (
      IN_tep: in std_logic_vector((size*size*Nbit)-1 downto 0);
      out_tep: out std_logic_vector(((1+size)*(1+size)*Nbit)-1 downto 0)
  );
end component TEP_TOP;

    component Matrix_tep is
      generic (    
        size : natural := tep_size;
        Nbit : natural := TEP_bit
        ); 
      port (
        Rst  : in  std_logic;
        
        --We pass all the element in a single row
        --because at priori we don't know the size of the matrix, and i cannot create NxN port (N is generic)
        Dout : out std_logic_vector(size*size*NBIT - 1 downto 0)
        );

    end component Matrix_tep;  
    
    begin
        -- instance 
	tep_top0: TEP_TOP
            generic map(tep_size, TEP_bit)
            port map(Data_in, Data_out);
  A: Matrix_tep
   Generic Map (tep_size, TEP_bit)
	Port Map (Reset, Data_in);
  
  
  PCLOCK : process(Clock)
	begin
		Clock <= not(Clock) after 1 ns;	
	end process;
	
	Reset <= 'Z', '1' after 5 ns,'0' after 30 ns;
 
  
end TEST;
    