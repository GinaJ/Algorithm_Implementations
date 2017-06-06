library ieee;
use ieee.std_logic_1164.all;

package myTypes is
    
    --Define size of a single number-->number of bit 
    constant Nint : natural := 8;    
    constant Nfloat : natural := 8;    
    
    --Define size of matrix
    constant SIZE : natural := 4;--3 -- Should be equal to ROW_B_SIZE      
   -- constant ROW_A_SIZE : natural := 4;--4 
    
    end myTypes;