library IEEE;
use IEEE.std_logic_1164.all;
use WORK.all;
use work.myTypes.all;


    entity logic_plane is
      generic (    
        nbit : natural := TG_nbit;
        size_1 : natural := i_size;
        size_2 : natural := j_size;
        size_3 : natural := k_size); 
      port (
    clk : in std_logic;
    rst : in std_logic;
    IN_TG: in std_logic_vector((size_1*size_2*nbit)-1 downto 0);
    OUT_TG: out std_logic_vector((size_1*size_2*nbit)- 1 downto 0)
    );

    end logic_plane;
    
architecture struct_logic_plane of logic_plane is

    
    component cell is
      generic (    
        nbit : natural := TG_nbit); 
      port (
    clk : in std_logic;
    rst : in std_logic;
    input: in std_logic_vector(nbit-1 downto 0);
    output: out std_logic_vector(nbit- 1 downto 0)
      
		);
   end component cell;
   
   

  
  --to store the value of the TG cell, (usefull for the testbench)
  type t11 is array (0 to size_2 - 1) of std_logic_vector(nbit - 1 downto 0);
  type t1 is array (0 to size_1 -1) of t11;
  Signal INPUT, OUTPUT : t1;
  

  begin
 
    --Set the input
  cycle_s1: for i in 0 to (size_1-1)  generate
    cycle_s2: for j in 0 to (size_2-1) generate
    
   TG_cell: cell
   Generic Map (nbit)   
	Port Map (clk, Rst, IN_TG((((size_2)*(size_1-i)-j)*nbit - 1) downto (((size_2)*(size_1-i)-j-1)*nbit)),
  OUTPUT(i)(j));
  --out_TG((((size_2)*(size_1-i)-j)*nbit - 1) downto (((size_2)*(size_1-i)-j-1)*nbit)));
    INPUT(i)(j)<=IN_TG((((size_2)*(size_1-i)-j)*nbit - 1) downto (((size_2)*(size_1-i)-j-1)*nbit));
    --OUTPUT(i)(j)<=IN_TG((((size_2)*(size_1-i)-j)*nbit - 1) downto (((size_2)*(size_1-i)-j-1)*nbit));
    out_TG((((size_2)*(size_1-i)-j)*nbit - 1) downto (((size_2)*(size_1-i)-j-1)*nbit))<=OUTPUT(i)(j);
    end generate;
  end generate;
  
    end struct_logic_plane; 