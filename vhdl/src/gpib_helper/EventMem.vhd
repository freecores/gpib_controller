--------------------------------------------------------------------------------
-- Entity: EventMem
-- Date:2011-11-11  
-- Author: Administrator     
--
-- Description ${cursor}
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity EventMem is
	port (
		reset : std_logic;
		-- event occured
		occured : in std_logic;
		-- event approved
		approved : in std_logic;
		-- output
		output : out std_logic
	);
end EventMem;

architecture arch of EventMem is

begin

	process(reset, occured, approved) begin
		if reset = '1' or approved = '1' then
			output <= '0';
		elsif rising_edge(occured) then
			output <= '1';
		end if;
	end process;

end arch;

