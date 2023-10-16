JMP @4   ;Deve desviar para 4
JEQ @9   ;Deve desviar para 9


LDI $5   ;Carrega o acumulador com valor 5
STA @256 ;Armazena 5 na posição 256 da memória
CEQ @256 ;A comparação deve fazer o flag_zero ser 1
JMP @1   ;Vai testar o flag_zero depois do jump

LDI $4   ;Carrega acumulador com valor 4
CEQ @256 ;Compara com valor 5, deve fazer o flag_zero ser 0
JEQ @3   ;Não deve ocorrer o desvio
JMP @12  ;Fim. Deve ficar neste laço
NOP      ;Ordem PC: 0 4 5 6 7 1 9 10 11 12 12 ...