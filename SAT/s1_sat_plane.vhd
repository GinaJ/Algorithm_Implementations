library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use IEEE.numeric_std.all;
use WORK.all;
use work.myTypes.all;

--summed area table planes
--it will divide the matrix in sub-matrices MxM (M=2^level) depending on the level.
--It will give these value to the according sat_cell that will evaluate the SAT og these sub-matrices 

entity sat_plane is 
    generic (
    COL_A : natural := 2;
    ROW_A : natural := 2;
    LEVEL : natural :=1
    ); 
    port (

    IN_A : in   std_logic_vector(COL_A*NBIT*ROW_A - 1 downto 0);
    OUT_A: out  std_logic_vector(COL_A*NBIT*ROW_A-1 downto 0)
      
		);
end sat_plane;

architecture struct_sat_plane of sat_plane is

component sat_cell is 
    generic ( 
    COL_A : natural := 2;
    ROW_A : natural := 2
    ); 
    port (
    IN_A : in   std_logic_vector(COL_A*NBIT*ROW_A - 1 downto 0);
    OUT_A: out  std_logic_vector(COL_A*NBIT*ROW_A-1 downto 0)
      
		);
end component sat_cell;

constant size : integer := (2**LEVEL);
type t_line is array (0 to size-1) of std_logic_vector(size*NBIT - 1 downto 0); 
type array_line is array (0 to ((COL_A*ROW_A)/(size*size))-1) of t_line;
signal temp_imp, temp_out : array_line;
--I will store all the lines of a single sub-matrix in a single vector of type t_line.
--A single t_line will store all the elements of a single sub-matrix, thus it contains 2^level lines.

--I will store all t_line of all the sub-matrices in a vector array_lines
--the size of array_line is the number of matrix of size (2**level)x(2**level)



type t_array is array (0 to ((COL_A*ROW_A)/(size*size))-1) of std_logic_vector((size*size)*NBIT - 1 downto 0); 
signal t_input, t_output: t_array;
--I will store all the element of a single sub-matrices in a single vector of type t_array
--the size of array_line is the number of matrix of size (2**level)x(2**level)
--t_input is before the sat_cell computation, t_output is the output

type t11 is array (0 to COL_A - 1) of std_logic_vector(NBIT - 1 downto 0);
type t1 is array (0 to ROW_A -1) of t11;
  --type t is array (0 to log2(ROW_A)) of t1; --level of planes
  Signal A : t1;
  
  begin

  cycle_tempR:for j in 0 to (ROW_A/size)-1 generate
  cycle_tempLine:for i in 0 to (size-1) generate
  cycle_tempC: for k in 0 to (COL_A/size)-1 generate --with j, k generate all the small matrix    
      
      temp_imp((ROW_A/size)*j+k)(i)<=   IN_A((((COL_A)*(ROW_A)-(j*size*ROW_A)-(k*size)-(i*ROW_A))*NBIT - 1) 
     downto (((COL_A)*(ROW_A)-(j*size*ROW_A)-(k*size)-(i*ROW_A)-size)*NBIT));
  
  end generate;
  end generate;
  end generate;
  
  
  cycle_a:  for i in 0 to (((COL_A*ROW_A)/(size*size))-1) generate
  cucle_B:  for j in 0 to (2** level)-1 generate
            t_input(i)(((size*size)-(j*size))*NBIT-1
            Downto (((size*size)-((j+1)*size))*NBIT))<=temp_imp(i)(j);
            end generate;
  end generate;
      
      
 cycle_ext_u: for i in 0 to (((COL_A*ROW_A)/(size*size))-1) generate
        s0: sat_cell
        generic map(size, size)
        port map(t_input(i), t_output(i));
  end generate;
  
  
  
  --retrive the output
  cycle_y:  for i in 0 to (((COL_A*ROW_A)/(size*size))-1) generate
  cucle_z:  for j in 0 to (2** level)-1 generate
            temp_out(i)(j)<=t_output(i)(((size*size)-(j*size))*NBIT-1
            Downto (((size*size)-((j+1)*size))*NBIT));
              end generate;
  end generate;
            
  
  --set the output  
  cycle_ztempR:for j in 0 to (ROW_A/size)-1 generate
  cycle_ztempLine:for i in 0 to (size-1) generate
  cycle_ztempC: for k in 0 to (COL_A/size)-1 generate 
  out_A((((COL_A)*(ROW_A)-(j*size*ROW_A)-(k*size)-(i*ROW_A))*NBIT - 1) 
     downto (((COL_A)*(ROW_A)-(j*size*ROW_A)-(k*size)-(i*ROW_A)-size)*NBIT))<=temp_out((ROW_A/size)*j+k)(i);
  
  end generate ;
  end generate ;
  end generate;
  

  
  end struct_sat_plane;





