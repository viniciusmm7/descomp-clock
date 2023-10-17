tmp(0)	:= "0101111111111";	-- STA @511 		;Limpa a leitura do botão
tmp(1)	:= "0100000000001";	-- LDI $1 	    	;Carrega o acumulador com o valor 1
tmp(2)	:= "0101000000001";	-- STA @1 	    	;Armazena o valor do acumulador em MEM[1] (constante 1)
tmp(3)	:= "0101100100000";	-- STA @288
tmp(4)	:= "0101100100001";	-- STA @289
tmp(5)	:= "0101100100010";	-- STA @290
tmp(6)	:= "0101100100011";	-- STA @291
tmp(7)	:= "0101100100100";	-- STA @292
tmp(8)	:= "0101100100101";	-- STA @293
tmp(9)	:= "0101100000000";	-- STA @256
tmp(10)	:= "0101100000001";	-- STA @257
tmp(11)	:= "0101100000010";	-- STA @258
tmp(12)	:= "0000000000000";	-- NOP
tmp(13)	:= "0001101100000";	-- LDA @352 		;Carrega o acumulador com a leitura do botão KEY0
tmp(14)	:= "0101100100000";	-- STA @288 		;Armazena o valor lido em HEX0 (para verificar erros de leitura)
tmp(15)	:= "1011000000001";	-- AND @1 	    	;Utiliza a máscara b0000_0001 para limpar todos os bits menos o bit 0
tmp(16)	:= "0101100100001";	-- STA @289 		;Armazena o valor mascarado em HEX1
tmp(17)	:= "0000000000000";	-- NOP
tmp(18)	:= "0110000001100";	-- JMP @12 	    	;Fecha o laço principal, faz uma nova leitura de KEY0
