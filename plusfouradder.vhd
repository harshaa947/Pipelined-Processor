
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity plusfouradder is 
Port (input_sig1 ,input_sig2: in std_logic_vector(31 downto 0);
			
          output_sig : out std_logic_vector(31 downto 0));
    End;

Architecture behaviour of plusfouradder is
    begin
	process(input_sig1,input_sig2)
	begin
        output_sig <= input_sig1 + input_sig2 + X"00000004"  ;
		end process;
    end;
	
