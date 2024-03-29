tmp(0)	:= "0000000000000";	-- 	; SETUP
tmp(1)	:= "0101111111111";	-- STA @511    	; reseta a leitura do key 0
tmp(2)	:= "0101111111110";	-- STA @510    	; reseta a leitura do key 1
tmp(3)	:= "0101111111101";	-- STA @509    	; reseta a leitura do key reset
tmp(4)	:= "0100000000000";	-- LDI $0      	; carrega o valor inicial das casas
tmp(5)	:= "0101000111001";	-- STA @57     	; intervalo numérico de configuração
tmp(6)	:= "0101000000000";	-- STA @0      	; armazena 0 na unidade
tmp(7)	:= "0101000000001";	-- STA @1      	; armazena 0 na dezena
tmp(8)	:= "0101000000010";	-- STA @2      	; armazena 0 na centena
tmp(9)	:= "0101000000011";	-- STA @3      	; armazena 0 no milhar
tmp(10)	:= "0101000000100";	-- STA @4      	; armazena 0 na dezena de milhar
tmp(11)	:= "0101000000101";	-- STA @5      	; armazena 0 na centena de milhar
tmp(12)	:= "0101000001000";	-- STA @8      	; armazena um 0 de referência
tmp(13)	:= "0100000000001";	-- LDI $1      	; carrega o valor de incremento
tmp(14)	:= "0101000000110";	-- STA @6      	; armazena o valor de incremento
tmp(15)	:= "0101000001001";	-- STA @9			; armazena 1 no 9 para referência do intervalo numérico de configuração
tmp(16)	:= "0100000001010";	-- LDI $10     	; carrega o valor máximo por casa possível
tmp(17)	:= "0101000000111";	-- STA @7      	; armazena o valor máximo por casa possível
tmp(18)	:= "0100000001001";	-- LDI $9      	; carrega o número 9 para definir o limite de contagem inicial
tmp(19)	:= "0101000110011";	-- STA @51			; armazena na casa das unidades do limite temporário
tmp(20)	:= "0101000110100";	-- STA @52			; armazena na casa das dezenas do limite temporário
tmp(21)	:= "0101000110101";	-- STA @53			; armazena na casa das centenas do limite temporário
tmp(22)	:= "0101000110110";	-- STA @54			; armazena na casa dos milhares do limite temporário
tmp(23)	:= "0101000110111";	-- STA @55			; armazena na casa das dezenas de milhares do limite temporário
tmp(24)	:= "0101000111000";	-- STA @56			; armazena na casa das centenas de milhares do limite temporário
tmp(25)	:= "0101000111010";	-- STA @58     	; armazena na casa das unidades do limite
tmp(26)	:= "0101000111011";	-- STA @59     	; armazena na casa das dezenas do limite
tmp(27)	:= "0101000111100";	-- STA @60     	; armazena na casa das centenas do limite
tmp(28)	:= "0101000111101";	-- STA @61     	; armazena na casa dos milhares do limite
tmp(29)	:= "0101000111110";	-- STA @62     	; armazena na casa das dezenas de milhar do limite
tmp(30)	:= "0101000111111";	-- STA @63     	; armazena na casa das centenas de milhar do limite
tmp(31)	:= "0100000000010";	-- LDI $2			; carrega 2 para inicializar próximo endereço de referência do intervalo numérico de configuração
tmp(32)	:= "0101000001010";	-- STA @10			; armazena a referência de estado 2 no endereço 10
tmp(33)	:= "0100000000011";	-- LDI $3			; carrega 3 para inicializar próximo endereço de referência do intervalo numérico de configuração
tmp(34)	:= "0101000001011";	-- STA @11			; armazena a referência de estado 3 no endereço 11
tmp(35)	:= "0100000000100";	-- LDI $4			; carrega 4 para inicializar próximo endereço de referência do intervalo numérico de configuração
tmp(36)	:= "0101000001100";	-- STA @12			; armazena a referência de estado 4 no endereço 12
tmp(37)	:= "0001101100100";	-- LDA @356    	; carrega o valor do botão reset
tmp(38)	:= "1011000000110";	-- AND @6      	; aplica a mask
tmp(39)	:= "1000000001000";	-- CEQ @8      	; verifica se é 0
tmp(40)	:= "0111000101011";	-- JEQ .PULA_RESET
tmp(41)	:= "0101111111101";	-- STA @509
tmp(42)	:= "1001001011001";	-- JSR .RESET
tmp(43)	:= "0001101100001";	-- LDA @353    	; carrega o valor do botão 1
tmp(44)	:= "1011000000110";	-- AND @6      	; aplica a mask
tmp(45)	:= "1000000001000";	-- CEQ @8      	; verifica se é 0
tmp(46)	:= "0111000110001";	-- JEQ .PULA_CONFIG
tmp(47)	:= "0101111111110";	-- STA @510
tmp(48)	:= "0110000111100";	-- JMP .INICIO_LOOP_CONFIGURACAO_LIMITE
tmp(49)	:= "1001101011010";	-- JSR .ATINGIU_LIMITE			; verifica se a contagem atingiu o limite
tmp(50)	:= "1000000000110";	-- CEQ @6						; se atingiu o limite, pula o incrementa contagem
tmp(51)	:= "0111000111010";	-- JEQ .PULA_INCREMENTA_CONTAGEM
tmp(52)	:= "0001101100000";	-- LDA @352    	; carrega o valor do botão 0
tmp(53)	:= "1011000000110";	-- AND @6      	; aplica a mask
tmp(54)	:= "1000000001000";	-- CEQ @8      	; verifica se é 0
tmp(55)	:= "0111000111010";	-- JEQ .PULA_INCREMENTA_CONTAGEM
tmp(56)	:= "0101111111111";	-- STA @511
tmp(57)	:= "1001001110100";	-- JSR .INCREMENTA_CONTAGEM
tmp(58)	:= "1001010100101";	-- JSR .MOSTRA_CONTAGEM    	; escreve os números da contagem nos displays
tmp(59)	:= "0110000100101";	-- JMP .LOOP_PRINCIPAL
tmp(60)	:= "1001001011001";	-- JSR .RESET		; reseta a contagem
tmp(61)	:= "0100000000011";	-- LDI $3			; acende os leds da primeira posição
tmp(62)	:= "0101100000000";	-- STA @256
tmp(63)	:= "0100000000000";	-- LDI $0
tmp(64)	:= "0101100000001";	-- STA @257
tmp(65)	:= "0101100000010";	-- STA @258
tmp(66)	:= "0001101100100";	-- LDA @356    	; carrega o valor do botão reset
tmp(67)	:= "1011000000110";	-- AND @6      	; aplica a mask
tmp(68)	:= "1000000000110";	-- CEQ @6      	; verifica se é 1
tmp(69)	:= "0111001010101";	-- JEQ .SAIR_LOOP_CONFIGURACAO_LIMITE_SEM_SALVAR
tmp(70)	:= "0001101100001";	-- LDA @353    	; carrega o valor do botão 1
tmp(71)	:= "1011000000110";	-- AND @6      	; aplica a mask
tmp(72)	:= "1000000001000";	-- CEQ @8      	; verifica se é 0
tmp(73)	:= "0111001001100";	-- JEQ .PULA_MUDANCA_ESTADO
tmp(74)	:= "0101111111110";	-- STA @510
tmp(75)	:= "0110001010100";	-- JMP .SAIR_LOOP_CONFIGURACAO_LIMITE
tmp(76)	:= "0001101100000";	-- LDA @352    	; carrega o valor do botão 0
tmp(77)	:= "1011000000110";	-- AND @6      	; aplica a mask
tmp(78)	:= "1000000001000";	-- CEQ @8      	; verifica se é 0
tmp(79)	:= "0111001010010";	-- JEQ .PULA_MUDANCA_INTERVALO
tmp(80)	:= "0101111111111";	-- STA @511
tmp(81)	:= "1001100010001";	-- JSR .MUDA_INTERVALO
tmp(82)	:= "1001010110010";	-- JSR .MOSTRA_LIMITE
tmp(83)	:= "0110001000010";	-- JMP .LOOP_CONFIGURACAO_LIMITE
tmp(84)	:= "1001101111110";	-- JSR .ARMAZENA_LIMITE		; armazena o limite do jeito que mostra nos displays
tmp(85)	:= "1001100001100";	-- JSR .APAGA_LEDS
tmp(86)	:= "0100000000000";	-- LDI $0    		; carrega 0
tmp(87)	:= "0101000111001";	-- STA @57     	; armazena 0 no intervalo de mudança atual
tmp(88)	:= "0110000100101";	-- JMP .LOOP_PRINCIPAL
tmp(89)	:= "0100000000000";	-- LDI $0
tmp(90)	:= "0101000000000";	-- STA @0
tmp(91)	:= "0101000000001";	-- STA @1
tmp(92)	:= "0101000000010";	-- STA @2
tmp(93)	:= "0101000000011";	-- STA @3
tmp(94)	:= "0101000000100";	-- STA @4
tmp(95)	:= "0101000000101";	-- STA @5
tmp(96)	:= "0100000000000";	-- LDI $0
tmp(97)	:= "0101100000000";	-- STA @256
tmp(98)	:= "0101100000001";	-- STA @257
tmp(99)	:= "0101100000010";	-- STA @258
tmp(100)	:= "0101111111111";	-- STA @511
tmp(101)	:= "0101111111110";	-- STA @510
tmp(102)	:= "0101111111101";	-- STA @509
tmp(103)	:= "0001000111010";	-- LDA @58
tmp(104)	:= "0101000110011";	-- STA @51
tmp(105)	:= "0001000111011";	-- LDA @59
tmp(106)	:= "0101000110100";	-- STA @52
tmp(107)	:= "0001000111100";	-- LDA @60
tmp(108)	:= "0101000110101";	-- STA @53
tmp(109)	:= "0001000111101";	-- LDA @61
tmp(110)	:= "0101000110110";	-- STA @54
tmp(111)	:= "0001000111110";	-- LDA @62
tmp(112)	:= "0101000110111";	-- STA @55
tmp(113)	:= "0001000111111";	-- LDA @63
tmp(114)	:= "0101000111000";	-- STA @56
tmp(115)	:= "1010000000000";	-- RET
tmp(116)	:= "0001000000000";	-- LDA @0                  	; carrega o valor da unidade
tmp(117)	:= "0010000000110";	-- ADD @6                  	; incrementa o valor da unidade
tmp(118)	:= "1000000000111";	-- CEQ @7                  	; compara o valor da casa com 10
tmp(119)	:= "0111001111010";	-- JEQ .INCREMENTA_DEZENA  	; incrementa a casa da dezena caso necessário
tmp(120)	:= "0101000000000";	-- STA @0                  	; armazena o valor da unidade
tmp(121)	:= "1010000000000";	-- RET
tmp(122)	:= "0100000000000";	-- LDI $0                  	; carrega 0
tmp(123)	:= "0101000000000";	-- STA @0                  	; armazena 0 na unidade
tmp(124)	:= "0001000000001";	-- LDA @1                  	; carrega o valor atual da dezena
tmp(125)	:= "0010000000110";	-- ADD @6                  	; incrementa o valor da dezena
tmp(126)	:= "1000000000111";	-- CEQ @7                  	; verifica se é igual a 10
tmp(127)	:= "0111010000010";	-- JEQ .INCREMENTA_CENTENA 	; se for, incrementa a centena
tmp(128)	:= "0101000000001";	-- STA @1                  	; armazena o novo valor da dezena
tmp(129)	:= "0110001111001";	-- JMP .FIM_INCREMENTA     	; sai da função
tmp(130)	:= "0100000000000";	-- LDI $0                  	; carrega 0
tmp(131)	:= "0101000000001";	-- STA @1                  	; armazena 0 na dezena
tmp(132)	:= "0001000000010";	-- LDA @2                  	; carrega o valor atual da centena
tmp(133)	:= "0010000000110";	-- ADD @6                  	; incrementa o valor da centena
tmp(134)	:= "1000000000111";	-- CEQ @7                  	; verifica se é igual a 10
tmp(135)	:= "0111010001010";	-- JEQ .INCREMENTA_MILHAR  	; se for, incrementa o milhar
tmp(136)	:= "0101000000010";	-- STA @2                  	; armazena o novo valor da centena
tmp(137)	:= "0110001111001";	-- JMP .FIM_INCREMENTA     	; sai da função
tmp(138)	:= "0100000000000";	-- LDI $0                  	; carrega 0
tmp(139)	:= "0101000000010";	-- STA @2                  	; armazena 0 na centena
tmp(140)	:= "0001000000011";	-- LDA @3                  	; carrega o valor atual do milhar
tmp(141)	:= "0010000000110";	-- ADD @6                  	; incrementa o valor do milhar
tmp(142)	:= "1000000000111";	-- CEQ @7                  	; verifica se é igual a 10
tmp(143)	:= "0111010010010";	-- JEQ .INCREMENTA_DMILHAR 	; se for, incrementa a dezena de milhar
tmp(144)	:= "0101000000011";	-- STA @3                  	; armazena o novo valor do milhar
tmp(145)	:= "0110001111001";	-- JMP .FIM_INCREMENTA     	; sai da função
tmp(146)	:= "0100000000000";	-- LDI $0                  	; carrega 0
tmp(147)	:= "0101000000011";	-- STA @3                  	; armazena 0 no milhar
tmp(148)	:= "0001000000100";	-- LDA @4                  	; carrega o valor atual da dezena de milhar
tmp(149)	:= "0010000000110";	-- ADD @6                  	; incrementa o valor da dezena de milhar
tmp(150)	:= "1000000000111";	-- CEQ @7                  	; verifica se é igual a 10
tmp(151)	:= "0111010011010";	-- JEQ .INCREMENTA_CMILHAR 	; se for, incrementa a centena de milhar
tmp(152)	:= "0101000000100";	-- STA @4                  	; armazena o novo valor da dezena de milhar
tmp(153)	:= "0110001111001";	-- JMP .FIM_INCREMENTA     	; sai da função
tmp(154)	:= "0100000000000";	-- LDI $0                  	; carrega 0
tmp(155)	:= "0101000000100";	-- STA @4                  	; armazena 0 na dezena de milhar
tmp(156)	:= "0001000000101";	-- LDA @5                  	; carrega o valor atual da centena de milhar
tmp(157)	:= "0010000000110";	-- ADD @6                  	; incrementa o valor da centena de milhar
tmp(158)	:= "1000000000111";	-- CEQ @7                  	; verifica se é igual a 10
tmp(159)	:= "0111010100010";	-- JEQ .INCREMENTA_MILHAO  	; se for, zera tudo
tmp(160)	:= "0101000000101";	-- STA @5                  	; armazena o novo valor da centena de milhar
tmp(161)	:= "0110001111001";	-- JMP .FIM_INCREMENTA     	; sai da função
tmp(162)	:= "0100000000000";	-- LDI $0  	; carrega 0
tmp(163)	:= "0101000000101";	-- STA $5  	; armazena 0 na centena de milhar
tmp(164)	:= "0110001111001";	-- JMP .FIM_INCREMENTA
tmp(165)	:= "0001000000000";	-- LDA @0      	; carrega o valor da unidade
tmp(166)	:= "0101100100000";	-- STA @288    	; armazena no HEX 0
tmp(167)	:= "0001000000001";	-- LDA @1      	; carrega o valor da dezena
tmp(168)	:= "0101100100001";	-- STA @289    	; armazena no HEX 1
tmp(169)	:= "0001000000010";	-- LDA @2      	; carrega o valor da centena
tmp(170)	:= "0101100100010";	-- STA @290    	; armazena no HEX 2
tmp(171)	:= "0001000000011";	-- LDA @3      	; carrega o valor do milhar
tmp(172)	:= "0101100100011";	-- STA @291    	; armazena no HEX 3
tmp(173)	:= "0001000000100";	-- LDA @4      	; carrega o valor da dezena de milhar
tmp(174)	:= "0101100100100";	-- STA @292    	; armazena no HEX 4
tmp(175)	:= "0001000000101";	-- LDA @5      	; carrega o valor da centena de milhar
tmp(176)	:= "0101100100101";	-- STA @293    	; armazena no HEX 5
tmp(177)	:= "1010000000000";	-- RET
tmp(178)	:= "0001000111001";	-- LDA @57                 	; carrega o intervalo atual
tmp(179)	:= "1000000001000";	-- CEQ @8                  	; verifica se é igual a 0
tmp(180)	:= "0111010111110";	-- JEQ .DIGITO_0_ML     	; se for
tmp(181)	:= "1000000001001";	-- CEQ @9                  	; verifica se é igual a 1
tmp(182)	:= "0111011001011";	-- JEQ .DIGITO_1_ML     	; se for
tmp(183)	:= "1000000001010";	-- CEQ @10                 	; verifica se é igual a 2
tmp(184)	:= "0111011011000";	-- JEQ .DIGITO_2_ML     	; se for
tmp(185)	:= "1000000001011";	-- CEQ @11                 	; verifica se é igual a 3
tmp(186)	:= "0111011100101";	-- JEQ .DIGITO_3_ML     	; se for
tmp(187)	:= "1000000001100";	-- CEQ @12                 	; verifica se é igual a 4
tmp(188)	:= "0111011110010";	-- JEQ .DIGITO_4_ML     	; se for
tmp(189)	:= "0110011111111";	-- JMP .DIGITO_5_ML 		; se não for nenhum dos acima
tmp(190)	:= "0001101000000";	-- LDA @320    	; carrega o valor das chaves
tmp(191)	:= "0101100100000";	-- STA @288    	; armazena no HEX 0
tmp(192)	:= "0001000110100";	-- LDA @52			; carrega o valor da dezena do limite temporário
tmp(193)	:= "0101100100001";	-- STA @289    	; armazena no HEX 1
tmp(194)	:= "0001000110101";	-- LDA @53			; carrega o valor de centena do limite temporário
tmp(195)	:= "0101100100010";	-- STA @290    	; armazena no HEX 2
tmp(196)	:= "0001000110110";	-- LDA @54     	; carrega o valor do milhar do limite temporário
tmp(197)	:= "0101100100011";	-- STA @291    	; armazena no HEX 3
tmp(198)	:= "0001000110111";	-- LDA @55     	; carrega o valor da dezena de milhar do limite temporário
tmp(199)	:= "0101100100100";	-- STA @292    	; armazena no HEX 4
tmp(200)	:= "0001000111000";	-- LDA @56     	; carrega o valor da centena de milhar do limite temporário
tmp(201)	:= "0101100100101";	-- STA @293    	; armazena no HEX 5
tmp(202)	:= "1010000000000";	-- RET
tmp(203)	:= "0001000110011";	-- LDA @51     	; carrega o valor da unidade do limite temporário
tmp(204)	:= "0101100100000";	-- STA @288    	; armazena no HEX 0
tmp(205)	:= "0001101000000";	-- LDA @320    	; carrega o valor das chaves
tmp(206)	:= "0101100100001";	-- STA @289    	; armazena no HEX 1
tmp(207)	:= "0001000110101";	-- LDA @53     	; carrega o valor da centena do limite temporário
tmp(208)	:= "0101100100010";	-- STA @290    	; armazena no HEX 2
tmp(209)	:= "0001000110110";	-- LDA @54     	; carrega o valor do milhar do limite temporário
tmp(210)	:= "0101100100011";	-- STA @291    	; armazena no HEX 3
tmp(211)	:= "0001000110111";	-- LDA @55     	; carrega o valor da dezena de milhar do limite temporário
tmp(212)	:= "0101100100100";	-- STA @292    	; armazena no HEX 4
tmp(213)	:= "0001000111000";	-- LDA @56     	; carrega o valor da centena de milhar do limite temporário
tmp(214)	:= "0101100100101";	-- STA @293    	; armazena no HEX 5
tmp(215)	:= "1010000000000";	-- RET
tmp(216)	:= "0001000110011";	-- LDA @51     	; carrega o valor da unidade do limite temporário
tmp(217)	:= "0101100100000";	-- STA @288    	; armazena no HEX 0
tmp(218)	:= "0001000110100";	-- LDA @52			; carrega o valor da dezena do limite temporário
tmp(219)	:= "0101100100001";	-- STA @289    	; armazena no HEX 1
tmp(220)	:= "0001101000000";	-- LDA @320    	; carrega o valor das chaves
tmp(221)	:= "0101100100010";	-- STA @290    	; armazena no HEX 2
tmp(222)	:= "0001000110110";	-- LDA @54     	; carrega o valor do milhar do limite temporário
tmp(223)	:= "0101100100011";	-- STA @291    	; armazena no HEX 3
tmp(224)	:= "0001000110111";	-- LDA @55     	; carrega o valor da dezena de milhar do limite temporário
tmp(225)	:= "0101100100100";	-- STA @292    	; armazena no HEX 4
tmp(226)	:= "0001000111000";	-- LDA @56     	; carrega o valor da centena de milhar do limite temporário
tmp(227)	:= "0101100100101";	-- STA @293    	; armazena no HEX 5
tmp(228)	:= "1010000000000";	-- RET
tmp(229)	:= "0001000110011";	-- LDA @51     	; carrega o valor da unidade do limite temporário
tmp(230)	:= "0101100100000";	-- STA @288    	; armazena no HEX 0
tmp(231)	:= "0001000110100";	-- LDA @52			; carrega o valor da dezena do limite temporário
tmp(232)	:= "0101100100001";	-- STA @289    	; armazena no HEX 1
tmp(233)	:= "0001000110101";	-- LDA @53    		; carrega o valor da centena do limite temporário
tmp(234)	:= "0101100100010";	-- STA @290    	; armazena no HEX 2
tmp(235)	:= "0001101000000";	-- LDA @320    	; carrega o valor das chaves
tmp(236)	:= "0101100100011";	-- STA @291    	; armazena no HEX 3
tmp(237)	:= "0001000110111";	-- LDA @55     	; carrega o valor da dezena de milhar do limite temporário
tmp(238)	:= "0101100100100";	-- STA @292    	; armazena no HEX 4
tmp(239)	:= "0001000111000";	-- LDA @56     	; carrega o valor da centena de milhar do limite temporário
tmp(240)	:= "0101100100101";	-- STA @293    	; armazena no HEX 5
tmp(241)	:= "1010000000000";	-- RET
tmp(242)	:= "0001000110011";	-- LDA @51     	; carrega o valor da unidade do limite temporário
tmp(243)	:= "0101100100000";	-- STA @288    	; armazena no HEX 0
tmp(244)	:= "0001000110100";	-- LDA @52			; carrega o valor da dezena do limite temporário
tmp(245)	:= "0101100100001";	-- STA @289    	; armazena no HEX 1
tmp(246)	:= "0001000110101";	-- LDA @53    		; carrega o valor da centena do limite temporário
tmp(247)	:= "0101100100010";	-- STA @290    	; armazena no HEX 2
tmp(248)	:= "0001000110110";	-- LDA @54     	; carrega o valor do milhar do limite temporário
tmp(249)	:= "0101100100011";	-- STA @291    	; armazena no HEX 3
tmp(250)	:= "0001101000000";	-- LDA @320    	; carrega o valor das chaves
tmp(251)	:= "0101100100100";	-- STA @292    	; armazena no HEX 4
tmp(252)	:= "0001000111000";	-- LDA @56     	; carrega o valor da centena de milhar do limite temporário
tmp(253)	:= "0101100100101";	-- STA @293    	; armazena no HEX 5
tmp(254)	:= "1010000000000";	-- RET
tmp(255)	:= "0001000110011";	-- LDA @51     	; carrega o valor da unidade do limite temporário
tmp(256)	:= "0101100100000";	-- STA @288    	; armazena no HEX 0
tmp(257)	:= "0001000110100";	-- LDA @52			; carrega o valor da dezena do limite temporário
tmp(258)	:= "0101100100001";	-- STA @289    	; armazena no HEX 1
tmp(259)	:= "0001000110101";	-- LDA @53    		; carrega o valor da centena do limite temporário
tmp(260)	:= "0101100100010";	-- STA @290    	; armazena no HEX 2
tmp(261)	:= "0001000110110";	-- LDA @54     	; carrega o valor do milhar do limite temporário
tmp(262)	:= "0101100100011";	-- STA @291    	; armazena no HEX 3
tmp(263)	:= "0001000110111";	-- LDA @55     	; carrega o valor da dezena de milhar do limite temporário
tmp(264)	:= "0101100100100";	-- STA @292    	; armazena no HEX 4
tmp(265)	:= "0001101000000";	-- LDA @320    	; carrega o valor das chaves
tmp(266)	:= "0101100100101";	-- STA @293    	; armazena no HEX 5
tmp(267)	:= "1010000000000";	-- RET
tmp(268)	:= "0100000000000";	-- LDI $0
tmp(269)	:= "0101100000000";	-- STA @256
tmp(270)	:= "0101100000001";	-- STA @257
tmp(271)	:= "0101100000010";	-- STA @258
tmp(272)	:= "1010000000000";	-- RET
tmp(273)	:= "0001000111001";	-- LDA @57                 	; carrega o intervalo atual
tmp(274)	:= "1000000001000";	-- CEQ @8                  	; verifica se é igual a 0
tmp(275)	:= "0111100011101";	-- JEQ .DIGITO_0_MI     		; se for
tmp(276)	:= "1000000001001";	-- CEQ @9                  	; verifica se é igual a 1
tmp(277)	:= "0111100100111";	-- JEQ .DIGITO_1_MI     		; se for
tmp(278)	:= "1000000001010";	-- CEQ @10                 	; verifica se é igual a 2
tmp(279)	:= "0111100110001";	-- JEQ .DIGITO_2_MI     		; se for
tmp(280)	:= "1000000001011";	-- CEQ @11                 	; verifica se é igual a 3
tmp(281)	:= "0111100111011";	-- JEQ .DIGITO_3_MI     		; se for
tmp(282)	:= "1000000001100";	-- CEQ @12                 	; verifica se é igual a 4
tmp(283)	:= "0111101000110";	-- JEQ .DIGITO_4_MI     		; se for
tmp(284)	:= "0110101010000";	-- JMP .DIGITO_5_MI 			; se não for nenhum dos acima
tmp(285)	:= "0100000000001";	-- LDI $1			; atualiza o intervalo
tmp(286)	:= "0101000111001";	-- STA @57
tmp(287)	:= "0100000000110";	-- LDI $6			; acende os LEDs da segunda posição e apaga o resto
tmp(288)	:= "0101100000000";	-- STA @256
tmp(289)	:= "0100000000000";	-- LDI $0
tmp(290)	:= "0101100000001";	-- STA @257
tmp(291)	:= "0101100000010";	-- STA @258
tmp(292)	:= "0001101000000";	-- LDA @320		; salva o novo valor do dígito
tmp(293)	:= "0101000110011";	-- STA @51
tmp(294)	:= "1010000000000";	-- RET
tmp(295)	:= "0100000000010";	-- LDI $2			; atualiza o intervalo
tmp(296)	:= "0101000111001";	-- STA @57
tmp(297)	:= "0100000011000";	-- LDI $24			; acende os LEDs da terceira posição e apaga o resto
tmp(298)	:= "0101100000000";	-- STA @256
tmp(299)	:= "0100000000000";	-- LDI $0
tmp(300)	:= "0101100000001";	-- STA @257
tmp(301)	:= "0101100000010";	-- STA @258
tmp(302)	:= "0001101000000";	-- LDA @320		; salva o novo valor do dígito
tmp(303)	:= "0101000110100";	-- STA @52
tmp(304)	:= "1010000000000";	-- RET
tmp(305)	:= "0100000000011";	-- LDI $3			; atualiza o intervalo
tmp(306)	:= "0101000111001";	-- STA @57
tmp(307)	:= "0100001100000";	-- LDI $96			; acende os LEDs da quarta posição e apaga o resto
tmp(308)	:= "0101100000000";	-- STA @256
tmp(309)	:= "0100000000000";	-- LDI $0
tmp(310)	:= "0101100000001";	-- STA @257
tmp(311)	:= "0101100000010";	-- STA @258
tmp(312)	:= "0001101000000";	-- LDA @320		; salva o novo valor do dígito
tmp(313)	:= "0101000110101";	-- STA @53
tmp(314)	:= "1010000000000";	-- RET
tmp(315)	:= "0100000000100";	-- LDI $4			; atualiza o intervalo
tmp(316)	:= "0101000111001";	-- STA @57
tmp(317)	:= "0100010000000";	-- LDI $128		; acende os LEDs da quinta posição e apaga o resto
tmp(318)	:= "0101100000000";	-- STA @256
tmp(319)	:= "0100000000001";	-- LDI $1
tmp(320)	:= "0101100000001";	-- STA @257
tmp(321)	:= "0100000000000";	-- LDI $0
tmp(322)	:= "0101100000010";	-- STA @258
tmp(323)	:= "0001101000000";	-- LDA @320		; salva o novo valor do dígito
tmp(324)	:= "0101000110110";	-- STA @54
tmp(325)	:= "1010000000000";	-- RET
tmp(326)	:= "0100000000101";	-- LDI $5			; atualiza o intervalo
tmp(327)	:= "0101000111001";	-- STA @57
tmp(328)	:= "0100000000000";	-- LDI $0			; acende os LEDs da sexta posição e apaga o resto
tmp(329)	:= "0101100000000";	-- STA @256
tmp(330)	:= "0100000000001";	-- LDI $1
tmp(331)	:= "0101100000001";	-- STA @257
tmp(332)	:= "0101100000010";	-- STA @258
tmp(333)	:= "0001101000000";	-- LDA @320		; salva o novo valor do dígito
tmp(334)	:= "0101000110111";	-- STA @55
tmp(335)	:= "1010000000000";	-- RET
tmp(336)	:= "0100000000000";	-- LDI $0			; atualiza o intervalo
tmp(337)	:= "0101000111001";	-- STA @57
tmp(338)	:= "0100000000011";	-- LDI $3			; acende os LEDs da primeira posição e apaga o resto
tmp(339)	:= "0101100000000";	-- STA @256
tmp(340)	:= "0100000000000";	-- LDI $0
tmp(341)	:= "0101100000001";	-- STA @257
tmp(342)	:= "0101100000010";	-- STA @258
tmp(343)	:= "0001101000000";	-- LDA @320		; salva o novo valor do dígito
tmp(344)	:= "0101000111000";	-- STA @56
tmp(345)	:= "1010000000000";	-- RET
tmp(346)	:= "0001000000101";	-- LDA @5			; carrega o valor da centena de milhar
tmp(347)	:= "1000000111111";	-- CEQ @63			; compara com o valor limite da centena de milhar
tmp(348)	:= "0111101011111";	-- JEQ .CMILHAR_ATINGIU
tmp(349)	:= "0100000000000";	-- LDI $0			; se não for igual, não atingiu
tmp(350)	:= "1010000000000";	-- RET
tmp(351)	:= "0001000000100";	-- LDA @4			; carrega o valor da dezena de milhar
tmp(352)	:= "1000000111110";	-- CEQ @62			; compara com o valor limite da dezena de milhar
tmp(353)	:= "0111101100100";	-- JEQ .DMILHAR_ATINGIU
tmp(354)	:= "0100000000000";	-- LDI $0			; se não for igual, não atingiu
tmp(355)	:= "1010000000000";	-- RET
tmp(356)	:= "0001000000011";	-- LDA @3			; carrega o valor do milhar
tmp(357)	:= "1000000111101";	-- CEQ @61			; compara com o valor limite do milhar
tmp(358)	:= "0111101101001";	-- JEQ .MILHAR_ATINGIU
tmp(359)	:= "0100000000000";	-- LDI $0			; se não for igual, não atingiu
tmp(360)	:= "1010000000000";	-- RET
tmp(361)	:= "0001000000010";	-- LDA @2			; carrega o valor da centena
tmp(362)	:= "1000000111100";	-- CEQ @60			; compara com o valor limite da centena
tmp(363)	:= "0111101101110";	-- JEQ .CENTENA_ATINGIU
tmp(364)	:= "0100000000000";	-- LDI $0			; se não for igual, não atingiu
tmp(365)	:= "1010000000000";	-- RET
tmp(366)	:= "0001000000001";	-- LDA @1			; carrega o valor da dezena
tmp(367)	:= "1000000111011";	-- CEQ @59			; compara com o valor limite da dezena
tmp(368)	:= "0111101110011";	-- JEQ .DEZENA_ATINGIU
tmp(369)	:= "0100000000000";	-- LDI $0			; se não for igual, não atingiu
tmp(370)	:= "1010000000000";	-- RET
tmp(371)	:= "0001000000000";	-- LDA @0			; carrega o valor da unidade
tmp(372)	:= "1000000111010";	-- CEQ @58			; compara com o valor limite da unidade
tmp(373)	:= "0111101111000";	-- JEQ .UNIDADE_ATINGIU
tmp(374)	:= "0100000000000";	-- LDI $0			; se não for igual, não atingiu
tmp(375)	:= "1010000000000";	-- RET
tmp(376)	:= "0100011111111";	-- LDI $255
tmp(377)	:= "0101100000000";	-- STA @256
tmp(378)	:= "0101100000001";	-- STA @257
tmp(379)	:= "0101100000010";	-- STA @258
tmp(380)	:= "0100000000001";	-- LDI $1
tmp(381)	:= "1010000000000";	-- RET
tmp(382)	:= "0001000111001";	-- LDA @57                 	; carrega o digito atual
tmp(383)	:= "1000000001000";	-- CEQ @8                  	; verifica se é igual a 0
tmp(384)	:= "0111110001010";	-- JEQ .DIGITO_0_AL     		; se for
tmp(385)	:= "1000000001001";	-- CEQ @9                  	; verifica se é igual a 1
tmp(386)	:= "0111110001101";	-- JEQ .DIGITO_1_AL     		; se for
tmp(387)	:= "1000000001010";	-- CEQ @10                 	; verifica se é igual a 2
tmp(388)	:= "0111110010000";	-- JEQ .DIGITO_2_AL     		; se for
tmp(389)	:= "1000000001011";	-- CEQ @11                 	; verifica se é igual a 3
tmp(390)	:= "0111110010011";	-- JEQ .DIGITO_3_AL     		; se for
tmp(391)	:= "1000000001100";	-- CEQ @12                 	; verifica se é igual a 4
tmp(392)	:= "0111110010110";	-- JEQ .DIGITO_4_AL     		; se for
tmp(393)	:= "0110110011001";	-- JMP .DIGITO_5_AL 			; se não for nenhum dos acima
tmp(394)	:= "0001101000000";	-- LDA @320		; carrega o valor dos switches
tmp(395)	:= "0101000110011";	-- STA @51			; armazena na unidade do limite
tmp(396)	:= "0110110011011";	-- JMP .FINAL_AL
tmp(397)	:= "0001101000000";	-- LDA @320		; carrega o valor dos switches
tmp(398)	:= "0101000110100";	-- STA @52			; armazena na dezena do limite
tmp(399)	:= "0110110011011";	-- JMP .FINAL_AL
tmp(400)	:= "0001101000000";	-- LDA @320		; carrega o valor dos switches
tmp(401)	:= "0101000110101";	-- STA @53			; armazena na centena do limite
tmp(402)	:= "0110110011011";	-- JMP .FINAL_AL
tmp(403)	:= "0001101000000";	-- LDA @320		; carrega o valor dos switches
tmp(404)	:= "0101000110110";	-- STA @54			; armazena no milhar do limite
tmp(405)	:= "0110110011011";	-- JMP .FINAL_AL
tmp(406)	:= "0001101000000";	-- LDA @320		; carrega o valor dos switches
tmp(407)	:= "0101000110111";	-- STA @55			; armazena na dezena de milhar do limite
tmp(408)	:= "0110110011011";	-- JMP .FINAL_AL
tmp(409)	:= "0001101000000";	-- LDA @320		; carrega o valor dos switches
tmp(410)	:= "0101000111000";	-- STA @56			; armazena na centena de milhar do limite
tmp(411)	:= "0001000110011";	-- LDA @51
tmp(412)	:= "0101000111010";	-- STA @58
tmp(413)	:= "0001000110100";	-- LDA @52
tmp(414)	:= "0101000111011";	-- STA @59
tmp(415)	:= "0001000110101";	-- LDA @53
tmp(416)	:= "0101000111100";	-- STA @60
tmp(417)	:= "0001000110110";	-- LDA @54
tmp(418)	:= "0101000111101";	-- STA @61
tmp(419)	:= "0001000110111";	-- LDA @55
tmp(420)	:= "0101000111110";	-- STA @62
tmp(421)	:= "0001000111000";	-- LDA @56
tmp(422)	:= "0101000111111";	-- STA @63
tmp(423)	:= "1010000000000";	-- RET
