library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
--use IEEE.std_logic_arith.all;
use std.textio.all;
use ieee.std_logic_textio.all;
use work.myTypes.all;


    entity svd_fsm is
      generic (    
        N_int : natural := nint;
        N_float : natural := nfloat;
        N_size : natural := size); 
      port (
    clk : in std_logic;
    rst : in std_logic;
    IN_svd : in   std_logic_vector(N_size*N_size*(N_int+N_float)- 1 downto 0);
    OUT_svd: out std_logic_vector(N_size*(N_int+N_float)- 1 downto 0)
    );

    end svd_fsm;
    
architecture beh_svd of svd_fsm is

  constant total_bit: natural :=N_int+N_float;
  
  signal state : std_logic_vector(2 downto 0);
  signal zero_float : std_logic_vector((N_float/2)-1 downto 0);
  signal zero_int : std_logic_vector((N_int/2)-1 downto 0);
  signal sum, product, lambda1, lambda2, zero : std_logic_vector(total_bit - 1 downto 0);
  
  type v1 is array (0 to N_size - 1) of std_logic_vector(total_bit - 1 downto 0);
  signal eigenvector1, eigenvector2:v1;
  
  --to store the value of the matrix
  type t11 is array (0 to N_size - 1) of std_logic_vector(total_bit - 1 downto 0);
  type t1 is array (0 to N_size -1) of t11;
  Signal C, CTC, Sigma, U, V, CTC_lambdaI : t1;
  
  
  function  sqrt  ( d : UNSIGNED ) return UNSIGNED is
      variable a : unsigned((N_int+N_float)-1 downto 0):=d;  --original input.
      variable q : unsigned(((N_int+N_float)/2)-1 downto 0):=(others => '0');  --result.
      variable left,right,r : unsigned(((N_int+N_float)/2)+1 downto 0):=(others => '0');  --input to adder/sub.r-remainder.
      variable i : integer:=0;

      begin
          for i in 0 to ((N_int+N_float)/2)-1 loop
                  right(0):='1';
                  right(1):=r(((N_int+N_float)/2)+1);
                  right(((N_int+N_float)/2)+1 downto 2):=q;
                  left(1 downto 0):=a((N_int+N_float)-1 downto (N_int+N_float)-2);
                  left(((N_int+N_float)/2)+1 downto 2):=r(((N_int+N_float)/2)-1  downto 0);
                  a((N_int+N_float)-1 downto 2):=a((N_int+N_float)-3 downto 0);  --shifting by 2 bit.
                  if ( r(((N_int+N_float)/2)+1) = '1') then
                  r := left + right;
                  else
                  r := left - right;
                  end if;
                  q(((N_int+N_float)/2)-1 downto 1) := q(((N_int+N_float)/2)-2 downto 0);
                  q(0) := not r(((N_int+N_float)/2)+1);
          end loop; 
      return q;

      end sqrt;
  
  
    
    
  
  begin
        zero_int <=(others=>'0');
        zero_float <=(others=>'0');
        zero <=(others=>'0');
      matrix_fill: process (rst)
        begin
        if (rst='1' and rst'event) then
        state <="000";
          for j in 0 to (N_size-1)  loop
           for k in 0 to (N_size-1) loop
            C(j)(k)<=IN_svd((((N_size)*(N_size-j)-k)*total_bit - 1) downto (((N_size)*(N_size-j)-k-1)*total_bit));
            end loop;
        end loop;
        end if;
       end process matrix_fill;
       
       SVD_fill: process (clk)
        begin

        if (clk='1' and rst'event) then
            case state is
            
            --evaluating the matrix CT * C
            when "000" =>
                CTC(0)(0)<=std_logic_vector(to_signed(to_integer((signed(c(0)(0))*signed(c(0)(0)))+(signed(c(1)(0))*signed(c(1)(0)))),(n_int+N_float)));
                CTC(0)(1)<=std_logic_vector(to_signed(to_integer((signed(c(0)(0))*signed(c(0)(1)))+(signed(c(1)(0))*signed(c(1)(1)))),(n_int+N_float)));
                CTC(1)(0)<=std_logic_vector(to_signed(to_integer((signed(c(0)(1))*signed(c(0)(0)))+(signed(c(1)(0))*signed(c(1)(1)))),(n_int+N_float)));
                CTC(1)(1)<=std_logic_vector(to_signed(to_integer((signed(c(0)(1))*signed(c(0)(1)))+(signed(c(1)(1))*signed(c(1)(1)))),(n_int+N_float)));
                state <="001";  
            when "001" => 
              --evaluating the characteristic polynomial of the matrix
             sum<=std_logic_vector(to_signed(to_integer((0-signed((ctc(0)(0)))+signed(ctc(1)(1)))),(n_int+N_float)));
             product <=std_logic_vector(to_signed(to_integer((signed(c(0)(0))*signed(c(1)(1)))-(signed(c(1)(0))*signed(c(0)(1)))),(n_int+N_float)));
             state <="010";
            when "010" =>
            --find the eigenvalue
            lambda1<=std_logic_vector(to_signed(((to_integer((signed(sum)+(signed(sum)*signed(sum))-(4*signed(product)))))/2),(n_int+N_float)));
            lambda2<=std_logic_vector(to_signed(((to_integer((signed(sum)-(signed(sum)*signed(sum))-(4*signed(product)))))/2),(n_int+N_float)));
            state <="011";
            when "011"=>
            --building the matrix CTC-lambdaI
            CTC_lambdaI(0)(0)<=std_logic_vector(to_signed(to_integer(signed(CTC(0)(0))-signed(lambda1)),(n_int+N_float)));
            CTC_lambdaI(0)(1)<=CTC(0)(1);
            CTC_lambdaI(1)(0)<=CTC(1)(1);
            CTC_lambdaI(1)(1)<=std_logic_vector(to_signed(to_integer(signed(CTC(1)(1))-signed(lambda2)),(n_int+N_float)));
            
            --building the Sigma amtrix
            Sigma(0)(0)((N_int+N_float)-1 downto((N_int)/2+N_float))<=zero_int;
            Sigma(0)(0)((N_float/2)-1 downto(0))<=zero_float;
            Sigma(0)(0)(((N_int)/2+N_float)-1 downto (N_float/2))<= std_logic_vector(sqrt(unsigned(lambda1))); 
            
            Sigma(0)(1)<=zero;
            Sigma(1)(0)<=zero;
            
            Sigma(1)(1)((N_int+N_float)-1 downto((N_int)/2+N_float))<=zero_int;
            Sigma(1)(1)((N_float/2)-1 downto(0))<=zero_float;
            Sigma(1)(1)(((N_int)/2+N_float)-1 downto (N_float/2))<= std_logic_vector(sqrt(unsigned(lambda2))); 
            
            state <="100";
            when others =>             
             end case; 
        end if;
       end process SVD_fill;
       
       
        
       
       
       

 
end beh_svd;  