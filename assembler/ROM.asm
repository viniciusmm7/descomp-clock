; SETUP

STA @511    ; reseta a leitura do key 0
STA @510    ; reseta a leitura do key 1
STA @509    ; reseta a leitura do key reset
LDI $0      ; carrega o valor inicial das casas
STA @57     ; intervalo numérico de configuração
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
STA @51		; armazena na casa das unidades do limite temporário
STA @52		; armazena na casa das dezenas do limite temporário
STA @53		; armazena na casa das centenas do limite temporário
STA @54		; armazena na casa dos milhares do limite temporário
STA @55		; armazena na casa das dezenas de milhares do limite temporário
STA @56		; armazena na casa das centenas de milhares do limite temporário
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
    JMP .INICIO_LOOP_CONFIGURACAO_LIMITE

    PULA_CONFIG:

	JSR .ATINGIU_LIMITE		; verifica se a contagem atingiu o limite
	CEQ @6					; se atingiu o limite, pula o incrementa contagem
	JEQ .PULA_INCREMENTA_CONTAGEM

    LDA @352    ; carrega o valor do botão 0
    AND @6      ; aplica a mask
    CEQ @8      ; verifica se é 0
    JEQ .PULA_INCREMENTA_CONTAGEM
    STA @511
    JSR .INCREMENTA_CONTAGEM

    PULA_INCREMENTA_CONTAGEM:

    JSR .MOSTRA_CONTAGEM    ; escreve os números da contagem nos displays
    JMP .LOOP_PRINCIPAL



INICIO_LOOP_CONFIGURACAO_LIMITE:
JSR .RESET	; reseta a contagem
LDI $3		; acende os leds da primeira posição
STA @256	
LDI $0
STA @257
STA @258

LOOP_CONFIGURACAO_LIMITE:

    LDA @356    ; carrega o valor do botão reset
    AND @6      ; aplica a mask
    CEQ @6      ; verifica se é 1
    JEQ .SAIR_LOOP_CONFIGURACAO_LIMITE_SEM_SALVAR

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
	JSR .ARMAZENA_LIMITE	; armazena o limite do jeito que mostra nos displays

	SAIR_LOOP_CONFIGURACAO_LIMITE_SEM_SALVAR:
	JSR .APAGA_LEDS

    LDI $0    	; carrega 0
    STA @57     ; armazena 0 no intervalo de mudança atual
    JMP .LOOP_PRINCIPAL



