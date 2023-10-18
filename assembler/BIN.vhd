tmp(0)	:= "0000000000000";	-- 	; SETUP
tmp(1)	:= "0000000000000";	-- NOP
tmp(2)	:= "0101111111111";	-- STA @511    	; reseta a leitura do key 0
tmp(3)	:= "0101111111110";	-- STA @510    	; reseta a leitura do key 1
tmp(4)	:= "0101111111101";	-- STA @509    	; reseta a leitura do key reset
tmp(5)	:= "0100000000000";	-- LDI $0      	; carrega o valor inicial das casas
tmp(6)	:= "0101000000000";	-- STA @0      	; armazena 0 na unidade
tmp(7)	:= "0101000000001";	-- STA @1      	; armazena 0 na dezena
tmp(8)	:= "0101000000010";	-- STA @2      	; armazena 0 na centena
tmp(9)	:= "0101000000011";	-- STA @3      	; armazena 0 no milhar
tmp(10)	:= "0101000000100";	-- STA @4      	; armazena 0 na dezena de milhar
tmp(11)	:= "0101000000101";	-- STA @5      	; armazena 0 na centena de milhar
tmp(12)	:= "0101000001000";	-- STA @8      	; armazena um 0 de referência
tmp(13)	:= "0100000000001";	-- LDI $1      	; carrega o valor de incremento
tmp(14)	:= "0101000000110";	-- STA @6      	; armazena o valor de incremento
tmp(15)	:= "0100000001010";	-- LDI $10     	; carrega o valor máximo por casa possível
tmp(16)	:= "0101000000111";	-- STA @7      	; armazena o valor máximo por casa possível
tmp(17)	:= "0100011100000";	-- LDI $224    	; carrega 224
tmp(18)	:= "0101000111001";	-- STA @57     	; intervalo numérico de configuração
tmp(19)	:= "0001101100100";	-- LDA @356    	; carrega o valor do botão reset
tmp(20)	:= "1011000000110";	-- AND @6      	; aplica a mask
tmp(21)	:= "1000000001000";	-- CEQ @8      	; verifica se é 0
tmp(22)	:= "0111000011001";	-- JEQ .PULA_RESET
tmp(23)	:= "0101111111101";	-- STA @509
tmp(24)	:= "1001000111110";	-- JSR .RESET
tmp(25)	:= "0001101100001";	-- LDA @353    	; carrega o valor do botão 1
tmp(26)	:= "1011000000110";	-- AND @6      	; aplica a mask
tmp(27)	:= "1000000001000";	-- CEQ @8      	; verifica se é 0
tmp(28)	:= "0111000100000";	-- JEQ .PULA_CONFIG
tmp(29)	:= "0101111111110";	-- STA @510
tmp(30)	:= "1001010001001";	-- JSR .MUDA_INTERVALO
tmp(31)	:= "0110000101010";	-- JMP .LOOP_CONFIGURACAO_LIMITE
tmp(32)	:= "0001101100000";	-- LDA @352    	; carrega o valor do botão 0
tmp(33)	:= "1011000000110";	-- AND @6      	; aplica a mask
tmp(34)	:= "1000000001000";	-- CEQ @8      	; verifica se é 0
tmp(35)	:= "0111000100110";	-- JEQ .PULA_INCREMENTA_CONTAGEM
tmp(36)	:= "0101111111111";	-- STA @511
tmp(37)	:= "1001001000110";	-- JSR .INCREMENTA_CONTAGEM
tmp(38)	:= "0100000000000";	-- LDI $0                  	; define se apaga ou acende os LEDS
tmp(39)	:= "1001010000100";	-- JSR .APAGA_LEDS         	; apaga os LEDs
tmp(40)	:= "1001001110111";	-- JSR .MOSTRA_CONTAGEM    	; escreve os números da contagem nos displays
tmp(41)	:= "0110000010011";	-- JMP .LOOP_PRINCIPAL
tmp(42)	:= "0001101100100";	-- LDA @356    	; carrega o valor do botão reset
tmp(43)	:= "1011000000110";	-- AND @6      	; aplica a mask
tmp(44)	:= "1000000000110";	-- CEQ @6      	; verifica se é 1
tmp(45)	:= "0111000111011";	-- JEQ .SAIR_LOOP_CONFIGURACAO_LIMITE
tmp(46)	:= "0001101100001";	-- LDA @353    	; carrega o valor do botão 1
tmp(47)	:= "1011000000110";	-- AND @6      	; aplica a mask
tmp(48)	:= "1000000001000";	-- CEQ @8      	; verifica se é 0
tmp(49)	:= "0111000110100";	-- JEQ .PULA_MUDANCA_ESTADO
tmp(50)	:= "0101111111110";	-- STA @510
tmp(51)	:= "0110000111011";	-- JMP .SAIR_LOOP_CONFIGURACAO_LIMITE
tmp(52)	:= "0001101100000";	-- LDA @352    	; carrega o valor do botão 0
tmp(53)	:= "1011000000110";	-- AND @6      	; aplica a mask
tmp(54)	:= "1000000001000";	-- CEQ @8      	; verifica se é 0
tmp(55)	:= "0111000111010";	-- JEQ .PULA_MUDANCA_INTERVALO
tmp(56)	:= "0101111111111";	-- STA @511
tmp(57)	:= "1001010001001";	-- JSR .MUDA_INTERVALO
tmp(58)	:= "0110000101010";	-- JMP .LOOP_CONFIGURACAO_LIMITE
tmp(59)	:= "0100011100000";	-- LDI $224    	; carrega 224
tmp(60)	:= "0101000111001";	-- STA @57     	; armazena 224 no intervalo de mudança atual
tmp(61)	:= "0110000010011";	-- JMP .LOOP_PRINCIPAL
tmp(62)	:= "0100000000000";	-- LDI $0
tmp(63)	:= "0101000000000";	-- STA @0
tmp(64)	:= "0101000000001";	-- STA @1
tmp(65)	:= "0101000000010";	-- STA @2
tmp(66)	:= "0101000000011";	-- STA @3
tmp(67)	:= "0101000000100";	-- STA @4
tmp(68)	:= "0101000000101";	-- STA @5
tmp(69)	:= "1000000000000";	-- RET
tmp(70)	:= "0001000000000";	-- LDA @0                  	; carrega o valor da unidade
tmp(71)	:= "0010000000110";	-- ADD @6                  	; incrementa o valor da unidade
tmp(72)	:= "1000000000111";	-- CEQ @7                  	; compara o valor da casa com 10
tmp(73)	:= "0111001001100";	-- JEQ .INCREMENTA_DEZENA  	; incrementa a casa da dezena caso necessário
tmp(74)	:= "0101000000000";	-- STA @0                  	; armazena o valor da unidade
tmp(75)	:= "1000000000000";	-- RET
tmp(76)	:= "0100000000000";	-- LDI $0                  	; carrega 0
tmp(77)	:= "0101000000000";	-- STA @0                  	; armazena 0 na unidade
tmp(78)	:= "0001000000001";	-- LDA @1                  	; carrega o valor atual da dezena
tmp(79)	:= "0010000000110";	-- ADD @6                  	; incrementa o valor da dezena
tmp(80)	:= "1000000000111";	-- CEQ @7                  	; verifica se é igual a 10
tmp(81)	:= "0111001010100";	-- JEQ .INCREMENTA_CENTENA 	; se for, incrementa a centena
tmp(82)	:= "0101000000001";	-- STA @1                  	; armazena o novo valor da dezena
tmp(83)	:= "0110001001011";	-- JMP .FIM_INCREMENTA     	; sai da função
tmp(84)	:= "0100000000000";	-- LDI $0                  	; carrega 0
tmp(85)	:= "0101000000001";	-- STA @1                  	; armazena 0 na dezena
tmp(86)	:= "0001000000010";	-- LDA @2                  	; carrega o valor atual da centena
tmp(87)	:= "0010000000110";	-- ADD @6                  	; incrementa o valor da centena
tmp(88)	:= "1000000000111";	-- CEQ @7                  	; verifica se é igual a 10
tmp(89)	:= "0111001011100";	-- JEQ .INCREMENTA_MILHAR  	; se for, incrementa o milhar
tmp(90)	:= "0101000000010";	-- STA @2                  	; armazena o novo valor da centena
tmp(91)	:= "0110001001011";	-- JMP .FIM_INCREMENTA     	; sai da função
tmp(92)	:= "0100000000000";	-- LDI $0                  	; carrega 0
tmp(93)	:= "0101000000010";	-- STA @2                  	; armazena 0 na centena
tmp(94)	:= "0001000000011";	-- LDA @3                  	; carrega o valor atual do milhar
tmp(95)	:= "0010000000110";	-- ADD @6                  	; incrementa o valor do milhar
tmp(96)	:= "1000000000111";	-- CEQ @7                  	; verifica se é igual a 10
tmp(97)	:= "0111001100100";	-- JEQ .INCREMENTA_DMILHAR 	; se for, incrementa a dezena de milhar
tmp(98)	:= "0101000000011";	-- STA @3                  	; armazena o novo valor do milhar
tmp(99)	:= "0110001001011";	-- JMP .FIM_INCREMENTA     	; sai da função
tmp(100)	:= "0100000000000";	-- LDI $0                  	; carrega 0
tmp(101)	:= "0101000000011";	-- STA @3                  	; armazena 0 no milhar
tmp(102)	:= "0001000000100";	-- LDA @4                  	; carrega o valor atual da dezena de milhar
tmp(103)	:= "0010000000110";	-- ADD @6                  	; incrementa o valor da dezena de milhar
tmp(104)	:= "1000000000111";	-- CEQ @7                  	; verifica se é igual a 10
tmp(105)	:= "0111001101100";	-- JEQ .INCREMENTA_CMILHAR 	; se for, incrementa a centena de milhar
tmp(106)	:= "0101000000100";	-- STA @4                  	; armazena o novo valor da dezena de milhar
tmp(107)	:= "0110001001011";	-- JMP .FIM_INCREMENTA     	; sai da função
tmp(108)	:= "0100000000000";	-- LDI $0                  	; carrega 0
tmp(109)	:= "0101000000100";	-- STA @4                  	; armazena 0 na dezena de milhar
tmp(110)	:= "0001000000101";	-- LDA @5                  	; carrega o valor atual da centena de milhar
tmp(111)	:= "0010000000110";	-- ADD @6                  	; incrementa o valor da centena de milhar
tmp(112)	:= "1000000000111";	-- CEQ @7                  	; verifica se é igual a 10
tmp(113)	:= "0111001110100";	-- JEQ .INCREMENTA_MILHAO  	; se for, zera tudo
tmp(114)	:= "0101000000101";	-- STA @5                  	; armazena o novo valor da centena de milhar
tmp(115)	:= "0110001001011";	-- JMP .FIM_INCREMENTA     	; sai da função
tmp(116)	:= "0100000000000";	-- LDI $0  	; carrega 0
tmp(117)	:= "0101000000101";	-- STA $5  	; armazena 0 na centena de milhar
tmp(118)	:= "0110001001011";	-- JMP .FIM_INCREMENTA
tmp(119)	:= "0001000000000";	-- LDA @0      	; carrega o valor da unidade
tmp(120)	:= "0101100100000";	-- STA @288    	; armazena o 0 no HEX 0
tmp(121)	:= "0001000000001";	-- LDA @1      	; carrega o valor da dezena
tmp(122)	:= "0101100100001";	-- STA @289    	; armazena o 0 no HEX 1
tmp(123)	:= "0001000000010";	-- LDA @2      	; carrega o valor da centena
tmp(124)	:= "0101100100010";	-- STA @290    	; armazena o 0 no HEX 2
tmp(125)	:= "0001000000011";	-- LDA @3      	; carrega o valor do milhar
tmp(126)	:= "0101100100011";	-- STA @291    	; armazena o 0 no HEX 3
tmp(127)	:= "0001000000100";	-- LDA @4      	; carrega o valor da dezena de milhar
tmp(128)	:= "0101100100100";	-- STA @292    	; armazena o 0 no HEX 4
tmp(129)	:= "0001000000101";	-- LDA @5      	; carrega o valor da centena de milhar
tmp(130)	:= "0101100100101";	-- STA @293    	; armazena o 0 no HEX 5
tmp(131)	:= "1000000000000";	-- RET
tmp(132)	:= "0100000000000";	-- LDI $0
tmp(133)	:= "0101100000000";	-- STA @256
tmp(134)	:= "0101100000001";	-- STA @257
tmp(135)	:= "0101100000010";	-- STA @258
tmp(136)	:= "1000000000000";	-- RET
tmp(137)	:= "0001000111001";	-- LDA @57                 	; carrega o intervalo atual
tmp(138)	:= "1000000001000";	-- CEQ @8                  	; verifica se é igual a 0
tmp(139)	:= "0111010001101";	-- JEQ .INTERVALO_ZERO     	; se for
tmp(140)	:= "0110010010100";	-- JMP .INTERVALO_NAO_ZERO 	; se não for
tmp(141)	:= "0100011100000";	-- LDI $224
tmp(142)	:= "0101000111001";	-- STA @57
tmp(143)	:= "0101100000000";	-- STA @256
tmp(144)	:= "0100000000001";	-- LDI $1
tmp(145)	:= "0101100000001";	-- STA @257
tmp(146)	:= "0101100000010";	-- STA @258
tmp(147)	:= "1000000000000";	-- RET
tmp(148)	:= "0100000000000";	-- LDI $0
tmp(149)	:= "0101000111001";	-- STA @57
tmp(150)	:= "0101100000001";	-- STA @257
tmp(151)	:= "0101100000010";	-- STA @258
tmp(152)	:= "0100000011111";	-- LDI $31
tmp(153)	:= "0101100000000";	-- STA @256
tmp(154)	:= "1000000000000";	-- RET