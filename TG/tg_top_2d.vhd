library IEEE;
use IEEE.std_logic_1164.all;
use WORK.all;
use work.myTypes.all;


    entity TG_TOP_2d is
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

    end TG_TOP_2d;
    
architecture struct_TG_TOP_2d of TG_TOP_2d is

    
    component logic_plane is
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

    end component logic_plane;
   
    component mem_plane is
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
   end component mem_plane;

  
  --to store the value of the TG cell, (usefull for the testbench)
  --type t11 is array (0 to size_2 - 1) of std_logic_vector(nbit - 1 downto 0);
  --type t1 is array (0 to size_1 -1) of t11;
  --Signal INPUT, OUTPUT : t1;
  
  type rst11 is array (0 to size_3) of std_logic;
  signal rst_signal :rst11;
  
  --signal for storing the results of a single plane
  type s11 is array (0 to size_3 - 1) of std_logic_vector(size_1*size_2*nbit - 1 downto 0);
  signal tg_res : s11;
  begin
 
 TG_logic : logic_plane
 generic map (nbit, size_1, size_2, size_3)
 port map(clk, rst, IN_TG, tg_res(0));
   
   rst_signal(0)<=rst;
 --save the results into a cube
 --other levels
 cycle_s3: for k in 0 to (size_3-2)  generate
 TG_mem: mem_plane
 generic map (nbit,size_1, size_2)
 port map(clk, rst_signal(k), tg_res(k), rst_signal(k+1),tg_res(k+1));
 end generate;
 
  --last level
 TG_mem: mem_plane
 generic map (nbit,size_1, size_2)
 port map(clk, rst_signal(size_3-1), tg_res(size_3-1),rst_signal(size_3), out_tg);
 
  end struct_TG_TOP_2d;  