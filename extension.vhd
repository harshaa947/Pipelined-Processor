library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity ext is
	port(
		inp : in std_logic_vector(11 downto 0);
		outp : out std_logic_vector(31 downto 0)
	);
end ext;

architecture behavioral of ext is
begin 
	outp <= "00000000000000000000"&inp;
end behavioral;