--------------------------------------------------------------------------------
-- Entity: SecAddrSaver
-- Date:2011-11-11  
-- Author: Administrator     
--
-- Description ${cursor}
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity SecAddrSaver is
	port (
		reset : in std_logic;
		------------------- gpib ----------------------
		TADS : in std_logic;
		TPAS : in std_logic;
		LADS : in std_logic;
		LPAS : in std_logic;
		MSA_Dec : in std_logic;
		DI : in std_logic_vector(4 downto 0);
		currentSecAddr : out std_logic_vector(4 downto 0)
	);
end SecAddrSaver;

architecture arch of SecAddrSaver is

	signal goToSecAddressed : std_logic;

begin

	goToSecAddressed <= MSA_Dec and ((TADS and TPAS) or (LADS and LPAS));

	-- save secondary address
	process (reset, goToSecAddressed) begin
		if(reset = '1') then
			currentSecAddr <= (others => '0');
		elsif rising_edge(goToSecAddressed) then
			currentSecAddr <= DI(4 downto 0);
		end if;
	end process;

end arch;

