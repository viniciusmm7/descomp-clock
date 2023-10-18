; SETUP

NOP
STA @511    ; reseta a leitura do key 0
STA @510    ; reseta a leitura do key 1
STA @509    ; reseta a leitura do key reset
LDI $0      ; carrega o valor inicial das casas
STA @0      ; armazena 0 na unidade
STA @1      ; armazena 0 na dezena
STA @2      ; armazena 0 na centena
STA @3      ; armazena 0 no milhar
STA @4      ; armazena 0 na dezena de milhar
STA @5      ; armazena 0 na centena de milhar
STA @8      ; armazena um 0 de referência
LDI $1      ; carrega o valor de incremento
STA @6      ; armazena o valor de incremento
STA @9		; armazena 1 no 9 para referência do intervalo numérico de configuração
LDI $10     ; carrega o valor máximo por casa possível
STA @7      ; armazena o valor máximo por casa possível
LDI $9      ; carrega o número 9 para definir o limite de contagem inicial
STA @58     ; armazena na casa das unidades do limite
STA @59     ; armazena na casa das dezenas do limite
STA @60     ; armazena na casa das centenas do limite
STA @61     ; armazena na casa dos milhares do limite
STA @62     ; armazena na casa das dezenas de milhar do limite
STA @63     ; armazena na casa das centenas de milhar do limite
LDI $2		; carrega 2 para inicializar próximo endereço de referência do intervalo numérico de configuração
STA @10		; armazena a referência de estado 2 no endereço 10
LDI $3		; carrega 3 para inicializar próximo endereço de referência do intervalo numérico de configuração
STA @11		; armazena a referência de estado 3 no endereço 11
LDI $4		; carrega 4 para inicializar próximo endereço de referência do intervalo numérico de configuração
STA @12		; armazena a referência de estado 4 no endereço 12
LDI $5		; carrega 5 como valor inicial do intervalo numérico de configuração
STA @57     ; intervalo numérico de configuração


LOOP_PRINCIPAL:

    LDA @356    ; carrega o valor do botão reset
    AND @6      ; aplica a mask
    CEQ @8      ; verifica se é 0
    JEQ .PULA_RESET
    STA @509
    JSR .RESET

    PULA_RESET:
    LDA @353    ; carrega o valor do botão 1
    AND @6      ; aplica a mask
    CEQ @8      ; verifica se é 0
    JEQ .PULA_CONFIG
    STA @510
    JSR .MUDA_INTERVALO
    JMP .LOOP_CONFIGURACAO_LIMITE

    PULA_CONFIG:
    LDA @352    ; carrega o valor do botão 0
    AND @6      ; aplica a mask
    CEQ @8      ; verifica se é 0
    JEQ .PULA_INCREMENTA_CONTAGEM
    STA @511
    JSR .INCREMENTA_CONTAGEM

    PULA_INCREMENTA_CONTAGEM:
    JSR .APAGA_LEDS         ; apaga os LEDs
    JSR .MOSTRA_CONTAGEM    ; escreve os números da contagem nos displays
    JMP .LOOP_PRINCIPAL



LOOP_CONFIGURACAO_LIMITE:

    LDA @356    ; carrega o valor do botão reset
    AND @6      ; aplica a mask
    CEQ @6      ; verifica se é 1
    JEQ .SAIR_LOOP_CONFIGURACAO_LIMITE

    LDA @353    ; carrega o valor do botão 1
    AND @6      ; aplica a mask
    CEQ @8      ; verifica se é 0
    JEQ .PULA_MUDANCA_ESTADO
    STA @510
    JMP .SAIR_LOOP_CONFIGURACAO_LIMITE

    PULA_MUDANCA_ESTADO:
    LDA @352    ; carrega o valor do botão 0
    AND @6      ; aplica a mask
    CEQ @8      ; verifica se é 0
    JEQ .PULA_MUDANCA_INTERVALO
    STA @511
    JSR .MUDA_INTERVALO

    PULA_MUDANCA_INTERVALO:
    JSR .MOSTRA_LIMITE
    JMP .LOOP_CONFIGURACAO_LIMITE

    SAIR_LOOP_CONFIGURACAO_LIMITE:
    LDI $5    	; carrega 5
    STA @57     ; armazena 5 no intervalo de mudança atual
    JMP .LOOP_PRINCIPAL



