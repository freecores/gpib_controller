--------------------------------------------------------------------------------
-- Entity: ReaderControlReg0
-- Date:2011-11-10  
-- Author: Administrator     
--
-- Description ${cursor}
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity ReaderControlReg1 is
	port (
		data_out : out std_logic_vector (15 downto 0);
		------------------ gpib --------------------
		-- num of bytes available in fifo
		bytes_available_in_fifo : in std_logic_vector (10 downto 0)
	);
end ReaderControlReg1;

architecture arch of ReaderControlReg1 is

begin

	data_out(10 downto 0) <= bytes_available_in_fifo(10 downto 0);
	data_out(15 downto 11) <= "00000";

end arch;

