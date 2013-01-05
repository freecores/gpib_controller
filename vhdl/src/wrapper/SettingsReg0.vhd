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

entity SettingsReg0 is
	port (
		reset : in std_logic;
		strobe : in std_logic;
		data_in : in std_logic_vector (15 downto 0);
		data_out : out std_logic_vector (15 downto 0);
		------------- gpib -----------------------------
		isLE_TE : out std_logic;
		lpeUsed : out std_logic;
		fixedPpLine : out std_logic_vector (2 downto 0);
		eosUsed : out std_logic;
		eosMark : out std_logic_vector (7 downto 0);
		lon : out std_logic;
		ton : out std_logic
	);
end SettingsReg0;

architecture arch of SettingsReg0 is

	signal inner_buf : std_logic_vector (15 downto 0);

begin

	data_out <= inner_buf;
	
	isLE_TE <= inner_buf(0);
	lpeUsed <= inner_buf(1);
	fixedPpLine <= inner_buf(4 downto 2);
	eosUsed <= inner_buf(5);
	eosMark <= inner_buf(13 downto 6);
	lon <= inner_buf(14);
	ton <= inner_buf(15);

	process (reset, strobe) begin
		if reset = '1' then
			inner_buf <= "0000000000000000";
		elsif rising_edge(strobe) then
			inner_buf <= data_in;
		end if;
	end process;

end arch;

