library ieee;
use ieee.std_logic_1164.all;

entity muxGenerico2x1 is
  -- Total de bits das entradas e saidas
  generic (larguraDados: natural := 8);
  port (
    entrada_0 : in  STD_LOGIC_VECTOR((larguraDados - 1) downto 0);
    entrada_1 : in  STD_LOGIC_VECTOR((larguraDados - 1) downto 0);
    seletor   : in  STD_LOGIC;
    saida     : out STD_LOGIC_VECTOR((larguraDados - 1) downto 0)
  );
end entity;

architecture comportamento of muxGenerico2x1 is
  begin
    saida   <=  entrada_1 when (seletor = '1') else
                entrada_0;
end architecture;