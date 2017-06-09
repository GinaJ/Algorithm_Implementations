library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use work.myTypes.all;

entity FIR_constants is
      generic (    
         N_bits : natural := FIR_bits;
         N_size : natural := FIR_size); 
      port (
        Rst  : in  std_logic;
        
        --We pass all the element in a single row
        --because at priori we don't know the size of the FIR, and i cannot create N port (N is generic)
        Dout : out std_logic_vector(N_size*N_bits- 1 downto 0)
        );

    end FIR_constants;
    

architecture FIR_beh of FIR_constants is

    type t11 is array (0 to N_size - 1) of std_logic_vector(N_bits - 1 downto 0);
    Signal FIR_array : t11;
    begin
    FILL_FIR_constants: process (rst)
    file mem_fp: text;
    variable i : natural := 0;
    variable file_line : line;
    variable tmp_data_bin : std_logic_vector(N_bits - 1 downto 0);
    begin 

    i:=0;
      -- When reset pos edge, we read the file
        if (Rst = '1' and rst'event) then
          file_open(mem_fp,"FIR_constants.txt",READ_MODE);
          while (not endfile(mem_fp)) loop
            readline(mem_fp,file_line);
              hread(file_line,tmp_data_bin);
              
              FIR_array(i)<= tmp_data_bin;          
              i:=i+1;
          end loop;    
          file_close(mem_fp);
        end if;
        
        --Set the output
        for i in 0 to (N_size-1) loop
        Dout(((N_size-i)*N_bits - 1) downto ((N_size-i-1)*N_bits))<=FIR_array(i);
        end loop;
      
     end process FILL_FIR_constants; 
   
  end FIR_beh;