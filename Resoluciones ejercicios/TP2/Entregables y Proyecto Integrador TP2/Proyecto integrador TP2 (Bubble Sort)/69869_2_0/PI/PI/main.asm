;
; PI.asm
;
; Created: 16/5/2025 08:21:33
; Author : nachito crack
; Algoritmo de ordenamiento: Bubble Sort
; Algoritmo de generación aleatoria: LFSR 16 bits
; Ocupación de la memoria de programa (solo Bubble Sort):
; Ocupación de la memoria de datos (sin el vector):
; Tiempo medio de la iteración ordenamiento:
; Tiempo medio de la iteración generación:
; Ubicación inicial en RAM del vector
; Set del largo del vector deseado:

.SET LAR = $FF

;----------------------------
; Definiciones de constantes
;----------------------------

.DEF N      = R17
.DEF PER    = R18 ; Cantidad de permutaciones
.DEF LARX   = R19 ; Largo auxiliar
.DEF A      = R20 ; Registro auxiliar para almacenenar elemento A
.DEF B      = R21 ; Registro auxiliar para almacenenar elemento B
.DEF AUX    = R23
.DEF LFSRL  = R24 ; LFSR Low 
.DEF LFSRH  = R25 ; LFSR High

            LDI LFSRL, 0b01100101 ; Semilla L
            LDI LFSRH, 0b11000110 ; Semilla H

;---------------------------------
; Generación aleatoria del vector
;---------------------------------

GEN:        CLR R30           ; Inicializo el puntero Z en 0x0100
            LDI R31, $01

            LDI N, LAR        ; Defino el número de iteraciones según el largo del vector que se desea generar. 

            ; Realizo el XOR entre los bits 0 y 1

DNV:        MOV AUX, LFSRL
            LSR AUX 
            EOR AUX, LFSRL
            LSR AUX
            ROR LFSRH
            ROR LFSRL

            ST Z+, LFSRH      ; Guardo los 8 bits altos del LFSR

            DEC N
            BRNE DNV          ; De nuevo

CHAU:       RJMP CHAU

;-----------------------------
;   Programa de ordenamiento
;-----------------------------

ORD:        LDI N, $01        ; Defino variables y constantes.

LUP1:       CLR PER           ; Reseteo del flag de permutación y del largo auxiliar.
            LDI LARX, LAR
            SUB LARX, N

            ; Reseteo el puntero Y:

            CLR R28           ; Y apunta a 0x0100
            LDI R29, $01

            ; Loop interno, se compara elemento a elemento iterativamente y se permuta si es necesario:

LUP2:       LD A, Y+          ; Aumento el puntero
            LDD B, Y
            CP A, B
            BRMI SKP          ; Se omite (SKiP) la permutación si el resultado es negativo.

            ; Bloque de permutación:

            ST Y-1, B
            STD Y, A

            LDI PER, $01      ; Se activa el flag de permutación.

SKP:        DEC LARX          ; Si se terminó de recorrer el vector, salgo del lup interno.
            BRNE LUP

            INC N
            TST PER           ; Si el flag de permutaciones es 0, el vector está ordenado. Sino, se itera nuevamente.
            BREQ FIN
            RJMP LUP1

FIN:        RJMP FIN
