--------------------------------------------------------------------------------
-- Entity: Clk2x
-- Date:2012-02-02  
-- Author: Administrator     
--
-- Description ${cursor}
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

library UNISIM;
use UNISIM.VComponents.all;

entity Clk2x is
	port  (
		reset: in std_logic;
		clk : in std_logic;
		clk2x : out std_logic
	);
end Clk2x;

architecture arch of Clk2x is
	signal GND_BIT, CLKFX_BUF : STD_LOGIC;
	signal STATUS : std_logic_vector(7 downto 0);
begin

	GND_BIT <= '0';
	clk2x <= CLKFX_BUF;

	DCM_INST : DCM
		generic map(
			CLKDV_DIVIDE => 2.0,
			CLKFX_DIVIDE => 1,
			CLKFX_MULTIPLY => 2,
			CLKIN_DIVIDE_BY_2 => false,
			CLKIN_PERIOD => 20.0,
			CLKOUT_PHASE_SHIFT => "NONE",
			CLK_FEEDBACK => "NONE",
			DESKEW_ADJUST => "SYSTEM_SYNCHRONOUS",
			DFS_FREQUENCY_MODE => "LOW",
			DLL_FREQUENCY_MODE => "LOW",
			DUTY_CYCLE_CORRECTION => TRUE,
			FACTORY_JF => x"C080",
			PHASE_SHIFT => 0,
			STARTUP_WAIT => FALSE
		)
		port map (CLKFB=>open,
			CLKIN=>clk,
			DSSEN=>GND_BIT,
			PSCLK=>GND_BIT,
			PSEN=>GND_BIT,
			PSINCDEC=>GND_BIT,
			RST=>reset,
			CLKDV=>open,
			CLKFX=>CLKFX_BUF,
			CLKFX180=>open,
			CLK0=>open,
			CLK2X=>open,
			CLK2X180=>open,
			CLK90=>open,
			CLK180=>open,
			CLK270=>open,
			LOCKED=>open,
			PSDONE=>open,
			STATUS(7 downto 0)=>STATUS
		);

end arch;

