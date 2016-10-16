library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity pc is
	port(
		clk : in std_logic ;
		inp : in std_logic_vector(31 downto 0);
		outp : out std_logic_vector(31 downto 0)
		);
end pc;

architecture behavioral of pc is 

begin
	process(clk)
	begin
		if rising_edge(clk) then 
			outp <= inp;
		end if;	
	end process;	
end behavioral;