--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:22:23 02/04/2012
-- Design Name:   
-- Module Name:   /home/andrzej/apaluch/projects/elektronika/GPIB/vhdl/test/RegsGpibFasade_test.vhd
-- Project Name:  proto1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: RegsGpibFasade
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
use work.wrapperComponents.ALL;
 
ENTITY RegsGpibFasade_communication_test IS
END RegsGpibFasade_communication_test;
 
ARCHITECTURE behavior OF RegsGpibFasade_communication_test IS 

	component gpibCableEmulator is port (
		-- interface signals
		DIO_1 : in std_logic_vector (7 downto 0);
		output_valid_1 : in std_logic;
		DIO_2 : in std_logic_vector (7 downto 0);
		output_valid_2 : in std_logic;
		DIO : out std_logic_vector (7 downto 0);
		-- attention
		ATN_1 : in std_logic;
		ATN_2 : in std_logic;
		ATN : out std_logic;
		-- data valid
		DAV_1 : in std_logic;
		DAV_2 : in std_logic;
		DAV : out std_logic;
		-- not ready for data
		NRFD_1 : in std_logic;
		NRFD_2 : in std_logic;
		NRFD : out std_logic;
		-- no data accepted
		NDAC_1 : in std_logic;
		NDAC_2 : in std_logic;
		NDAC : out std_logic;
		-- end or identify
		EOI_1 : in std_logic;
		EOI_2 : in std_logic;
		EOI : out std_logic;
		-- service request
		SRQ_1 : in std_logic;
		SRQ_2 : in std_logic;
		SRQ : out std_logic;
		-- interface clear
		IFC_1 : in std_logic;
		IFC_2 : in std_logic;
		IFC : out std_logic;
		-- remote enable
		REN_1 : in std_logic;
		REN_2 : in std_logic;
		REN : out std_logic
	);
	end component;

   --Inputs
   signal reset : std_logic := '0';
   signal clk : std_logic := '0';
   signal DI : std_logic_vector(7 downto 0) := (others => '0');
   signal ATN_in : std_logic := '0';
   signal DAV_in : std_logic := '0';
   signal NRFD_in : std_logic := '0';
   signal NDAC_in : std_logic := '0';
   signal EOI_in : std_logic := '0';
   signal SRQ_in : std_logic := '0';
   signal IFC_in : std_logic := '0';
   signal REN_in : std_logic := '0';
   signal data_in : std_logic_vector(15 downto 0) := (others => '0');
   signal reg_addr : std_logic_vector(14 downto 0) := (others => '0');
   signal strobe_read : std_logic := '0';
   signal strobe_write : std_logic := '0';

 	--Outputs
   signal DO : std_logic_vector(7 downto 0);
   signal output_valid : std_logic;
   signal ATN_out : std_logic;
   signal DAV_out : std_logic;
   signal NRFD_out : std_logic;
   signal NDAC_out : std_logic;
   signal EOI_out : std_logic;
   signal SRQ_out : std_logic;
   signal IFC_out : std_logic;
   signal REN_out : std_logic;
   signal data_out : std_logic_vector(15 downto 0);
   signal interrupt_line : std_logic;
   signal debug1 : std_logic;

   --Inputs
   signal data_in_1 : std_logic_vector(15 downto 0) := (others => '0');
   signal reg_addr_1 : std_logic_vector(14 downto 0) := (others => '0');
   signal strobe_read_1 : std_logic := '0';
   signal strobe_write_1 : std_logic := '0';

	--Outputs
   signal DO_1 : std_logic_vector(7 downto 0);
   signal output_valid_1 : std_logic;
   signal ATN_out_1 : std_logic;
   signal DAV_out_1 : std_logic;
   signal NRFD_out_1 : std_logic;
   signal NDAC_out_1 : std_logic;
   signal EOI_out_1 : std_logic;
   signal SRQ_out_1 : std_logic;
   signal IFC_out_1 : std_logic;
   signal REN_out_1 : std_logic;
   signal data_out_1 : std_logic_vector(15 downto 0);
   signal interrupt_line_1 : std_logic;


	-- Clock period definitions
	constant clk_period : time := 10 ns;


