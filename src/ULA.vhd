library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;    -- Biblioteca IEEE para funções aritméticas

-- ULA com soma, subtração e pass

entity ULA is
  
  port(
    entrada_A : in  STD_LOGIC_VECTOR(7 downto 0);
    entrada_B : in  STD_LOGIC_VECTOR(7 downto 0);
    seletor   : in  STD_LOGIC_VECTOR(1 downto 0);
    saida     : out STD_LOGIC_VECTOR(7 downto 0);
    zero      : out STD_LOGIC
  );

end entity;

architecture comportamento of ULA is

  signal soma         : STD_LOGIC_VECTOR(7 downto 0);
  signal subtracao    : STD_LOGIC_VECTOR(7 downto 0);
  signal saida_signal : STD_LOGIC_VECTOR(7 downto 0);

  begin

    soma          <=  STD_LOGIC_VECTOR(unsigned(entrada_A) + unsigned(entrada_B));
    subtracao     <=  STD_LOGIC_VECTOR(unsigned(entrada_A) - unsigned(entrada_B));
    saida_signal  <=  subtracao  when (seletor = "00") else
                      soma       when (seletor = "01") else
                      entrada_B  when (seletor = "10") else
                      entrada_A and entrada_B;

    zero  <= not (saida_signal(7) or saida_signal(6) or saida_signal(5) or saida_signal(4) or saida_signal(3) or saida_signal(2) or saida_signal(1) or saida_signal(0));
    saida <= saida_signal;

end architecture;