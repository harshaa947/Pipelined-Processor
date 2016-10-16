library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;
entity rotator is
    port (input : in std_logic_vector(7 downto 0);
		s_amt : in std_logic_vector(3 downto 0);
		
     output : out std_logic_vector(31 downto 0);
	 carryout : out std_logic
	 );
end rotator;

architecture behaviour of rotator is
signal temp_carry :std_logic;
begin
  process(input,s_amt) 
  variable temp_store :std_logic_vector(31 downto 0);
  variable temp_amt : std_logic_vector(4 downto 0);
  begin
  temp_store := X"000000" & input;
  temp_amt := s_amt & '0' ;
  -- temp_carry <= temp_store(to_integer(unsigned(temp_amt))-1);

  temp_store := std_logic_vector(rotate_right(unsigned(temp_store), to_integer(unsigned(temp_amt))));
  output <= temp_store;
  end process;
 
 carryout <= temp_carry;
end behaviour;


