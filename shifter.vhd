library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;
entity shifter is
    port (input : in std_logic_vector(31 downto 0);
		s_amt : in std_logic_vector(4 downto 0);
		s_type : in std_logic_vector(1 downto 0);
     output : out std_logic_vector(31 downto 0);
	 carryout : out std_logic
	 );
end shifter;

architecture behaviour of shifter is
signal temp_store :std_logic_vector(31 downto 0);
signal temp_carry :std_logic;
begin
  process(input,s_amt,s_type) 
  
  begin
  case s_type is 
  when "00" => 
  -- temp_carry <= input(to_integer(unsigned(s_amt))-1);
  temp_store <= std_logic_vector(shift_left(unsigned(input), to_integer(unsigned(s_amt))));
  
  when "01" =>
  -- temp_carry <= input(to_integer(unsigned(s_amt))-1);
   temp_store <= std_logic_vector(shift_right(unsigned(input), to_integer(unsigned(s_amt))));
  
  when "10" => 
  -- temp_carry <= input(to_integer(unsigned(s_amt))-1);
  temp_store <= std_logic_vector(shift_right(signed(input), to_integer(unsigned(s_amt))));
  
  when "11" =>
  -- temp_carry <= input(to_integer(unsigned(s_amt))-1);
  temp_store <= std_logic_vector(rotate_right(unsigned(input), to_integer(unsigned(s_amt))));
  
  when others => null ;
  end case;
  end process;
 output <= temp_store;
 carryout <= temp_carry;
end behaviour;

