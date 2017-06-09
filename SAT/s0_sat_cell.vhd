--(C) Gina Jiang
--gina.jiang.93@email.com


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use WORK.all;
use work.myTypes.all;

--summed area table cell
--it evaluate the SAT of a matrix MxM where M is 2^level (and obviously M<N)
--it should receive (thanks to the sat plane) the value of a partial SAT evaluated in the previous level 
entity sat_cell is 
    generic ( 
    COL_A : natural := 2;
    ROW_A : natural := 2
    ); 
    port (
   
    IN_A : in   std_logic_vector(COL_A*NBIT*ROW_A - 1 downto 0);
    OUT_A: out  std_logic_vector(COL_A*NBIT*ROW_A-1 downto 0)
      
		);
end sat_cell;

architecture struct_sat_cell of sat_cell is

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
   

function Log4( input:integer ) return integer is
 variable temp,log:integer;
 begin
  temp:=input;
  log:=0;
   while (temp /= 0) loop
    temp:=temp/4;
    log:=log+1;
   end loop;
  return log-1;
end function log4;


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

 
  type t11 is array (0 to COL_A - 1) of std_logic_vector(NBIT - 1 downto 0);
  type t1 is array (0 to ROW_A -1) of t11;
  Signal A,B,D : t1 := (others=>(others=>(others=>'0')));
  signal cout : std_logic_vector((COL_A*ROW_A)-1  downto 0) := (others=>'0');
  --A,B,C are matrix of NxN size
  --A has the value of the partial SAT evaluated in the previous level (the UP-LEFT QUARTER MATRIX is ok; it has already the desired SAT)
  --B has the partial SAT after summing in vertical (the down-left quarter matrix now is ok)
  --D has the partial SAT after summing (in vertical and) in horizontal (now the right hald matrix is ok)
  
  --at beginning
  --  a00           a01 
  --  a10           a11           ==>a00 is already ok
  
  --then
  --  a00           a01
  --  b10=a10+a00   b11=a11+a01   ==>b10 now is ok
  
  --finally
  --  a00          b01=a00+a01 
  --  b10          d11=b11+ba10                   ==>b01 and d11 now are ok
--                     (a11+a01)+(a10+a00)   
  

  
  begin
    --MATRIX A
    --get the value
  cycle_aRow:for j in 0 to (ROW_A-1) generate
  cycle_aCol: for k in 0 to (COL_A-1) generate
  A(j)(k)<=IN_A((((COL_A)*(ROW_A-j)-k)*NBIT - 1) downto (((COL_A)*(ROW_A-j)-k-1)*NBIT));
  end generate cycle_aCol;
  end generate cycle_aRow;
  
  
 cycle_SUM_Downr:
 --sum in pairs in vertical
 for j in 0 to ((ROW_A/2)-1) generate
      cycle_SUM_Downc:
      for k in 0 to (COL_A-1) generate
      
      sum: P4adder 
			generic map (Nbit, log2(Nbit)) 
      port map(A((ROW_A/2)-1)(k), A(j+ROW_A/2)(k), 
      '0', 
      B(j+ROW_A/2)(k),
      cout(COL_A*(j)+k));
      
      end generate cycle_SUM_Downc;
end generate cycle_SUM_Downr;
  
      
      
  --sum in pairs in horizontal
     cycle_SUM_LRc: 
        for c in 0 to ((COL_A/2)-1) generate
        cycle_SUM_LRr: for j in 0 to (ROW_A-1) generate
            
            --B10, up_right corner
            cycle_upper_SUM_LRr: 
            if j<ROW_A/2 generate
            up_sum: P4adder
            generic map (Nbit, log2(Nbit))
            port map(A(j)(((COL_A/2)-1)),A(j)(c+COL_A/2), 
            '0', B(j)(c+COL_A/2), 
            cout(COL_A*(c)+j+(COL_A)*(COL_A/2)));
            end generate cycle_upper_SUM_LRr;
            
           --D11, down_right corner 
           cycle_lower_SUM_LRr: 
           if j>=ROW_A/2 generate
           low_sum: P4adder
           generic map (Nbit, log2(Nbit))
           port map(B(j)((COL_A/2)-1),
           B(j)(c+COL_A/2),'0',
           D(j)(c+COL_A/2),     
           cout((COL_A)*(COL_A)-(COL_A*(c)+j)));
           end generate cycle_lower_SUM_LRr;
             
        end generate cycle_SUM_LRr;
      end generate cycle_SUM_LRc;
  
      --set the output
  f1: for j in 0 to ((ROW_A/2)-1) generate
  f2: for k in 0 to ((COL_A/2)-1) generate
  out_a((((COL_A)*(ROW_A-j)-k)*NBIT - 1) downto (((COL_A)*(ROW_A-j)-k-1)*NBIT))<=A(j)(k);
  end generate;
  end generate;
  
  f3: for j in (ROW_A/2) to (ROW_A-1) generate
  f4: for k in 0 to ((COL_A/2)-1) generate
  out_a((((COL_A)*(ROW_A-j)-k)*NBIT - 1) downto (((COL_A)*(ROW_A-j)-k-1)*NBIT))<=B(j)(k);
  end generate;
  end generate;
  
  f5: for j in 0 to ((ROW_A/2)-1) generate
  f6: for k in (COL_A/2) to (COL_A-1) generate
  out_a((((COL_A)*(ROW_A-j)-k)*NBIT - 1) downto (((COL_A)*(ROW_A-j)-k-1)*NBIT))<=B(j)(k);
  end generate;
  end generate;
  
  f7: for j in (ROW_A/2) to (ROW_A-1) generate
  f8: for k in (COL_A/2) to (COL_A-1) generate
  out_a((((COL_A)*(ROW_A-j)-k)*NBIT - 1) downto (((COL_A)*(ROW_A-j)-k-1)*NBIT))<=D(j)(k);--D
  end generate;
  end generate;
  
  end struct_sat_cell;
  
  
  