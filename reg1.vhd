library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity reg1 is
	port(
		clk : in std_logic;
		write_en : in std_logic;
		inp1 ,inp2 : in std_logic_vector(31 downto 0);
		outp1 ,outp2 : out std_logic_vector(31 downto 0)
	);
end reg1;

architecture behavioral of reg1 is
component temp_reg 
    port (writed : in std_logic_vector(31 downto 0);
     clk : in std_logic;
     we : in std_logic;
     readd : out std_logic_vector(31 downto 0)
	 );
end component;

begin
	temp_reg1 : temp_reg port map
							(
								writed => inp1,
								clk => clk ,
								we => write_en ,
								readd => outp1
							);
	temp_reg2 : temp_reg port map
							(
								writed => inp2,
								clk => clk ,
								we => write_en ,
								readd => outp2
							);						
end behavioral;












