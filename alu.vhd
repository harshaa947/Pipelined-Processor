--********************************************************************************************************************--
--! @file
--! @brief File Description
--! Copyright&copy - YOUR COMPANY NAME
--********************************************************************************************************************--
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;

--! Local libraries

--! Entity/Package Description
entity alu is
   port (
      input_a :in std_LOGIC_VECTOR(31 downto 0):= (others => '1');
	  input_b : in std_LOGIC_VECTOR(31 downto 0):= (others => '1');
	  opcode :in std_LOGIC_VECTOR(3 downto 0):= (others => '1');
	  result : out std_LOGIC_VECTOR(31 downto 0);
	  carryin : in std_LOGiC;
	  Zerof , overflowf , carryflowf , negativef:out std_LOGiC
   );
end entity alu;

architecture rtl of alu is

begin

process(opcode,input_a,input_b)
variable response : std_LOGIC_VECTOR(32 downto 0);
begin
response := "000000000000000000000000000000000" ;
case opcode is 
 when "0000" =>  response := '0' & (input_a and input_b) ;
when "0001" =>  response :=  '0' & (input_a xor input_b) ;
when "0010" =>  response :=  ('0' & input_a)  - ('0' & input_b)  ;
when "0011" =>  response :=  ('0' & input_b)  - ('0' & input_a)  ;
when "0100" =>  response :=  ('0' & input_a)  + ('0' & input_b)  ;
when "0101" =>  response :=  ('0' & input_a)  + ('0' & input_b)  + carryin ;
when "0110" =>  response :=  ('0' & input_a)  - ('0' & input_b)  - not carryin ;
when "0111" =>  response :=  ('0' & input_b)  - ('0' & input_a)  - not carryin ;
when "1000" =>  response :=  ('0' & input_a)  - ('0' & input_b)  ;
when "1001" =>  response :=  ('0' & input_a)  - ('0' & input_b)  ;
when "1010" =>  response :=  ('0' & input_a)  - ('0' & input_b)  ;
when "1011" =>  response :=  ('0' & input_a)  - ('0' & input_b)  ;
when "1100" =>  response :=  '0' & (input_a  or  input_b)  ;
when "1101" =>  response :=  '0' & (input_b)  ;
when "1110" =>  response :=  '0' & (not input_b) ;
when "1111" =>  response :=  '0' & (input_a and (not input_b)) ;
when others => null;
end case;
			-- Setting z flag
			if response= 0 then
                Zerof <= '1';
            else
                Zerof <= '0';
            end if;

            -- Check if there was overflowf
            if ((input_a > "00000000000000000000000000000000" AND input_b > "00000000000000000000000000000000") 
                 AND (response< ('0' & "00000000000000000000000000000000"))) OR ((input_a < "00000000000000000000000000000000" AND input_b < "00000000000000000000000000000000") AND (response> ('0' & "00000000000000000000000000000000"))) then
               overflowf <= '1';
            else
               overflowf <= '0';
            end if;

            -- Check if there was carryflowf
            if response(32) = '1' then
                carryflowf <= '1';
            else
                carryflowf <= '0';
            end if;
			-- Check if there was negativef
			if response(31) = '1' then
                negativef <= '1';
            else
                negativef <= '0';
            end if;
		result <= response (31 downto 0);
end process ; 

end rtl;
