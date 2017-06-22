library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use work.myTypes.all;


    entity dct_result is
       generic (    
        N_int : natural := DCT_ndec;
        N_float : natural := DCT_nfloat;
        N_size : natural := DCT_size); 
      port (
        --We pass all the element in a single row
        --because at priori we don't know the size of the matrix, and i cannot create NxN port (N is generic)
        Din : in std_logic_vector((N_size*(N_int+N_float))-1 downto 0)
        );

    end dct_result;
    
    
architecture dct_result_Bhe of dct_result is


  constant total_bit: natural :=N_int+N_float;
  
  
    
  begin
  FILL_dct_result: process (din)
  file mem_fp: text;
  variable index_row : natural := 0;
  variable index_col : natural := 0;  
  variable i : natural := 0;
  variable file_line : line;
  variable tmp_data_bin : std_logic_vector((N_size*total_bit) - 1 downto 0);
      
  begin 
  
  file_open(mem_fp,"matrix_dct_TB.txt",WRITE_MODE);
          
  for j in 0 to (N_size-1) loop
        
        write(file_line,Din(((N_size-j)*(N_int+N_float))-1 downto ((N_size-j-1)*(N_int+N_float))) ,right,(N_int+N_float));
        writeline(mem_fp,file_line);
        end loop;
        write(file_line, string'(""));
        writeline(mem_fp,file_line);
  file_close(mem_fp);
    
  end process FILL_dct_result;
     
  end dct_result_Bhe;