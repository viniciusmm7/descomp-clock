library ieee;
use ieee.std_logic_1164.all;

entity timeCounter is
	port(
		clock_in        : in  STD_LOGIC;
    reset_count     : in  STD_LOGIC;
    run_count       : in  STD_LOGIC;
    stop_count      : in  STD_LOGIC;
    reset_flag      : in  STD_LOGIC;
    habilita_flag   : in  STD_LOGIC;
    output          : out STD_LOGIC
	);
end entity;

architecture arch of timeCounter is

  signal signal_divided   : STD_LOGIC;
  signal reg_in           : STD_LOGIC_VECTOR(18 downto 0);
  signal reg_out          : STD_LOGIC_VECTOR(18 downto 0);
  signal clock_out        : STD_LOGIC;
  signal status           : STD_LOGIC;
  signal key_out          : STD_LOGIC;
  signal reg_reset        : STD_LOGIC;
  signal clock_out_setter : STD_LOGIC;

  constant LIMIT : STD_LOGIC_VECTOR := "1011111010111100001";

begin
  
  DIVISOR: entity work.dividerBy128
    port map (
      clock_in  => clock_in,
      clock_out => signal_divided 
    );

  COUNT_REG: entity work.registradorGenerico
		generic map (
			larguraDados => 19
    )
		port map (
			entrada   => reg_in,
      habilita  => status,
      clock     => signal_divided,
      reset     => reset_count or reg_reset,
      saida     => reg_out
		);

  STATUS_REG: entity work.registradorBit 
    port map (
      entrada   => '1',
      habilita  => '1',
      clock     => run_count,
      reset     => stop_count,
      saida     => status
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

  FLAG: entity work.keyUnit
		port map (
			CLK       => clock_in,
			CLEAR     => reset_flag,
			HABILITA  => habilita_flag,
			BUTTON    => clock_out_setter,
			OUTPUT    => key_out
		);
  
  detectorSub0: work.edgeDetector(bordaSubida)
			port map (clk => clock_in, entrada => (not clock_out), saida => clock_out_setter);

  reg_reset  <= '1' when (reg_out = "1011111010111100010") else
                '0';

  clock_out  <= '1' when (reg_out = "1011111010111100001") else
                '0';

  output <= key_out;

end architecture;
