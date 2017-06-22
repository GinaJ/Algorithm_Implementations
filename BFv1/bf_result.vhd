library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use work.myTypes.all;


    entity bf_result is
       generic (    
        nbit : natural := BF_bits;
    size : natural := BF_size); 
      port (
        --We pass all the element in a single row
        --because at priori we don't know the size of the matrix, and i cannot create NxN port (N is generic)
        Din : in std_logic_vector(size*size*NBIT - 1 downto 0)
        );

    end bf_result;
    
    
architecture bf_result_Bhe of bf_result is


   type t11 is array (0 to size - 1) of std_logic_vector(size*NBIT - 1 downto 0);
  Signal A : t11;
  
    
  begin
  FILL_bf_result: process (din)
  file mem_fp: text;
  variable index_row : natural := 0;
  variable index_col : natural := 0;  
  variable i : natural := 0;
  variable file_line : line;
  variable tmp_data_bin : std_logic_vector((size*nbit) - 1 downto 0);
      
  begin 
  
  file_open(mem_fp,"matrix_bf_TB.txt",WRITE_MODE);
          
		  
		   for j in 0 to (size-1) loop
        A(j)<=Din((((size)*(size-j))*NBIT - 1) downto (((size)*(size-j-1))*NBIT));
        hwrite(file_line,A(j),right,(size)*(size));
        writeline(mem_fp,file_line);
        end loop;
  file_close(mem_fp);
  

    
  end process FILL_bf_result;
     
  end bf_result_Bhe;