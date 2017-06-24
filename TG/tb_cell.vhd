library IEEE;
use IEEE.std_logic_1164.all;
use WORK.all;
use work.myTypes.all;

entity tb_tg_cell is
generic (    
        nbit : natural := TG_nbit); 
end tb_tg_cell;

architecture TEST_tg_cell of tb_tg_cell is
    signal Clock: std_logic := '0';
    signal Reset: std_logic := '1';
    signal tg_input :  std_logic_vector(nbit-1 downto 0);
    signal tg_output : std_logic_vector(nbit-1 downto 0);
    
    component cell is
      generic (    
        nbit : natural := TG_nbit); 
    port (
    clk : in std_logic;
    rst : in std_logic;
    input: in std_logic_vector(nbit-1 downto 0);
    output: out std_logic_vector(nbit- 1 downto 0)
      
		);
   end component cell;

    
    begin
        -- instance 
	DUT: cell
   Generic Map (nbit)   
	Port Map (clock, Reset, tg_input, tg_output);
   
  
  
  PCLOCK : process(Clock)
	begin
		Clock <= not(Clock) after 1 ns;	
	end process;
	
	Reset <= 'Z', '1' after 5 ns,'0' after 12 ns;
  
  tg_input<=x"0001" after 12 ns, --mx
            x"0002" after 14 ns, --my
            x"0003" after 16 ns, --mz
            
            x"0004" after 18 ns, --tgxx
            x"0005" after 20 ns, --tgxy
            x"0006" after 22 ns, --tgxz
            
            x"0007" after 24 ns, --tgyx
            x"0008" after 26 ns, --tgyy
            x"0009" after 28 ns, --tgyz
            
            x"000A" after 30 ns, --tgxx
            x"000B" after 32 ns, --tgyz
            x"000C" after 34 ns, --tgzz
            
            --------------------------------------
            
            x"0014" after 36 ns, --tgxx
            x"0015" after 38 ns, --tgxy
            x"0016" after 40 ns, --tgxz
            
            x"0017" after 42 ns, --tgyx
            x"0018" after 44 ns, --tgyy
            x"0019" after 46 ns, --tgyz
            
            x"001A" after 48 ns, --tgxx
            x"001B" after 50 ns, --tgyz
            x"001C" after 52 ns; --tgzz
  
end TEST_tg_cell;
    