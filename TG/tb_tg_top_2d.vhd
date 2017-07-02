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
    signal finished : std_logic :='0';
    signal tg_input :  std_logic_vector(size_1*size_2*nbit-1 downto 0);
    signal output_hx : std_logic_vector(nbit-1 downto 0);
    signal output_hy : std_logic_vector(nbit-1 downto 0);
    signal output_hz : std_logic_vector(nbit-1 downto 0);
    
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
    finished: out std_logic;
    output_hx: out std_logic_vector(nbit- 1 downto 0);
    output_hy: out std_logic_vector(nbit- 1 downto 0);
    output_hz: out std_logic_vector(nbit- 1 downto 0)
    );
   end component TG_top_2d;

    
    begin
        -- instance 
	DUT: TG_top_2d
   Generic Map (nbit, size_1, size_2, size_3)   
	Port Map (clock, Reset, tg_input, finished,output_hx, output_hy, output_hz);
   
  
  
  PCLOCK : process(Clock)
	begin
		Clock <= not(Clock) after 1 ns;	
	end process;
	
	Reset <= 'Z', '1' after 5 ns,'0' after 12 ns;
    tg_input<=x"0001000200030000" after 12 ns, --mx
            x"0002000400060000" after 14 ns, --my
            x"0003000600090000" after 16 ns, --mz
            
            x"0004000200030000" after 18 ns, --tgxx
            x"0005000200030000" after 20 ns, --tgxy
            x"0006000200030000" after 22 ns, --tgxz
            
            x"0007000200030000" after 24 ns, --tgyx
            x"0008000200030000" after 26 ns, --tgyy
            x"0009000200030000" after 28 ns, --tgyz
            
            x"000A000200030000" after 30 ns, --tgxx
            x"000B000200030000" after 32 ns, --tgyz
            x"000C000200030000" after 34 ns, --tgzz
            
            --------------------------------------
            
            x"0014000200030000" after 36 ns, --mx
            x"0015000200030000" after 38 ns, --my
            x"0016000200030000" after 40 ns, --mz
            
            x"0017000200030000" after 42 ns, --tgxx
            x"0018000200030000" after 44 ns, --tgxy
            x"0019000200030000" after 46 ns, --tgxz
            
            x"001A000200030000" after 48 ns, --tgyx
            x"001B000200030000" after 50 ns, --tgyz
            x"001C000200030000" after 52 ns, --tgyz
            
            x"001D000200030000" after 54 ns, --tgxx
            x"001E000200030000" after 56 ns, --tgyz
            x"001F000200030000" after 58 ns, --tgzz
            
            ---------------------------------------------------
            
            x"0001000200030000" after 60 ns, --mx
            x"0002000400060000" after 62 ns, --my
            x"0003000600090000" after 64 ns, --mz
            
            x"0004000200030000" after 66 ns, --tgxx
            x"0005000200030000" after 68 ns, --tgxy
            x"0006000200030000" after 70 ns, --tgxz
            
            x"0007000200030000" after 72 ns, --tgyx
            x"0008000200030000" after 74 ns, --tgyy
            x"0009000200030000" after 76 ns, --tgyz
            
            x"000A000200030000" after 78 ns, --tgxx
            x"000B000200030000" after 80 ns, --tgyz
            x"000C000200030000" after 82 ns, --tgzz
            
            --------------------------------------
            
            x"0014000200030000" after 84 ns, --mx
            x"0015000200030000" after 86 ns, --my
            x"0016000200030000" after 88 ns, --mz
            
            x"0017000200030000" after 90 ns, --tgxx
            x"0018000200030000" after 92 ns, --tgxy
            x"0019000200030000" after 94 ns, --tgxz
            
            x"001A000200030000" after 96 ns, --tgyx
            x"001B000200030000" after 98 ns, --tgyz
            x"001C000200030000" after 100 ns, --tgyz
            
            x"001D000200030000" after 102 ns, --tgxx
            x"001E000200030000" after 104 ns, --tgyz
            x"001F000200030000" after 106 ns; --tgzz
  
  -- tg_input<=x"0001000200030000" after 12 ns, --mx
            -- x"000200040006000000010002" after 14 ns, --my
            -- x"000300060009000000010001" after 16 ns, --mz
            
            -- x"0004000200030000" after 18 ns, --tgxx
            -- x"0005000200030000" after 20 ns, --tgxy
            -- x"0006000200030000" after 22 ns, --tgxz
            
            -- x"0007000200030000" after 24 ns, --tgyx
            -- x"0008000200030000" after 26 ns, --tgyy
            -- x"0009000200030000" after 28 ns, --tgyz
            
            -- x"000A000200030000" after 30 ns, --tgxx
            -- x"000B000200030000" after 32 ns, --tgyz
            -- x"000C000200030000" after 34 ns, --tgzz
            
            -- --------------------------------------
            
            -- x"0014000200030000" after 36 ns, --mx
            -- x"0015000200030000" after 38 ns, --my
            -- x"0016000200030000" after 40 ns, --mz
            
            -- x"0017000200030000" after 42 ns, --tgxx
            -- x"0018000200030000" after 44 ns, --tgxy
            -- x"0019000200030000" after 46 ns, --tgxz
            
            -- x"001A000200030000" after 48 ns, --tgyx
            -- x"001B000200030000" after 50 ns, --tgyz
            -- x"001C000200030000" after 52 ns, --tgyz
            
            -- x"001D000200030000" after 54 ns, --tgxx
            -- x"001E000200030000" after 56 ns, --tgyz
            -- x"001F000200030000" after 58 ns; --tgzz
  
end TEST_tg_top_2d;
    