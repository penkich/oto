; 
; 
; 割り込みで基準音を生成する
; A0-H0,C1-G#1
; I2CやUSARTでコントロールしたい。
; 2019-03-30 penkich
;

.include "m328def.inc"
.equ B_LED = 0
.equ P_LED = PORTC
.def flag = r20

; 7セグの表示データ
.equ disp_0 = 0xfc
.equ disp_1 = 0x60
.equ disp_2 = 0xda
.equ disp_3 = 0xf2
.equ disp_4 = 0x66
.equ disp_5 = 0xb6
.equ disp_6 = 0xbe
.equ disp_7 = 0xe4
.equ disp_8 = 0xfe
.equ disp_9 = 0xe6
.equ disp_sharp = 0b11000110
.equ disp_A = 0b11101110
.equ disp_b = 0b00111110

.cseg
.org 0x0000
start:
    jmp reset

; 割り込みアドレス 0x001A  TIMER1 OVF for ATmega328P
.org 0x001A
iovf1:
    in r16, sreg     ; 1 clock

; プリスケーラ＝０でカウンタ停止
    ldi r17, 0x00    ; 1 
	sts tccr1b, r17  ; 2

    cpi r22,'8'      ; 1
	breq freq438_0   ; 1/2

	cpi r22,'9'      ; 1
	breq freq439_0   ; 1/2

	cpi r22,'0'      ; 1
	breq freq440_0   ; 1/2

	cpi r22,'1'      ; 1
	breq freq441_0   ; 1/2

	cpi r22,'2'      ; 1
	breq freq442_0   ; 1/2

freq438_0:
    nop
	nop
	nop
	nop
    jmp freq438      ; 3   /  7 + 3 + 4 = 14

freq439_0:
    nop
	nop
    jmp freq439      ; 3   /  9 + 3 + 2 = 14
freq440_0:
    jmp freq440      ; 3   / 11 + 3 = 14

freq441_0:
    jmp freq441      ; 3   / 13 + 3 = 16

freq442_0:
    jmp freq442      ; 3   / 15 + 3 = 18

.include "438h.asm"
.include "439h.asm"
.include "440h.asm"
.include "441h.asm"
.include "442h.asm"

reset:
; 割り込み禁止
    cli
	ldi r21,'a'
    ldi r22,'0'
    ldi flag,0

	ldi r17, 0b11111111
	ldi r18, 0b00001111
	out ddrc, r17
	out portc, r18

; USART initialize 115.2k bps
;    ldi r17, 10
;    sts UBRR0L, r17
;	ldi r17, 0
;	sts UBRR0H, r17
;
;    lds r17, UCSR0C
;	sbr r17, ((1<<UCSZ01)+(1<<UCSZ00))
;	sts UCSR0C, r17
;
;	lds r17, UCSR0B
;	sbr r17, ((1<<RXEN0)+(1<<TXEN0))
;
;	sts UCSR0B, r17

; timer
    ldi r17, 0x01
	ldi r18, 0xff
	sts tcnt1H, r17
	sts tcnt1L, r18

    ldi r17, 0x01
	sts tccr1b, r17

    lds r17, timsk1
	sbr r17, (1<<toie1)
	sts timsk1, r17

;uarts:
;    lds r17, UCSR0A
;	sbrs r17, UDRE0
;	rjmp uarts
;	sts UDR0, r21
;	ret

;----------------------------
; i2c master set up
; slave HT16K33 i2c adress 0h70(0he0)
;----------------------------
i2c:
    ldi r16, 4
	sts TWBR, r16    ; ビットレートレジスタ=4
	ldi r16, 0x10
	sts TWSR, r16    ; プリスケーラ=16

    ldi r16, 0x00
	sbr r16, (1<<TWEN)    ; I2c 許可
	sts TWCR, r16


; 割り込み許可
	sei

main:
;    lds r17, UCSR0A
;	sbrs r17, RXC0
;	rjmp main
;	lds r21, UDR0
;    rcall uarts
;
;    cpi r21, 'A'
;	brlo next
;	mov r23, r21
;    rjmp main
;
;next:
;    mov r22, r21
;	mov r21, r23

    rcall tstrt
	rcall slawr
    ldi r17, 0x21
	rcall sdata

    rcall tstrt
	rcall slawr
	ldi r17, 0xea
	rcall sdata

    rcall tstrt
	rcall slawr
	ldi r17, 0x06 ; 周波数表示LED
	rcall sdata
	ldi r17, 0b00100000
	rcall sdata

    rcall tstrt
	rcall slawr
	ldi r17, 0x02 ; 音名表示７セグ(A-G)
	rcall sdata
	ldi r17, disp_sharp
	rcall sdata

    rcall tstrt
	rcall slawr
	ldi r17, 0x04 ; 音域表示７セグ(0-9)
	rcall sdata
	ldi r17, disp_7
	rcall sdata

    rcall tstrt
	rcall slawr
	ldi r17, 0x00 ; 真ん中７セグ(0-9)
	rcall sdata
	ldi r17, disp_2
	rcall sdata

    rcall tstrt
	rcall slawr
	ldi r17, 0x81
	rcall sdata

    rcall tstop
    rjmp main

;---------------------------
; i2c スタートコンディション
;---------------------------
tstrt:
    lds r16, twcr
	sbr r16, ((1<<twint)+(1<<twsta))
	sts twcr, r16

tstrt01:
    lds r16, twcr
	sbrs r16, twint
	rjmp tstrt01

    lds r16, twsr
	andi r16, 0xf8
    cpi r16, 0x08
	brne tstrt10

tstrt02:
    ret

tstrt10:
    nop
	rjmp tstrt02

;---------------------------
; SLA+W 送出
;---------------------------
slawr:
    ldi r16, 0xe0
	sts twdr, r16

	lds r16, twcr
	cbr r16, (1<<twsta)
	sbr r16, (1<<twint)
	sts twcr, r16

slawr01:
    lds r16, twcr
	sbrs r16, twint
	rjmp slawr01

	lds r16,twsr
	andi r16, 0xf8

	cpi r16, 0x18
	brne slawr10
slawr02:
    ret

slawr10:
    nop
	rjmp slawr02
;---------------------------
; r17: 書き込みデータ
;---------------------------
sdata:
    sts twdr, r17
	lds r16, twcr
	sbr r16, (1<<twint)
	sts twcr, r16

sdata01:
    lds r16, twcr
	sbrs r16, twint
	rjmp sdata01

    lds r16, twsr
	andi r16, 0xf8
	cpi r16, 0x28
	brne sdata10

sdata0f:
    ret

sdata10:
    nop
	rjmp sdata0f
;---------------------------
;
;---------------------------
tstop:
    lds r16, twcr
	sbr r16, ((1<<twint)+(1<<twsto))
	sts twcr, r16
	ret

;---------------------------
; delay10us
;---------------------------
                    ;rcall  ;3
delay10us:
    push r16        ;2
    in r16,sreg     ;1
    push r16        ;2
    ldi r16,20      ;1
loop_10us:
    nop             ;1
    nop             ;1
    dec r16         ;1
    brne loop_10us  ;1/2
    pop r16         ;2
    out sreg,r16    ;1
    pop r16         ;2
    nop             ;1
    nop             ;1
    nop             ;1
    ret             ;4
