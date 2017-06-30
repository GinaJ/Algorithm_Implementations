library IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
use WORK.all;
use work.myTypes.all;


    entity mem_plane is
      generic (    
        nbit : natural := TG_nbit;
        size_1 : natural := i_size;
        size_2 : natural := j_size); 
      port (
    clk : in std_logic;
    rst : in std_logic;
    input: in std_logic_vector((size_1*size_2*nbit)-1 downto 0);
    rst_delayed:out std_logic;
    output: out std_logic_vector((size_1*size_2*nbit)- 1 downto 0)
      
		);
   end mem_plane;
   
 architecture struct_mem_plane of  mem_plane is 
   component memory_cell is
      generic (    
        nbit : natural := TG_nbit); 
      port (
    clk : in std_logic;
    rst : in std_logic;
    input: in std_logic_vector(nbit-1 downto 0);
    output: out std_logic_vector(nbit- 1 downto 0)
      
		);
   end component memory_cell;
   
   component rst_delay is
    Port (		
		CK            :		In	std_logic;
		RESET         :	In	std_logic;
    
    rst : out std_logic
    );
		
   end component rst_delay;
   
   signal rst_signal : std_logic;
   begin
   
   delay :rst_delay
   port map(clk,rst, rst_signal);
   cycle_s1_mem: for i in 0 to (size_1-1)  generate
    cycle_s2_mem: for j in 0 to (size_2-1) generate
    
   TG_mem: memory_cell
   Generic Map (nbit)   
	Port Map (clk, rst_signal, input((((size_2)*(size_1-i)-j)*nbit - 1) downto (((size_2)*(size_1-i)-j-1)*nbit)),
  OUTPUT((((size_2)*(size_1-i)-j)*nbit - 1) downto (((size_2)*(size_1-i)-j-1)*nbit)));
    end generate;
  end generate;
   rst_delayed<=rst_signal;
   end struct_mem_plane;