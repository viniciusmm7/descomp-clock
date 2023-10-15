library ieee;
use ieee.std_logic_1164.all;

entity processador is
  -- Total de bits das entradas e saidas
  generic (
    larguraDados            : natural := 8;
    larguraEnderecos        : natural := 9;
    larguraInstrucoes       : natural := 13
  );
  port   (
    CLK         : in  STD_LOGIC;
    RESET       : in  STD_LOGIC;
    RD          : out STD_LOGIC;
    WR          : out STD_LOGIC;
    ROM_ADDR    : out STD_LOGIC_VECTOR((larguraEnderecos - 1) downto 0);
    INSTRUCTION : in  STD_LOGIC_VECTOR((larguraInstrucoes - 1) downto 0);
    DATA_IN     : in  STD_LOGIC_VECTOR((larguraDados - 1) downto 0);
    DATA_OUT    : out STD_LOGIC_VECTOR((larguraDados - 1) downto 0);
    DATA_ADDR   : out STD_LOGIC_VECTOR((larguraEnderecos - 1) downto 0)
  );
end entity;


architecture arquitetura of processador is

  signal endereco     : STD_LOGIC_VECTOR((larguraEnderecos - 1) downto 0);
  signal PC_count     : STD_LOGIC_VECTOR((larguraEnderecos - 1) downto 0);
  signal soma_endMUX  : STD_LOGIC_VECTOR((larguraEnderecos - 1) downto 0);
  signal endMUX_PC    : STD_LOGIC_VECTOR((larguraEnderecos - 1) downto 0);
  signal reg_ret_out  : STD_LOGIC_VECTOR((larguraEnderecos - 1) downto 0);

  signal acu_out    : STD_LOGIC_VECTOR((larguraDados - 1) downto 0);
  signal MUX_ULA    : STD_LOGIC_VECTOR((larguraDados - 1) downto 0);
  signal ULA_acu    : STD_LOGIC_VECTOR((larguraDados - 1) downto 0);
  signal imediato   : STD_LOGIC_VECTOR((larguraDados - 1) downto 0);

  signal controle             : STD_LOGIC_VECTOR(11 downto 0);
  signal opcode               : STD_LOGIC_VECTOR(3 downto 0);
  signal operacao             : STD_LOGIC_VECTOR(1 downto 0);
  signal sel_next_instruction : STD_LOGIC_VECTOR(1 downto 0);

  signal habilita_escrita_ret : STD_LOGIC;
  signal habilita_acumulador  : STD_LOGIC;
  signal seletor_MUX_dados    : STD_LOGIC;
  signal habilita_flag        : STD_LOGIC;
  signal current_zero         : STD_LOGIC;
  signal zero_flag            : STD_LOGIC;
  signal jmp                  : STD_LOGIC;
  signal jeq                  : STD_LOGIC;
  signal ret                  : STD_LOGIC;
  signal jsr                  : STD_LOGIC;

begin

-- Instanciando os componentes:

ULA: entity work.ULA port map (
  entrada_A => acu_out,
  entrada_B => MUX_ULA,
  saida     => ULA_acu,
  seletor   => operacao,
  zero      => current_zero
);

ACUMULADOR: entity work.registradorGenerico
generic map (larguraDados => larguraDados)
port map (
  entrada   => ULA_acu,
  habilita  => habilita_acumulador,
  clock     => CLK,
  reset     => '0',
  saida     => acu_out
);

MUX_DADOS: entity work.muxGenerico2x1
generic map (larguraDados => larguraDados)
port map (
  entrada_0 => DATA_IN,
  entrada_1 => imediato,
  seletor   => seletor_MUX_dados,
  saida     => MUX_ULA
);

DECODER: entity work.decoderInstrucoes port map (
  opcode  => opcode,
  saida   => controle
);

SOMAPC: entity work.somaConstante
generic map (
  larguraDados => larguraEnderecos,
  constante => 1
)
port map (
  entrada => PC_count,
  saida   => soma_endMUX
);

MUX_END: entity work.Mux4Way9 port map (
  a   => soma_endMUX,
  b   => endereco,
  c   => reg_ret_out,
  d   => "000000000",
  sel => sel_next_instruction,
  q   => endMUX_PC
);

PC: entity work.registradorGenerico
generic map (larguraDados => larguraEnderecos)
port map (
  entrada   => endMUX_PC,
  habilita  => '1',
  clock     => CLK,
  reset     => RESET,
  saida     => PC_count
);

LOGICA_DESVIO: entity work.logicaDesvio port map (
  zero  => zero_flag,
  jeq   => jeq,
  jmp   => jmp,
  jsr   => jsr,
  ret   => ret,
  saida => sel_next_instruction
);

REG_ZERO: entity work.BinaryDigit port map (
  clock   => CLK,
  input   => current_zero,
  load    => habilita_flag,
  output  => zero_flag
);

REG_RET: entity work.registradorGenerico
generic map (larguraDados => larguraEnderecos)
port map (
  entrada   => soma_endMUX,
  habilita  => habilita_escrita_ret,
  clock     => CLK,
  reset     => '0',
  saida     => reg_ret_out
);

habilita_escrita_ret  <= controle(11);
jmp                   <= controle(10);
ret                   <= controle(9);
jsr                   <= controle(8);
jeq                   <= controle(7);
seletor_MUX_dados     <= controle(6);
habilita_acumulador   <= controle(5);
operacao              <= controle(4 downto 3);
habilita_flag         <= controle(2);
imediato              <= INSTRUCTION(7 downto 0);
opcode                <= INSTRUCTION(12 downto 9);
endereco              <= INSTRUCTION(8 downto 0);

DATA_ADDR   <= endereco;
DATA_OUT    <= acu_out;
ROM_ADDR    <= PC_count;
RD          <= controle(1);
WR          <= controle(0);

end architecture;