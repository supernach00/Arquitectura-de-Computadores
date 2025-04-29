.INCLUDE "M328PDEF.INC" 

LDI R16, $F0; Cargo en el registro R16 la parte menos significativa del operando A
LDI R17, $A0; Cargo en el registro R17 la parte más significativa del operando A
LDI R18, $F1; Cargo en el registro R18 la parte menos significativa del operando B
LDI R19, $10; Cargo en el registro R19 la parte más significativa del operando B

ADD R16, R18; Sumo la parte menos significativa. El carry se guarda en el registro de estado "C"
ADC R17, R19; Sumo la parte más signfica5tiva. El carry utilizado se toma del registro de estado "C"

IN R22, SREG ; Cargo el contenido de SREG en R16
ANDI R22, $01      ; Aislo solo el bit 0 (el carry)
LDI R20, $FF; Cargo en el registro 20 todos unos
LDI R21, $01; Cargo en el registro 21 solo un uno

OUT DDRB, R20; Pongo el puerto B en modo salida (le cargo los unos)
OUT DDRC, R20; Pongo el puerto C en modo salida (")
OUT DDRD, R21; Pongo PD0 como salida, para el carry

OUT PORTB, R16; Pongo en el puerto B la parte menos significativa
OUT PORTC, R17; Pongo en el puerto C la parte más significativa
OUT PORTD, R22; Pongo en el puerto D el carry


