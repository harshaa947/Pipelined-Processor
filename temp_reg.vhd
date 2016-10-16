
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity temp_reg is
    port (writed : in std_logic_vector(31 downto 0);
     clk : in std_logic;
     we : in std_logic;
     readd : out std_logic_vector(31 downto 0)
	 );
end temp_reg;

architecture behaviour of temp_reg is
signal temp_store :std_logic_vector(31 downto 0);
begin
  process(clk,we) begin
  
 if clk'event and clk = '1' then
  		if we = '1' then
    temp_store<= writed ;
  		end if ;	
  	end if;
  end process;
  readd <= temp_store;
 
end behaviour;

