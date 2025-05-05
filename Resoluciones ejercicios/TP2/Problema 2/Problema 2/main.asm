;
; Problema 2.asm
;
; Created: 5/5/2025 12:54:56
; Author : nacho

; Problema 2 
; Desarrolle un programa para AVR que realice el producto entre dos n�meros 
; positivos, donde el multiplicando y el producto sean de dos bytes y el 
; multiplicador de un byte: a) Utilizando la instrucci�n MUL. b) Sin utilizar la 
; instrucci�n MUL.  Calcule el tiempo de ejecuci�n de cada procedimiento. �Qu� rango 
; de validez tiene cada variable?, �Qu� ocurre si se lo sobrepasa? �C�mo 
; solucionar�a este inconveniente? �La instrucci�n MUL est� disponible en todas las 
; implementaciones de AVR? Finalmente, proponga un algoritmo adecuado para AVR que 
; realice el cociente entre dos n�meros positivos, donde el divisor y el cociente 
; sean de un byte y el dividendo de dos bytes. 


; Carga de operandos:

    LDI R16, $02 ; Cargo el multiplicador en el R16 (1 byte)
	LDI R17, $AA ; Cargo la parte baja del multiplicando en R17 (1 byte)
	LDI R18, $0A ; Cargo la parte alta del multiplicando en R18 (1 byte)

	MUL R17, R16; Realizo (Multiplicando low) x (Multiplicador). Se guarda en los registros R1:R0.
	MOVW R25:R24, R1:R0 ; Muevo el resultado de la parte baja a R25:R24

	MUL R18, R16; Realizo (Multiplicando high) x (Multiplicador). Se guarda en los registros R1:R0.
	MOVW R27:R26, R1:R0 ; Muevo el resultado de la parte alta a R27:R26



