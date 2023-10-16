library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package constants is

	constant NOP  : STD_LOGIC_VECTOR(3 downto 0) := "0000";
	constant LDA  : STD_LOGIC_VECTOR(3 downto 0) := "0001";
	constant ADD  : STD_LOGIC_VECTOR(3 downto 0) := "0010";
	constant SUBR : STD_LOGIC_VECTOR(3 downto 0) := "0011";
	constant LDI  : STD_LOGIC_VECTOR(3 downto 0) := "0100";
	constant STA  : STD_LOGIC_VECTOR(3 downto 0) := "0101";
	constant JMP  : STD_LOGIC_VECTOR(3 downto 0) := "0110";
	constant JEQ  : STD_LOGIC_VECTOR(3 downto 0) := "0111";
	constant CEQ  : STD_LOGIC_VECTOR(3 downto 0) := "1000";
	constant JSR  : STD_LOGIC_VECTOR(3 downto 0) := "1001";
	constant RET  : STD_LOGIC_VECTOR(3 downto 0) := "1010";
	constant ANDR : STD_LOGIC_VECTOR(3 downto 0) := "1011";

end package;