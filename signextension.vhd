library ieee;
use ieee.std_logic_1164.all;

Entity signextension is
    Port (input_sig : in std_logic_vector(23 downto 0);
          output_sig : out std_logic_vector(31 downto 0));
    End;

Architecture behave of signextension is
    begin
        output_sig <= X"00" & input_sig when input_sig(15)='0' else X"ff" & input_sig;
    end;
