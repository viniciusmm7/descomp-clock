





LOOP:







    LDA $0
    STA @288
    ADD $1
    JMP .TEST






TEST:
    JMP .TEST2






TEST2:
    JMP .LOOP