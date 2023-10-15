library ieee;
use ieee.std_logic_1164.all;

entity decoderInstrucoes is
  port (
    opcode  : in  STD_LOGIC_VECTOR(3 downto 0);
    saida   : out STD_LOGIC_VECTOR(11 downto 0)
  );
end entity;

architecture comportamento of decoderInstrucoes is

  constant NOP  : STD_LOGIC_VECTOR(3 downto 0) := "0000";
  constant LDA  : STD_LOGIC_VECTOR(3 downto 0) := "0001";
  constant SOMA : STD_LOGIC_VECTOR(3 downto 0) := "0010";
  constant SUB  : STD_LOGIC_VECTOR(3 downto 0) := "0011";
  constant LDI  : STD_LOGIC_VECTOR(3 downto 0) := "0100";
  constant STA  : STD_LOGIC_VECTOR(3 downto 0) := "0101";
  constant JMP  : STD_LOGIC_VECTOR(3 downto 0) := "0110";
  constant JEQ  : STD_LOGIC_VECTOR(3 downto 0) := "0111";
  constant CEQ  : STD_LOGIC_VECTOR(3 downto 0) := "1000";
  constant JSR  : STD_LOGIC_VECTOR(3 downto 0) := "1001";
  constant RET  : STD_LOGIC_VECTOR(3 downto 0) := "1010";
  constant iAND : STD_LOGIC_VECTOR(3 downto 0) := "1011";
  
  begin

  saida <=  "000000000000" when opcode = NOP  else
            "000000110010" when opcode = LDA  else
            "000000101010" when opcode = SOMA else
            "000000100010" when opcode = SUB  else
            "000001110000" when opcode = LDI  else
            "000000000001" when opcode = STA  else
            "010000000000" when opcode = JMP  else
            "000010000000" when opcode = JEQ  else
            "000000000110" when opcode = CEQ  else
            "100100000000" when opcode = JSR  else
            "001000000000" when opcode = RET  else
            "000000111010" when opcode = iAND else
            "000000000000";

end architecture;