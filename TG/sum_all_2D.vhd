library IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
use WORK.all;
use work.myTypes.all;


    entity sum_all is
      generic (    
         nbit : natural := TG_nbit;
        size_1 : natural := i_size;
        size_2 : natural := j_size;
        size_3 : natural :=k_size); 
      port (
    clk : in std_logic;
    rst : in std_logic;
    input: in std_logic_vector((size_1*size_2*nbit)-1 downto 0);
    finished: out std_logic;
    output_hx: out std_logic_vector(nbit- 1 downto 0);
    output_hy: out std_logic_vector(nbit- 1 downto 0);
    output_hz: out std_logic_vector(nbit- 1 downto 0)
      
		);
   end sum_all;
   
   architecture beh_sum of sum_all is
   --signal Mx, My, Mz : 	std_logic_vector(nbit-1 downto 0);
   --signal TGxx, TGxy, TGxz, TGyx, TGyy, TGyz, TGzx, TGzy, TGzz : 	std_logic_vector(nbit-1 downto 0);
   --signal op1, op2 : 	std_logic_vector(nbit-1 downto 0);
   --signal Hx, Hy, Hz : 	std_logic_vector(nbit-1 downto 0);
   type state_type is (READ_MX, READ_MY, READ_MZ, READ_TGxx, READ_TGxy, READ_TGxz,READ_TGyx,READ_TGyy,READ_TGyz,READ_TGzx,READ_TGzy,READ_TGzz,stop);
   signal fsm_state: state_type;
   
     --to store the value of the TG cell, (usefull for the testbench)
  type t11 is array (0 to size_2 - 1) of std_logic_vector(nbit - 1 downto 0);
  type t1 is array (0 to size_1 -1) of t11;
  Signal tg_INPUT : t1;
    
begin


	proc_fsm : process(clk,rst) 
      constant total_cell: integer :=size_1*size_2*size_3;
      
     variable sum_hx : 	integer;
     variable sum_hy : 	integer;
     variable sum_hz : 	integer;
     variable counter: natural;
     variable counter_cell: natural:=0;
	begin
    for i in 0 to (size_1-1) loop
    for j in 0 to (size_2-1) loop
    tg_INPUT(i)(j)<=input((((size_2)*(size_1-i)-j)*nbit - 1) downto (((size_2)*(size_1-i)-j-1)*nbit));
    end loop;
    end loop;
		if rst = '1' then
			-- asynchronous reset.
      output_hx    <=(others =>'0');
      output_hy    <=(others =>'0');
      output_hx    <=(others =>'0');
      sum_hx:=0;
      sum_hy:=0;
      sum_hz:=0;
      counter:=0;
      counter_cell:=0;
			finished    <='0';
       
      fsm_state 	<= READ_MX;
		elsif (clk'event and clk = '1' and rst='0') then -- Working on rising edge
            
        case fsm_state is
					when READ_MX=>    
						 
						fsm_state 	<= READ_MY; 				
						
					when READ_MY => 
						
						fsm_state 	<= READ_MZ;  
	
					when READ_MZ => 
						
						fsm_state 	<= READ_TGxx;
					
          when READ_TGxx => 
						fsm_state 	<= READ_TGxy;  
          when READ_TGxy => 
						fsm_state 	<= READ_TGxz; 
          when READ_TGxz => 
						--TGxz<=input;
            --temp :=std_logic_vector(to_signed(to_integer(signed(op1)+signed(op2)+(signed(input)*signed(Mz))),(nbit)));          
            
            for i in 0 to (size_1-1) loop
            for j in 0 to (size_2-1) loop
            sum_hx:=sum_hx+to_integer(signed(tg_INPUT(i)(j)));
            end loop;
            end loop;
            
            output_hx<=std_logic_vector(to_signed(sum_hx,nbit));
            --Hx<=std_logic_vector(to_signed(to_integer(op1+op2+(signed(input)*signed(Mz))),(nbit)));  
						fsm_state 	<= READ_TGyx; 
          when READ_TGyx => 
          --TGyx<=input;
            --op1<=std_logic_vector(to_signed(to_integer(signed(input)*signed(Mx)),nbit));
						
						fsm_state 	<= READ_TGyy;  
          when READ_TGyy => 
          --TGyy<=input;
            --op2<=std_logic_vector(to_signed(to_integer(signed(input)*signed(My)),nbit));
						
						
						fsm_state 	<= READ_TGyz; 
          when READ_TGyz => 
            for i in 0 to (size_1-1) loop
            for j in 0 to (size_2-1) loop
            sum_hy:=sum_hy+to_integer(signed(tg_INPUT(i)(j)));
            end loop;
            end loop;
            
            output_hy<=std_logic_vector(to_signed(sum_hy,nbit));
            
						
						fsm_state 	<= READ_TGzx; 
          when READ_TGzx => 
            
						fsm_state 	<= READ_TGzy;  
          when READ_TGzy => 
            
						fsm_state 	<= READ_TGzz; 
          when READ_TGzz => 
            for i in 0 to (size_1-1) loop
            for j in 0 to (size_2-1) loop
            sum_hz:=sum_hz+to_integer(signed(tg_INPUT(i)(j)));
            end loop;
            end loop;
            
            output_hz<=std_logic_vector(to_signed(sum_hz,nbit));
            
						
					--	fsm_state 	<= IDLE; 
					--when IDLE => 
						--In idle always ask to read the first operand
						counter:=counter+1;
            counter_cell:=counter_cell+1;
            if counter_cell = total_cell then 
            fsm_state <=stop;
            finished<='1';
            elsif counter = size_3 then
            fsm_state <=READ_Mx;
            finished<='1';
            else
						fsm_state 	<= READ_Mx;		
            end if;
          
          when stop =>
          fsm_state <=stop;
					when OTHERS =>
						
						fsm_state <= READ_Mx;
        end case;
            
		end if;
	end process;
	
end architecture beh_sum;