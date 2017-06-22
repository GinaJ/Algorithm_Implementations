library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.std_logic_arith.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use work.myTypes.all;


    entity DCT8_TOP is
      generic (    
        N_int : natural := DCT_ndec;
        N_float : natural := DCT_nfloat;
        N_size : natural := DCT_size); 
      port (
    clk : in std_logic;
    rst : in std_logic;
    IN_X: in std_logic_vector((N_size*N_int)-1 downto 0);
    OUT_DCT: out std_logic_vector(N_size*(N_int+N_float)- 1 downto 0)
      
		);

    end DCT8_TOP;
    
architecture struct_dct8 of DCT8_TOP is

    
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

component SUB_P4adder is 
	generic (N : 	natural := 32;
		 PowerN:natural := 5);
	Port (	A:	In	std_logic_vector(N-1 downto 0);
		B:	In	std_logic_vector(N-1 downto 0);
		
		S:	Out	std_logic_vector(N-1 downto 0)
		
		);
end component SUB_P4adder;

component booth_mul_red is 
	generic (
		Nbit: 	natural := 16);
	Port (	
    		A:	In	std_logic_vector(Nbit-1 downto 0);
		B:	In	std_logic_vector(Nbit-1 downto 0);
		Res:	Out	std_logic_vector(Nbit-1 downto 0)
		);
