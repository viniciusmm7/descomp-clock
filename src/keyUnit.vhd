library ieee;
use ieee.std_logic_1164.all;

entity keyUnit is
  port (
    CLK         : in  STD_LOGIC;
    CLEAR       : in  STD_LOGIC;
    HABILITA    : in  STD_LOGIC;
    BUTTON      : in  STD_LOGIC;
    OUTPUT      : out STD_LOGIC
  );
end entity;

architecture comportamento of keyUnit is

  signal reg_out  : STD_LOGIC;
  signal edge_out : STD_LOGIC;

  begin

  EDGEDETECTOR: work.edgeDetector(bordaSubida) port map (
    clk => CLK,
    entrada => (not BUTTON),
    saida => edge_out
  );

  REG: entity work.registradorBit port map (
    entrada   => '1',
    habilita  => '1',
    clock     => edge_out,
    reset     => CLEAR,
    saida     => reg_out
  );

  TRISTATE: entity work.bufferTriState port map (
    entrada   => reg_out,
    habilita  => HABILITA,
    saida     => OUTPUT
  );

end architecture;