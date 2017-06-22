library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use work.myTypes.all;


    entity Matrix_cosine is
      generic (    
        N_int : natural := DCT_ndec;
        N_float : natural := DCT_nfloat;
        N_size : natural := DCT_size); 
      port (
        Rst  : in  std_logic;
        
        --We pass all the element in a single row
        --because at priori we don't know the size of the matrix, and i cannot create NxN port (N is generic)
        Dout : out std_logic_vector(N_size*N_size*(N_int+N_float)- 1 downto 0)
        );

    end Matrix_cosine;
    
    
architecture Matrix_cosine_Bhe of Matrix_cosine is

  constant total_bit: natural :=N_int+N_float;
  type t11 is array (0 to N_size - 1) of std_logic_vector(total_bit - 1 downto 0);
  type t1 is array (0 to N_size -1) of t11;
  Signal A : t1;
   
  begin
  FILL_Matrix_cosine: process (rst)
  file mem_fp: text;
  variable index_row : natural := 0;
  variable index_col : natural := 0;  
  variable i : natural := 0;
  variable file_line : line;
  variable tmp_data_bin : std_logic_vector((N_size*total_bit) - 1 downto 0);
     
  begin 

  -- When reset pos edge, we read the file
    if (Rst = '1' and rst'event) then
      file_open(mem_fp,"matrix_dct_MATLAB.txt",READ_MODE);
      while (not endfile(mem_fp)) loop
        readline(mem_fp,file_line);
          read(file_line,tmp_data_bin);
          --Since the file has a particular format, we need some operations to retrieve the elements of the matrix
          for i in 0 to (N_size-1) loop
          A(index_row)(i)<= tmp_data_bin((((N_size-i)*total_bit)-1) downto (N_size-i-1)*total_bit);          
          end loop;
        index_row := index_row + 1;
        end loop;
      file_close(mem_fp);
    end if;
  
  index_col := 0;
  index_row := 0;
  i := 0;
  
  
  --Set the output
  for j in 0 to (N_size-1) loop
  for k in 0 to (N_size-1) loop
  Dout((((N_size)*(N_size-j)-k)*total_bit - 1) downto (((N_size)*(N_size-j)-k-1)*total_bit))<=A(j)(k);
  end loop;
  end loop;
  
  
  end process FILL_Matrix_cosine; 
   
  end Matrix_cosine_Bhe;