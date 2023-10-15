library ieee;
use ieee.std_logic_1164.all;

entity decoder3x8 is
  port (
    INPUT   : in  STD_LOGIC_VECTOR(2 downto 0);
    OUTPUT  : out STD_LOGIC_VECTOR(7 downto 0)
  );
end entity;

architecture comportamento of decoder3x8 is
  
  begin

  OUTPUT <= "00000001" when INPUT = "000" else
            "00000010" when INPUT = "001" else
            "00000100" when INPUT = "010" else
            "00001000" when INPUT = "011" else
            "00010000" when INPUT = "100" else
            "00100000" when INPUT = "101" else
            "01000000" when INPUT = "110" else
            "10000000";

end architecture;