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
LDI $10     ; carrega o valor máximo por casa possível
STA @7      ; armazena o valor máximo por casa possível

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
    JMP .LOOP_CONFIGURACAO_LIMITE

    PULA_CONFIG:
    LDA @352    ; carrega o valor do botão 0
    AND @6      ; aplica a mask
    CEQ @8      ; verifica se é 0
    JEQ .PULA_INCREMENTA_CONTAGEM
    STA @511
    JSR .INCREMENTA_CONTAGEM

    PULA_INCREMENTA_CONTAGEM:
    LDI $0                  ; define se apaga ou acende os LEDS
    JSR .MODIFICA_LEDS      ; apaga os LEDs
    JSR .MOSTRA_CONTAGEM    ; escreve os números da contagem nos displays
    JMP .LOOP_PRINCIPAL

LOOP_CONFIGURACAO_LIMITE:

    LDA @356    ; carrega o valor do botão reset
    AND @6      ; aplica a mask
    CEQ @6      ; verifica se é 1
    JEQ .LOOP_PRINCIPAL

    LDA @353    ; carrega o valor do botão 1
    AND @6      ; aplica a mask
    CEQ @8      ; verifica se é 0
    JEQ .PULA_MUDANCA
    STA @510
    STA @511
    JMP .LOOP_PRINCIPAL

    PULA_MUDANCA:
    LDI $255
    JSR .MODIFICA_LEDS

    JMP .LOOP_CONFIGURACAO_LIMITE

FIM:
JMP .FIM

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
    STA @288    ; armazena o 0 no HEX 0
    LDA @1      ; carrega o valor da dezena
    STA @289    ; armazena o 0 no HEX 1
    LDA @2      ; carrega o valor da centena
    STA @290    ; armazena o 0 no HEX 2
    LDA @3      ; carrega o valor do milhar
    STA @291    ; armazena o 0 no HEX 3
    LDA @4      ; carrega o valor da dezena de milhar
    STA @292    ; armazena o 0 no HEX 4
    LDA @5      ; carrega o valor da centena de milhar
    STA @293    ; armazena o 0 no HEX 5
    RET



MODIFICA_LEDS:
    STA @256
    STA @257
    STA @258
    RET