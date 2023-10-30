


LOOP:               ; Label for the loop
    LDI $1          ; Load 1 into register r0
    LDA @1          ; Load the value at the register r0 into the memory address 1
    LDA @256        ; Load the value at the register r0 into the memory address 256

    NOP
    ADD @1          ; Add the value at the memory address 1 to the register r0
    JMP .TEST       ; Jump to the label .TEST
                    ; This is a comment

TEST:
    JMP .LOOP       ; Jump to the label .LOOP