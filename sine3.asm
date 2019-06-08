;
; Sine Wave Generation Tset
; for ATMEGA48
;

.include "m48def.inc"

.cseg
    rjmp main

.org 0x0004      ; pcint1
    rjmp int_c

;---------------------------
; int_c
;---------------------------
int_c:
;    in r16, sreg
;	push r16

    ld r20,x+
    cpi xh,0x02
;	inc xl         ; 3 line -> 64 mode, 1 line -> 128 mode, comment out -> 256 mode
	breq next
    reti

next:
    ldi xh,0x01
	ldi xl,0x00
	reti    
;    pop r16
;	out sreg,r16

;---------------------------
; main
;---------------------------
main:
    cli ; warikomi kinshi
	rcall data_store

    ldi    xh,0x01
    ldi    xl,0x00

    ldi r16,0b11110000 ; pin0 <- data in, pin1,2,3 to select data pin
    out ddrb,r16
;    ldi r16,0b00001111 ; pull up pin0,1,2,3
;	out portb,r16
    ldi r16,0b11110000
    out ddrc,r16
    ldi r16,0b11111111
    out ddrd,r16

    lds r16,pcicr      ; pin henka warikomi settei
	sbr r16,(1<<pcie1) ; pcie1 -> portc (pcie0 -> portb)
	sts pcicr,r16

    ldi  r17,0b00000001

	mov  r16,r17 ; taisyou pin
    sts pcmsk1,r16     ; pin henka mask resister (pcmsk1 -> portc, pcmsk0 -> portb)
    sbi pcifr, pcif1

;----------------------------
; i2c master
; slave HT16K33 i2c adress 0h70(0he0)
;----------------------------
i2c:
    ; i2c settei
	ldi r16, 0x00
	sts twbr, r16
	ldi r16, 0x00
	sts twsr, r16
	ldi r16, 0x00
	sbr r16, (1<<twen)
	sts twcr, r16




    sei; warikomi kyoka

loop:
	out portd,r20
    rcall settei
    rjmp loop

settei:
    in   r17,pinb
	andi r17,0b00001110
    cpi  r17,0b00000010
    breq set1
    cpi  r17,0b00000100
	breq set2
    cpi  r17,0b00000110
	breq set3
    cpi  r17,0b00001000
	breq set4
    cpi  r17,0b00001010
	breq set5
    ldi  r18,0b00000010
	sts pcmsk1,r18
    ret

set1:
    ldi r18,0b00000001
    sts pcmsk1,r18
	ret
set2:
	ldi r18,0b00000010
    sts pcmsk1,r18
	ret
set3:
    ldi r18,0b00000100
    sts pcmsk1,r18
	ret
set4:
	ldi r18,0b00001000
    sts pcmsk1,r18
	ret
set5:
    ldi r18,0b00010000
    sts pcmsk1,r18
	ret

;---------------------------
; sine data to ram
;---------------------------
data_store:
ldi    xh,0x01
ldi    xl,0x00

