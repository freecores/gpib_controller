--------------------------------------------------------------------------------
-- Entity: SettingsReg0
-- Date:2011-11-09  
-- Author: Administrator     
--
-- Description ${cursor}
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity GpibStatusReg is
	port (
		data_out : out std_logic_vector (15 downto 0);
		-- gpib
		currentSecAddr : in std_logic_vector (4 downto 0); -- current sec addr
		att : in std_logic; -- addressed to talk(L or LE)
		tac : in std_logic; -- talker active (T, TE)
		atl : in std_logic; -- addressed to listen (T or TE)
		lac : in std_logic; -- listener active (L, LE)
		cwrc : in std_logic; -- controller write commands
		cwrd : in std_logic; -- controller write data
		spa : in std_logic; -- seriall poll active
		isLocal : in std_logic -- device is local controlled
	);
end GpibStatusReg;

architecture arch of GpibStatusReg is

begin

	data_out(4 downto 0) <= currentSecAddr;
	data_out(5) <= att;
	data_out(6) <= tac;
	data_out(7) <= atl;
	data_out(8) <= lac;
	data_out(9) <= cwrc;
	data_out(10) <= cwrd;
	data_out(11) <= spa;
	data_out(12) <= isLocal;
	data_out(15 downto 13) <= "000";

end arch;