RESET:
    LDI $0
    STA @0
    STA @1
    STA @2
    STA @3
    STA @4
    STA @5
    RET



INCREMENTA_CONTAGEM:
    LDA @0                  ; carrega o valor da unidade
    ADD @6                  ; incrementa o valor da unidade
    CEQ @7                  ; compara o valor da casa com 10
    JEQ .INCREMENTA_DEZENA  ; incrementa a casa da dezena caso necessário
    STA @0                  ; armazena o valor da unidade
    FIM_INCREMENTA:
    RET

    INCREMENTA_DEZENA:
        LDI $0                  ; carrega 0
        STA @0                  ; armazena 0 na unidade
        LDA @1                  ; carrega o valor atual da dezena
        ADD @6                  ; incrementa o valor da dezena
        CEQ @7                  ; verifica se é igual a 10
        JEQ .INCREMENTA_CENTENA ; se for, incrementa a centena
        STA @1                  ; armazena o novo valor da dezena
        JMP .FIM_INCREMENTA     ; sai da função

    INCREMENTA_CENTENA:
        LDI $0                  ; carrega 0
        STA @1                  ; armazena 0 na dezena
        LDA @2                  ; carrega o valor atual da centena
        ADD @6                  ; incrementa o valor da centena
        CEQ @7                  ; verifica se é igual a 10
        JEQ .INCREMENTA_MILHAR  ; se for, incrementa o milhar
        STA @2                  ; armazena o novo valor da centena
        JMP .FIM_INCREMENTA     ; sai da função

    INCREMENTA_MILHAR:
        LDI $0                  ; carrega 0
        STA @2                  ; armazena 0 na centena
        LDA @3                  ; carrega o valor atual do milhar
        ADD @6                  ; incrementa o valor do milhar
        CEQ @7                  ; verifica se é igual a 10
        JEQ .INCREMENTA_DMILHAR ; se for, incrementa a dezena de milhar
        STA @3                  ; armazena o novo valor do milhar
        JMP .FIM_INCREMENTA     ; sai da função
    
    INCREMENTA_DMILHAR:
        LDI $0                  ; carrega 0
        STA @3                  ; armazena 0 no milhar
        LDA @4                  ; carrega o valor atual da dezena de milhar
        ADD @6                  ; incrementa o valor da dezena de milhar
        CEQ @7                  ; verifica se é igual a 10
        JEQ .INCREMENTA_CMILHAR ; se for, incrementa a centena de milhar
        STA @4                  ; armazena o novo valor da dezena de milhar
        JMP .FIM_INCREMENTA     ; sai da função
    
    INCREMENTA_CMILHAR:
        LDI $0                  ; carrega 0
        STA @4                  ; armazena 0 na dezena de milhar
        LDA @5                  ; carrega o valor atual da centena de milhar
        ADD @6                  ; incrementa o valor da centena de milhar
        CEQ @7                  ; verifica se é igual a 10
        JEQ .INCREMENTA_MILHAO  ; se for, zera tudo
        STA @5                  ; armazena o novo valor da centena de milhar
        JMP .FIM_INCREMENTA     ; sai da função

    INCREMENTA_MILHAO:
        LDI $0  ; carrega 0
        STA $5  ; armazena 0 na centena de milhar
        JMP .FIM_INCREMENTA



MOSTRA_CONTAGEM:
    LDA @0      ; carrega o valor da unidade
    STA @288    ; armazena no HEX 0
    LDA @1      ; carrega o valor da dezena
    STA @289    ; armazena no HEX 1
    LDA @2      ; carrega o valor da centena
    STA @290    ; armazena no HEX 2
    LDA @3      ; carrega o valor do milhar
    STA @291    ; armazena no HEX 3
    LDA @4      ; carrega o valor da dezena de milhar
    STA @292    ; armazena no HEX 4
    LDA @5      ; carrega o valor da centena de milhar
    STA @293    ; armazena no HEX 5
    RET



