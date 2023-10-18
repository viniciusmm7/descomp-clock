tmp(0)	:= "0000000000000";	-- 	; SETUP
tmp(1)	:= "0000000000000";	-- NOP
tmp(2)	:= "0101111111111";	-- STA @511    	; reseta a leitura do key 0
tmp(3)	:= "0101111111110";	-- STA @510    	; reseta a leitura do key 1
tmp(4)	:= "0101111111101";	-- STA @509    	; reseta a leitura do key reset
tmp(5)	:= "0100000000000";	-- LDI $0      	; carrega o valor inicial das casas
tmp(6)	:= "0101000111001";	-- STA @57     	; intervalo numérico de configuração
tmp(7)	:= "0101000000000";	-- STA @0      	; armazena 0 na unidade
tmp(8)	:= "0101000000001";	-- STA @1      	; armazena 0 na dezena
tmp(9)	:= "0101000000010";	-- STA @2      	; armazena 0 na centena
tmp(10)	:= "0101000000011";	-- STA @3      	; armazena 0 no milhar
tmp(11)	:= "0101000000100";	-- STA @4      	; armazena 0 na dezena de milhar
tmp(12)	:= "0101000000101";	-- STA @5      	; armazena 0 na centena de milhar
tmp(13)	:= "0101000001000";	-- STA @8      	; armazena um 0 de referência
tmp(14)	:= "0100000000001";	-- LDI $1      	; carrega o valor de incremento
tmp(15)	:= "0101000000110";	-- STA @6      	; armazena o valor de incremento
tmp(16)	:= "0101000001001";	-- STA @9			; armazena 1 no 9 para referência do intervalo numérico de configuração
tmp(17)	:= "0100000001010";	-- LDI $10     	; carrega o valor máximo por casa possível
tmp(18)	:= "0101000000111";	-- STA @7      	; armazena o valor máximo por casa possível
tmp(19)	:= "0100000001001";	-- LDI $9      	; carrega o número 9 para definir o limite de contagem inicial
tmp(20)	:= "0101000111010";	-- STA @58     	; armazena na casa das unidades do limite
tmp(21)	:= "0101000111011";	-- STA @59     	; armazena na casa das dezenas do limite
tmp(22)	:= "0101000111100";	-- STA @60     	; armazena na casa das centenas do limite
tmp(23)	:= "0101000111101";	-- STA @61     	; armazena na casa dos milhares do limite
tmp(24)	:= "0101000111110";	-- STA @62     	; armazena na casa das dezenas de milhar do limite
tmp(25)	:= "0101000111111";	-- STA @63     	; armazena na casa das centenas de milhar do limite
tmp(26)	:= "0100000000010";	-- LDI $2			; carrega 2 para inicializar próximo endereço de referência do intervalo numérico de configuração
tmp(27)	:= "0101000001010";	-- STA @10			; armazena a referência de estado 2 no endereço 10
tmp(28)	:= "0100000000011";	-- LDI $3			; carrega 3 para inicializar próximo endereço de referência do intervalo numérico de configuração
tmp(29)	:= "0101000001011";	-- STA @11			; armazena a referência de estado 3 no endereço 11
tmp(30)	:= "0100000000100";	-- LDI $4			; carrega 4 para inicializar próximo endereço de referência do intervalo numérico de configuração
tmp(31)	:= "0101000001100";	-- STA @12			; armazena a referência de estado 4 no endereço 12
tmp(32)	:= "0001101100100";	-- LDA @356    	; carrega o valor do botão reset
tmp(33)	:= "1011000000110";	-- AND @6      	; aplica a mask
tmp(34)	:= "1000000001000";	-- CEQ @8      	; verifica se é 0
tmp(35)	:= "0111000100110";	-- JEQ .PULA_RESET
tmp(36)	:= "0101111111101";	-- STA @509
tmp(37)	:= "1001001001100";	-- JSR .RESET
tmp(38)	:= "0001101100001";	-- LDA @353    	; carrega o valor do botão 1
tmp(39)	:= "1011000000110";	-- AND @6      	; aplica a mask
tmp(40)	:= "1000000001000";	-- CEQ @8      	; verifica se é 0
tmp(41)	:= "0111000101100";	-- JEQ .PULA_CONFIG
tmp(42)	:= "0101111111110";	-- STA @510
tmp(43)	:= "0110000110101";	-- JMP .INICIO_LOOP_CONFIGURACAO_LIMITE
tmp(44)	:= "0001101100000";	-- LDA @352    	; carrega o valor do botão 0
tmp(45)	:= "1011000000110";	-- AND @6      	; aplica a mask
tmp(46)	:= "1000000001000";	-- CEQ @8      	; verifica se é 0
tmp(47)	:= "0111000110010";	-- JEQ .PULA_INCREMENTA_CONTAGEM
tmp(48)	:= "0101111111111";	-- STA @511
tmp(49)	:= "1001001010100";	-- JSR .INCREMENTA_CONTAGEM
tmp(50)	:= "1001011101100";	-- JSR .APAGA_LEDS         	; apaga os LEDs
tmp(51)	:= "1001010000101";	-- JSR .MOSTRA_CONTAGEM    	; escreve os números da contagem nos displays
tmp(52)	:= "0110000100000";	-- JMP .LOOP_PRINCIPAL
tmp(53)	:= "0100000000011";	-- LDI $3			; acende os leds da primeira posição
tmp(54)	:= "0101100000000";	-- STA @256
tmp(55)	:= "0001101100100";	-- LDA @356    	; carrega o valor do botão reset
tmp(56)	:= "1011000000110";	-- AND @6      	; aplica a mask
tmp(57)	:= "1000000000110";	-- CEQ @6      	; verifica se é 1
tmp(58)	:= "0111001001001";	-- JEQ .SAIR_LOOP_CONFIGURACAO_LIMITE
tmp(59)	:= "0001101100001";	-- LDA @353    	; carrega o valor do botão 1
tmp(60)	:= "1011000000110";	-- AND @6      	; aplica a mask
tmp(61)	:= "1000000001000";	-- CEQ @8      	; verifica se é 0
tmp(62)	:= "0111001000001";	-- JEQ .PULA_MUDANCA_ESTADO
tmp(63)	:= "0101111111110";	-- STA @510
tmp(64)	:= "0110001001001";	-- JMP .SAIR_LOOP_CONFIGURACAO_LIMITE
tmp(65)	:= "0001101100000";	-- LDA @352    	; carrega o valor do botão 0
tmp(66)	:= "1011000000110";	-- AND @6      	; aplica a mask
tmp(67)	:= "1000000001000";	-- CEQ @8      	; verifica se é 0
tmp(68)	:= "0111001000111";	-- JEQ .PULA_MUDANCA_INTERVALO
tmp(69)	:= "0101111111111";	-- STA @511
tmp(70)	:= "1001011110001";	-- JSR .MUDA_INTERVALO
tmp(71)	:= "1001010010010";	-- JSR .MOSTRA_LIMITE
tmp(72)	:= "0110000110111";	-- JMP .LOOP_CONFIGURACAO_LIMITE
tmp(73)	:= "0100000000000";	-- LDI $0    		; carrega 0
tmp(74)	:= "0101000111001";	-- STA @57     	; armazena 0 no intervalo de mudança atual
tmp(75)	:= "0110000100000";	-- JMP .LOOP_PRINCIPAL
tmp(76)	:= "0100000000000";	-- LDI $0
tmp(77)	:= "0101000000000";	-- STA @0
tmp(78)	:= "0101000000001";	-- STA @1
tmp(79)	:= "0101000000010";	-- STA @2
tmp(80)	:= "0101000000011";	-- STA @3
tmp(81)	:= "0101000000100";	-- STA @4
tmp(82)	:= "0101000000101";	-- STA @5
tmp(83)	:= "1010000000000";	-- RET
tmp(84)	:= "0001000000000";	-- LDA @0                  	; carrega o valor da unidade
tmp(85)	:= "0010000000110";	-- ADD @6                  	; incrementa o valor da unidade
tmp(86)	:= "1000000000111";	-- CEQ @7                  	; compara o valor da casa com 10
tmp(87)	:= "0111001011010";	-- JEQ .INCREMENTA_DEZENA  	; incrementa a casa da dezena caso necessário
tmp(88)	:= "0101000000000";	-- STA @0                  	; armazena o valor da unidade
tmp(89)	:= "1010000000000";	-- RET
tmp(90)	:= "0100000000000";	-- LDI $0                  	; carrega 0
tmp(91)	:= "0101000000000";	-- STA @0                  	; armazena 0 na unidade
tmp(92)	:= "0001000000001";	-- LDA @1                  	; carrega o valor atual da dezena
tmp(93)	:= "0010000000110";	-- ADD @6                  	; incrementa o valor da dezena
tmp(94)	:= "1000000000111";	-- CEQ @7                  	; verifica se é igual a 10
tmp(95)	:= "0111001100010";	-- JEQ .INCREMENTA_CENTENA 	; se for, incrementa a centena
tmp(96)	:= "0101000000001";	-- STA @1                  	; armazena o novo valor da dezena
tmp(97)	:= "0110001011001";	-- JMP .FIM_INCREMENTA     	; sai da função
tmp(98)	:= "0100000000000";	-- LDI $0                  	; carrega 0
tmp(99)	:= "0101000000001";	-- STA @1                  	; armazena 0 na dezena
tmp(100)	:= "0001000000010";	-- LDA @2                  	; carrega o valor atual da centena
tmp(101)	:= "0010000000110";	-- ADD @6                  	; incrementa o valor da centena
tmp(102)	:= "1000000000111";	-- CEQ @7                  	; verifica se é igual a 10
tmp(103)	:= "0111001101010";	-- JEQ .INCREMENTA_MILHAR  	; se for, incrementa o milhar
tmp(104)	:= "0101000000010";	-- STA @2                  	; armazena o novo valor da centena
tmp(105)	:= "0110001011001";	-- JMP .FIM_INCREMENTA     	; sai da função
tmp(106)	:= "0100000000000";	-- LDI $0                  	; carrega 0
tmp(107)	:= "0101000000010";	-- STA @2                  	; armazena 0 na centena
tmp(108)	:= "0001000000011";	-- LDA @3                  	; carrega o valor atual do milhar
tmp(109)	:= "0010000000110";	-- ADD @6                  	; incrementa o valor do milhar
tmp(110)	:= "1000000000111";	-- CEQ @7                  	; verifica se é igual a 10
tmp(111)	:= "0111001110010";	-- JEQ .INCREMENTA_DMILHAR 	; se for, incrementa a dezena de milhar
tmp(112)	:= "0101000000011";	-- STA @3                  	; armazena o novo valor do milhar
tmp(113)	:= "0110001011001";	-- JMP .FIM_INCREMENTA     	; sai da função
tmp(114)	:= "0100000000000";	-- LDI $0                  	; carrega 0
tmp(115)	:= "0101000000011";	-- STA @3                  	; armazena 0 no milhar
tmp(116)	:= "0001000000100";	-- LDA @4                  	; carrega o valor atual da dezena de milhar
tmp(117)	:= "0010000000110";	-- ADD @6                  	; incrementa o valor da dezena de milhar
tmp(118)	:= "1000000000111";	-- CEQ @7                  	; verifica se é igual a 10
tmp(119)	:= "0111001111010";	-- JEQ .INCREMENTA_CMILHAR 	; se for, incrementa a centena de milhar
tmp(120)	:= "0101000000100";	-- STA @4                  	; armazena o novo valor da dezena de milhar
tmp(121)	:= "0110001011001";	-- JMP .FIM_INCREMENTA     	; sai da função
tmp(122)	:= "0100000000000";	-- LDI $0                  	; carrega 0
tmp(123)	:= "0101000000100";	-- STA @4                  	; armazena 0 na dezena de milhar
tmp(124)	:= "0001000000101";	-- LDA @5                  	; carrega o valor atual da centena de milhar
tmp(125)	:= "0010000000110";	-- ADD @6                  	; incrementa o valor da centena de milhar
tmp(126)	:= "1000000000111";	-- CEQ @7                  	; verifica se é igual a 10
tmp(127)	:= "0111010000010";	-- JEQ .INCREMENTA_MILHAO  	; se for, zera tudo
tmp(128)	:= "0101000000101";	-- STA @5                  	; armazena o novo valor da centena de milhar
tmp(129)	:= "0110001011001";	-- JMP .FIM_INCREMENTA     	; sai da função
tmp(130)	:= "0100000000000";	-- LDI $0  	; carrega 0
tmp(131)	:= "0101000000101";	-- STA $5  	; armazena 0 na centena de milhar
tmp(132)	:= "0110001011001";	-- JMP .FIM_INCREMENTA
tmp(133)	:= "0001000000000";	-- LDA @0      	; carrega o valor da unidade
tmp(134)	:= "0101100100000";	-- STA @288    	; armazena no HEX 0
tmp(135)	:= "0001000000001";	-- LDA @1      	; carrega o valor da dezena
tmp(136)	:= "0101100100001";	-- STA @289    	; armazena no HEX 1
tmp(137)	:= "0001000000010";	-- LDA @2      	; carrega o valor da centena
tmp(138)	:= "0101100100010";	-- STA @290    	; armazena no HEX 2
tmp(139)	:= "0001000000011";	-- LDA @3      	; carrega o valor do milhar
tmp(140)	:= "0101100100011";	-- STA @291    	; armazena no HEX 3
tmp(141)	:= "0001000000100";	-- LDA @4      	; carrega o valor da dezena de milhar
tmp(142)	:= "0101100100100";	-- STA @292    	; armazena no HEX 4
tmp(143)	:= "0001000000101";	-- LDA @5      	; carrega o valor da centena de milhar
tmp(144)	:= "0101100100101";	-- STA @293    	; armazena no HEX 5
tmp(145)	:= "1010000000000";	-- RET
tmp(146)	:= "0001000111001";	-- LDA @57                 	; carrega o intervalo atual
tmp(147)	:= "1000000001000";	-- CEQ @8                  	; verifica se é igual a 0
tmp(148)	:= "0111010011110";	-- JEQ .DIGITO_0_ML     	; se for
tmp(149)	:= "1000000001001";	-- CEQ @9                  	; verifica se é igual a 1
tmp(150)	:= "0111010101011";	-- JEQ .DIGITO_1_ML     	; se for
tmp(151)	:= "1000000001010";	-- CEQ @10                 	; verifica se é igual a 2
tmp(152)	:= "0111010111000";	-- JEQ .DIGITO_2_ML     	; se for
tmp(153)	:= "1000000001011";	-- CEQ @11                 	; verifica se é igual a 3
tmp(154)	:= "0111011000101";	-- JEQ .DIGITO_3_ML     	; se for
tmp(155)	:= "1000000001100";	-- CEQ @12                 	; verifica se é igual a 4
tmp(156)	:= "0111011010010";	-- JEQ .DIGITO_4_ML     	; se for
tmp(157)	:= "0110011011111";	-- JMP .DIGITO_5_ML 		; se não for nenhum dos acima
tmp(158)	:= "0001101000000";	-- LDA @320    	; carrega o valor das chaves
tmp(159)	:= "0101100100000";	-- STA @288    	; armazena no HEX 0
tmp(160)	:= "0001000111011";	-- LDA @59			; carrega o valor da dezena do limite
tmp(161)	:= "0101100100001";	-- STA @289    	; armazena no HEX 1
tmp(162)	:= "0001000111100";	-- LDA @60			; carrega o valor de centena do limite
tmp(163)	:= "0101100100010";	-- STA @290    	; armazena no HEX 2
tmp(164)	:= "0001000111101";	-- LDA @61     	; carrega o valor do milhar do limite
tmp(165)	:= "0101100100011";	-- STA @291    	; armazena no HEX 3
tmp(166)	:= "0001000111110";	-- LDA @62     	; carrega o valor da dezena de milhar do limite
tmp(167)	:= "0101100100100";	-- STA @292    	; armazena no HEX 4
tmp(168)	:= "0001000111111";	-- LDA @63     	; carrega o valor da centena de milhar do limite
tmp(169)	:= "0101100100101";	-- STA @293    	; armazena no HEX 5
tmp(170)	:= "1010000000000";	-- RET
tmp(171)	:= "0001000111010";	-- LDA @58     	; carrega o valor da unidade do limite
tmp(172)	:= "0101100100000";	-- STA @288    	; armazena no HEX 0
tmp(173)	:= "0001101000000";	-- LDA @320    	; carrega o valor das chaves
tmp(174)	:= "0101100100001";	-- STA @289    	; armazena no HEX 1
tmp(175)	:= "0001000111100";	-- LDA @60     	; carrega o valor da centena do limite
tmp(176)	:= "0101100100010";	-- STA @290    	; armazena no HEX 2
tmp(177)	:= "0001000111101";	-- LDA @61     	; carrega o valor do milhar do limite
tmp(178)	:= "0101100100011";	-- STA @291    	; armazena no HEX 3
tmp(179)	:= "0001000111110";	-- LDA @62     	; carrega o valor da dezena de milhar do limite
tmp(180)	:= "0101100100100";	-- STA @292    	; armazena no HEX 4
tmp(181)	:= "0001000111111";	-- LDA @63     	; carrega o valor da centena de milhar do limite
tmp(182)	:= "0101100100101";	-- STA @293    	; armazena no HEX 5
tmp(183)	:= "1010000000000";	-- RET
tmp(184)	:= "0001000111010";	-- LDA @58     	; carrega o valor da unidade do limite
tmp(185)	:= "0101100100000";	-- STA @288    	; armazena no HEX 0
tmp(186)	:= "0001000111011";	-- LDA @59			; carrega o valor da dezena do limite
tmp(187)	:= "0101100100001";	-- STA @289    	; armazena no HEX 1
tmp(188)	:= "0001101000000";	-- LDA @320    	; carrega o valor das chaves
tmp(189)	:= "0101100100010";	-- STA @290    	; armazena no HEX 2
tmp(190)	:= "0001000111101";	-- LDA @61     	; carrega o valor do milhar do limite
tmp(191)	:= "0101100100011";	-- STA @291    	; armazena no HEX 3
tmp(192)	:= "0001000111110";	-- LDA @62     	; carrega o valor da dezena de milhar do limite
tmp(193)	:= "0101100100100";	-- STA @292    	; armazena no HEX 4
tmp(194)	:= "0001000111111";	-- LDA @63     	; carrega o valor da centena de milhar do limite
tmp(195)	:= "0101100100101";	-- STA @293    	; armazena no HEX 5
tmp(196)	:= "1010000000000";	-- RET
tmp(197)	:= "0001000111010";	-- LDA @58     	; carrega o valor da unidade do limite
tmp(198)	:= "0101100100000";	-- STA @288    	; armazena no HEX 0
tmp(199)	:= "0001000111011";	-- LDA @59			; carrega o valor da dezena do limite
tmp(200)	:= "0101100100001";	-- STA @289    	; armazena no HEX 1
tmp(201)	:= "0001000111100";	-- LDA @60    		; carrega o valor da centena do limite
tmp(202)	:= "0101100100010";	-- STA @290    	; armazena no HEX 2
tmp(203)	:= "0001101000000";	-- LDA @320    	; carrega o valor das chaves
tmp(204)	:= "0101100100011";	-- STA @291    	; armazena no HEX 3
tmp(205)	:= "0001000111110";	-- LDA @62     	; carrega o valor da dezena de milhar do limite
tmp(206)	:= "0101100100100";	-- STA @292    	; armazena no HEX 4
tmp(207)	:= "0001000111111";	-- LDA @63     	; carrega o valor da centena de milhar do limite
tmp(208)	:= "0101100100101";	-- STA @293    	; armazena no HEX 5
tmp(209)	:= "1010000000000";	-- RET
tmp(210)	:= "0001000111010";	-- LDA @58     	; carrega o valor da unidade do limite
tmp(211)	:= "0101100100000";	-- STA @288    	; armazena no HEX 0
tmp(212)	:= "0001000111011";	-- LDA @59			; carrega o valor da dezena do limite
tmp(213)	:= "0101100100001";	-- STA @289    	; armazena no HEX 1
tmp(214)	:= "0001000111100";	-- LDA @60    		; carrega o valor da centena do limite
tmp(215)	:= "0101100100010";	-- STA @290    	; armazena no HEX 2
tmp(216)	:= "0001000111101";	-- LDA @61     	; carrega o valor do milhar do limite
tmp(217)	:= "0101100100011";	-- STA @291    	; armazena no HEX 3
tmp(218)	:= "0001101000000";	-- LDA @320    	; carrega o valor das chaves
tmp(219)	:= "0101100100100";	-- STA @292    	; armazena no HEX 4
tmp(220)	:= "0001000111111";	-- LDA @63     	; carrega o valor da centena de milhar do limite
tmp(221)	:= "0101100100101";	-- STA @293    	; armazena no HEX 5
tmp(222)	:= "1010000000000";	-- RET
tmp(223)	:= "0001000111010";	-- LDA @58     	; carrega o valor da unidade do limite
tmp(224)	:= "0101100100000";	-- STA @288    	; armazena no HEX 0
tmp(225)	:= "0001000111011";	-- LDA @59			; carrega o valor da dezena do limite
tmp(226)	:= "0101100100001";	-- STA @289    	; armazena no HEX 1
tmp(227)	:= "0001000111100";	-- LDA @60    		; carrega o valor da centena do limite
tmp(228)	:= "0101100100010";	-- STA @290    	; armazena no HEX 2
tmp(229)	:= "0001000111101";	-- LDA @61     	; carrega o valor do milhar do limite
tmp(230)	:= "0101100100011";	-- STA @291    	; armazena no HEX 3
tmp(231)	:= "0001000111110";	-- LDA @62     	; carrega o valor da dezena de milhar do limite
tmp(232)	:= "0101100100100";	-- STA @292    	; armazena no HEX 4
tmp(233)	:= "0001101000000";	-- LDA @320     	; carrega o valor das chaves
tmp(234)	:= "0101100100101";	-- STA @293    	; armazena no HEX 5
tmp(235)	:= "1010000000000";	-- RET
tmp(236)	:= "0100000000000";	-- LDI $0
tmp(237)	:= "0101100000000";	-- STA @256
tmp(238)	:= "0101100000001";	-- STA @257
tmp(239)	:= "0101100000010";	-- STA @258
tmp(240)	:= "1010000000000";	-- RET
tmp(241)	:= "0001000111001";	-- LDA @57                 	; carrega o intervalo atual
tmp(242)	:= "1000000001000";	-- CEQ @8                  	; verifica se é igual a 0
tmp(243)	:= "0111011111101";	-- JEQ .DIGITO_0_MI     		; se for
tmp(244)	:= "1000000001001";	-- CEQ @9                  	; verifica se é igual a 1
tmp(245)	:= "0111100000111";	-- JEQ .DIGITO_1_MI     		; se for
tmp(246)	:= "1000000001010";	-- CEQ @10                 	; verifica se é igual a 2
tmp(247)	:= "0111100010001";	-- JEQ .DIGITO_2_MI     		; se for
tmp(248)	:= "1000000001011";	-- CEQ @11                 	; verifica se é igual a 3
tmp(249)	:= "0111100011011";	-- JEQ .DIGITO_3_MI     		; se for
tmp(250)	:= "1000000001100";	-- CEQ @12                 	; verifica se é igual a 4
tmp(251)	:= "0111100100110";	-- JEQ .DIGITO_4_MI     		; se for
tmp(252)	:= "0110100110000";	-- JMP .DIGITO_5_MI 			; se não for nenhum dos acima
tmp(253)	:= "0100000000001";	-- LDI $1			; atualiza o intervalo
tmp(254)	:= "0101000111001";	-- STA @57
tmp(255)	:= "0100000000110";	-- LDI $6			; acende os LEDs da segunda posição e apaga o resto
tmp(256)	:= "0101100000000";	-- STA @256
tmp(257)	:= "0100000000000";	-- LDI $0
tmp(258)	:= "0101100000001";	-- STA @257
tmp(259)	:= "0101100000010";	-- STA @258
tmp(260)	:= "0001101000000";	-- LDA @320		; salva o novo valor do dígito
tmp(261)	:= "0101000111010";	-- STA @58
tmp(262)	:= "1010000000000";	-- RET
tmp(263)	:= "0100000000010";	-- LDI $2			; atualiza o intervalo
tmp(264)	:= "0101000111001";	-- STA @57
tmp(265)	:= "0100000011000";	-- LDI $24			; acende os LEDs da terceira posição e apaga o resto
tmp(266)	:= "0101100000000";	-- STA @256
tmp(267)	:= "0100000000000";	-- LDI $0
tmp(268)	:= "0101100000001";	-- STA @257
tmp(269)	:= "0101100000010";	-- STA @258
tmp(270)	:= "0001101000000";	-- LDA @320		; salva o novo valor do dígito
tmp(271)	:= "0101000111011";	-- STA @59
tmp(272)	:= "1010000000000";	-- RET
tmp(273)	:= "0100000000011";	-- LDI $3			; atualiza o intervalo
tmp(274)	:= "0101000111001";	-- STA @57
tmp(275)	:= "0100001100000";	-- LDI $96			; acende os LEDs da quarta posição e apaga o resto
tmp(276)	:= "0101100000000";	-- STA @256
tmp(277)	:= "0100000000000";	-- LDI $0
tmp(278)	:= "0101100000001";	-- STA @257
tmp(279)	:= "0101100000010";	-- STA @258
tmp(280)	:= "0001101000000";	-- LDA @320		; salva o novo valor do dígito
tmp(281)	:= "0101000111100";	-- STA @60
tmp(282)	:= "1010000000000";	-- RET
tmp(283)	:= "0100000000100";	-- LDI $4			; atualiza o intervalo
tmp(284)	:= "0101000111001";	-- STA @57
tmp(285)	:= "0100010000000";	-- LDI $128		; acende os LEDs da quinta posição e apaga o resto
tmp(286)	:= "0101100000000";	-- STA @256
tmp(287)	:= "0100000000001";	-- LDI $1
tmp(288)	:= "0101100000001";	-- STA @257
tmp(289)	:= "0100000000000";	-- LDI $0
tmp(290)	:= "0101100000010";	-- STA @258
tmp(291)	:= "0001101000000";	-- LDA @320		; salva o novo valor do dígito
tmp(292)	:= "0101000111101";	-- STA @61
tmp(293)	:= "1010000000000";	-- RET
tmp(294)	:= "0100000000101";	-- LDI $5			; atualiza o intervalo
tmp(295)	:= "0101000111001";	-- STA @57
tmp(296)	:= "0100000000000";	-- LDI $0			; acende os LEDs da sexta posição e apaga o resto
tmp(297)	:= "0101100000000";	-- STA @256
tmp(298)	:= "0100000000001";	-- LDI $1
tmp(299)	:= "0101100000001";	-- STA @257
tmp(300)	:= "0101100000010";	-- STA @258
tmp(301)	:= "0001101000000";	-- LDA @320		; salva o novo valor do dígito
tmp(302)	:= "0101000111110";	-- STA @62
tmp(303)	:= "1010000000000";	-- RET
tmp(304)	:= "0100000000000";	-- LDI $0			; atualiza o intervalo
tmp(305)	:= "0101000111001";	-- STA @57
tmp(306)	:= "0100000000011";	-- LDI $3			; acende os LEDs da primeira posição e apaga o resto
tmp(307)	:= "0101100000000";	-- STA @256
tmp(308)	:= "0100000000000";	-- LDI $0
tmp(309)	:= "0101100000001";	-- STA @257
tmp(310)	:= "0101100000010";	-- STA @258
tmp(311)	:= "0001101000000";	-- LDA @320		; salva o novo valor do dígito
tmp(312)	:= "0101000111111";	-- STA @63
tmp(313)	:= "1010000000000";	-- RET
