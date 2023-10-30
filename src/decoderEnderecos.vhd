library ieee;
use ieee.std_logic_1164.all;

entity decoderEnderecos is
  port (
    ADDRESS           : in  STD_LOGIC_VECTOR(8 downto 0);
    WR                : in  STD_LOGIC;
    RD                : in  STD_LOGIC;
    HAB_LED_0         : out STD_LOGIC;
    HAB_LED_1         : out STD_LOGIC;
    HAB_LED_2         : out STD_LOGIC;
    HAB_RAM           : out STD_LOGIC;
    HAB_HEX_0         : out STD_LOGIC;
    HAB_HEX_1         : out STD_LOGIC;
    HAB_HEX_2         : out STD_LOGIC;
    HAB_HEX_3         : out STD_LOGIC;
    HAB_HEX_4         : out STD_LOGIC;
    HAB_HEX_5         : out STD_LOGIC;
    HAB_SW_0          : out STD_LOGIC;
    HAB_SW_1          : out STD_LOGIC;
    HAB_SW_2          : out STD_LOGIC;
    HAB_KEY_0         : out STD_LOGIC;
    HAB_KEY_1         : out STD_LOGIC;
    HAB_KEY_2         : out STD_LOGIC;
    HAB_KEY_3         : out STD_LOGIC;
    HAB_KEY_R         : out STD_LOGIC;
    HAB_SECONDS_KEY   : out STD_LOGIC;
    CLEAR_KEY_0       : out STD_LOGIC;
    CLEAR_KEY_1       : out STD_LOGIC;
    CLEAR_KEY_R       : out STD_LOGIC;
    CLEAR_SECONDS_KEY : out STD_LOGIC
  );
end entity;

architecture comportamento of decoderEnderecos is

  signal decoder_addr_out   : STD_LOGIC_VECTOR(7 downto 0);
  signal decoder_bloco_out  : STD_LOGIC_VECTOR(7 downto 0);
  
  begin

  DECODER_BLOCO: entity work.decoder3x8 port map (
    INPUT   => ADDRESS(8 downto 6),
    OUTPUT  => decoder_bloco_out
  );

  DECODER_ADDR: entity work.decoder3x8 port map (
    INPUT   => ADDRESS(2 downto 0),
    OUTPUT  => decoder_addr_out
  );

  HAB_RAM     <= decoder_bloco_out(0);
  
  HAB_LED_0   <= WR and decoder_addr_out(0) and decoder_bloco_out(4) and not ADDRESS(5);
  HAB_LED_1   <= WR and decoder_addr_out(1) and decoder_bloco_out(4) and not ADDRESS(5);
  HAB_LED_2   <= WR and decoder_addr_out(2) and decoder_bloco_out(4) and not ADDRESS(5);
  HAB_HEX_0   <= WR and decoder_addr_out(0) and decoder_bloco_out(4) and ADDRESS(5);
  HAB_HEX_1   <= WR and decoder_addr_out(1) and decoder_bloco_out(4) and ADDRESS(5);
  HAB_HEX_2   <= WR and decoder_addr_out(2) and decoder_bloco_out(4) and ADDRESS(5);
  HAB_HEX_3   <= WR and decoder_addr_out(3) and decoder_bloco_out(4) and ADDRESS(5);
  HAB_HEX_4   <= WR and decoder_addr_out(4) and decoder_bloco_out(4) and ADDRESS(5);
  HAB_HEX_5   <= WR and decoder_addr_out(5) and decoder_bloco_out(4) and ADDRESS(5);

  HAB_SW_0        <= RD and decoder_addr_out(0) and decoder_bloco_out(5) and not ADDRESS(5);
  HAB_SW_1        <= RD and decoder_addr_out(1) and decoder_bloco_out(5) and not ADDRESS(5);
  HAB_SW_2        <= RD and decoder_addr_out(2) and decoder_bloco_out(5) and not ADDRESS(5);
  HAB_KEY_0       <= RD and decoder_addr_out(0) and decoder_bloco_out(5) and ADDRESS(5);
  HAB_KEY_1       <= RD and decoder_addr_out(1) and decoder_bloco_out(5) and ADDRESS(5);
  HAB_KEY_2       <= RD and decoder_addr_out(2) and decoder_bloco_out(5) and ADDRESS(5);
  HAB_KEY_3       <= RD and decoder_addr_out(3) and decoder_bloco_out(5) and ADDRESS(5);
  HAB_KEY_R       <= RD and decoder_addr_out(4) and decoder_bloco_out(5) and ADDRESS(5);
  HAB_SECONDS_KEY <= RD and decoder_addr_out(5) and decoder_bloco_out(5) and ADDRESS(5);

  CLEAR_SECONDS_KEY <= WR and not ADDRESS(0) and not ADDRESS(1) and ADDRESS(2) and ADDRESS(3) and ADDRESS(4) and ADDRESS(5) and ADDRESS(6) and ADDRESS(7) and ADDRESS(8);
  CLEAR_KEY_R       <= WR and ADDRESS(0) and not ADDRESS(1) and ADDRESS(2) and ADDRESS(3) and ADDRESS(4) and ADDRESS(5) and ADDRESS(6) and ADDRESS(7) and ADDRESS(8);
  CLEAR_KEY_1       <= WR and not ADDRESS(0) and ADDRESS(1) and ADDRESS(2) and ADDRESS(3) and ADDRESS(4) and ADDRESS(5) and ADDRESS(6) and ADDRESS(7) and ADDRESS(8);
  CLEAR_KEY_0       <= WR and ADDRESS(0) and ADDRESS(1) and ADDRESS(2) and ADDRESS(3) and ADDRESS(4) and ADDRESS(5) and ADDRESS(6) and ADDRESS(7) and ADDRESS(8);

end architecture;