MOSTRA_LIMITE:

    LDA @57                     ; carrega o intervalo atual
    CEQ @8                      ; verifica se é igual a 0
    JEQ .INTERVALO_ZERO_ML      ; se for
    JMP .INTERVALO_NAO_ZERO_ML	; se não for

	INTERVALO_ZERO_ML:
		LDA @320    ; carrega o valor das chaves
		STA @288    ; armazena no HEX 0
		STA @289    ; armazena no HEX 1
		STA @290    ; armazena no HEX 2
		LDA @61     ; carrega o valor do milhar do limite
		STA @291    ; armazena no HEX 3
		LDA @62     ; carrega o valor da dezena de milhar do limite
		STA @292    ; armazena no HEX 4
		LDA @63     ; carrega o valor da centena de milhar do limite
		STA @293    ; armazena no HEX 5
		RET

	INTERVALO_NAO_ZERO_ML:
		LDA @320    ; carrega o valor das chaves
		STA @291    ; armazena no HEX 3
		STA @292    ; armazena no HEX 4
		STA @293    ; armazena no HEX 5
		LDA @58     ; carrega o valor da unidade do limite
		STA @288    ; armazena no HEX 0
		LDA @59     ; carrega o valor da dezena do limite
		STA @289    ; armazena no HEX 1
		LDA @60     ; carrega o valor da centena do limite
		STA @290    ; armazena no HEX 2
		RET



APAGA_LEDS:
    LDI $0
    STA @256
    STA @257
    STA @258
    RET



MUDA_INTERVALO:

    LDA @57                 ; carrega o intervalo atual
    CEQ @8                  ; verifica se é igual a 0
    JEQ .INTERVALO_0_MI     ; se for
	CEQ @9                  ; verifica se é igual a 1
    JEQ .INTERVALO_1_MI     ; se for
	CEQ @10                 ; verifica se é igual a 2
    JEQ .INTERVALO_2_MI     ; se for
	CEQ @11                 ; verifica se é igual a 3
    JEQ .INTERVALO_3_MI     ; se for
	CEQ @12                 ; verifica se é igual a 4
    JEQ .INTERVALO_4_MI     ; se for
    JMP .INTERVALO_5_MI 	; se não for nenhum dos acima

    INTERVALO_0_MI:
    LDI $1		; atualiza o intervalo
    STA @57	
	LDI $6		; acende os LEDs da segunda posição e apaga o resto	
    STA @256
    LDI $0
    STA @257
    STA @258
    RET

    INTERVALO_1_MI:
    LDI $2		; atualiza o intervalo
    STA @57	
	LDI $24		; acende os LEDs da terceira posição e apaga o resto	
    STA @256
    LDI $0
    STA @257
    STA @258
    RET

	INTERVALO_2_MI:
    LDI $3		; atualiza o intervalo
    STA @57	
	LDI $96		; acende os LEDs da quarta posição e apaga o resto	
    STA @256
    LDI $0
    STA @257
    STA @258
    RET

	INTERVALO_3_MI:
    LDI $4		; atualiza o intervalo
    STA @57	
	LDI $128	; acende os LEDs da quinta posição e apaga o resto	
    STA @256
    LDI $1
    STA @257
	LDI $0
    STA @258
    RET

	INTERVALO_4_MI:
    LDI $5		; atualiza o intervalo
    STA @57	
	LDI $0		; acende os LEDs da sexta posição e apaga o resto	
    STA @256
    LDI $1
    STA @257
    STA @258
    RET

	INTERVALO_5_MI:
    LDI $0		; atualiza o intervalo
    STA @57	
	LDI $3		; acende os LEDs da primeira posição e apaga o resto	
    STA @256
    LDI $0
    STA @257
    STA @258
    RET