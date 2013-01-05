----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:04:57 10/03/2011 
-- Design Name: 
-- Module Name:    if_func_DT - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity if_func_DT is
	port(
		-- device inputs
		clk : in std_logic; -- clock
		-- state inputs
		LADS : in std_logic; -- listener addressed state (L or LE)
		ACDS : in std_logic; -- accept data state (AH)
		-- instructions
		GET : in std_logic; -- group execute trigger
		-- local instructions
		trg : out std_logic -- trigger
	);
end if_func_DT;

architecture Behavioral of if_func_DT is

 -- states
 type DT_STATE is (
  -- device trigger idle state
  ST_DTIS,
  -- device trigger active state
  ST_DTAS
 );

 -- current state
 signal current_state : DT_STATE;

 -- predicates
 signal pred1 : boolean;
 signal pred2 : boolean;
 
begin

 -- state machine process
 process(clk) begin
   
	if rising_edge(clk) then
	  
	  case current_state is
	    ------------------
	    when ST_DTIS =>
		   if pred1 then
		     current_state <= ST_DTAS;
		   end if;
		 ------------------
		 when ST_DTAS =>
		   if pred2 then
    		 current_state <= ST_DTIS;
    	   end if;
		 ------------------
		 when others =>
		   current_state <= ST_DTIS;
       end case;
	end if;
	
 end process;

 -- predicates
 pred1 <= GET='1' and LADS='1' and ACDS='1';
 pred2 <= not pred1;
 
 -- trg generator
 with current_state select
   trg <=
		'1' when ST_DTAS,
		'0' when others;
 
end Behavioral;
