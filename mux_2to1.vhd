library ieee;
use ieee.std_logic_1164.all;

entity muxtwotoone is 
Port (input_sig1 ,input_sig2: in std_logic_vector(31 downto 0);
			s : in std_logic ;
          output_sig : out std_logic_vector(31 downto 0));
    End;

Architecture behaviour of muxtwotoone is
    begin
        output_sig <= input_sig1 when s='0' else input_sig2 when s='1' else "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ" ;
    end;