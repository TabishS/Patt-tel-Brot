.ORIG x3000
START
    LEA R2, SIZECHAR
    AND R1, R1, #0 ; Indicator of width vs. height
    AND R3, R3, #0 ; Counter
    LEA R0, DIMCHECKMESSAGE
    PUTSP
    LD R0, FIRSTCHAR
    OUT
SIZECHECK
    ADD R3, R3, #1
    GETC
    ADD R0, R0, #-8
    BRz RESTART
    ADD R0, R0, #-2 ; Checks \n and \r
    BRz #2
    ADD R0, R0, #-3
    BRnp #3
    ADD R1, R1, #0
    BRz WIDTHFOUND
    BR HEIGHTFOUND
    ADD R0, R2, #0
    PUTSP
    BR SIZECHECK
RESTART
    LD R0, NEWLINE
    OUT
    OUT
    BR START
WIDTHFOUND
    ADD R1, R1, #1
    ADD R2, R2, #1
    LD R0, NEWLINE
    OUT
    ST R3, WIDTH
    AND R3, R3, #0
    BR SIZECHECK
HEIGHTFOUND
    ST R3, HEIGHT
    HALT
; Width and Height checks are the same, but one uses newlines

FIRSTCHAR
    .FILL x004F ; 'O'
SIZECHAR
    .FILL x002D ; "-\0"
    .FILL x0A7C ; "|\n"
    .FILL x0000 ; "\0"
NEWLINE
    .FILL x000A
NEGNEWLINE
    .FILL xFFF5

WIDTH
    .BLKW #1
HEIGHT
    .BLKW #1

DIMCHECKMESSAGE ; Change to backspace?
    ; "Press space until the end of your console is reached, then hit enter. To restart, press delete\n\n"
    .FILL x7250
    .FILL x7365
    .FILL x2073
    .FILL x7073
    .FILL x6361
    .FILL x2065
    .FILL x6E75
    .FILL x6974
    .FILL x206C
    .FILL x6874
    .FILL x2065
    .FILL x6E65
    .FILL x2064
    .FILL x666F
    .FILL x7920
    .FILL x756F
    .FILL x2072
    .FILL x6F63
    .FILL x736E
    .FILL x6C6F
    .FILL x2065
    .FILL x7369
    .FILL x7220
    .FILL x6165
    .FILL x6863
    .FILL x6465
    .FILL x202C
    .FILL x6874
    .FILL x6E65
    .FILL x6820
    .FILL x7469
    .FILL x6520
    .FILL x746E
    .FILL x7265
    .FILL x202E
    .FILL x6F54
    .FILL x7220
    .FILL x7365
    .FILL x6174
    .FILL x7472
    .FILL x202C
    .FILL x7270
    .FILL x7365
    .FILL x2073
    .FILL x6564
    .FILL x656C
    .FILL x6574
    .FILL x0A0A
    .FILL x0000

.END