library ieee;
use ieee.std_logic_1164.all;

entity dividerBy8 is
	port(
		clock_in:  in std_logic;
		clock_out: out std_logic
	);
end entity;

architecture arch of dividerBy8 is

    signal signal2  : STD_LOGIC;

begin
    
	DIVIDER0: entity work.dividerBy4
		port map (
			clock_in  => clock_in,
      clock_out => signal2
		);

  DIVIDER1: entity work.dividerBy2
		port map (
			clock_in  => signal2,
      clock_out => clock_out
		);

end architecture;
