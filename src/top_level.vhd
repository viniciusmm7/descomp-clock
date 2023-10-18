library ieee;
use ieee.std_logic_1164.all;

entity top_level is
	-- Total de bits das entradas e saidas
	generic (
		larguraDados            : natural := 8;
		larguraEnderecos        : natural := 9;
		larguraInstrucoes       : natural := 13;
		simulacao               : boolean := TRUE -- para gravar na placa, altere de TRUE para FALSE
	);
	port (
		CLOCK_50      : in  STD_LOGIC;
		CLOCK         : in  STD_LOGIC;

		PCOUT         : out STD_LOGIC_VECTOR((larguraEnderecos - 1) downto 0);
		DIN           : out STD_LOGIC_VECTOR((larguraDados - 1) downto 0);
		DOUT          : out STD_LOGIC_VECTOR((larguraDados - 1) downto 0);
		ADDR		  : out STD_LOGIC_VECTOR((larguraEnderecos - 1) downto 0);

		SW            : in STD_LOGIC_VECTOR(9 downto 0);
		KEY           : in STD_LOGIC_VECTOR(3 downto 0);
		FPGA_RESET_N  : in STD_LOGIC;

		LEDR          : out STD_LOGIC_VECTOR(9 downto 0);
		HEX0          : out STD_LOGIC_VECTOR(6 downto 0);
		HEX1          : out STD_LOGIC_VECTOR(6 downto 0);
		HEX2          : out STD_LOGIC_VECTOR(6 downto 0);
		HEX3          : out STD_LOGIC_VECTOR(6 downto 0);
		HEX4          : out STD_LOGIC_VECTOR(6 downto 0);
		HEX5          : out STD_LOGIC_VECTOR(6 downto 0)
	);
end entity;


architecture arquitetura of top_level is

	signal instruction    : STD_LOGIC_VECTOR((larguraInstrucoes - 1) downto 0);
	signal ROM_address    : STD_LOGIC_VECTOR((larguraEnderecos - 1) downto 0);
	signal data_addr_bus  : STD_LOGIC_VECTOR((larguraEnderecos - 1) downto 0);
	signal data_rd_bus    : STD_LOGIC_VECTOR((larguraDados - 1) downto 0);
	signal data_wr_bus    : STD_LOGIC_VECTOR((larguraDados - 1) downto 0);

	signal rd           : STD_LOGIC;
	signal wr           : STD_LOGIC;
	signal CLK          : STD_LOGIC;

	signal hab_led_0    : STD_LOGIC;
	signal hab_led_1    : STD_LOGIC;
	signal hab_led_2    : STD_LOGIC;
	signal hab_RAM      : STD_LOGIC;

	signal hab_hex_0    : STD_LOGIC;
	signal hab_hex_1    : STD_LOGIC;
	signal hab_hex_2    : STD_LOGIC;
	signal hab_hex_3    : STD_LOGIC;
	signal hab_hex_4    : STD_LOGIC;
	signal hab_hex_5    : STD_LOGIC;

	signal hab_sw_0    : STD_LOGIC;
	signal hab_sw_1    : STD_LOGIC;
	signal hab_sw_2    : STD_LOGIC;

	signal hab_key_0    : STD_LOGIC;
	signal hab_key_1    : STD_LOGIC;
	signal hab_key_2    : STD_LOGIC;
	signal hab_key_3    : STD_LOGIC;
	signal hab_key_r    : STD_LOGIC;

	signal clear_key_0  : STD_LOGIC;
	signal clear_key_1  : STD_LOGIC;
	signal clear_key_r  : STD_LOGIC;