RESET:
    LDI $0
    STA @0
    STA @1
    STA @2
    STA @3
    STA @4
    STA @5
	LDI $0
	STA @256
	STA @257
	STA @258
	STA @511
	STA @510
	STA @509
	LDA @58
	STA @51
	LDA @59
	STA @52
	LDA @60
	STA @53
	LDA @61
	STA @54
	LDA @62
	STA @55
	LDA @63
	STA @56
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

    LDA @57                 ; carrega o intervalo atual
    CEQ @8                  ; verifica se é igual a 0
    JEQ .DIGITO_0_ML     ; se for
	CEQ @9                  ; verifica se é igual a 1
    JEQ .DIGITO_1_ML     ; se for
	CEQ @10                 ; verifica se é igual a 2
    JEQ .DIGITO_2_ML     ; se for
	CEQ @11                 ; verifica se é igual a 3
    JEQ .DIGITO_3_ML     ; se for
	CEQ @12                 ; verifica se é igual a 4
    JEQ .DIGITO_4_ML     ; se for
    JMP .DIGITO_5_ML 	; se não for nenhum dos acima

	DIGITO_0_ML:
		LDA @320    ; carrega o valor das chaves
		STA @288    ; armazena no HEX 0
		LDA @52		; carrega o valor da dezena do limite temporário
		STA @289    ; armazena no HEX 1
		LDA @53		; carrega o valor de centena do limite temporário
		STA @290    ; armazena no HEX 2
		LDA @54     ; carrega o valor do milhar do limite temporário
		STA @291    ; armazena no HEX 3
		LDA @55     ; carrega o valor da dezena de milhar do limite temporário
		STA @292    ; armazena no HEX 4
		LDA @56     ; carrega o valor da centena de milhar do limite temporário
		STA @293    ; armazena no HEX 5
		RET

	DIGITO_1_ML:
		LDA @51     ; carrega o valor da unidade do limite temporário
		STA @288    ; armazena no HEX 0
		LDA @320    ; carrega o valor das chaves
		STA @289    ; armazena no HEX 1
		LDA @53     ; carrega o valor da centena do limite temporário
		STA @290    ; armazena no HEX 2
		LDA @54     ; carrega o valor do milhar do limite temporário
		STA @291    ; armazena no HEX 3
		LDA @55     ; carrega o valor da dezena de milhar do limite temporário
		STA @292    ; armazena no HEX 4
		LDA @56     ; carrega o valor da centena de milhar do limite temporário
		STA @293    ; armazena no HEX 5
		RET

	DIGITO_2_ML:
		LDA @51     ; carrega o valor da unidade do limite temporário
		STA @288    ; armazena no HEX 0
		LDA @52		; carrega o valor da dezena do limite temporário
		STA @289    ; armazena no HEX 1
		LDA @320    ; carrega o valor das chaves
		STA @290    ; armazena no HEX 2
		LDA @54     ; carrega o valor do milhar do limite temporário
		STA @291    ; armazena no HEX 3
		LDA @55     ; carrega o valor da dezena de milhar do limite temporário
		STA @292    ; armazena no HEX 4
		LDA @56     ; carrega o valor da centena de milhar do limite temporário
		STA @293    ; armazena no HEX 5
		RET

	DIGITO_3_ML:
		LDA @51     ; carrega o valor da unidade do limite temporário
		STA @288    ; armazena no HEX 0
		LDA @52		; carrega o valor da dezena do limite temporário
		STA @289    ; armazena no HEX 1
		LDA @53    	; carrega o valor da centena do limite temporário
		STA @290    ; armazena no HEX 2
		LDA @320    ; carrega o valor das chaves
		STA @291    ; armazena no HEX 3
		LDA @55     ; carrega o valor da dezena de milhar do limite temporário
		STA @292    ; armazena no HEX 4
		LDA @56     ; carrega o valor da centena de milhar do limite temporário
		STA @293    ; armazena no HEX 5
		RET

	DIGITO_4_ML:
		LDA @51     ; carrega o valor da unidade do limite temporário
		STA @288    ; armazena no HEX 0
		LDA @52		; carrega o valor da dezena do limite temporário
		STA @289    ; armazena no HEX 1
		LDA @53    	; carrega o valor da centena do limite temporário
		STA @290    ; armazena no HEX 2
		LDA @54     ; carrega o valor do milhar do limite temporário
		STA @291    ; armazena no HEX 3
		LDA @320    ; carrega o valor das chaves
		STA @292    ; armazena no HEX 4
		LDA @56     ; carrega o valor da centena de milhar do limite temporário
		STA @293    ; armazena no HEX 5
		RET

	DIGITO_5_ML:
		LDA @51     ; carrega o valor da unidade do limite temporário
		STA @288    ; armazena no HEX 0
		LDA @52		; carrega o valor da dezena do limite temporário
		STA @289    ; armazena no HEX 1
		LDA @53    	; carrega o valor da centena do limite temporário
		STA @290    ; armazena no HEX 2
		LDA @54     ; carrega o valor do milhar do limite temporário
		STA @291    ; armazena no HEX 3
		LDA @55     ; carrega o valor da dezena de milhar do limite temporário
		STA @292    ; armazena no HEX 4
		LDA @320    ; carrega o valor das chaves
		STA @293    ; armazena no HEX 5
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
    JEQ .DIGITO_0_MI     	; se for
	CEQ @9                  ; verifica se é igual a 1
    JEQ .DIGITO_1_MI     	; se for
	CEQ @10                 ; verifica se é igual a 2
    JEQ .DIGITO_2_MI     	; se for
	CEQ @11                 ; verifica se é igual a 3
    JEQ .DIGITO_3_MI     	; se for
	CEQ @12                 ; verifica se é igual a 4
    JEQ .DIGITO_4_MI     	; se for
    JMP .DIGITO_5_MI 		; se não for nenhum dos acima

    DIGITO_0_MI:
    LDI $1		; atualiza o intervalo
    STA @57	
	LDI $6		; acende os LEDs da segunda posição e apaga o resto	
    STA @256
    LDI $0
    STA @257
    STA @258
	LDA @320	; salva o novo valor do dígito
	STA @51
    RET

    DIGITO_1_MI:
    LDI $2		; atualiza o intervalo
    STA @57	
	LDI $24		; acende os LEDs da terceira posição e apaga o resto	
    STA @256
    LDI $0
    STA @257
    STA @258
	LDA @320	; salva o novo valor do dígito
	STA @52
    RET

	DIGITO_2_MI:
    LDI $3		; atualiza o intervalo
    STA @57	
	LDI $96		; acende os LEDs da quarta posição e apaga o resto	
    STA @256
    LDI $0
    STA @257
    STA @258
	LDA @320	; salva o novo valor do dígito
	STA @53
    RET

	DIGITO_3_MI:
    LDI $4		; atualiza o intervalo
    STA @57	
	LDI $128	; acende os LEDs da quinta posição e apaga o resto	
    STA @256
    LDI $1
    STA @257
	LDI $0
    STA @258
	LDA @320	; salva o novo valor do dígito
	STA @54
    RET

	DIGITO_4_MI:
    LDI $5		; atualiza o intervalo
    STA @57	
	LDI $0		; acende os LEDs da sexta posição e apaga o resto	
    STA @256
    LDI $1
    STA @257
    STA @258
	LDA @320	; salva o novo valor do dígito
	STA @55
    RET

	DIGITO_5_MI:
    LDI $0		; atualiza o intervalo
    STA @57	
	LDI $3		; acende os LEDs da primeira posição e apaga o resto	
    STA @256
    LDI $0
    STA @257
    STA @258
	LDA @320	; salva o novo valor do dígito
	STA @56
    RET



