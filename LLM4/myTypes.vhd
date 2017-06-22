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
    
    
    --do not change for the implementation LLM dct 8 point.
    --otherwise change also the constants c1, c2, c3 ... c8
    constant DCT_ndec     : natural := 8; --number of bits for integer part
    constant DCT_nfloat   : natural := 8; --number of bits for float part
    constant DCT_size     : natural := 4; --size of the X array.
    
    
    -- constant c1 : std_logic_vector(DCT_nfloat - 1 downto 0) := "0111110110001010";
    -- constant c2 : std_logic_vector(DCT_nfloat - 1 downto 0) := "0111011001000001";
    -- constant c3 : std_logic_vector(DCT_nfloat - 1 downto 0) := "0110101001101101";
    -- constant c4 : std_logic_vector(DCT_nfloat - 1 downto 0) := "0101101010000010";
    -- constant c5 : std_logic_vector(DCT_nfloat - 1 downto 0) := "0100011100011100";
    -- constant c6 : std_logic_vector(DCT_nfloat - 1 downto 0) := "0011000011111011";
    -- constant c7 : std_logic_vector(DCT_nfloat - 1 downto 0) := "0001100011111000";
        
        
        --constant for a DCT of 4
    constant c2 : std_logic_vector(DCT_nfloat+DCT_ndec - 1 downto 0) := "0000000010000000"; --22
    constant c1 : std_logic_vector(DCT_nfloat+DCT_ndec - 1 downto 0) := "0000000010100111"; --1
    constant c3 : std_logic_vector(DCT_nfloat+DCT_ndec - 1 downto 0) := "0000000001000101"; --3
--    constant c4 : std_logic_vector(DCT_nfloat+DCT_ndec - 1 downto 0) := "00000000000000000101101010000010"; --4
--    constant c5 : std_logic_vector(DCT_nfloat+DCT_ndec - 1 downto 0) := "00000000000000000100011100011100"; --5
--    constant c6 : std_logic_vector(DCT_nfloat+DCT_ndec - 1 downto 0) := "00000000000000000011000011111011"; --6
--    constant c7 : std_logic_vector(DCT_nfloat+DCT_ndec - 1 downto 0) := "00000000000000000001100011111000"; --7
                                                              --  00000000000000000000000000000000
                                                              --  11111111111111111111111111111111
                                                              --  11111111111111111101110010101111
                                                              --  11111111111111110100111001110111
                                                              --  11111111111111111001101101101110
                                                              --  11111111111111110110100101111110
                                                              --  00000000000000000100010101000110
                                                              --  11111111111111110101100011000100
                                                              --  11111111111111101110010000001011
                                                              --  00000000000000000010001101010001
                                                              --  00000000000000000110010010010010
--    constant s1_m_c1 : std_logic_vector(DCT_nfloat+DCT_ndec - 1 downto 0) := "11111111111111111001101101101110";
--    constant m_s1_m_c1 : std_logic_vector(DCT_nfloat+DCT_ndec - 1 downto 0) := "11111111111111110110100101111110";

     constant s3_m_c3 : std_logic_vector(DCT_nfloat+DCT_ndec - 1 downto 0) := "0000000001100001";
     constant m_s3_m_c3 : std_logic_vector(DCT_nfloat+DCT_ndec - 1 downto 0):= "1111111100010011";

    
    -- constant s5_m_c5 : std_logic_vector(DCT_nfloat+DCT_ndec - 1 downto 0) := "00000000000000000010001101010001";
    -- constant m_s5_m_c5 : std_logic_vector(DCT_nfloat+DCT_ndec - 1 downto 0) := "11111111111111110100111001110111";

    
    -- constant s6_m_c6 : std_logic_vector(DCT_nfloat+DCT_ndec - 1 downto 0) := "00000000000000000100010101000110";
    -- constant m_s6_m_c6 : std_logic_vector(DCT_nfloat+DCT_ndec - 1 downto 0) := "11111111111111110101100011000100";
    
    -- constant s7_m_c7 : std_logic_vector(DCT_nfloat+DCT_ndec - 1 downto 0) := "00000000000000000110010010010010";
    -- constant m_s7_m_c7 : std_logic_vector(DCT_nfloat+DCT_ndec - 1 downto 0) := "11111111111111110110100101111110";
    
    
    
    
    end myTypes;