begin

	-- Instanciando os componentes:

	-- Para simular, fica mais simples tirar o edgeDetector
	gravar:  if simulacao generate
		CLK <= CLOCK_50;
	else generate
		detectorSub0: work.edgeDetector(bordaSubida)
			port map (clk => CLOCK_50, entrada => (not KEY(3)), saida => CLK);
	end generate;

	CPU: entity work.processador
		generic map (
			larguraDados      => larguraDados,
			larguraEnderecos  => larguraEnderecos,
			larguraInstrucoes => larguraInstrucoes
		)
		port map (
			CLK         => CLK,
			RESET       => '0',
			RD          => rd,
			WR          => wr,
			ROM_ADDR    => ROM_address,
			INSTRUCTION => instruction,
			DATA_IN     => data_rd_bus,
			DATA_OUT    => data_wr_bus,
			DATA_ADDR   => data_addr_bus
		);

	RAM: entity work.memoriaRAM
		generic map (
			dataWidth => larguraDados,
			addrWidth => 6
		)
		port map (
			endereco  => data_addr_bus(5 downto 0),
			leitura   => rd,
			escrita   => wr,
			habilita  => hab_RAM,
			clock     => CLK,
			entrada   => data_wr_bus,
			saida     => data_rd_bus
		);

	ROM: entity work.memoriaROM
		generic map (
			dataWidth => larguraInstrucoes,
			addrWidth => larguraEnderecos
		)
		port map (
			address	=> ROM_address,
			data		=> instruction
		);

	ADDR_DECODER: entity work.decoderEnderecos
		port map (
			ADDRESS     => data_addr_bus,
			WR          => wr,
			RD          => rd,
			HAB_LED_0   => hab_led_0,
			HAB_LED_1   => hab_led_1,
			HAB_LED_2   => hab_led_2,
			HAB_RAM     => hab_RAM,
			HAB_HEX_0   => hab_hex_0,
			HAB_HEX_1   => hab_hex_1,
			HAB_HEX_2   => hab_hex_2,
			HAB_HEX_3   => hab_hex_3,
			HAB_HEX_4   => hab_hex_4,
			HAB_HEX_5   => hab_hex_5,
			HAB_SW_0    => hab_sw_0,
			HAB_SW_1    => hab_sw_1,
			HAB_SW_2    => hab_sw_2,
			HAB_KEY_0   => hab_key_0,
			HAB_KEY_1   => hab_key_1,
			HAB_KEY_2   => hab_key_2,
			HAB_KEY_3   => hab_key_3,
			HAB_KEY_R   => hab_key_r,
			CLEAR_KEY_0 => clear_key_0,
			CLEAR_KEY_1 => clear_key_1,
			CLEAR_KEY_R => clear_key_r
		);

	LED_0_REG: entity work.registradorGenerico
		generic map (larguraDados => 8)
		port map (
			entrada   => data_wr_bus,
			habilita  => hab_led_0,
			clock     => CLK,
			reset     => '0',
			saida     => LEDR(7 downto 0)
		);

	LED_1_REG: entity work.BinaryDigit
		port map (
			clock   => CLK,
			input   => data_wr_bus(0),
			load    => hab_led_1,
			output  => LEDR(8)
		);

	LED_2_REG: entity work.BinaryDigit
		port map (
			clock   => CLK,
			input   => data_wr_bus(0),
			load    => hab_led_2,
			output  => LEDR(9)
		);

	HEX_0: entity work.hexUnit
		port map (
			CLK       => CLK,
			HABILITA  => hab_hex_0,
			DATA      => data_wr_bus(3 downto 0),
			OUTPUT    => HEX0
		);

	HEX_1: entity work.hexUnit
		port map (
			CLK       => CLK,
			HABILITA  => hab_hex_1,
			DATA      => data_wr_bus(3 downto 0),
			OUTPUT    => HEX1
		);

	HEX_2: entity work.hexUnit
		port map (
			CLK       => CLK,
			HABILITA  => hab_hex_2,
			DATA      => data_wr_bus(3 downto 0),
			OUTPUT    => HEX2
		);

	HEX_3: entity work.hexUnit
		port map (
			CLK       => CLK,
			HABILITA  => hab_hex_3,
			DATA      => data_wr_bus(3 downto 0),
			OUTPUT    => HEX3
		);

	HEX_4: entity work.hexUnit
		port map (
		CLK       => CLK,
		HABILITA  => hab_hex_4,
		DATA      => data_wr_bus(3 downto 0),
		OUTPUT    => HEX4
		);

	HEX_5: entity work.hexUnit
		port map (
			CLK       => CLK,
			HABILITA  => hab_hex_5,
			DATA      => data_wr_bus(3 downto 0),
			OUTPUT    => HEX5
		);

	SW_0: entity work.bufferTriState8
		port map (
			entrada   => SW(7 downto 0),
			habilita  => hab_sw_0,
			saida     => data_rd_bus
		);

	SW_1: entity work.bufferTriState
		port map (
			entrada   => SW(8),
			habilita  => hab_sw_1,
			saida     => data_rd_bus(0)
		);

	SW_2: entity work.bufferTriState
		port map (
			entrada   => SW(9),
			habilita  => hab_sw_2,
			saida     => data_rd_bus(0)
		);

	KEY_0: entity work.keyUnit
		port map (
			CLK       => CLK,
			CLEAR     => clear_key_0,
			HABILITA  => hab_key_0,
			BUTTON    => KEY(0),
			OUTPUT    => data_rd_bus(0)
		);

	KEY_1: entity work.keyUnit
		port map (
			CLK       => CLK,
			CLEAR     => clear_key_1,
			HABILITA  => hab_key_1,
			BUTTON    => KEY(1),
			OUTPUT    => data_rd_bus(0)
		);

	KEY_2: entity work.bufferTriState
		port map (
			entrada   => KEY(2),
			habilita  => hab_key_2,
			saida     => data_rd_bus(0)
		);

	KEY_3: entity work.bufferTriState
		port map (
			entrada   => KEY(3),
			habilita  => hab_key_3,
			saida     => data_rd_bus(0)
		);

	KEY_R: entity work.keyUnit
		port map (
			CLK       => CLK,
			CLEAR     => clear_key_r,
			HABILITA  => hab_key_r,
			BUTTON    => FPGA_RESET_N,
			OUTPUT    => data_rd_bus(0)
		);

	PCOUT   <= ROM_address;
	DOUT    <= data_wr_bus;
	DIN     <= data_rd_bus;
	ADDR    <= data_addr_bus;

end architecture;