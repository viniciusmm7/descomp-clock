library IEEE;
use ieee.std_logic_1164.all;

entity bufferTriState8 is
    port(
        entrada  : in STD_LOGIC_VECTOR(7 downto 0);
        habilita : in STD_LOGIC;
        saida    : out STD_LOGIC_VECTOR(7 downto 0)
    );
end entity;

architecture comportamento of bufferTriState8 is
begin
    -- A saida esta ativa quando o habilita = 1.
    saida <= "ZZZZZZZZ" when (habilita = '0') else entrada;
end architecture;