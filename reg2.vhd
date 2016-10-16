library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity reg2 is
	port(
		clk : in std_logic;
		write_en : in std_logic;
		inp1 ,inp2 ,inp3,inp4,inp5: in std_logic_vector(31 downto 0);
		outp1 ,outp2 ,outp3,outp4,outp5: out std_logic_vector(31 downto 0)
	);
end reg2;

architecture behavioral of reg2 is
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
	temp_reg3 : temp_reg port map
							(
								writed => inp3,
								clk => clk ,
								we => write_en ,
								readd => outp3
							);				
	temp_reg4 : temp_reg port map
							(
								writed => inp4,
								clk => clk ,
								we => write_en ,
								readd => outp4
							);				
	temp_reg5 : temp_reg port map
							(
								writed => inp5,
								clk => clk ,
								we => write_en ,
								readd => outp5
							);										
end behavioral;












