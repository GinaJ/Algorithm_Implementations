library ieee;
use ieee.std_logic_1164.all;

package myTypes is
    
    --Define size of a single number-->number of bit 
    constant NBIT : natural := 16;    
    
    --Define size of matrix
    constant COL_A_SIZE : natural := 4;--3 -- Should be equal to ROW_B_SIZE      
    constant ROW_A_SIZE : natural := 4;--4 
    constant COL_B_SIZE : natural := 3;       
    constant ROW_B_SIZE : natural := 3; -- Should be equal to COL_A_SIZE  

    constant COL_C_SIZE : natural := 3; -- Should be equal to COL_B_SIZE      
    constant ROW_C_SIZE : natural := 4; -- Should be equal to ROW_A_SIZE
    
    
    constant DCT_ndec     : natural := 16; --number of bits for integer part
    constant DCT_nfloat   : natural := 16; --number of bits for float part
    constant DCT_size     : natural := 6; --size of the X array.
    
    
    end myTypes;