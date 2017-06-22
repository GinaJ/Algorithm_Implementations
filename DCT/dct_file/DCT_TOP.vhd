library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.std_logic_arith.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use work.myTypes.all;


    entity DCT_TOP is
      generic (    
        N_int : natural := DCT_ndec;
        N_float : natural := DCT_nfloat;
        N_size : natural := DCT_size); 
      port (
    clk : in std_logic;
    rst : in std_logic;
    IN_X: in std_logic_vector((N_size*N_int)-1 downto 0);
    IN_DCT : in   std_logic_vector(N_size*N_size*(N_int+N_float)- 1 downto 0);
    OUT_DCT: out std_logic_vector(N_size*(N_int+N_float)- 1 downto 0)
      
		);

    end DCT_TOP;
    
architecture struct_dct of DCT_TOP is

    
    component pipeline is
generic (N    :  integer :=32);
Port (		
		CK            :		In	std_logic;
		RESET         :	In	std_logic;
    
     input  : in std_logic_vector(n-1 downto 0);
    output   : out std_logic_vector(n-1 downto 0)
    );
		
end component pipeline;

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

component booth_mul_red is 
	generic (
		Nbit: 	natural := 16);
	Port (	
    		A:	In	std_logic_vector(Nbit-1 downto 0);
		B:	In	std_logic_vector(Nbit-1 downto 0);
		Res:	Out	std_logic_vector(Nbit-1 downto 0)
		);
