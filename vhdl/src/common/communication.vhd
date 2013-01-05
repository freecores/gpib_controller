--------------------------------------------------------------------------------
-- Entity: communication
-- Date:2011-11-27  
-- Author: apaluch     
--
-- Description ${cursor}
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

package communication is

	component Uart is
		port (
			reset : in std_logic;
			clk : in std_logic;
			---------- UART ---------------
			RX : in std_logic;
			TX : out std_logic;
			---------- gpib ---------------
			data_out : out std_logic_vector(7 downto 0);
			data_out_ready : out std_logic;
			data_in : in std_logic_vector(7 downto 0);
			data_in_ready : in std_logic;
			ready_to_send : out std_logic
		);
	end component;


end communication;