ATINGIU_LIMITE:

	LDA @5		; carrega o valor da centena de milhar
	CEQ @63		; compara com o valor limite da centena de milhar
	JEQ .CMILHAR_ATINGIU
	LDI $0		; se não for igual, não atingiu
	RET

	CMILHAR_ATINGIU:
	LDA @4		; carrega o valor da dezena de milhar
	CEQ @62		; compara com o valor limite da dezena de milhar
	JEQ .DMILHAR_ATINGIU
	LDI $0		; se não for igual, não atingiu
	RET

	DMILHAR_ATINGIU:
	LDA @3		; carrega o valor do milhar
	CEQ @61		; compara com o valor limite do milhar
	JEQ .MILHAR_ATINGIU
	LDI $0		; se não for igual, não atingiu
	RET

	MILHAR_ATINGIU:
	LDA @2		; carrega o valor da centena
	CEQ @60		; compara com o valor limite da centena
	JEQ .CENTENA_ATINGIU
	LDI $0		; se não for igual, não atingiu
	RET

	CENTENA_ATINGIU:
	LDA @1		; carrega o valor da dezena
	CEQ @59		; compara com o valor limite da dezena
	JEQ .DEZENA_ATINGIU
	LDI $0		; se não for igual, não atingiu
	RET

	DEZENA_ATINGIU:
	LDA @0		; carrega o valor da unidade
	CEQ @58		; compara com o valor limite da unidade
	JEQ .UNIDADE_ATINGIU
	LDI $0		; se não for igual, não atingiu
	RET

	UNIDADE_ATINGIU:
	LDI $255
	STA @256
	STA @257
	STA @258
	LDI $1
	RET


ARMAZENA_LIMITE:

	LDA @57                 ; carrega o digito atual
    CEQ @8                  ; verifica se é igual a 0
    JEQ .DIGITO_0_AL     	; se for
	CEQ @9                  ; verifica se é igual a 1
    JEQ .DIGITO_1_AL     	; se for
	CEQ @10                 ; verifica se é igual a 2
    JEQ .DIGITO_2_AL     	; se for
	CEQ @11                 ; verifica se é igual a 3
    JEQ .DIGITO_3_AL     	; se for
	CEQ @12                 ; verifica se é igual a 4
    JEQ .DIGITO_4_AL     	; se for
    JMP .DIGITO_5_AL 		; se não for nenhum dos acima

    DIGITO_0_AL:
    LDA @320	; carrega o valor dos switches
	STA @51		; armazena na unidade do limite
    JMP .FINAL_AL

    DIGITO_1_AL:
    LDA @320	; carrega o valor dos switches
	STA @52		; armazena na dezena do limite
    JMP .FINAL_AL

	DIGITO_2_AL:
    LDA @320	; carrega o valor dos switches
	STA @53		; armazena na centena do limite
    JMP .FINAL_AL

	DIGITO_3_AL:
    LDA @320	; carrega o valor dos switches
	STA @54		; armazena no milhar do limite
    JMP .FINAL_AL

	DIGITO_4_AL:
    LDA @320	; carrega o valor dos switches
	STA @55		; armazena na dezena de milhar do limite
    JMP .FINAL_AL

	DIGITO_5_AL:
    LDA @320	; carrega o valor dos switches
	STA @56		; armazena na centena de milhar do limite
	
	FINAL_AL:
	LDA @51
	STA @58
	LDA @52
	STA @59
	LDA @53
	STA @60
	LDA @54
	STA @61
	LDA @55
	STA @62
	LDA @56
	STA @63
    RET