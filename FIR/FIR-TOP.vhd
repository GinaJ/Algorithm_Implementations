library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.std_logic_arith.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use work.myTypes.all;

entity FIR_TOP is
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

    end FIR_TOP;
    
    
    architecture struct_fir of FIR_TOP is
      component booth_mul_red is 
      generic (
      Nbit: 	natural := 16);
      Port (	
          A:	In	std_logic_vector(Nbit-1 downto 0);
          B:	In	std_logic_vector(Nbit-1 downto 0);
          Res:	Out	std_logic_vector(Nbit-1 downto 0)
      );
      end component booth_mul_red; 
      
      component P4adder is 
        generic (
                  N:		natural := 32; --number of bits, lenght of vectors
                  PowerN:	natural := 5
                  );
        Port (	
              A:	In	std_logic_vector(N-1 downto 0);
          B:	In	std_logic_vector(N-1 downto 0);
          Ci:	In	std_logic;
          S:	Out	std_logic_vector(N-1 downto 0);
          Overf:	Out	std_logic
          );
      end component P4adder;

      component FIR_reg is
      generic (N    :  integer :=32);
      Port (		
          CK            :		In	std_logic;
          RESET         :	In	std_logic;
          
           input  : in std_logic_vector(n-1 downto 0);
          output   : out std_logic_vector(n-1 downto 0)
          );

      end component FIR_reg;
      
      type t11 is array (0 to N_size - 1) of std_logic_vector(N_bits - 1 downto 0);
      Signal FIR_array : t11;
      
      --we save the last n inputs
      type x11 is array (0 to N_size - 1) of std_logic_vector(N_bits - 1 downto 0);
      signal x_input : x11;
      
      --signal for the product costant_i * input_i
      type m11 is array (0 to N_size - 1) of std_logic_vector(N_bits - 1 downto 0);
      signal m_res : m11;
      
      --signal that saves the partial sum
      type a11 is array (0 to N_size - 1) of std_logic_vector(N_bits - 1 downto 0);
      signal a_res : a11;
      
      type c11 is array (0 to N_size - 1) of std_logic;
      signal cout : c11;
      
      function Log2( input:integer ) return integer is
     variable temp,log:integer;
     begin
      temp:=input;
      log:=0;
       while (temp /= 0) loop
        temp:=temp/2;
        log:=log+1;
       end loop;
      return log-1;
    end function log2;
      
begin      
        --Set the input
        cycle_fir_constants:
        for i in 0 to (N_size-1) generate
        FIR_array(i)<=FIR_const(((N_size-i)*N_bits - 1) downto ((N_size-i-1)*N_bits));
        end generate;   
        
        x_input(0) <= IN_X;
        
        
        --set the first mult_fir for (costant_0 * input_0)
        mult_fir: booth_mul_red 
        generic map (N_bits)
        Port map(FIR_array(0),x_input(0),m_res(0));
        
        a_res(0)<=m_res(0);
        
        
        --set the register in cascade to store the last n inputs
        --set the multipliers for each (costant_i * input_i)
        --set the partial sum
        cycle_pipe_mult: for i in 1  to N_size-1 generate
          pipe_fir: FIR_reg  
          generic map (N_bits)
          Port map(  clk, rst, 
          x_input(i-1), 
          x_input(i));

          mult_fir: booth_mul_red 
          generic map (N_bits)
          Port map(FIR_array(i),x_input(i),m_res(i));
          
          add_dct:P4adder 
          generic map (N_bits, log2(N_bits)) --modificato to_log2
          port map(a_res(i-1),m_res(i),'0',a_res(i), cout(i)); 
        end generate;

        OUT_FIR<=a_res(N_size-1);
  end struct_fir; 