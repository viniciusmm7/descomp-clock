library ieee;
use ieee.std_logic_1164.all;

entity registradorBit is

  port (
    entrada   : in  STD_LOGIC;
    habilita  : in  STD_LOGIC;
    clock     : in  STD_LOGIC;
    reset     : in  STD_LOGIC;
    saida     : out STD_LOGIC
  );

end entity;

architecture comportamento of registradorBit is
begin
    -- In Altera devices, register signals have a set priority.
    -- The HDL design should reflect this priority.
    process(reset, clock)
    begin
        -- The asynchronous reset signal has the highest priority
        if (reset = '1') then
            saida <= '0';    -- Código reconfigurável.
        else
            -- At a clock edge, if asynchronous signals have not taken priority,
            -- respond to the appropriate synchronous signal.
            -- Check for synchronous reset, then synchronous load.
            -- If none of these takes precedence, update the register output
            -- to be the register input.
            if (rising_edge(clock)) then
                if (habilita = '1') then
                        saida <= entrada;
                end if;
            end if;
        end if;
    end process;
end architecture;