
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

library UNISIM;
use UNISIM.VComponents.all;

entity mul is
port(
	c : out ieee.numeric_std.unsigned (31 downto 0);
	x1,x2 : in ieee.numeric_std.unsigned (31 downto 0);
	clk : in std_logic
	);
end mul;
architecture Behavioral of rfmul is
signal c1 : ieee.numeric_std.unsigned (63 downto 0);

begin

C1 <= x1 * x2;
c <= c1(31 downto 0);
end Behavioral;

