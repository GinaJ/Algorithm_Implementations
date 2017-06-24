library IEEE;
use IEEE.std_logic_1164.all;
use WORK.all;
use work.myTypes.all;

entity tb_tg_top_2d is
generic (    
        nbit : natural := TG_nbit;
        size_1 : natural := i_size;
        size_2 : natural := j_size;
        size_3 : natural := k_size); 
end tb_tg_top_2d;

architecture TEST_tg_top_2d of tb_tg_top_2d is
    signal Clock: std_logic := '0';
    signal Reset: std_logic := '1';
    signal tg_input :  std_logic_vector(size_1*size_2*nbit-1 downto 0);
    signal tg_output : std_logic_vector(size_1*size_2*nbit-1 downto 0);
    
    component TG_top_2d is
      generic (    
        nbit : natural := TG_nbit;
        size_1 : natural := i_size;
        size_2 : natural := j_size;
        size_3 : natural := k_size); 
      port (
    clk : in std_logic;
    rst : in std_logic;
    IN_TG: in std_logic_vector((size_1*size_2*nbit)-1 downto 0);
    OUT_TG: out std_logic_vector((size_1*size_2*nbit)- 1 downto 0)
    );
   end component TG_top_2d;

    
    begin
        -- instance 
	DUT: TG_top_2d
   Generic Map (nbit, size_1, size_2, size_3)   
	Port Map (clock, Reset, tg_input, tg_output);
   
  
  
  PCLOCK : process(Clock)
	begin
		Clock <= not(Clock) after 1 ns;	
	end process;
	
	Reset <= 'Z', '1' after 5 ns,'0' after 12 ns;
  
  tg_input<=x"000100020003000000010003" after 12 ns, --mx
            x"000200040006000000010002" after 14 ns, --my
            x"000300060009000000010001" after 16 ns, --mz
            
            x"000400020003000000010003" after 18 ns, --tgxx
            x"000500020003000000010003" after 20 ns, --tgxy
            x"000600020003000000010003" after 22 ns, --tgxz
            
            x"000700020003000000010003" after 24 ns, --tgyx
            x"000800020003000000010003" after 26 ns, --tgyy
            x"000900020003000000010003" after 28 ns, --tgyz
            
            x"000A00020003000000010003" after 30 ns, --tgxx
            x"000B00020003000000010003" after 32 ns, --tgyz
            x"000C00020003000000010003" after 34 ns, --tgzz
            
            --------------------------------------
            
            x"001400020003000000010003" after 36 ns, --mx
            x"001500020003000000010003" after 38 ns, --my
            x"001600020003000000010003" after 40 ns, --mz
            
            x"001700020003000000010003" after 42 ns, --tgxx
            x"001800020003000000010003" after 44 ns, --tgxy
            x"001900020003000000010003" after 46 ns, --tgxz
            
            x"001A00020003000000010003" after 48 ns, --tgyx
            x"001B00020003000000010003" after 50 ns, --tgyz
            x"001C00020003000000010003" after 52 ns, --tgyz
            
            x"001D00020003000000010003" after 54 ns, --tgxx
            x"001E00020003000000010003" after 56 ns, --tgyz
            x"001F00020003000000010003" after 58 ns; --tgzz
  
end TEST_tg_top_2d;
    