end component booth_mul_red; 

   component DCT_LLM_rotation is
      generic (    
        N_int : natural := DCT_ndec;
        N_float : natural := DCT_nfloat); 
      port (
    
    COS1: in std_logic_vector((N_float+N_int)-1 downto 0);
    --COS2: in std_logic_vector((N_float+N_int)-1 downto 0);
    diff_cos: in std_logic_vector((N_float+N_int)-1 downto 0); --difference between the 2 cosine constant
    n_sum_cos:in std_logic_vector((N_float+N_int)-1 downto 0); --zero minus the sum of the 2 cosine constants
    IN_A: in std_logic_vector((N_float+N_int)-1 downto 0);
    IN_B: in std_logic_vector((N_float+N_int)-1 downto 0);
    SUM1: out std_logic_vector((N_float+N_int)-1 downto 0);
    SUM2: out std_logic_vector((N_float+N_int)-1 downto 0)
      
		);
    end component;

  constant total_bit: natural :=N_int+N_float;
  
  
  --store here the values of cosine
  constant cos4       : std_logic_vector(DCT_nfloat+DCT_ndec - 1 downto 0) := c4;
  constant cos1       : std_logic_vector(DCT_nfloat+DCT_ndec - 1 downto 0) := c1;
  constant diff_cos1  : std_logic_vector(DCT_nfloat+DCT_ndec - 1 downto 0) := s1_m_c1;
  constant n_sum_cos1 : std_logic_vector(DCT_nfloat+DCT_ndec - 1 downto 0) := m_s1_m_c1;
  
  constant cos6       : std_logic_vector(DCT_nfloat+DCT_ndec - 1 downto 0) := c6;
  constant diff_cos6  : std_logic_vector(DCT_nfloat+DCT_ndec - 1 downto 0) := s6_m_c6;
  constant n_sum_cos6 : std_logic_vector(DCT_nfloat+DCT_ndec - 1 downto 0) := m_s6_m_c6;
  
  constant cos5       : std_logic_vector(DCT_nfloat+DCT_ndec - 1 downto 0) := c5;
  constant diff_cos5  : std_logic_vector(DCT_nfloat+DCT_ndec - 1 downto 0) := s5_m_c5;
  constant n_sum_cos5 : std_logic_vector(DCT_nfloat+DCT_ndec - 1 downto 0) := m_s5_m_c5;
  
  constant cos7       : std_logic_vector(DCT_nfloat+DCT_ndec - 1 downto 0) := c7;
  constant diff_cos7  : std_logic_vector(DCT_nfloat+DCT_ndec - 1 downto 0) := s7_m_c7;
  constant n_sum_cos7 : std_logic_vector(DCT_nfloat+DCT_ndec - 1 downto 0) := m_s7_m_c7;
  
  
  constant cos3       : std_logic_vector(DCT_nfloat+DCT_ndec - 1 downto 0) := c3;
  constant diff_cos3  : std_logic_vector(DCT_nfloat+DCT_ndec - 1 downto 0) := s3_m_c3;
  constant n_sum_cos3 : std_logic_vector(DCT_nfloat+DCT_ndec - 1 downto 0) := m_s3_m_c3;
  
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
  
  
  --store the first/second/third/last step results
  type s11 is array (0 to N_size -1) of std_logic_vector(total_bit - 1 downto 0);
  type s1 is array (0 to (log2(N_size) + 1)) of s11;
  Signal stage : s1;
  
  --store partial rotation
  type rot11 is array (0 to 3) of std_logic_vector(total_bit - 1 downto 0);
  signal rot : rot11;
  
  --cout signal
    type c11 is array (0 to N_size - 1 ) of std_logic;
    type c1 is array (0 to N_size -1) of c11;
  signal cout : c1;
   
  begin
  
   --Sign Extend
    cycle_in: for level in 0  to N_size-1 generate
              stage(0)(level)(N_int-1 downto 0 ) <= IN_X(((N_size-level)*(N_int) - 1) downto ((N_size-1-level)*N_int));
              stage(0)(level)(total_bit-1 downto N_int ) <= ( total_bit-1 downto N_int => IN_X((N_size-level)*(N_int) - 1));
              end generate;
    
    -----------------------STAGES 1, 2, 3----------------------
    -------------------------UPPER STAGES ---------------------
    -----------------Additions and substractions---------------
    
   cycle_step:  for step in 0 to (log2(N_size)-1) generate
            
           cycle_step_add_sub:  for lev in 0  to ((N_size/(2**(1+step)))-1) generate
                                    --addition upper halves
                                    add_dct:P4adder 
                                            generic map (total_bit, log2(total_bit)) 
                                            port map(stage(step)(lev), stage(step)((N_size/(2**(step)))-1-lev), '0', stage(step+1)(lev),cout(step)(lev));
                                           
                                    
                             
                                    --substraction lower halves
                                    sub_dct:SUB_P4adder 
                                            generic map (total_bit, log2(total_bit)) 
                                            port map(stage(step)(lev), stage(step)((N_size/(2**(step)))-1-lev), stage(step+1)((N_size/(2**(step)))-1-lev));
                                            
                                end generate;
                end generate;
    
    
    
    
    -------------------- ROTATIONS ----------------------
    c1_rot: DCT_LLM_rotation
            generic map(N_int,N_float)
            port map(cos1, diff_cos1, n_sum_cos1,stage(1)(5),stage(1)(6),stage(2)(5),stage(2)(6));
            
            
    
    c3_rot: DCT_LLM_rotation
            generic map(N_int,N_float)
            port map(cos3, diff_cos3,n_sum_cos3,stage(1)(4),stage(1)(7),stage(2)(4),stage(2)(7));
            
    
    c5_rot: DCT_LLM_rotation
            generic map(N_int,N_float)
            port map(cos3, diff_cos3,n_sum_cos3,stage(1)(6),stage(1)(5),rot(0),rot(1));
    --c5_rot: DCT_LLM_rotation
      --      generic map(N_int,N_float)
        --    port map(cos5, diff_cos5, n_sum_cos5,stage(1)(5),stage(1)(6),stage(2)(5),stage(2)(6));
            
                
    c6_rot: DCT_LLM_rotation
            generic map(N_int,N_float)
            port map(cos6, diff_cos6, n_sum_cos7,stage(2)(2),stage(2)(3),stage(3)(2),stage(3)(3));
            
    c7_rot: DCT_LLM_rotation
            generic map(N_int,N_float)
            port map(cos7, diff_cos7, n_sum_cos7,stage(1)(4),stage(1)(7),rot(2),rot(3));
            
     
     
     -------------------------STAGE 3---------------------
     ----------------------lower stages-------------------
     
    
   -- add3_dct:P4adder 
     --               generic map (total_bit, log2(total_bit)) 
       --             port map(stage(2)((N_size/2)), stage(2)((N_size/2)+(N_size/4)), '0', stage(3)(N_size/2),cout(2)(0));
                   
    sub3_dct:SUB_P4adder 
                    generic map (total_bit, log2(total_bit)) 
                    port map(stage(2)((N_size/2)), stage(2)((N_size/2)+(N_size/4)), stage(3)((N_size/2)+(N_size/4)));

    --add31_dct:P4adder 
      --              generic map (total_bit, log2(total_bit)) 
        --            port map(stage(2)((N_size/2)+1), stage(2)((N_size/2)+(N_size/4)+1), '0', stage(3)((N_size/2)+(N_size/4)+1),cout(2)(1));
                   
    sub31_dct:SUB_P4adder 
                    generic map (total_bit, log2(total_bit)) 
                    port map(stage(2)((N_size/2)+(N_size/4)+1), stage(2)((N_size/2)+1), stage(3)((N_size/2)+1));
                    
    add31_dct:P4adder 
                    generic map (total_bit, log2(total_bit)) 
                    port map(rot(0), rot(2), '0', stage(3)(N_size/2),cout(2)(0));
                    
    add3_dct:P4adder 
                    generic map (total_bit, log2(total_bit)) 
                    port map(rot(1), rot(3), '0', stage(3)((N_size/2)+(N_size/4)+1),cout(2)(1));
      
     
    -------------------------STAGE 4---------------------
    
    
    mult_dct0: booth_mul_red 
        generic map (total_bit)
        Port map(stage(3)(0),cos4,stage(4)(0));
    
    mult_dct1: booth_mul_red 
        generic map (total_bit)
        Port map(stage(3)(1),cos4,stage(4)(4));
        
    stage(4)(2)<=stage(3)(2);
    stage(4)(6)<=stage(3)(3);
    stage(4)(3)<=stage(3)(5);
    stage(4)(5)<=stage(3)(6);
    stage(4)(1)<=stage(3)(4);
    stage(4)(7)<=stage(3)(7);
     
    -- add4_dct:P4adder 
                    -- generic map (total_bit, log2(total_bit)) 
                    -- port map(stage(3)((N_size/2)), stage(3)((N_size/2)+(N_size/4)+1), '0', stage(4)(1),cout(3)(1));
                   
    -- sub4_dct:SUB_P4adder 
                    -- generic map (total_bit, log2(total_bit))
                    -- port map(stage(3)((N_size/2)+(N_size/4)+1),stage(3)((N_size/2)), stage(4)((N_size/2)+(N_size/4)+1));
                    
    cycle_res : for i in 0 to (N_size-1) generate
      OUT_DCT((N_size-i)*(total_bit)- 1 downto (N_size-i-1)*(total_bit))<=stage(4)(i);
    end generate;
       
    end struct_dct8;


  
  
  
  
  
  
  
  