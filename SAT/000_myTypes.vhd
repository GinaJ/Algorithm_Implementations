library ieee;
use ieee.std_logic_1164.all;

package myTypes is
    
    --Define size of a single number-->number of bit 
    constant NBIT : natural := 16;    
    
    --Define size of matrix
    constant COL_A_SIZE : natural := 4; -- Should be equal to ROW_B_SIZE ===>SQUARE MATRIX    
    constant ROW_A_SIZE : natural := 4; 
    
    
end myTypes;