library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memoriaROM is
	generic (
		dataWidth : natural := 13;
		addrWidth : natural := 9
	);
	port (
		address : in std_logic_vector (addrWidth-1 downto 0);
		data : out std_logic_vector (dataWidth-1 downto 0)
	);
end entity;

architecture program of memoriaROM is

	subtype word_t is std_logic_vector(dataWidth-1 downto 0);
	type memory_t is array (2**addrWidth-1 downto 0) of word_t;

	signal rom : memory_t;
	attribute ram_init_file : string;
	attribute ram_init_file of rom:
	signal is "initROM.mif";

	begin
		data <= rom(to_integer(unsigned(address)));

end architecture;