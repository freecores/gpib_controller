--------------------------------------------------------------------------------
-- Entity: SecondaryAddressDecoder
-- Date:2011-11-07  
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

entity SecondaryAddressDecoder is
	port (
		-- secondary address mask
		secAddrMask : in std_logic_vector (31 downto 0);
		-- data input
		DI : in std_logic_vector (4 downto 0);
		-- secondary address detected
		secAddrDetected : out std_logic
	);
end SecondaryAddressDecoder;

architecture arch of SecondaryAddressDecoder is

begin

	secAddrDetected <= secAddrMask(conv_integer(DI));

end arch;

