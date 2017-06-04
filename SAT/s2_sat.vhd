library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use WORK.all;
use work.myTypes.all;


entity sat is --summed area table
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
end sat;

architecture struct_sat of sat is

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

component sat_plane is 
    generic (
    COL_A : natural := 2;
    ROW_A : natural := 2;
    LEVEL : natural :=1
    ); 
    port (
    IN_A : in   std_logic_vector(COL_A*NBIT*ROW_A - 1 downto 0);
    OUT_A: out  std_logic_vector(COL_A*NBIT*ROW_A-1 downto 0)
    );
end component sat_plane;

component pipeline is
generic (N    :  integer :=32);
Port (		
		CK            :		In	std_logic;
		RESET         :	In	std_logic;
    
     input  : in std_logic_vector(n-1 downto 0);
    output   : out std_logic_vector(n-1 downto 0)
    );
		
end component pipeline;

    
  type t is array (0 to (log2(COL_A))-1) of std_logic_vector(COL_A*NBIT*ROW_A-1 downto 0);
  Signal Aout, Apipe : t;
  --prepare the signal that connects the various partial SAT to the different levels / planes
  
  begin
 
    sp0: sat_plane
    generic map(COL_A, ROW_A, 1)
    port map(IN_A, Aout(0));
        
    cycle_level: for level in 1  to ((log2(COL_A))-1) generate
    pipe_cycle: pipeline 
    generic map (COL_A*NBIT*ROW_A)
    Port map(  clk, rst, Aout(level-1),Apipe(level));
		  
    sp_cycle: sat_plane
    generic map(COL_A, ROW_A, (level+1))
    port map(Apipe(level), Aout(level));
    end generate;
  
  OUT_A<=Aout((log2(COL_A))-1);
  end struct_sat;
  
  
  