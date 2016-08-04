-------------------------------------------------------------------------------
--
-- Title       : FSM
-- Design      : FSM
-- Author      : Maximiliano Valencia Moctezuma
-- Company     : Universidad Autonoma de Queretaro
--
-------------------------------------------------------------------------------
--
-- File        : C:\My_Designs\Electronica_Avanzada_2\Up_Down_Counter_Synchronous_Clear\Up_Down_Counter_Synchronous_Clear\Up_Down_Counter_Synchronous_Clear\src\Up_Down_Counter_Synchronous_Clear.vhd
-- Generated   : Tue Aug  4 16:51:42 2015
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : Finite State Machine
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {Up_Down_Counter_Synchronous_Clear} architecture {Counter}}

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity FSM_TX is
	port( 
		CLK	:in	std_logic:='U';
		ARST:in	std_logic:='U';
		ST	:in	std_logic:='U';
		COMP:in	std_logic:='U';
		EOTB:in std_logic:='U';
		OPC :out std_logic_vector(1 downto 0):=(others=>'0');	
		EOT :out std_logic:='0'
		);
end FSM_TX;

architecture Finite_State_Machine of FSM_TX is
	signal Qn:std_logic_vector(1 downto 0):=(others=>'0'); 
	signal Qp:std_logic_vector(1 downto 0):=(others=>'0');   
begin
	
	P1:process(Qp,ST,COMP,EOTB)
	begin
		case Qp is
			when "00" =>
				OPC <= "00";
				EOT <= '1';
				if (ST='0') then
					Qn <= "01";	
				else
					Qn <= Qp;
				end if;
			when "01" => 
				OPC <= "00";
				EOT <= '0';
				if (EOTB='1') then
					Qn <= "10";	
				else
					Qn <= Qp;
				end if; 
			when "10" =>
				OPC <= "01";
				EOT <= '0';
				if (COMP='1') then
					Qn <= "11";	
				else
					Qn <= "01";
				end if;
			when others => 
				OPC <= "11";
				EOT <= '0';
				if (ST='1') then
					Qn <= "00";	
				else
					Qn <= Qp;
				end if;
		end case;
	end process P1;  
	
	P2:process(CLK,ARST)
	begin
		if (ARST='0') then
			Qp <= (others=>'0');
		elsif (CLK'event and CLK='1') then
			Qp <= Qn;
		end if;
	end process P2;  	
	
end Finite_State_Machine;