BEGIN

	-- Instantiate the Unit Under Test (UUT)
	uut: RegsGpibFasade PORT MAP (
		reset => reset,
		clk => clk,
		DI => DI,
		DO => DO,
		output_valid => output_valid,
		ATN_in => ATN_in,
		ATN_out => ATN_out,
		DAV_in => DAV_in,
		DAV_out => DAV_out,
		NRFD_in => NRFD_in,
		NRFD_out => NRFD_out,
		NDAC_in => NDAC_in,
		NDAC_out => NDAC_out,
		EOI_in => EOI_in,
		EOI_out => EOI_out,
		SRQ_in => SRQ_in,
		SRQ_out => SRQ_out,
		IFC_in => IFC_in,
		IFC_out => IFC_out,
		REN_in => REN_in,
		REN_out => REN_out,
		data_in => data_in,
		data_out => data_out,
		reg_addr => reg_addr,
		strobe_read => strobe_read,
		strobe_write => strobe_write,
		interrupt_line => interrupt_line,
		debug1 => debug1
	);

	-- Instantiate the Unit Under Test (UUT)
	uut_1: RegsGpibFasade PORT MAP (
		reset => reset,
		clk => clk,
		DI => DI,
		DO => DO_1,
		output_valid => output_valid_1,
		ATN_in => ATN_in,
		ATN_out => ATN_out_1,
		DAV_in => DAV_in,
		DAV_out => DAV_out_1,
		NRFD_in => NRFD_in,
		NRFD_out => NRFD_out_1,
		NDAC_in => NDAC_in,
		NDAC_out => NDAC_out_1,
		EOI_in => EOI_in,
		EOI_out => EOI_out_1,
		SRQ_in => SRQ_in,
		SRQ_out => SRQ_out_1,
		IFC_in => IFC_in,
		IFC_out => IFC_out_1,
		REN_in => REN_in,
		REN_out => REN_out_1,
		data_in => data_in_1,
		data_out => data_out_1,
		reg_addr => reg_addr_1,
		strobe_read => strobe_read_1,
		strobe_write => strobe_write_1,
		interrupt_line => interrupt_line_1,
		debug1 => open
	);

	gce: gpibCableEmulator port map (
		-- interface signals
		DIO_1 => DO,
		output_valid_1 => output_valid,
		DIO_2 => DO_1,
		output_valid_2 => output_valid_1,
		DIO => DI,
		-- attention
		ATN_1 => ATN_out,
		ATN_2 => ATN_out_1,
		ATN => ATN_in,
		-- data valid
		DAV_1 => DAV_out,
		DAV_2 => DAV_out_1,
		DAV => DAV_in,
		-- not ready for data
		NRFD_1 => NRFD_out,
		NRFD_2 => NRFD_out_1,
		NRFD => NRFD_in,
		-- no data accepted
		NDAC_1 => NDAC_out,
		NDAC_2 => NDAC_out_1,
		NDAC => NDAC_in,
		-- end or identify
		EOI_1 => EOI_out,
		EOI_2 => EOI_out_1,
		EOI => EOI_in,
		-- service request
		SRQ_1 => SRQ_out,
		SRQ_2 => SRQ_out_1,
		SRQ => SRQ_in,
		-- interface clear
		IFC_1 => IFC_out,
		IFC_2 => IFC_out_1,
		IFC => IFC_in,
		-- remote enable
		REN_1 => REN_out,
		REN_2 => REN_out_1,
		REN => REN_in
	);

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
	stim_proc: process begin
	
		-- hold reset state for 10 clock cycles
		reset <= '1';
		wait for clk_period*10;	
		reset <= '0';
		wait for clk_period*10;
		
		-- set address of GPIB1
		reg_addr_1 <= "000000000000001";
		data_in_1 <= X"0002";
		wait for clk_period*2;
		strobe_write_1 <= '1';
		wait for clk_period*2;
		strobe_write_1 <= '0';
		wait for clk_period*2;
		
		-- set rsc
		reg_addr <= "000000000000111";
		data_in <= X"0040";
		wait for clk_period*2;
		strobe_write <= '1';
		wait for clk_period*2;
		strobe_write <= '0';
		wait for clk_period*20;
		
		-- set sic
		reg_addr <= "000000000000111";
		data_in <= X"00c0";
		wait for clk_period*2;
		strobe_write <= '1';
		wait for clk_period*2;
		strobe_write <= '0';
		wait for clk_period*20;
		
		-- reset sic
		reg_addr <= "000000000000111";
		data_in <= X"0040";
		wait for clk_period*2;
		strobe_write <= '1';
		wait for clk_period*2;
		strobe_write <= '0';
		wait until IFC_in = '0';

		-- address GPIB1 to listen
		reg_addr <= "000000000001101";
		data_in <= X"0022";
		wait for clk_period*2;
		strobe_write <= '1';
		wait for clk_period*2;
		strobe_write <= '0';
		wait for clk_period*5;

		-- address GPIB0 to talk
		reg_addr <= "000000000001101";
		data_in <= X"0041";
		wait for clk_period*2;
		strobe_write <= '1';
		wait for clk_period*2;
		strobe_write <= '0';
		wait for clk_period*5;

		-- go to standby
		reg_addr <= "000000000000111";
		data_in <= X"0240";
		wait for clk_period*2;
		strobe_write <= '1';
		wait for clk_period*2;
		strobe_write <= '0';
		wait until ATN_in = '0';
		reg_addr <= "000000000000111";
		data_in <= X"0040";
		wait for clk_period*2;
		strobe_write <= '1';
		wait for clk_period*2;
		strobe_write <= '0';
		wait for clk_period*5;
		
		-- set eof
		reg_addr <= "000000000001010";
		data_in <= X"0006";
		wait for clk_period*2;
		strobe_write <= '1';
		wait for clk_period*2;
		strobe_write <= '0';
		wait for clk_period*5;
		
		-- writes data to GPIB1
		reg_addr <= "000000000001101";
		data_in <= X"0007";
		wait for clk_period*2;
		strobe_write <= '1';
		wait for clk_period*2;
		strobe_write <= '0';
		wait for clk_period*15;

		-- take control
		reg_addr <= "000000000000111";
		data_in <= X"0840";
		wait for clk_period*2;
		strobe_write <= '1';
		wait for clk_period*2;
		strobe_write <= '0';
		wait for clk_period*150;
		
		-- reset buffer
		reg_addr <= "000000000001010";
		data_in <= X"000a";
		wait for clk_period*2;
		strobe_write <= '1';
		wait for clk_period*2;
		strobe_write <= '0';
		wait for clk_period*10;
		
		-- address GPIB0 to listen
		reg_addr <= "000000000001101";
		data_in <= X"0021";
		wait for clk_period*2;
		strobe_write <= '1';
		wait for clk_period*2;
		strobe_write <= '0';
		wait for clk_period*5;

		wait;
	end process;

END;
