library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use work.myTypes.all;


-- Matrix A filled by a process which reads from a file
    entity Matrix_tep is
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

    end Matrix_tep;
    
    
architecture Matrix_tep_Bhe of Matrix_tep is

  type t11 is array (0 to size - 1) of std_logic_vector(NBIT - 1 downto 0);
  type t1 is array (0 to size -1) of t11;
  Signal A : t1;
   
  begin
  FILL_MATRIX_TEP: process (rst)
  file mem_fp: text;
  variable index_row : natural := 0;
  variable index_col : natural := 0;  
  variable i : natural := 0;
  variable file_line : line;
  variable tmp_data_hex : std_logic_vector((size*NBIT) - 1 downto 0);
     
  begin 

  -- When reset pos edge, we read the file
    if (Rst = '1' and rst'event) then
      file_open(mem_fp,"matrix_tep.txt",READ_MODE);
      while (not endfile(mem_fp)) loop
        readline(mem_fp,file_line);
          hread(file_line,tmp_data_hex);
          --Since the file has a particular format, we need some operations to retrieve the elements of the matrix
          for i in 0 to (size-1) loop
          A(index_row)(i)<= tmp_data_hex((((size-i)*NBIT)-1) downto (size-i-1)*NBIT);          
          end loop;
        index_row := index_row + 1;
        end loop;
      file_close(mem_fp);
    end if;
  
  index_col := 0;
  index_row := 0;
  i := 0;
  
  
  --Set the output
  for j in 0 to (size-1) loop
  for k in 0 to (size-1) loop
  Dout((((size)*(size-j)-k)*NBIT - 1) downto (((size)*(size-j)-k-1)*NBIT))<=A(j)(k);
  end loop;
  end loop;
  
  
  end process FILL_MATRIX_tep; 
   
  end Matrix_tep_Bhe;