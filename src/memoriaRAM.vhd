
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memoriaRAM is
  generic (
    dataWidth: natural := 8;
    addrWidth: natural := 8
  );
  port (
      endereco  : in  STD_LOGIC_VECTOR(addrWidth - 1 downto 0);
      leitura   : in  STD_LOGIC;
      escrita   : in  STD_LOGIC;
      habilita  : in  STD_LOGIC;
      clock     : in  STD_LOGIC;
      entrada   : in  STD_LOGIC_VECTOR(dataWidth - 1 downto 0);
      saida     : out STD_LOGIC_VECTOR(dataWidth - 1 downto 0)
  );
end entity;

architecture rtl of memoriaRAM is
    -- Build a 2-D array type for the RAM
    subtype word_t is STD_LOGIC_VECTOR(dataWidth - 1 downto 0);
    type memory_t is array((2**addrWidth - 1) downto 0) of word_t;

    -- Declare the RAM signal.
    signal ram : memory_t;
begin
    process(clock)
    begin
        if(rising_edge(clock)) then
            if(escrita = '1' and habilita = '1') then
                ram(to_integer(unsigned(endereco))) <= entrada;
            end if;
        end if;
    end process;

    -- A leitura é sempre assincrona e quando houver habilitacao:
    saida <= ram(to_integer(unsigned(endereco))) when (leitura = '1' and habilita = '1') else (others => 'Z');
end architecture;