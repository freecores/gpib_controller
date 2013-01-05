--------------------------------------------------------------------------------
-- Entity: 	utilPkg
-- Date:	2011-10-09  
-- Author: 	apaluch
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

package utilPkg is

	-- converts boolean to std_logic '0' or '1'
	function to_stdl(b : boolean) return std_logic;
	
	-- converts std_logic to boolean
	function is_1(v : std_logic) return boolean;

end;

package body utilPkg is

	function to_stdl(b : boolean) return std_logic is begin
		if b then
			return '1';
		else
			return '0';
		end if;
	end function;

	function is_1(v : std_logic) return boolean is begin
		if v = '1' then
			return true;
		else
			return false;
		end if;
	end function;

end package body;