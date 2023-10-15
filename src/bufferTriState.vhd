library IEEE;
use ieee.std_logic_1164.all;

entity bufferTriState is
    port(
        entrada  : in STD_LOGIC;
        habilita : in std_logic;
        saida    : out STD_LOGIC
    );
end entity;

architecture comportamento of bufferTriState is
begin
    -- A saida esta ativa quando o habilita = 1.
    saida <= 'Z' when (habilita = '0') else entrada;
end architecture;