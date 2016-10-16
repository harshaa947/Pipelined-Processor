library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity im is 
	port(
		clk : in std_logic ;
		addr : in std_logic_vector(7 downto 0);
		rd : out std_logic_vector(31 downto 0)
		
	);
end im; 

architecture behavioral of im is
	type memory is array(0 to 255) of std_logic_vector(31 downto 0);
	signal ram : memory ;
	
	signal r_add : std_logic_vector(7 downto 0);	
	
begin	

	process(clk)	
	begin	
		if clk'event and clk = '1' then	
			r_add <= addr; 
		end if;	
	end process;	

	rd <= ram(to_integer(unsigned(r_add))); -- Reading the data from RAM 	
end behavioral;