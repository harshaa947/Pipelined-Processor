
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity regFile is
    port (
	
        rad1  : in std_logic_vector(3 downto 0);
     rad2  : in std_logic_vector(3 downto 0);
     wad  : in std_logic_vector(3 downto 0);
     wd : in std_logic_vector(31 downto 0);
     clk : in std_logic;
     we : in std_logic;
     rd1 : out std_logic_vector(31 downto 0);
     rd2 : out std_logic_vector(31 downto 0)
    );
end regFile;

architecture regFileArch of regFile is
type regFile_typ is array(0 to 15) of STD_LOGIC_VECTOR(31 downto 0);
signal reg: regFile_typ;
begin
  process(clk,rad1,rad2,wad) begin
   
 if clk'event and clk = '1' then
  		if we = '1' then
   reg(conv_integer(unsigned(wad))) <= wd ;
  		end if ;	
  	end if;
  end process;
   rd1<= reg(conv_integer(unsigned(rad1)));
 rd2<= reg(conv_integer(unsigned(rad2)));
  	
end regFileArch;
