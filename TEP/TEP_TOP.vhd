--(C) Gina Jiang
--gina.jiang.93@email.com
library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.std_logic_arith.all;
use work.myTypes.all;


entity TEP_TOP is 
  generic (    
        size : natural := tep_size;
        Nbit : natural := TEP_bit
        ); 
  port (
      IN_tep: in std_logic_vector((size*size*Nbit)-1 downto 0);
      out_tep: out std_logic_vector(((1+size)*(1+size)*Nbit)-1 downto 0)
  );
end TEP_TOP;


architecture struct_tep_top of TEP_TOP is

    component TEP_unit is
      generic (    
        Nbit : natural := TEP_bit); 
      port (
    
    t0 : std_logic_vector(Nbit-1 downto 0);
    tdx : std_logic_vector(Nbit-1 downto 0);
    tup : std_logic_vector(Nbit-1 downto 0);
    tsx : std_logic_vector(Nbit-1 downto 0);
    tdown : std_logic_vector(Nbit-1 downto 0);
    alpha : std_logic_vector(Nbit-1 downto 0);
    res: out std_logic_vector(Nbit-1 downto 0)
      
		);

    end component TEP_unit;
   
    
    --0 to size +1
  --type a11 is array (0 to size -1) of std_logic_vector(nbit - 1 downto 0);
  --type a1 is array (0 to size -1) of a11;
  --Signal cell : a1;
  
  type r11 is array (0 to size +1) of std_logic_vector(nbit - 1 downto 0);
  type r1 is array (0 to size +1) of r11;
  Signal res, cell : r1;
  
  signal zero : std_logic_vector(Nbit-1 downto 0);
  signal alpha : std_logic_vector(Nbit-1 downto 0);
  
  
  begin
  
  alpha<=const_alpha;
  zero<=(others=>'0');
     
      --get the input matrix
      cycle_row_in: for j in 0 to (size-1) generate
      cycle_col_in: for k in 0 to (size-1) generate
                    cell(j+1)(k+1)<=IN_tep((((size)*(size-j)-k)*NBIT - 1) downto (((size)*(size-j)-k-1)*NBIT));
                    end generate;
                    end generate;    
      
      --set zero at the boundaries
      --top and bottom side of the boudaries
      cycle_z_updown: for j in 0 to (size+1) generate
      cell(0)(j)<=(others=>'0');
      cell(size+1)(j)<=(others=>'0');
      end generate;  

      --set zero at the boundaries
      --ledt and right side of the boudaries
      cycle_z_lr: for j in 1 to (size) generate
      cell(j)(0)<=(others=>'0');
      cell(j)(size+1)<=(others=>'0');
      end generate;  
      
      --evaluate the final value of the cells in the grid
      cycle_row:  for row in 1 to (size) generate
          cycle_col:  for col in 1 to (size) generate
            tep0: TEP_unit
                generic map(Nbit)
                port map(cell(row)(col),
                        cell(row)(col+1),--dx
                        cell(row-1)(col),--up
                        cell(row)(col-1),--sx
                        cell(row+1)(col),--down
                        alpha,
                        res(row)(col)
                        --res(row)(col);
                        
                        );
          end generate;
      end generate;
      
  --    propagate the value to the boundaries
        -- at corner
        res(0)(0)<=res(1)(1);
        res(0)(size+1)<=res(1)(size);
        res(size+1)(0) <=res(size)(1);
        res(size+1)(size+1) <=res(size)(size);
        
        --at top, bottom, left, right sides
        cycle_bond:  for j in 1 to (size) generate
                    res(0)(j)<=res(1)(j); --up
                    res(j)(0)<=res(j)(1); --left
                    res(size+1)(j) <=res(size)(j); --down
                    res(j)(size+1) <=res(j)(size); --right
                    end generate;
  
  --Set the output
  cycle_row_out: for j in 0 to (size) generate
  cycle_col_out: for k in 0 to (size) generate
 
                out_tep((((size+1)*(size+1-j)-k)*NBIT - 1) downto (((size+1)*(size+1-j)-k-1)*NBIT))<=res(j)(k);
                end generate;
                end generate;    
      
      end struct_tep_top;