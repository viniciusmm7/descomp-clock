


LOOP:               ; Label for the loop
    LDI $1, %r0     ; Load 1 into register r0
    LDA @1, %r1     ; Load the value at the register r0 into the memory address 1
    LDA @256, %r2   ; Load the value at the register r0 into the memory address 256

    NOP
    ADD @1, %r3     ; Add the value at the memory address 1 to the register r0
    JMP .TEST       ; Jump to the label .TEST
                    ; This is a comment

TEST:
    JMP .LOOP       ; Jump to the label .LOOP