library ieee;
use ieee.std_logic_1164.all;

entity dividerBy2 is
	port(
		clock_in:  in std_logic;
		clock_out: out std_logic
	);
end entity;

architecture arch of dividerBy2 is

    signal dnotq    : STD_LOGIC;

begin
    
	FLIPFLOP: entity work.FlipFlopD
		port map (
			clock   => clock_in,
      d       => dnotq,
      preset  => '0',
      clear   => '0',
      q       => clock_out
		);

  dnotq <= not clock_out;

end architecture;