ldi r16,	127
st x+,r16
ldi r16,	130
st x+,r16
ldi r16,	133
st x+,r16
ldi r16,	136
st x+,r16
ldi r16,	139
st x+,r16
ldi r16,	143
st x+,r16
ldi r16,	146
st x+,r16
ldi r16,	149
st x+,r16
ldi r16,	152
st x+,r16
ldi r16,	155
st x+,r16
ldi r16,	158
st x+,r16
ldi r16,	161
st x+,r16
ldi r16,	164
st x+,r16
ldi r16,	167
st x+,r16
ldi r16,	170
st x+,r16
ldi r16,	173
st x+,r16
ldi r16,	176
st x+,r16
ldi r16,	178
st x+,r16
ldi r16,	181
st x+,r16
ldi r16,	184
st x+,r16
ldi r16,	187
st x+,r16
ldi r16,	190
st x+,r16
ldi r16,	192
st x+,r16
ldi r16,	195
st x+,r16
ldi r16,	198
st x+,r16
ldi r16,	200
st x+,r16
ldi r16,	203
st x+,r16
ldi r16,	205
st x+,r16
ldi r16,	208
st x+,r16
ldi r16,	210
st x+,r16
ldi r16,	212
st x+,r16
ldi r16,	215
st x+,r16
ldi r16,	217
st x+,r16
ldi r16,	219
st x+,r16
ldi r16,	221
st x+,r16
ldi r16,	223
st x+,r16
ldi r16,	225
st x+,r16
ldi r16,	227
st x+,r16
ldi r16,	229
st x+,r16
ldi r16,	231
st x+,r16
ldi r16,	233
st x+,r16
ldi r16,	234
st x+,r16
ldi r16,	236
st x+,r16
ldi r16,	238
st x+,r16
ldi r16,	239
st x+,r16
ldi r16,	240
st x+,r16
ldi r16,	242
st x+,r16
ldi r16,	243
st x+,r16
ldi r16,	244
st x+,r16
ldi r16,	245
st x+,r16
ldi r16,	247
st x+,r16
ldi r16,	248
st x+,r16
ldi r16,	249
st x+,r16
ldi r16,	249
st x+,r16
ldi r16,	250
st x+,r16
ldi r16,	251
st x+,r16
ldi r16,	252
st x+,r16
ldi r16,	252
st x+,r16
ldi r16,	253
st x+,r16
ldi r16,	253
st x+,r16
ldi r16,	253
st x+,r16
ldi r16,	254
st x+,r16
ldi r16,	254
st x+,r16
ldi r16,	254
st x+,r16
ldi r16,	254
st x+,r16
ldi r16,	254
st x+,r16
ldi r16,	254
st x+,r16
ldi r16,	254
st x+,r16
ldi r16,	253
st x+,r16
ldi r16,	253
st x+,r16
ldi r16,	253
st x+,r16
ldi r16,	252
st x+,r16
ldi r16,	252
st x+,r16
ldi r16,	251
st x+,r16
ldi r16,	250
st x+,r16
ldi r16,	249
st x+,r16
ldi r16,	249
st x+,r16
ldi r16,	248
st x+,r16
ldi r16,	247
st x+,r16
ldi r16,	245
st x+,r16
ldi r16,	244
st x+,r16
ldi r16,	243
st x+,r16
ldi r16,	242
st x+,r16
ldi r16,	240
st x+,r16
ldi r16,	239
st x+,r16
ldi r16,	238
st x+,r16
ldi r16,	236
st x+,r16
ldi r16,	234
st x+,r16
ldi r16,	233
st x+,r16
ldi r16,	231
st x+,r16
ldi r16,	229
st x+,r16
ldi r16,	227
st x+,r16
ldi r16,	225
st x+,r16
ldi r16,	223
st x+,r16
ldi r16,	221
st x+,r16
ldi r16,	219
st x+,r16
ldi r16,	217
st x+,r16
ldi r16,	215
st x+,r16
ldi r16,	212
st x+,r16
ldi r16,	210
st x+,r16
ldi r16,	208
st x+,r16
ldi r16,	205
st x+,r16
ldi r16,	203
st x+,r16
ldi r16,	200
st x+,r16
ldi r16,	198
st x+,r16
ldi r16,	195
st x+,r16
ldi r16,	192
st x+,r16
ldi r16,	190
st x+,r16
ldi r16,	187
st x+,r16
ldi r16,	184
st x+,r16
ldi r16,	181
st x+,r16
ldi r16,	178
st x+,r16
ldi r16,	176
st x+,r16
ldi r16,	173
st x+,r16
ldi r16,	170
st x+,r16
ldi r16,	167
st x+,r16
ldi r16,	164
st x+,r16
ldi r16,	161
st x+,r16
ldi r16,	158
st x+,r16
ldi r16,	155
st x+,r16
ldi r16,	152
st x+,r16
ldi r16,	149
st x+,r16
ldi r16,	146
st x+,r16
ldi r16,	143
st x+,r16
ldi r16,	139
st x+,r16
ldi r16,	136
st x+,r16
ldi r16,	133
st x+,r16
ldi r16,	130
st x+,r16
ldi r16,	127
st x+,r16
ldi r16,	124
st x+,r16
ldi r16,	121
st x+,r16
ldi r16,	118
st x+,r16
ldi r16,	115
st x+,r16
ldi r16,	111
st x+,r16
ldi r16,	108
st x+,r16
ldi r16,	105
st x+,r16
ldi r16,	102
st x+,r16
ldi r16,	99
st x+,r16
ldi r16,	96
st x+,r16
ldi r16,	93
st x+,r16
ldi r16,	90
st x+,r16
ldi r16,	87
st x+,r16
ldi r16,	84
st x+,r16
ldi r16,	81
st x+,r16
ldi r16,	78
st x+,r16
ldi r16,	76
st x+,r16
ldi r16,	73
st x+,r16
ldi r16,	70
st x+,r16
ldi r16,	67
st x+,r16
ldi r16,	64
st x+,r16
ldi r16,	62
st x+,r16
ldi r16,	59
st x+,r16
ldi r16,	56
st x+,r16
ldi r16,	54
st x+,r16
ldi r16,	51
st x+,r16
ldi r16,	49
st x+,r16
ldi r16,	46
st x+,r16
ldi r16,	44
st x+,r16
ldi r16,	42
st x+,r16
ldi r16,	39
st x+,r16
ldi r16,	37
st x+,r16
ldi r16,	35
st x+,r16
ldi r16,	33
st x+,r16
ldi r16,	31
st x+,r16
ldi r16,	29
st x+,r16
ldi r16,	27
st x+,r16
ldi r16,	25
st x+,r16
ldi r16,	23
st x+,r16
ldi r16,	21
st x+,r16
ldi r16,	20
st x+,r16
ldi r16,	18
st x+,r16
ldi r16,	16
st x+,r16
ldi r16,	15
st x+,r16
ldi r16,	14
st x+,r16
ldi r16,	12
st x+,r16
ldi r16,	11
st x+,r16
ldi r16,	10
st x+,r16
ldi r16,	9
st x+,r16
ldi r16,	7
st x+,r16
ldi r16,	6
st x+,r16
ldi r16,	5
st x+,r16
ldi r16,	5
st x+,r16
ldi r16,	4
st x+,r16
ldi r16,	3
st x+,r16
ldi r16,	2
st x+,r16
ldi r16,	2
st x+,r16
ldi r16,	1
st x+,r16
ldi r16,	1
st x+,r16
ldi r16,	1
st x+,r16
ldi r16,	0
st x+,r16
ldi r16,	0
st x+,r16
ldi r16,	0
st x+,r16
ldi r16,	0
st x+,r16
ldi r16,	0
st x+,r16
ldi r16,	0
st x+,r16
ldi r16,	0
st x+,r16
ldi r16,	1
st x+,r16
ldi r16,	1
st x+,r16
ldi r16,	1
st x+,r16
ldi r16,	2
st x+,r16
ldi r16,	2
st x+,r16
ldi r16,	3
st x+,r16
ldi r16,	4
st x+,r16
ldi r16,	5
st x+,r16
ldi r16,	5
st x+,r16
ldi r16,	6
st x+,r16
ldi r16,	7
st x+,r16
ldi r16,	9
st x+,r16
ldi r16,	10
st x+,r16
ldi r16,	11
st x+,r16
ldi r16,	12
st x+,r16
ldi r16,	14
st x+,r16
ldi r16,	15
st x+,r16
ldi r16,	16
st x+,r16
ldi r16,	18
st x+,r16
ldi r16,	20
st x+,r16
ldi r16,	21
st x+,r16
ldi r16,	23
st x+,r16
ldi r16,	25
st x+,r16
ldi r16,	27
st x+,r16
ldi r16,	29
st x+,r16
ldi r16,	31
st x+,r16
ldi r16,	33
st x+,r16
ldi r16,	35
st x+,r16
ldi r16,	37
st x+,r16
ldi r16,	39
st x+,r16
ldi r16,	42
st x+,r16
ldi r16,	44
st x+,r16
ldi r16,	46
st x+,r16
ldi r16,	49
st x+,r16
ldi r16,	51
st x+,r16
ldi r16,	54
st x+,r16
ldi r16,	56
st x+,r16
ldi r16,	59
st x+,r16
ldi r16,	62
st x+,r16
ldi r16,	64
st x+,r16
ldi r16,	67
st x+,r16
ldi r16,	70
st x+,r16
ldi r16,	73
st x+,r16
ldi r16,	76
st x+,r16
ldi r16,	78
st x+,r16
ldi r16,	81
st x+,r16
ldi r16,	84
st x+,r16
ldi r16,	87
st x+,r16
ldi r16,	90
st x+,r16
ldi r16,	93
st x+,r16
ldi r16,	96
st x+,r16
ldi r16,	99
st x+,r16
ldi r16,	102
st x+,r16
ldi r16,	105
st x+,r16
ldi r16,	108
st x+,r16
ldi r16,	111
st x+,r16
ldi r16,	115
st x+,r16
ldi r16,	118
st x+,r16
ldi r16,	121
st x+,r16
ldi r16,	124
st x+,r16

ret
