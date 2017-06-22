library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use WORK.all;
use work.myTypes.all;


entity BF_v2_TOP is 
    generic ( 
    nbit : natural := BF_bits;
    size : natural := BF_size
    ); 
    port (
    clk : in std_logic;
    rst : in std_logic;
    IN_BF : in   std_logic_vector(size*NBIT*size - 1 downto 0);
    OUT_BF: out  std_logic_vector(size*NBIT*size-1 downto 0)
      
		);
end BF_v2_TOP;

architecture struct_BF_v2_TOP of BF_v2_TOP is

component BF_add_shift_3 is 
	generic (
		Nbit: 	natural := 16);
	Port (	
    A:	In	std_logic_vector(Nbit-1 downto 0);
		B:	In	std_logic_vector(Nbit-1 downto 0);
    C:	In	std_logic_vector(Nbit-1 downto 0);
		Res:	Out	std_logic_vector(Nbit-1 downto 0)
		);
end component BF_add_shift_3;

component BF_add_shift_2 is 
	generic (
		Nbit: 	natural := 16);
	Port (	
    A:	In	std_logic_vector(Nbit-1 downto 0);
		B:	In	std_logic_vector(Nbit-1 downto 0);
   
		Res:	Out	std_logic_vector(Nbit-1 downto 0)
		);
end component BF_add_shift_2;

  --to store the value of the bf matrix
  type t11 is array (0 to size+1) of std_logic_vector(Nbit - 1 downto 0);
  type t1 is array (0 to size+1) of t11;
  Signal A : t1;
  
  --to store the value of the partial sum
  Signal Add_res : t1;
  
  --to store the value of the final sum
  Signal Final_res : t1;
  
  --to store the value of the resdult shifted by 4 (--> division by 16)
  Signal shift_res : t1;
  
  begin  
  
  
 

  cycle_bf_mat1: for j in 0 to (size-1)  generate
    cycle_bf_mat2: for k in 0 to (size-1) generate
    A(j+1)(k+1)<=IN_BF((((size)*(size-j)-k)*Nbit - 1) downto (((size)*(size-j)-k-1)*Nbit));
    end generate;
  end generate;
  
   --set to zero the neighbourd values of the border
  cycle_res1: for j in 0 to (size+1)  generate
   A(0)(j)<=(others=>'0');
   A(size+1)(j)<=(others=>'0');
   add_res(0)(j)<=(others=>'0');
   add_bf_up:BF_add_shift_2
    generic map(nbit)
    port map(add_res(2)(j),add_res(1)(j),final_res(1)(j));
   add_res(size+1)(j)<=(others=>'0');
   add_bf_down:BF_add_shift_2
    generic map(nbit)
    port map(add_res(size-1)(j),add_res(size)(j),final_res(size)(j));
   end generate;
   
  cycle_res2: for j in 1 to (size)  generate
   A(j)(0)<=(others=>'0');
   add_bf_sx:BF_add_shift_2
    generic map(nbit)
    port map(A(j)(2),A(j)(1),add_res(j)(1));
   A(j)(size+1)<=(others=>'0');
   add_bf_dx:BF_add_shift_2
   generic map(nbit)
    port map(A(j)(size-1),A(j)(size),add_res(j)(size));
   
   end generate;
  
  cycle_bf_add1: for j in 1 to (size)  generate
    cycle_bf_add2: for k in 2 to (size-1) generate
    add_bf:BF_add_shift_3
    generic map(nbit)
    port map(A(j)(k-1),A(j)(k),A(j)(k+1),add_res(j)(k));
    
    end generate;
  end generate;
  

  
  cycle_bf_fin1: for j in 2 to (size-1)  generate
    cycle_bf_fin2: for k in 1 to (size) generate
    add_bf:BF_add_shift_3
    generic map(nbit)
    port map(add_res(j-1)(k),add_res(j)(k),add_res(j+1)(k),final_res(j)(k));
    
    end generate;
  end generate;
  
  
     cycle_bf_shift1: for j in 1 to (size)  generate
   cycle_bf_shift2: for k in 1 to (size) generate
   shift_res(j)(k)(nbit-5 downto 0)<=final_res(j)(k)(nbit-1 downto 4);
   shift_res(j)(k)(nbit-1 downto nbit-4)<=(others=>'0');
   end generate;
  end generate;
  
  
  --keep the borde values unchanged
  -- cycle_res1: for j in 0 to (size-1)  generate
   -- shift_res(0)(j)<=A(0)(j);
   -- shift_res(size-1)(j)<=A(size-1)(j);
   -- end generate;
   
  -- cycle_res2: for j in 1 to (size-2)  generate
   -- shift_res(j)(0)<=A(j)(0);
   -- shift_res(j)(size-1)<=A(j)(size-1);
   -- end generate;

   
     cycle_bf_out1: for j in 0 to (size-1)  generate
    cycle_bf_out2: for k in 0 to (size-1) generate
    OUT_BF((((size)*(size-j)-k)*Nbit - 1) downto (((size)*(size-j)-k-1)*Nbit))<=shift_res(j)(k);
    end generate;
  end generate;
  
  
  end struct_BF_v2_TOP;
  
  
  
  
  
  
  
  
  
  
  
  
  