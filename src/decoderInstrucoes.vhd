library ieee;
use ieee.std_logic_1164.all;
use ieee.constants.all;

entity decoderInstrucoes is
  port (
    opcode  : in  STD_LOGIC_VECTOR(3 downto 0);
    saida   : out STD_LOGIC_VECTOR(11 downto 0)
  );
end entity;

architecture comportamento of decoderInstrucoes is
  
  begin

  saida <=  "000000000000" when opcode = NOP  else
            "000000110010" when opcode = LDA  else
            "000000101010" when opcode = ADD  else
            "000000100010" when opcode = SUBR else
            "000001110000" when opcode = LDI  else
            "000000000001" when opcode = STA  else
            "010000000000" when opcode = JMP  else
            "000010000000" when opcode = JEQ  else
            "000000000110" when opcode = CEQ  else
            "100100000000" when opcode = JSR  else
            "001000000000" when opcode = RET  else
            "000000111010" when opcode = ANDR else
            "000000000000";

end architecture;