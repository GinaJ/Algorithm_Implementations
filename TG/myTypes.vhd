library ieee;
use ieee.std_logic_1164.all;

package myTypes is
    
    --Define size of a single number-->number of bit 
    constant TG_NBIT : natural := 16;    
    
    --Define size of the CUBE (size of i, j, k)
    constant i_size : natural:=2;
    constant j_size : natural:=3;
    constant k_size : natural:=4;
    
    end myTypes;