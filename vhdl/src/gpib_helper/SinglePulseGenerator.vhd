--------------------------------------------------------------------------------
-- Entity: SinglePulseGenerator
-- Date:2011-11-10  
-- Author: Administrator     
--
-- Description ${cursor}
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

use work.utilPkg.all;


entity SinglePulseGenerator is
	generic (
		WIDTH : integer := 3
	);
	
	port (
		reset : in std_logic;
		clk : in std_logic;
		t_in: in std_logic;
		t_out : out std_logic;
		pulse : out std_logic
	);
end SinglePulseGenerator;

architecture arch of SinglePulseGenerator is

	signal rcount : integer range 0 to WIDTH;
	signal i_t_out : std_logic;

begin

	pulse <= to_stdl(t_in /= i_t_out);
	t_out <= i_t_out;

	-- buffer reset generator
	process (reset, clk, t_in) begin
		if reset = '1' then
			i_t_out <= t_in;
			rcount <= 0;
		elsif rising_edge(clk) then
			if t_in /= i_t_out then
				rcount <= rcount + 1;
				
				if rcount = WIDTH then
					rcount <= 0;
					i_t_out <= t_in;
				end if;
			end if;
		end if;
	end process;

end arch;

