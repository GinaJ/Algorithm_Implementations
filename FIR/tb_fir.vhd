library IEEE;
use IEEE.std_logic_1164.all;
use WORK.all;
use work.myTypes.all;

entity tb_fir is
generic (    
        N_bits : natural := FIR_bits;
        N_size : natural := FIR_size);  
end tb_fir;


architecture TEST_fir of tb_fir is
    signal Clock: std_logic := '1';
    signal Reset: std_logic := '1';
    signal FIR_const :  std_logic_vector(N_bits*N_size-1 downto 0);
    signal input_x : std_logic_vector(N_bits-1 downto 0);
    signal fir_res :  std_logic_vector(N_bits- 1 downto 0);
    
    component FIR_TOP is
      generic (    
         N_bits : natural := FIR_bits;
         N_size : natural := FIR_size); 
      port (
    clk : in std_logic;
    rst : in std_logic;
    FIR_const : in std_logic_vector(N_bits*N_size-1 downto 0);
    IN_X: in std_logic_vector(N_bits-1 downto 0); --a single input per clock
    OUT_FIR: out std_logic_vector(N_bits- 1 downto 0)
      
		);

    end component FIR_TOP;
    
    component FIR_constants is
      generic (    
         N_bits : natural := FIR_bits;
         N_size : natural := FIR_size); 
      port (
        Rst  : in  std_logic;
        
        --We pass all the element in a single row
        --because at priori we don't know the size of the FIR, and i cannot create N port (N is generic)
        Dout : out std_logic_vector(N_size*N_bits- 1 downto 0)
        );

    end component FIR_constants;
    
    begin
    
    FIR_constants_value: FIR_constants
    generic map(N_bits, N_size)
    port map(Reset, FIR_const);
    
    FIR_0 : FIR_TOP
    generic map(N_bits, N_size)
    port map(clock, Reset, FIR_const, input_x, fir_res);
    
    
    PCLOCK : process(Clock)
	begin
		Clock <= not(Clock) after 5 ns;	
	end process;
	
	Reset <= 'Z', '1' after 5 ns,'0' after 30 ns;
  --N.B. the input x has to change when we have a rising edge of the clock.
  input_x <=x"0001" after 30 ns,
            x"000A" after 40 ns,
            x"0009" after 50 ns,
            x"000B" after 60 ns,
            x"0005" after 70 ns,
            x"0002" after 80 ns,
            x"0003" after 90 ns,
            x"0006" after 100 ns,
            x"0008" after 110 ns,
            x"0007" after 120 ns;
            
  end TEST_fir;
  
    
    