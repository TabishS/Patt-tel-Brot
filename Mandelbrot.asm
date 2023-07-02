; Ask if user knows screen width, otherwise find
; Ask if user knows screen height, otherwise find

.ORIG x3000

TESTADD ; Testing 8-digit addition
    LEA R3, OP1
    LEA R4, OP2
    LEA R5, RES
STARTADD
    LDR R1, R3, #0
    LDR R2, R4, #0
    AND R7, R7, #0
    LD R0, TESTCARRY
    AND R0, R0, R1
    AND R0, R0, R2

    ; Cin = R0[15]
    BRz #1
    ADD R7, R7, #1

    ADD R1, R1, R2
    STR R1, R5, #0

    LDR R1, R3, #1
    LDR R2, R4, #1

    ADD R1, R1, R2
    ADD R1, R1, R7

    STR R1, R5, #1
    HALT

OP1
    .FILL x1010
    .FILL x1010
OP2
    .FILL x0101
    .FILL x0101
RES
    .BLKW #1
    .BLKW #1
TESTCARRY
    .FILL x8000

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
    BR PREBROTCALC
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

DIMCHECKMESSAGE ; Change to backspace?
    ; "Press space until the end of your console is reached, then hit enter. To restart, press delete\n\n"
    ; Fix to make it clear to keep pressing space to go down, tweak or add new message
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

PREBROTCALC
    LEA R0, #2
    PUTSP
    BR BROTCALC
    ; "Use w, a, s, d to pan, i and o to zoom in and out, and j and k to increase or decrease the maximum number of iterations"
    .FILL x7355
    .FILL x2065
    .FILL x2C77
    .FILL x6120
    .FILL x202C
    .FILL x2C73
    .FILL x6420
    .FILL x7420
    .FILL x206F
    .FILL x6170
    .FILL x2C6E
    .FILL x6920
    .FILL x6120
    .FILL x646E
    .FILL x6F20
    .FILL x7420
    .FILL x206F
    .FILL x6F7A
    .FILL x6D6F
    .FILL x6920
    .FILL x206E
    .FILL x6E61
    .FILL x2064
    .FILL x756F
    .FILL x2C74
    .FILL x6120
    .FILL x646E
    .FILL x6A20
    .FILL x6120
    .FILL x646E
    .FILL x6B20
    .FILL x7420
    .FILL x206F
    .FILL x6E69
    .FILL x7263
    .FILL x6165
    .FILL x6573
    .FILL x6F20
    .FILL x2072
    .FILL x6564
    .FILL x7263
    .FILL x6165
    .FILL x6573
    .FILL x7420
    .FILL x6568
    .FILL x6D20
    .FILL x7861
    .FILL x6D69
    .FILL x6D75
    .FILL x6E20
    .FILL x6D75
    .FILL x6562
    .FILL x2072
    .FILL x666F
    .FILL x6920
    .FILL x6574
    .FILL x6172
    .FILL x6974
    .FILL x6E6F
    .FILL x2E73
    .FILL x5020
    .FILL x6572
    .FILL x7373
    .FILL x6520
    .FILL x746E
    .FILL x7265
    .FILL x7420
    .FILL x206F
    .FILL x6562
    .FILL x6967
    .FILL x2C6E
    .FILL x6120
    .FILL x646E
    .FILL x7020
    .FILL x6572
    .FILL x7373
    .FILL x6420
    .FILL x6C65
    .FILL x7465
    .FILL x2065
    .FILL x6F74
    .FILL x7220
    .FILL x7365
    .FILL x7A69
    .FILL x2065
    .FILL x6F79
    .FILL x7275
    .FILL x7720
    .FILL x6E69
    .FILL x6F64
    .FILL x0077

BROTCALC
; Find smaller dim
    LD R2, WIDTH
    NOT R4, R2
    ADD R4, R4, #1 ; R4 has negative WIDTH
    ADD R4, R3, R4 ; R4 has HEIGHT - WIDTH
    ; Divide R4 by 2
    ; If WIDTH is smaller, answer will be negative, else positive
    BRn #1
    ; HEIGHT is smaller, add XSHIFT (Height - Width)/2
    ST R4, XSHIFT
    BR #1
    ; WIDTH is smaller, add YSHIFT (Width - Height)/2
    ST R4, YSHIFT
    HALT

SAVER5
    .BLKW #1
SAVER6
    .BLKW #1

; R1 - Frac of OP1, R2 - Int of OP1, R3 - Frac of OP2, R4 - Int of OP2
; Results in R1 and R2
; Also use R5 and R6

MULTIPLY

DIVIDE

ADDADD
    ; CONTINUE HERE - Need to check fractional parts for carry out
    AND R5, R1, #7
    AND R6, R3, #7
    ADD R5, R5, R6 ; R5 has sum of three lower bits - conserve
    AND R6, R5, #8 ; R6 checks if there is a carry-out from the three lower bits
SUBTRACT

; R1 - Frac of OP, R2 - Int of OP, R3 - # of bits to shift by
RIGHTSHIFT

RIGHTSHIFTHALF


SCALEWIDTH ; 4.5
    .FILL x0004
    .FILL x8000
WIDTH
    .BLKW #1
HEIGHT
    .BLKW #1
SMALLERDIMINT
    .BLKW #1
SMALLDERDIMFRAC
    .BLKW #1
ISHIFTINT
    .BLKW #1
ISHIFTFRAC
    .BLKW #1
JSHIFTINT
    .BLKW #1
JSHIFTFRAC
    .BLKW #1
XSHIFT
    .FILL x0000
YSHIFT
    .FILL x0000
ZOOM
    .BLKW #1
MI
    .BLKW #1

; UPKEY 
;     .FILL x0077
; DOWNKEY
;     .FILL x0073
; ZOOMOUTKEY
;     .FILL x006F
; MIMINUSKEY
;     .FILL x006B
; MIPLUSKEY
;     .FILL x006A
; ZOOMINKEY
;     .FILL x0069
; RIGHTKEY
;     .FILL x0064
; LEFTKEY
;     .FILL x0061
NEGUPKEY
    .FILL xFF89
NEGDOWNKEY
    .FILL xFF8D
NEGZOOMOUTKEY
    .FILL xFF91
NEGMIMINUSKEY
    .FILL xFF95
NEGMIPLUSKEY
    .FILL xFF96
NEGZOOMINKEY
    .FILL xFF97
NEGRIGHTKEY
    .FILL xFF9C
NEGLEFTKEY
    .FILL xFF9E

; R0 - I/O, temporary values
; R1 - i
; R2 - j
; R3 - 
; R4 - 
; R5 - 
; R6 - 
; R7 - JSR, temporary values

.END

; Add toggling between escape time and modular