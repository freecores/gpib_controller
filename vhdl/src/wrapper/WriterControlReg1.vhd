--------------------------------------------------------------------------------
-- Entity: WriterControlReg1
-- Date:2011-11-10  
-- Author: Administrator     
--
-- Description ${cursor}
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity WriterControlReg1 is
	port (
		reset : in std_logic;
		strobe : in std_logic;
		data_in : in std_logic_vector (15 downto 0);
		data_out : out std_logic_vector (15 downto 0);
		------------------ gpib --------------------
		-- num of bytes available in fifo
		bytes_available_in_fifo : in std_logic_vector (10 downto 0)
	);
end WriterControlReg1;

architecture arch of WriterControlReg1 is

begin

	data_out(10 downto 0) <= bytes_available_in_fifo(10 downto 0);
	data_out(15 downto 11) <= "00000";

end arch;

