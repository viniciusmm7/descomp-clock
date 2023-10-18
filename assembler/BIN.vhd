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
tmp(19)	:= "0101000111010";	-- STA @58     	; armazena na casa das unidades do limite
tmp(20)	:= "0101000111011";	-- STA @59     	; armazena na casa das dezenas do limite
tmp(21)	:= "0101000111100";	-- STA @60     	; armazena na casa das centenas do limite
tmp(22)	:= "0101000111101";	-- STA @61     	; armazena na casa dos milhares do limite
tmp(23)	:= "0101000111110";	-- STA @62     	; armazena na casa das dezenas de milhar do limite
tmp(24)	:= "0101000111111";	-- STA @63     	; armazena na casa das centenas de milhar do limite
tmp(25)	:= "0100000000010";	-- LDI $2			; carrega 2 para inicializar próximo endereço de referência do intervalo numérico de configuração
tmp(26)	:= "0101000001010";	-- STA @10			; armazena a referência de estado 2 no endereço 10
tmp(27)	:= "0100000000011";	-- LDI $3			; carrega 3 para inicializar próximo endereço de referência do intervalo numérico de configuração
tmp(28)	:= "0101000001011";	-- STA @11			; armazena a referência de estado 3 no endereço 11
tmp(29)	:= "0100000000100";	-- LDI $4			; carrega 4 para inicializar próximo endereço de referência do intervalo numérico de configuração
tmp(30)	:= "0101000001100";	-- STA @12			; armazena a referência de estado 4 no endereço 12
tmp(31)	:= "0001101100100";	-- LDA @356    	; carrega o valor do botão reset
tmp(32)	:= "1011000000110";	-- AND @6      	; aplica a mask
tmp(33)	:= "1000000001000";	-- CEQ @8      	; verifica se é 0
tmp(34)	:= "0111000100101";	-- JEQ .PULA_RESET
tmp(35)	:= "0101111111101";	-- STA @509
tmp(36)	:= "1001001010011";	-- JSR .RESET
tmp(37)	:= "0001101100001";	-- LDA @353    	; carrega o valor do botão 1
tmp(38)	:= "1011000000110";	-- AND @6      	; aplica a mask
tmp(39)	:= "1000000001000";	-- CEQ @8      	; verifica se é 0
tmp(40)	:= "0111000101011";	-- JEQ .PULA_CONFIG
tmp(41)	:= "0101111111110";	-- STA @510
tmp(42)	:= "0110000110110";	-- JMP .INICIO_LOOP_CONFIGURACAO_LIMITE
tmp(43)	:= "1001101001000";	-- JSR .ATINGIU_LIMITE			; verifica se a contagem atingiu o limite
tmp(44)	:= "1000000000110";	-- CEQ @6						; se atingiu o limite, pula o incrementa contagem
tmp(45)	:= "0111000110100";	-- JEQ .PULA_INCREMENTA_CONTAGEM
tmp(46)	:= "0001101100000";	-- LDA @352    	; carrega o valor do botão 0
tmp(47)	:= "1011000000110";	-- AND @6      	; aplica a mask
tmp(48)	:= "1000000001000";	-- CEQ @8      	; verifica se é 0
tmp(49)	:= "0111000110100";	-- JEQ .PULA_INCREMENTA_CONTAGEM
tmp(50)	:= "0101111111111";	-- STA @511
tmp(51)	:= "1001001100010";	-- JSR .INCREMENTA_CONTAGEM
tmp(52)	:= "1001010010011";	-- JSR .MOSTRA_CONTAGEM    	; escreve os números da contagem nos displays
tmp(53)	:= "0110000011111";	-- JMP .LOOP_PRINCIPAL
tmp(54)	:= "1001001010011";	-- JSR .RESET		; reseta a contagem
tmp(55)	:= "0100000000011";	-- LDI $3			; acende os leds da primeira posição
tmp(56)	:= "0101100000000";	-- STA @256
tmp(57)	:= "0100000000000";	-- LDI $0
tmp(58)	:= "0101100000001";	-- STA @257
tmp(59)	:= "0101100000010";	-- STA @258
tmp(60)	:= "0001101100100";	-- LDA @356    	; carrega o valor do botão reset
tmp(61)	:= "1011000000110";	-- AND @6      	; aplica a mask
tmp(62)	:= "1000000000110";	-- CEQ @6      	; verifica se é 1
tmp(63)	:= "0111001001110";	-- JEQ .SAIR_LOOP_CONFIGURACAO_LIMITE
tmp(64)	:= "0001101100001";	-- LDA @353    	; carrega o valor do botão 1
tmp(65)	:= "1011000000110";	-- AND @6      	; aplica a mask
tmp(66)	:= "1000000001000";	-- CEQ @8      	; verifica se é 0
tmp(67)	:= "0111001000110";	-- JEQ .PULA_MUDANCA_ESTADO
tmp(68)	:= "0101111111110";	-- STA @510
tmp(69)	:= "0110001001110";	-- JMP .SAIR_LOOP_CONFIGURACAO_LIMITE
tmp(70)	:= "0001101100000";	-- LDA @352    	; carrega o valor do botão 0
tmp(71)	:= "1011000000110";	-- AND @6      	; aplica a mask
tmp(72)	:= "1000000001000";	-- CEQ @8      	; verifica se é 0
tmp(73)	:= "0111001001100";	-- JEQ .PULA_MUDANCA_INTERVALO
tmp(74)	:= "0101111111111";	-- STA @511
tmp(75)	:= "1001011111111";	-- JSR .MUDA_INTERVALO
tmp(76)	:= "1001010100000";	-- JSR .MOSTRA_LIMITE
tmp(77)	:= "0110000111100";	-- JMP .LOOP_CONFIGURACAO_LIMITE
tmp(78)	:= "1001011111010";	-- JSR .APAGA_LEDS         	; apaga os LEDs
tmp(79)	:= "1001101101100";	-- JSR .ARMAZENA_LIMITE		; armazena o limite do jeito que mostra nos displays
tmp(80)	:= "0100000000000";	-- LDI $0    		; carrega 0
tmp(81)	:= "0101000111001";	-- STA @57     	; armazena 0 no intervalo de mudança atual
tmp(82)	:= "0110000011111";	-- JMP .LOOP_PRINCIPAL
tmp(83)	:= "0100000000000";	-- LDI $0
tmp(84)	:= "0101000000000";	-- STA @0
tmp(85)	:= "0101000000001";	-- STA @1
tmp(86)	:= "0101000000010";	-- STA @2
tmp(87)	:= "0101000000011";	-- STA @3
tmp(88)	:= "0101000000100";	-- STA @4
tmp(89)	:= "0101000000101";	-- STA @5
tmp(90)	:= "0100000000000";	-- LDI $0
tmp(91)	:= "0101100000000";	-- STA @256
tmp(92)	:= "0101100000001";	-- STA @257
tmp(93)	:= "0101100000010";	-- STA @258
tmp(94)	:= "0101111111111";	-- STA @511
tmp(95)	:= "0101111111110";	-- STA @510
tmp(96)	:= "0101111111101";	-- STA @509
tmp(97)	:= "1010000000000";	-- RET
tmp(98)	:= "0001000000000";	-- LDA @0                  	; carrega o valor da unidade
tmp(99)	:= "0010000000110";	-- ADD @6                  	; incrementa o valor da unidade
tmp(100)	:= "1000000000111";	-- CEQ @7                  	; compara o valor da casa com 10
tmp(101)	:= "0111001101000";	-- JEQ .INCREMENTA_DEZENA  	; incrementa a casa da dezena caso necessário
tmp(102)	:= "0101000000000";	-- STA @0                  	; armazena o valor da unidade
tmp(103)	:= "1010000000000";	-- RET
tmp(104)	:= "0100000000000";	-- LDI $0                  	; carrega 0
tmp(105)	:= "0101000000000";	-- STA @0                  	; armazena 0 na unidade
tmp(106)	:= "0001000000001";	-- LDA @1                  	; carrega o valor atual da dezena
tmp(107)	:= "0010000000110";	-- ADD @6                  	; incrementa o valor da dezena
tmp(108)	:= "1000000000111";	-- CEQ @7                  	; verifica se é igual a 10
tmp(109)	:= "0111001110000";	-- JEQ .INCREMENTA_CENTENA 	; se for, incrementa a centena
tmp(110)	:= "0101000000001";	-- STA @1                  	; armazena o novo valor da dezena
tmp(111)	:= "0110001100111";	-- JMP .FIM_INCREMENTA     	; sai da função
tmp(112)	:= "0100000000000";	-- LDI $0                  	; carrega 0
tmp(113)	:= "0101000000001";	-- STA @1                  	; armazena 0 na dezena
tmp(114)	:= "0001000000010";	-- LDA @2                  	; carrega o valor atual da centena
tmp(115)	:= "0010000000110";	-- ADD @6                  	; incrementa o valor da centena
tmp(116)	:= "1000000000111";	-- CEQ @7                  	; verifica se é igual a 10
tmp(117)	:= "0111001111000";	-- JEQ .INCREMENTA_MILHAR  	; se for, incrementa o milhar
tmp(118)	:= "0101000000010";	-- STA @2                  	; armazena o novo valor da centena
tmp(119)	:= "0110001100111";	-- JMP .FIM_INCREMENTA     	; sai da função
tmp(120)	:= "0100000000000";	-- LDI $0                  	; carrega 0
tmp(121)	:= "0101000000010";	-- STA @2                  	; armazena 0 na centena
tmp(122)	:= "0001000000011";	-- LDA @3                  	; carrega o valor atual do milhar
tmp(123)	:= "0010000000110";	-- ADD @6                  	; incrementa o valor do milhar
tmp(124)	:= "1000000000111";	-- CEQ @7                  	; verifica se é igual a 10
tmp(125)	:= "0111010000000";	-- JEQ .INCREMENTA_DMILHAR 	; se for, incrementa a dezena de milhar
tmp(126)	:= "0101000000011";	-- STA @3                  	; armazena o novo valor do milhar
tmp(127)	:= "0110001100111";	-- JMP .FIM_INCREMENTA     	; sai da função
tmp(128)	:= "0100000000000";	-- LDI $0                  	; carrega 0
tmp(129)	:= "0101000000011";	-- STA @3                  	; armazena 0 no milhar
tmp(130)	:= "0001000000100";	-- LDA @4                  	; carrega o valor atual da dezena de milhar
tmp(131)	:= "0010000000110";	-- ADD @6                  	; incrementa o valor da dezena de milhar
tmp(132)	:= "1000000000111";	-- CEQ @7                  	; verifica se é igual a 10
tmp(133)	:= "0111010001000";	-- JEQ .INCREMENTA_CMILHAR 	; se for, incrementa a centena de milhar
tmp(134)	:= "0101000000100";	-- STA @4                  	; armazena o novo valor da dezena de milhar
tmp(135)	:= "0110001100111";	-- JMP .FIM_INCREMENTA     	; sai da função
tmp(136)	:= "0100000000000";	-- LDI $0                  	; carrega 0
tmp(137)	:= "0101000000100";	-- STA @4                  	; armazena 0 na dezena de milhar
tmp(138)	:= "0001000000101";	-- LDA @5                  	; carrega o valor atual da centena de milhar
tmp(139)	:= "0010000000110";	-- ADD @6                  	; incrementa o valor da centena de milhar
tmp(140)	:= "1000000000111";	-- CEQ @7                  	; verifica se é igual a 10
tmp(141)	:= "0111010010000";	-- JEQ .INCREMENTA_MILHAO  	; se for, zera tudo
tmp(142)	:= "0101000000101";	-- STA @5                  	; armazena o novo valor da centena de milhar
tmp(143)	:= "0110001100111";	-- JMP .FIM_INCREMENTA     	; sai da função
tmp(144)	:= "0100000000000";	-- LDI $0  	; carrega 0
tmp(145)	:= "0101000000101";	-- STA $5  	; armazena 0 na centena de milhar
tmp(146)	:= "0110001100111";	-- JMP .FIM_INCREMENTA
tmp(147)	:= "0001000000000";	-- LDA @0      	; carrega o valor da unidade
tmp(148)	:= "0101100100000";	-- STA @288    	; armazena no HEX 0
tmp(149)	:= "0001000000001";	-- LDA @1      	; carrega o valor da dezena
tmp(150)	:= "0101100100001";	-- STA @289    	; armazena no HEX 1
tmp(151)	:= "0001000000010";	-- LDA @2      	; carrega o valor da centena
tmp(152)	:= "0101100100010";	-- STA @290    	; armazena no HEX 2
tmp(153)	:= "0001000000011";	-- LDA @3      	; carrega o valor do milhar
tmp(154)	:= "0101100100011";	-- STA @291    	; armazena no HEX 3
tmp(155)	:= "0001000000100";	-- LDA @4      	; carrega o valor da dezena de milhar
tmp(156)	:= "0101100100100";	-- STA @292    	; armazena no HEX 4
tmp(157)	:= "0001000000101";	-- LDA @5      	; carrega o valor da centena de milhar
tmp(158)	:= "0101100100101";	-- STA @293    	; armazena no HEX 5
tmp(159)	:= "1010000000000";	-- RET
tmp(160)	:= "0001000111001";	-- LDA @57                 	; carrega o intervalo atual
tmp(161)	:= "1000000001000";	-- CEQ @8                  	; verifica se é igual a 0
tmp(162)	:= "0111010101100";	-- JEQ .DIGITO_0_ML     	; se for
tmp(163)	:= "1000000001001";	-- CEQ @9                  	; verifica se é igual a 1
tmp(164)	:= "0111010111001";	-- JEQ .DIGITO_1_ML     	; se for
tmp(165)	:= "1000000001010";	-- CEQ @10                 	; verifica se é igual a 2
tmp(166)	:= "0111011000110";	-- JEQ .DIGITO_2_ML     	; se for
tmp(167)	:= "1000000001011";	-- CEQ @11                 	; verifica se é igual a 3
tmp(168)	:= "0111011010011";	-- JEQ .DIGITO_3_ML     	; se for
tmp(169)	:= "1000000001100";	-- CEQ @12                 	; verifica se é igual a 4
tmp(170)	:= "0111011100000";	-- JEQ .DIGITO_4_ML     	; se for
tmp(171)	:= "0110011101101";	-- JMP .DIGITO_5_ML 		; se não for nenhum dos acima
tmp(172)	:= "0001101000000";	-- LDA @320    	; carrega o valor das chaves
tmp(173)	:= "0101100100000";	-- STA @288    	; armazena no HEX 0
tmp(174)	:= "0001000111011";	-- LDA @59			; carrega o valor da dezena do limite
tmp(175)	:= "0101100100001";	-- STA @289    	; armazena no HEX 1
tmp(176)	:= "0001000111100";	-- LDA @60			; carrega o valor de centena do limite
tmp(177)	:= "0101100100010";	-- STA @290    	; armazena no HEX 2
tmp(178)	:= "0001000111101";	-- LDA @61     	; carrega o valor do milhar do limite
tmp(179)	:= "0101100100011";	-- STA @291    	; armazena no HEX 3
tmp(180)	:= "0001000111110";	-- LDA @62     	; carrega o valor da dezena de milhar do limite
tmp(181)	:= "0101100100100";	-- STA @292    	; armazena no HEX 4
tmp(182)	:= "0001000111111";	-- LDA @63     	; carrega o valor da centena de milhar do limite
tmp(183)	:= "0101100100101";	-- STA @293    	; armazena no HEX 5
tmp(184)	:= "1010000000000";	-- RET
tmp(185)	:= "0001000111010";	-- LDA @58     	; carrega o valor da unidade do limite
tmp(186)	:= "0101100100000";	-- STA @288    	; armazena no HEX 0
tmp(187)	:= "0001101000000";	-- LDA @320    	; carrega o valor das chaves
tmp(188)	:= "0101100100001";	-- STA @289    	; armazena no HEX 1
tmp(189)	:= "0001000111100";	-- LDA @60     	; carrega o valor da centena do limite
tmp(190)	:= "0101100100010";	-- STA @290    	; armazena no HEX 2
tmp(191)	:= "0001000111101";	-- LDA @61     	; carrega o valor do milhar do limite
tmp(192)	:= "0101100100011";	-- STA @291    	; armazena no HEX 3
tmp(193)	:= "0001000111110";	-- LDA @62     	; carrega o valor da dezena de milhar do limite
tmp(194)	:= "0101100100100";	-- STA @292    	; armazena no HEX 4
tmp(195)	:= "0001000111111";	-- LDA @63     	; carrega o valor da centena de milhar do limite
tmp(196)	:= "0101100100101";	-- STA @293    	; armazena no HEX 5
tmp(197)	:= "1010000000000";	-- RET
tmp(198)	:= "0001000111010";	-- LDA @58     	; carrega o valor da unidade do limite
tmp(199)	:= "0101100100000";	-- STA @288    	; armazena no HEX 0
tmp(200)	:= "0001000111011";	-- LDA @59			; carrega o valor da dezena do limite
tmp(201)	:= "0101100100001";	-- STA @289    	; armazena no HEX 1
tmp(202)	:= "0001101000000";	-- LDA @320    	; carrega o valor das chaves
tmp(203)	:= "0101100100010";	-- STA @290    	; armazena no HEX 2
tmp(204)	:= "0001000111101";	-- LDA @61     	; carrega o valor do milhar do limite
tmp(205)	:= "0101100100011";	-- STA @291    	; armazena no HEX 3
tmp(206)	:= "0001000111110";	-- LDA @62     	; carrega o valor da dezena de milhar do limite
tmp(207)	:= "0101100100100";	-- STA @292    	; armazena no HEX 4
tmp(208)	:= "0001000111111";	-- LDA @63     	; carrega o valor da centena de milhar do limite
tmp(209)	:= "0101100100101";	-- STA @293    	; armazena no HEX 5
tmp(210)	:= "1010000000000";	-- RET
tmp(211)	:= "0001000111010";	-- LDA @58     	; carrega o valor da unidade do limite
tmp(212)	:= "0101100100000";	-- STA @288    	; armazena no HEX 0
tmp(213)	:= "0001000111011";	-- LDA @59			; carrega o valor da dezena do limite
tmp(214)	:= "0101100100001";	-- STA @289    	; armazena no HEX 1
tmp(215)	:= "0001000111100";	-- LDA @60    		; carrega o valor da centena do limite
tmp(216)	:= "0101100100010";	-- STA @290    	; armazena no HEX 2
tmp(217)	:= "0001101000000";	-- LDA @320    	; carrega o valor das chaves
tmp(218)	:= "0101100100011";	-- STA @291    	; armazena no HEX 3
tmp(219)	:= "0001000111110";	-- LDA @62     	; carrega o valor da dezena de milhar do limite
tmp(220)	:= "0101100100100";	-- STA @292    	; armazena no HEX 4
tmp(221)	:= "0001000111111";	-- LDA @63     	; carrega o valor da centena de milhar do limite
tmp(222)	:= "0101100100101";	-- STA @293    	; armazena no HEX 5
tmp(223)	:= "1010000000000";	-- RET
tmp(224)	:= "0001000111010";	-- LDA @58     	; carrega o valor da unidade do limite
tmp(225)	:= "0101100100000";	-- STA @288    	; armazena no HEX 0
tmp(226)	:= "0001000111011";	-- LDA @59			; carrega o valor da dezena do limite
tmp(227)	:= "0101100100001";	-- STA @289    	; armazena no HEX 1
tmp(228)	:= "0001000111100";	-- LDA @60    		; carrega o valor da centena do limite
tmp(229)	:= "0101100100010";	-- STA @290    	; armazena no HEX 2
tmp(230)	:= "0001000111101";	-- LDA @61     	; carrega o valor do milhar do limite
tmp(231)	:= "0101100100011";	-- STA @291    	; armazena no HEX 3
tmp(232)	:= "0001101000000";	-- LDA @320    	; carrega o valor das chaves
tmp(233)	:= "0101100100100";	-- STA @292    	; armazena no HEX 4
tmp(234)	:= "0001000111111";	-- LDA @63     	; carrega o valor da centena de milhar do limite
tmp(235)	:= "0101100100101";	-- STA @293    	; armazena no HEX 5
tmp(236)	:= "1010000000000";	-- RET
tmp(237)	:= "0001000111010";	-- LDA @58     	; carrega o valor da unidade do limite
tmp(238)	:= "0101100100000";	-- STA @288    	; armazena no HEX 0
tmp(239)	:= "0001000111011";	-- LDA @59			; carrega o valor da dezena do limite
tmp(240)	:= "0101100100001";	-- STA @289    	; armazena no HEX 1
tmp(241)	:= "0001000111100";	-- LDA @60    		; carrega o valor da centena do limite
tmp(242)	:= "0101100100010";	-- STA @290    	; armazena no HEX 2
tmp(243)	:= "0001000111101";	-- LDA @61     	; carrega o valor do milhar do limite
tmp(244)	:= "0101100100011";	-- STA @291    	; armazena no HEX 3
tmp(245)	:= "0001000111110";	-- LDA @62     	; carrega o valor da dezena de milhar do limite
tmp(246)	:= "0101100100100";	-- STA @292    	; armazena no HEX 4
tmp(247)	:= "0001101000000";	-- LDA @320     	; carrega o valor das chaves
tmp(248)	:= "0101100100101";	-- STA @293    	; armazena no HEX 5
tmp(249)	:= "1010000000000";	-- RET
tmp(250)	:= "0100000000000";	-- LDI $0
tmp(251)	:= "0101100000000";	-- STA @256
tmp(252)	:= "0101100000001";	-- STA @257
tmp(253)	:= "0101100000010";	-- STA @258
tmp(254)	:= "1010000000000";	-- RET
tmp(255)	:= "0001000111001";	-- LDA @57                 	; carrega o intervalo atual
tmp(256)	:= "1000000001000";	-- CEQ @8                  	; verifica se é igual a 0
tmp(257)	:= "0111100001011";	-- JEQ .DIGITO_0_MI     		; se for
tmp(258)	:= "1000000001001";	-- CEQ @9                  	; verifica se é igual a 1
tmp(259)	:= "0111100010101";	-- JEQ .DIGITO_1_MI     		; se for
tmp(260)	:= "1000000001010";	-- CEQ @10                 	; verifica se é igual a 2
tmp(261)	:= "0111100011111";	-- JEQ .DIGITO_2_MI     		; se for
tmp(262)	:= "1000000001011";	-- CEQ @11                 	; verifica se é igual a 3
tmp(263)	:= "0111100101001";	-- JEQ .DIGITO_3_MI     		; se for
tmp(264)	:= "1000000001100";	-- CEQ @12                 	; verifica se é igual a 4
tmp(265)	:= "0111100110100";	-- JEQ .DIGITO_4_MI     		; se for
tmp(266)	:= "0110100111110";	-- JMP .DIGITO_5_MI 			; se não for nenhum dos acima
tmp(267)	:= "0100000000001";	-- LDI $1			; atualiza o intervalo
tmp(268)	:= "0101000111001";	-- STA @57
tmp(269)	:= "0100000000110";	-- LDI $6			; acende os LEDs da segunda posição e apaga o resto
tmp(270)	:= "0101100000000";	-- STA @256
tmp(271)	:= "0100000000000";	-- LDI $0
tmp(272)	:= "0101100000001";	-- STA @257
tmp(273)	:= "0101100000010";	-- STA @258
tmp(274)	:= "0001101000000";	-- LDA @320		; salva o novo valor do dígito
tmp(275)	:= "0101000111010";	-- STA @58
tmp(276)	:= "1010000000000";	-- RET
tmp(277)	:= "0100000000010";	-- LDI $2			; atualiza o intervalo
tmp(278)	:= "0101000111001";	-- STA @57
tmp(279)	:= "0100000011000";	-- LDI $24			; acende os LEDs da terceira posição e apaga o resto
tmp(280)	:= "0101100000000";	-- STA @256
tmp(281)	:= "0100000000000";	-- LDI $0
tmp(282)	:= "0101100000001";	-- STA @257
tmp(283)	:= "0101100000010";	-- STA @258
tmp(284)	:= "0001101000000";	-- LDA @320		; salva o novo valor do dígito
tmp(285)	:= "0101000111011";	-- STA @59
tmp(286)	:= "1010000000000";	-- RET
tmp(287)	:= "0100000000011";	-- LDI $3			; atualiza o intervalo
tmp(288)	:= "0101000111001";	-- STA @57
tmp(289)	:= "0100001100000";	-- LDI $96			; acende os LEDs da quarta posição e apaga o resto
tmp(290)	:= "0101100000000";	-- STA @256
tmp(291)	:= "0100000000000";	-- LDI $0
tmp(292)	:= "0101100000001";	-- STA @257
tmp(293)	:= "0101100000010";	-- STA @258
tmp(294)	:= "0001101000000";	-- LDA @320		; salva o novo valor do dígito
tmp(295)	:= "0101000111100";	-- STA @60
tmp(296)	:= "1010000000000";	-- RET
tmp(297)	:= "0100000000100";	-- LDI $4			; atualiza o intervalo
tmp(298)	:= "0101000111001";	-- STA @57
tmp(299)	:= "0100010000000";	-- LDI $128		; acende os LEDs da quinta posição e apaga o resto
tmp(300)	:= "0101100000000";	-- STA @256
tmp(301)	:= "0100000000001";	-- LDI $1
tmp(302)	:= "0101100000001";	-- STA @257
tmp(303)	:= "0100000000000";	-- LDI $0
tmp(304)	:= "0101100000010";	-- STA @258
tmp(305)	:= "0001101000000";	-- LDA @320		; salva o novo valor do dígito
tmp(306)	:= "0101000111101";	-- STA @61
tmp(307)	:= "1010000000000";	-- RET
tmp(308)	:= "0100000000101";	-- LDI $5			; atualiza o intervalo
tmp(309)	:= "0101000111001";	-- STA @57
tmp(310)	:= "0100000000000";	-- LDI $0			; acende os LEDs da sexta posição e apaga o resto
tmp(311)	:= "0101100000000";	-- STA @256
tmp(312)	:= "0100000000001";	-- LDI $1
tmp(313)	:= "0101100000001";	-- STA @257
tmp(314)	:= "0101100000010";	-- STA @258
tmp(315)	:= "0001101000000";	-- LDA @320		; salva o novo valor do dígito
tmp(316)	:= "0101000111110";	-- STA @62
tmp(317)	:= "1010000000000";	-- RET
tmp(318)	:= "0100000000000";	-- LDI $0			; atualiza o intervalo
tmp(319)	:= "0101000111001";	-- STA @57
tmp(320)	:= "0100000000011";	-- LDI $3			; acende os LEDs da primeira posição e apaga o resto
tmp(321)	:= "0101100000000";	-- STA @256
tmp(322)	:= "0100000000000";	-- LDI $0
tmp(323)	:= "0101100000001";	-- STA @257
tmp(324)	:= "0101100000010";	-- STA @258
tmp(325)	:= "0001101000000";	-- LDA @320		; salva o novo valor do dígito
tmp(326)	:= "0101000111111";	-- STA @63
tmp(327)	:= "1010000000000";	-- RET
tmp(328)	:= "0001000000101";	-- LDA @5			; carrega o valor da centena de milhar
tmp(329)	:= "1000000111111";	-- CEQ @63			; compara com o valor limite da centena de milhar
tmp(330)	:= "0111101001101";	-- JEQ .CMILHAR_ATINGIU
tmp(331)	:= "0100000000000";	-- LDI $0			; se não for igual, não atingiu
tmp(332)	:= "1010000000000";	-- RET
tmp(333)	:= "0001000000100";	-- LDA @4			; carrega o valor da dezena de milhar
tmp(334)	:= "1000000111110";	-- CEQ @62			; compara com o valor limite da dezena de milhar
tmp(335)	:= "0111101010010";	-- JEQ .DMILHAR_ATINGIU
tmp(336)	:= "0100000000000";	-- LDI $0			; se não for igual, não atingiu
tmp(337)	:= "1010000000000";	-- RET
tmp(338)	:= "0001000000011";	-- LDA @3			; carrega o valor do milhar
tmp(339)	:= "1000000111101";	-- CEQ @61			; compara com o valor limite do milhar
tmp(340)	:= "0111101010111";	-- JEQ .MILHAR_ATINGIU
tmp(341)	:= "0100000000000";	-- LDI $0			; se não for igual, não atingiu
tmp(342)	:= "1010000000000";	-- RET
tmp(343)	:= "0001000000010";	-- LDA @2			; carrega o valor da centena
tmp(344)	:= "1000000111100";	-- CEQ @60			; compara com o valor limite da centena
tmp(345)	:= "0111101011100";	-- JEQ .CENTENA_ATINGIU
tmp(346)	:= "0100000000000";	-- LDI $0			; se não for igual, não atingiu
tmp(347)	:= "1010000000000";	-- RET
tmp(348)	:= "0001000000001";	-- LDA @1			; carrega o valor da dezena
tmp(349)	:= "1000000111011";	-- CEQ @59			; compara com o valor limite da dezena
tmp(350)	:= "0111101100001";	-- JEQ .DEZENA_ATINGIU
tmp(351)	:= "0100000000000";	-- LDI $0			; se não for igual, não atingiu
tmp(352)	:= "1010000000000";	-- RET
tmp(353)	:= "0001000000000";	-- LDA @0			; carrega o valor da unidade
tmp(354)	:= "1000000111010";	-- CEQ @58			; compara com o valor limite da unidade
tmp(355)	:= "0111101100110";	-- JEQ .UNIDADE_ATINGIU
tmp(356)	:= "0100000000000";	-- LDI $0			; se não for igual, não atingiu
tmp(357)	:= "1010000000000";	-- RET
tmp(358)	:= "0100011111111";	-- LDI $255
tmp(359)	:= "0101100000000";	-- STA @256
tmp(360)	:= "0101100000001";	-- STA @257
tmp(361)	:= "0101100000010";	-- STA @258
tmp(362)	:= "0100000000001";	-- LDI $1
tmp(363)	:= "1010000000000";	-- RET
tmp(364)	:= "0001000111001";	-- LDA @57                 	; carrega o digito atual
tmp(365)	:= "1000000001000";	-- CEQ @8                  	; verifica se é igual a 0
tmp(366)	:= "0111101111000";	-- JEQ .DIGITO_0_AL     		; se for
tmp(367)	:= "1000000001001";	-- CEQ @9                  	; verifica se é igual a 1
tmp(368)	:= "0111101111011";	-- JEQ .DIGITO_1_AL     		; se for
tmp(369)	:= "1000000001010";	-- CEQ @10                 	; verifica se é igual a 2
tmp(370)	:= "0111101111110";	-- JEQ .DIGITO_2_AL     		; se for
tmp(371)	:= "1000000001011";	-- CEQ @11                 	; verifica se é igual a 3
tmp(372)	:= "0111110000001";	-- JEQ .DIGITO_3_AL     		; se for
tmp(373)	:= "1000000001100";	-- CEQ @12                 	; verifica se é igual a 4
tmp(374)	:= "0111110000100";	-- JEQ .DIGITO_4_AL     		; se for
tmp(375)	:= "0110110000111";	-- JMP .DIGITO_5_AL 			; se não for nenhum dos acima
tmp(376)	:= "0001101000000";	-- LDA @320		; carrega o valor dos switches
tmp(377)	:= "0101000111010";	-- STA @58			; armazena na unidade do limite
tmp(378)	:= "1010000000000";	-- RET
tmp(379)	:= "0001101000000";	-- LDA @320		; carrega o valor dos switches
tmp(380)	:= "0101000111011";	-- STA @59			; armazena na dezena do limite
tmp(381)	:= "1010000000000";	-- RET
tmp(382)	:= "0001101000000";	-- LDA @320		; carrega o valor dos switches
tmp(383)	:= "0101000111100";	-- STA @60			; armazena na centena do limite
tmp(384)	:= "1010000000000";	-- RET
tmp(385)	:= "0001101000000";	-- LDA @320		; carrega o valor dos switches
tmp(386)	:= "0101000111101";	-- STA @61			; armazena no milhar do limite
tmp(387)	:= "1010000000000";	-- RET
tmp(388)	:= "0001101000000";	-- LDA @320		; carrega o valor dos switches
tmp(389)	:= "0101000111110";	-- STA @62			; armazena na dezena de milhar do limite
tmp(390)	:= "1010000000000";	-- RET
tmp(391)	:= "0001101000000";	-- LDA @320		; carrega o valor dos switches
tmp(392)	:= "0101000111111";	-- STA @63			; armazena na centena de milhar do limite
tmp(393)	:= "1010000000000";	-- RET
