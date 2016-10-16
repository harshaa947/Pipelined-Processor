library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity flag is
	port(
		clk : in std_logic;
		Zi,Ni,Ci,Vi : in std_logic;
		S :in std_logic;
		Zo, No ,Co ,Vo : out std_logic
	);
end flag;

architecture behavioral of flag is
begin
	process(clk)
	begin
		if clk'event and clk = '1' and S = '1'  then
			Zo <= Zi;
			No <= Ni;
			Co <= Ci;
			Vo <= Vi;
		end if;		
	end process;	
end behavioral;