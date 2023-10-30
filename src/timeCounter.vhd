library ieee;
use ieee.std_logic_1164.all;

entity timeCounter is
	port(
		clock_in:  in STD_LOGIC;
		clock_out: out STD_LOGIC;
    reg_out_out:   out STD_LOGIC_VECTOR(18 downto 0)
	);
end entity;

architecture arch of timeCounter is

  signal signal_divided   : STD_LOGIC;
  signal reg_in           : STD_LOGIC_VECTOR(18 downto 0);
  signal reg_out          : STD_LOGIC_VECTOR(18 downto 0);
  signal reg_reset        : STD_LOGIC;
  signal reg_hab          : STD_LOGIC;

  constant LIMIT : STD_LOGIC_VECTOR := "1011111010111100001";

begin
    
	DIVISOR: entity work.dividerBy128 port map (
    clock_in  => clock_in,
    clock_out => signal_divided
  );

  REG: entity work.registradorGenerico
		generic map (
			larguraDados => 19
    )
		port map (
			entrada   => reg_in,
      habilita  => '1',
      clock     => signal_divided,
      reset     => reg_reset,
      saida     => reg_out
		);

  SOMA: entity work.somaConstante
    generic map (
      larguraDados => 19,
      constante => 1
    )
    port map (
      entrada => reg_out,
      saida   => reg_in
    );

  reg_reset  <= '1' when (reg_in = "1011111010111100011") else
                '0';

  clock_out  <= '1' when (reg_out = "1011111010111100001") else
                '0';

  reg_out_out <= reg_out;

end architecture;
