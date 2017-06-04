library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use work.myTypes.all;


    entity Matrix_sat is
      generic (    
        COL_A : natural := COL_A_SIZE;
        ROW_A : natural := ROW_A_SIZE); 
      port (
        Din : in std_logic_vector(COL_A*ROW_A*NBIT - 1 downto 0)
        );

    end Matrix_sat;
    
    
architecture Matrix_sat_Bhe of Matrix_sat is

  --similar to matrix_A.vhd
  --instead of reading and store into a matrix, we will do the reverse thing
  --from a single line write a matrix in a file
  type t11 is array (0 to ROW_A - 1) of std_logic_vector(COL_A*NBIT - 1 downto 0);
  Signal A : t11;
  
    type B11 is array (0 to COL_A - 1) of std_logic_vector(NBIT - 1 downto 0);
  type B1 is array (0 to ROW_A -1) of B11;
  Signal B : B1;
    
  begin
  FILL_MATRIX_sat: process (din)
  file mem_fp: text;
  variable index_row : natural := 0;
  variable index_col : natural := 0;  
  variable i : natural := 0;
  variable file_line : line;
  variable tmp_data_hex : std_logic_vector((COL_A*NBIT) - 1 downto 0);
      
  begin 
  
  file_open(mem_fp,"matrix_sat_TB.txt",WRITE_MODE);
          
  for j in 0 to (ROW_A-1) loop
        A(j)<=Din((((COL_A)*(ROW_A-j))*NBIT - 1) downto (((COL_A)*(ROW_A-j-1))*NBIT));
        hwrite(file_line,A(j),right,(COL_A)*(ROW_A));
        writeline(mem_fp,file_line);
        end loop;
  file_close(mem_fp);
    
    for j in 0 to (ROW_A-1) loop
  for k in 0 to (COL_A-1) loop
  B(j)(k)<=Din((((COL_A)*(ROW_A-j)-k)*NBIT - 1) downto (((COL_A)*(ROW_A-j)-k-1)*NBIT));
  end loop;
  end loop;
  end process FILL_MATRIX_sat;
     
  end Matrix_sat_Bhe;