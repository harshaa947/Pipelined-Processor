library ieee;
use ieee.std_logic_1164.all;

entity muxfourtoone is 
Port (input_sig1 ,input_sig2,input_sig3,input_sig4: in std_logic_vector(31 downto 0);
			s : in std_logic_vector(1 downto 0) ;
          output_sig : out std_logic_vector(31 downto 0));
    End;

Architecture behaviour of muxfourtoone is
    begin
        output_sig <= input_sig1 when s="00" else input_sig2 when s="01" else 
						input_sig3 when s="10" else input_sig4 when s="11" else "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ" ;
    end;
