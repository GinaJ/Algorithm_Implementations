library IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
use WORK.all;
use work.myTypes.all;


    entity cell is
      generic (    
        nbit : natural := TG_nbit); 
      port (
    clk : in std_logic;
    rst : in std_logic;
    input: in std_logic_vector(nbit-1 downto 0);
    output: out std_logic_vector(nbit- 1 downto 0)
      
		);
   end cell;
   
   architecture beh_cell of cell is
   signal Mx, My, Mz : 	std_logic_vector(nbit-1 downto 0);
   signal TGxx, TGxy, TGxz, TGyx, TGyy, TGyz, TGzx, TGzy, TGzz : 	std_logic_vector(nbit-1 downto 0);
   signal op1, op2 : 	std_logic_vector(nbit-1 downto 0);
   signal Hx, Hy, Hz : 	std_logic_vector(nbit-1 downto 0);
   type state_type is (READ_MX, READ_MY, READ_MZ, READ_TGxx, READ_TGxy, READ_TGxz,READ_TGyx,READ_TGyy,READ_TGyz,READ_TGzx,READ_TGzy,READ_TGzz);
   signal fsm_state: state_type;
    
begin

	proc_fsm : process(clk,rst) 
     variable temp : 	std_logic_vector(nbit-1 downto 0);
	begin
		
		if (clk'event and clk = '1' and rst='0') then -- Working on rising edge
            if rst = '1' then
                -- synchronous reset.
                Mx    <=(others =>'0');
                My    <=(others =>'0');
                Mz    <=(others =>'0');
                Hx    <=(others =>'0');
                Hy    <=(others =>'0');
                Hz    <=(others =>'0');
                TGxx  <=(others =>'0');
                TGxy  <=(others =>'0');
                TGxz  <=(others =>'0');
                TGyx  <=(others =>'0');
                TGyy  <=(others =>'0');
                TGyz  <=(others =>'0');
                TGzx  <=(others =>'0');
                TGzy  <=(others =>'0');
                TGzz  <=(others =>'0');
                op1   <=(others =>'0');
                op2   <=(others =>'0');
                output<=(others =>'0'); 
                fsm_state 	<= READ_MX;
            end if;
        case fsm_state is
					when READ_MX=>    
						Mx<=input;
            --My    <=(others =>'0');
            --Mz    <=(others =>'0');
            TGxx  <=(others =>'0');
            TGxy  <=(others =>'0');
            TGxz  <=(others =>'0');
            TGyx  <=(others =>'0');
            TGyy  <=(others =>'0');
            TGyz  <=(others =>'0');
            TGzx  <=(others =>'0');
            TGzy  <=(others =>'0');
            TGzz  <=(others =>'0');
            op1   <=(others =>'0');
            op2   <=(others =>'0');
            --output<=(others =>'0'); 
            --output<=Mx;
            output<=input;
						fsm_state 	<= READ_MY; 				
						
					when READ_MY => 
						My<=input;
            --output<=My;
            output<=input;
						fsm_state 	<= READ_MZ;  
	
					when READ_MZ => 
						Mz<=input;
            --output<=Mz;
            output<=input;
						fsm_state 	<= READ_TGxx;
					
          when READ_TGxx => 
						TGxx<=input;
            op1<=std_logic_vector(to_signed(to_integer(signed(input)*signed(Mx)),nbit));
						fsm_state 	<= READ_TGxy;  
          when READ_TGxy => 
						TGxy<=input;
            op2<=std_logic_vector(to_signed(to_integer(signed(input)*signed(My)),nbit));
						fsm_state 	<= READ_TGxz; 
          when READ_TGxz => 
						TGxz<=input;
            temp :=std_logic_vector(to_signed(to_integer(signed(op1)+signed(op2)+(signed(input)*signed(Mz))),(nbit)));          
            
            output<=temp;
            Hx<=temp;
            --Hx<=std_logic_vector(to_signed(to_integer(op1+op2+(signed(input)*signed(Mz))),(nbit)));  
						fsm_state 	<= READ_TGyx; 
          when READ_TGyx => 
          TGyx<=input;
            op1<=std_logic_vector(to_signed(to_integer(signed(input)*signed(Mx)),nbit));
						
						fsm_state 	<= READ_TGyy;  
          when READ_TGyy => 
          TGyy<=input;
            op2<=std_logic_vector(to_signed(to_integer(signed(input)*signed(My)),nbit));
						
						
						fsm_state 	<= READ_TGyz; 
          when READ_TGyz => 
            TGyz<=input;
            temp :=std_logic_vector(to_signed(to_integer(signed(op1)+signed(op2)+(signed(input)*signed(Mz))),(nbit)));          
            
            output<=temp;
            Hy<=temp;
						
						fsm_state 	<= READ_TGzx; 
          when READ_TGzx => 
            TGzx<=input;
            op2<=std_logic_vector(to_signed(to_integer(signed(input)*signed(Mx)),nbit));
						
						
						fsm_state 	<= READ_TGzy;  
          when READ_TGzy => 
            TGzy<=input;
            op1<=std_logic_vector(to_signed(to_integer(signed(input)*signed(My)),nbit));
						
						
						fsm_state 	<= READ_TGzz; 
          when READ_TGzz => 
            TGzz<=input;
            temp :=std_logic_vector(to_signed(to_integer(signed(op1)+signed(op2)+(signed(input)*signed(Mz))),(nbit)));          
            
            output<=temp;
            Hz<=temp;
						
					--	fsm_state 	<= IDLE; 
					--when IDLE => 
						--In idle always ask to read the first operand
						
						fsm_state 	<= READ_Mx;						
					when OTHERS =>
						
						fsm_state <= READ_Mx;
        end case;
            
		end if;
	end process;
	
end architecture beh_cell;