end component booth_mul_red; 



  constant total_bit: natural :=N_int+N_float;
  
  --signal to shift the X input
  --(needed to keep alignment with real number of cosine)
  --type x11 is array (0 to N_size - 1) of std_logic_vector(N_int - 1 downto 0);
  type x11 is array (0 to N_size - 1) of std_logic_vector(total_bit - 1 downto 0);
  signal x_input : x11;
  
  --to store the value of the cosine matrix
  type t11 is array (0 to N_size - 1) of std_logic_vector(total_bit - 1 downto 0);
  type t1 is array (0 to N_size -1) of t11;
  Signal A : t1;
  
  
  --signal for pipelining in dct (size is n_size*(n_int + n_float))
  type p_dct11 is array (1 to N_size - 1) of std_logic_vector(n_size*total_bit - 1 downto 0);
  signal  pip_dct_out : p_dct11;
  
  --signal for pipelining the X vector (integer) (size is n_int * n_size)
  type p11 is array (1 to N_size - 1) of std_logic_vector(n_size*n_int - 1 downto 0);
  signal  pip_out: p11;
  
  --signal for multiplier results
  type m11 is array (0 to N_size - 1) of std_logic_vector(total_bit - 1 downto 0);
  type m1 is array (0 to N_size -1) of m11;
  signal mult_res : m1;
  
  signal mult0_res : std_logic_vector(N_size*total_bit - 1 downto 0);
  
  --signal for adder results
  --type add11 is array (0 to N_size - 1) of std_logic_vector(total_bit - 1 downto 0);
  type add1 is array (1 to N_size -1) of std_logic_vector(N_size*total_bit - 1 downto 0);
  signal add_res : add1;
  
  --signal for adder carry out
  type c11 is array (0 to N_size - 1) of std_logic;
  type c1 is array (1 to N_size -1) of c11;
  signal cout : c1;
  
  signal  zeros : std_logic_vector(N_float-1 downto 0);
  
  function shiftLeft( A_ext:std_logic_vector; i:integer ) return std_logic_vector is
      variable signA: std_logic_vector(total_bit-1 downto 0);
      begin
	    signA := A_ext(A_ext'left  downto 0) & (i-1 downto 0 => '0');
      return signA;
  end function shiftLeft;
  
  
  
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
  zeros<=(others=>'0');
    --Set the input
  cycle_cos_mat1: for j in 0 to (N_size-1)  generate
    cycle_cos_mat2: for k in 0 to (N_size-1) generate
    A(j)(k)<=IN_DCT((((N_size)*(N_size-j)-k)*total_bit - 1) downto (((N_size)*(N_size-j)-k-1)*total_bit));
    end generate;
  end generate;
  
  
  --MODIFICARE
  --OUTPUT <= to_StdLogicVector((to_bitvector(A)) sll (conv_integer(B)));
  --to_StdLogicVector((to_bitvector((IN_X((N_size*N_int - 1) downto ((N_size-1)*N_int)))) sll (N_float));
  
  
  
  --SIGN EXTEND (x integer, with n_int bits)
    x_input(0)(N_int-1 downto 0 ) <= IN_X((N_size*N_int - 1) downto ((N_size-1)*N_int));
    x_input(0)(total_bit-1 downto N_int ) <= ( total_bit-1 downto N_int => IN_X(N_size*N_int - 1));
 -- x_input(0)<= IN_X((N_size*N_int - 1) downto ((N_size-1)*N_int))&zeros;
  --x_input(0)<=  ShiftLeft(IN_X((N_size*N_int - 1) downto ((N_size-1)*N_int)),N_float);
  
  
  
  
  --to_StdLogicVector((to_bitvector(IN_DCT((N_size*N_int - 1) downto ((N_size-1)*N_int)))) sll (N_float));
  --ShiftLeft(IN_((N_size*N_int - 1) downto ((N_size-1)*N_int)),N_float);
  pipe_0: pipeline 
    generic map (N_size*N_int)
    Port map(  clk, rst, IN_X,pip_out(1));
    
  pipe_0_dct:pipeline
    generic map (total_bit*N_size)
    Port map( clk, rst, 
    mult0_res,
    pip_dct_out(1));
    
    
    --col means row
    cycle0_mult: for row in 0  to N_size-1 generate
   
      mult0: booth_mul_red 
      generic map (total_bit)
      Port map( A(row)(0),x_input(0),mult0_res((N_size-row)*total_bit - 1 downto (N_size-row-1)*total_bit) );
      --IN_DCT((N_size*N_int - 1) downto ((N_size-1)*N_int)&zeros,mult0_res((N_size-row)*total_bit - 1 downto (N_size-row-1)*total_bit) );
    
    end generate;
  

  
  cycle_pipe: for level in 2  to N_size-1 generate
    --pipeline for input
    pipe_input: pipeline 
    generic map (n_size*n_int)
    Port map(  clk, rst, pip_out(level-1), pip_out(level));
    
    
    --x_input(level-1)<=pip_out(level)(((N_size-(level-1))*N_int - 1) downto ((N_size-(level))*N_int))&zeros;
     
     --Sign Extend
     x_input(level-1)(N_int-1 downto 0)<=pip_out(level)(((N_size-(level-1))*N_int - 1) downto ((N_size-(level))*N_int));
     x_input(level-1)(total_bit-1 downto N_int ) <= ( total_bit-1 downto N_int => pip_out(level)((N_size-(level-1))*N_int - 1));
    --x_input(level-1)<=shiftLeft(pip_out(level)(((N_size-(level-1))*N_int - 1) downto ((N_size-(level))*N_int)),N_float);
      
    
    --to_StdLogicVector((to_bitvector(pip_out(level)(((N_size-(level))*16 - 1) downto ((N_size-1-(level))*N_int)))) sll (N_float));
    --shiftLeft(pip_out(level)(((N_size-(level))*16 - 1) downto ((N_size-1-(level))*N_int)),N_float);
 
    
    
          cycle_dct: for row in 0 to N_size-1 generate
   
            mult_dct: booth_mul_red 
            generic map (total_bit)
            Port map(A(row)(level-1),x_input(level-1),mult_res(level-1)(row));
    
            add_dct:P4adder 
			      generic map (total_bit, log2(total_bit)) --modificato to_log2
			      port map(pip_dct_out(level-1)((N_size-row)*total_bit-1 downto (N_size-row-1)*total_bit), 
            mult_res(level-1)(row), '0', add_res(level-1)((N_size-row)*total_bit - 1 downto (N_size-row-1)*total_bit), cout(level-1)(row));
      
          end generate;
   
   pipe_dct: pipeline  
    generic map (N_size*total_bit)
    Port map(  clk, rst, 
    add_res(level-1), 
    pip_dct_out(level)); 
    
  end generate;
  
  
      --x_input(N_size-1)<=pip_out(N_size-1)(N_int-1 downto 0)&zeros; 
      
      
      --sign extend
      x_input(N_size-1)(N_int-1 downto 0)<=pip_out(N_size-1)(N_int-1 downto 0);
      x_input(N_size-1)(total_bit-1 downto n_int)<=( total_bit-1 downto N_int=> pip_out(N_size-1)(N_int-1));
      
      --x_input(N_size-1)<=shiftLeft(pip_out(N_size-1)(N_int-1 downto 0),N_float);  
      
      
      --to_StdLogicVector((to_bitvector(pip_out(N_size-1)(N_int-1 downto 0))) sll (N_float));

      --shiftLeft(pip_out(N_size-1)(N_int-1 downto 0),N_float);  
      
  cycle_last_dct: for row in 0  to N_size-1 generate
   
    last_mult_dct: booth_mul_red 
    generic map (total_bit)
    Port map( A(row)(N_size-1),x_input(N_size-1),mult_res(N_size-1)(row) );

    last_add_dct:P4adder 
    generic map (total_bit, log2(total_bit)) --modificato to_log2
    port map(pip_dct_out(N_size-1)((N_size-row)*total_bit-1 downto (N_size-row-1)*total_bit), 
    mult_res(N_size-1)(row), '0', out_dct((N_size-row)*total_bit - 1 downto (N_size-row-1)*total_bit), cout(N_size-1)(row));

    
    --mult_res(N_size-1)(row), '0', add_res(N_size -1)((N_size-row)*total_bit - 1 downto (N_size-row-1)*total_bit), cout(N_size-1)(row));
  end generate;   
  
 -- out_dct<=add_res(N_size -1)((N_size-row)*total_bit - 1 downto (N_size-row-1)*total_bit);
    
  end struct_dct;  