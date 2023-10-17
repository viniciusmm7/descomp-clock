STA @511 	;Limpa a leitura do botão
LDI $1 	    ;Carrega o acumulador com o valor 1
STA @1 	    ;Armazena o valor do acumulador em MEM[1] (constante 1)
STA @288
STA @289
STA @290
STA @291
STA @292
STA @293
STA @256
STA @257
STA @258
NOP
LDA @352 	;Carrega o acumulador com a leitura do botão KEY0
STA @288 	;Armazena o valor lido em HEX0 (para verificar erros de leitura)
AND @1 	    ;Utiliza a máscara b0000_0001 para limpar todos os bits menos o bit 0
STA @289 	;Armazena o valor mascarado em HEX1
NOP
JMP @12 	    ;Fecha o laço principal, faz uma nova leitura de KEY0