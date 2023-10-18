library ieee;
use ieee.std_logic_1164.all;

entity hexUnit is
  port (
    CLK         : in  STD_LOGIC;
    HABILITA    : in  STD_LOGIC;
    DATA        : in  STD_LOGIC_VECTOR(3 downto 0);
    OUTPUT      : out STD_LOGIC_VECTOR(6 downto 0)
  );
end entity;

architecture comportamento of hexUnit is

  signal reg_out  : STD_LOGIC_VECTOR(3 downto 0);
  
  begin

  DECODER: entity work.conversorDec7Seg port map (
    dadoHex     => reg_out,
    saida7seg   => OUTPUT
  );

  REG: entity work.registradorGenerico
  generic map (larguraDados => 4)
  port map (
    entrada   => DATA,
    habilita  => HABILITA,
    clock     => CLK,
    reset     => '0',
    saida     => reg_out
  );

end architecture;