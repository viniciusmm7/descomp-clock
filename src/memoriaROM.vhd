library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memoriaROM is
  generic (
    dataWidth : natural := 8;
    addrWidth : natural := 3
  );
  port (
    endereco  : in  STD_LOGIC_VECTOR (addrWidth - 1 downto 0);
    dado      : out STD_LOGIC_VECTOR (dataWidth - 1 downto 0)
  );
end entity;

architecture assincrona of memoriaROM is

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

  type blocoMemoria is array(0 TO 2 ** addrWidth - 1) of STD_LOGIC_VECTOR(dataWidth - 1 DOWNTO 0);

  function initMemory
        return blocoMemoria is variable tmp : blocoMemoria := (others => (others => '0'));
  begin
        -- Inicializa os endereços:
        tmp(0)  := LDI  & "000000000";
        tmp(1)  := STA  & "000000000";
        tmp(2)  := STA  & "000000010";
        tmp(3)  := LDI  & "000000001";
        tmp(4)  := STA  & "000000001";
        tmp(5)  := NOP  & "000000000";
        tmp(6)  := LDA  & "101100000";
        tmp(7)  := iAND & "000000001";
        tmp(8)  := STA  & "100100000";
        tmp(9)  := CEQ  & "000000000";
        tmp(10) := JEQ  & "000001100";
        tmp(11) := JSR  & "000100000";
        tmp(12) := NOP  & "000000000";
        tmp(13) := JMP  & "000000101";
        tmp(32) := STA  & "111111110";
        tmp(33) := LDA  & "000000010";
        tmp(34) := SOMA & "000000001";
        tmp(35) := STA  & "000000010";
        tmp(36) := STA  & "100000010";
        tmp(37) := STA  & "100100101";
        tmp(38) := RET  & "000000000";
        return tmp;
    end initMemory;

    signal memROM : blocoMemoria := initMemory;

begin
    dado <= memROM (to_integer(unsigned(endereco)));
end architecture;