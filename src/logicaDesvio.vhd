library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity logicaDesvio is
  port (
    zero  : in  STD_LOGIC;
    jeq   : in  STD_LOGIC;
    jsr   : in  STD_LOGIC;
    ret   : in  STD_LOGIC;
    jmp   : in  STD_LOGIC;
    saida : out STD_LOGIC_VECTOR(1 downto 0)
  );
end entity;


architecture comportamento of logicaDesvio is

begin

  saida(0) <= (jeq and zero) or jmp or jsr;
  saida(1) <= ret;

end architecture;