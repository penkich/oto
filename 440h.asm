;---------------------------
;freq440.asm
; 2019-04-03 by penkich
;---------------------------
freq440:           ; 14
    cpi r21,'a'    ; 1
	breq a440_0    ; 1/2

    cpi r21,'b'    ; 1
	breq b440_0    ; 1/2

    cpi r21,'h'    ; 1
	breq h440_0    ; 1/2

    cpi r21,'c'    ; 1
 	breq c440_0    ; 1/2

    cpi r21,'C'    ; 1
	breq Cis440_0  ; 1/2

    cpi r21,'d'    ; 1
	breq d440_0    ; 1/2

    cpi r21,'D'    ; 1
	breq dis440_0  ; 1/2

    cpi r21,'e'    ; 1
	breq e440_0    ; 1/2

    cpi r21,'f'    ; 1
	breq f440_0    ; 1/2

    cpi r21,'F'    ; 1
	breq fis440_0  ; 1/2

    cpi r21,'g'    ; 1
	breq g440_0    ; 1/2

    cpi r21,'G'    ; 1
	breq gis440_0  ; 1/2

a440_0:
   jmp a440          ; 3 / 14 + 3 + 3     = 20
b440_0:
   jmp b440          ; 3 / 14 + 2 + 3 + 3 = 22
h440_0:
   jmp h440          ; 3 /                = 24
c440_0:
   jmp c440          ; 3 /                = 26
cis440_0:
   jmp cis440        ; 3 /                = 28
d440_0:
   jmp d440          ; 3 /                = 30
dis440_0:
   jmp dis440        ; 3 /                = 32
e440_0:
   jmp e440          ; 3 /                = 34
f440_0:
   jmp f440          ; 3 /                = 36
fis440_0:
   jmp fis440        ; 3 /                = 38
g440_0:
   jmp g440          ; 3 /                = 40
gis440_0:
   jmp gis440        ; 3 /                = 42

;--------------------------------------
;a440 27.5Hz 363636.363636364clk
;--------------------------------------
a440:
    cpi flag,1       ; 1
	breq a440_led    ; 1/2

; カウント値をセット（上位、下位バイト）
; 65536 - 0x55cb = 43573
;+7 
    ldi r17, 0x55    ; 1
	ldi r18, 0xd2    ; 1
	sts tcnt1H, r17  ; 2
	sts tcnt1L, r18  ; 2

;  プリスケーラ　1
    ldi r17, 0x01    ; 1
	sts tccr1b, r17  ; 2
; 20 + 2 + 43573 + 9 = 43604
; 20 + 2 + (65536 - X) +9

    ldi flag,1       ;

    jmp end440       ;

a440_led:
; カウント値をセット（上位、下位バイト）
; 65536 - 0x63c0 = 40000 x 8 = 320000
;
    ldi r17, 0x63    ; 1
	ldi r18, 0xc0    ; 1
	sts tcnt1H, r17  ; 2
	sts tcnt1L, r18  ; 2

;  プリスケーラ　8
    ldi r17, 0x02    ; 1
	sts tccr1b, r17  ; 2
; 20 + 3 + 320000 + 9 = 320032
; 43604 + 320032 = 363636
;
; 20 + 2 + (65536 -X ) + 9 + 320000 + 20 + 3 + 9 = clk
; X = 320000 + 2Y + 23 + 65536 -clk
; X = 2Y + 385559 -clk
; X = 40 + 385559 - 363636
; X = 21963 (0x55CB)

;  LED 点灯・消灯
    in r17, portc
	ldi r18, 0x00
	sbr r18, (1<<B_LED)
	eor r17, r18
	out P_LED, r17

    ldi flag,0
    jmp end440
;--------------------------------------
;b440 29.1352350948806Hz 343227.022793343clk
;--------------------------------------
b440: 
    cpi flag,1       ; 1
	breq b440_led         ; 1/2

; カウント値をセット（上位、下位バイト）
; Y = 22
; X = 2Y + 385559 -clk
; X = 44 + 385559 - 343227
; X = 42376 (0hA588)
;+7
    ldi r17, 0xa5    ; 1
	ldi r18, 0x8f    ; 1
	sts tcnt1H, r17  ; 2
	sts tcnt1L, r18  ; 2

;  プリスケーラ　1
    ldi r17, 0x01    ; 1
	sts tccr1b, r17  ; 2
;
    ldi flag,1       ;

    jmp end440 ;

b440_led:
; カウント値をセット（上位、下位バイト）
    ldi r17, 0x63    ; 1
	ldi r18, 0xc0    ; 1
	sts tcnt1H, r17  ; 2
	sts tcnt1L, r18  ; 2

;  プリスケーラ　8
    ldi r17, 0x02    ; 1
	sts tccr1b, r17  ; 2

;  LED 点灯・消灯
    in r17, portc
	ldi r18, 0x00
	sbr r18, (1<<B_LED)
	eor r17, r18
	out P_LED, r17

    ldi flag,0
    jmp end440
;--------------------------------------
;h440 30.8677063285078Hz 323963.170232851clk
;--------------------------------------
h440: 
    cpi flag,1       ; 1
	breq h440_led         ; 1/2

; カウント値をセット（上位、下位バイト）
; Y = 24
; X = 2Y + 385559 -clk
; X = 48 + 385559 - 323963
; X = 61644 (0hF0CD)
;+6
    ldi r17, 0xf0    ; 1
	ldi r18, 0xd3    ; 1
	sts tcnt1H, r17  ; 2
	sts tcnt1L, r18  ; 2

;  プリスケーラ　1
    ldi r17, 0x01    ; 1
	sts tccr1b, r17  ; 2

    ldi flag,1       ;

    jmp end440    ;

h440_led:
; カウント値をセット（上位、下位バイト）
    ldi r17, 0x63    ; 1
	ldi r18, 0xc0    ; 1
	sts tcnt1H, r17  ; 2
	sts tcnt1L, r18  ; 2

;  プリスケーラ　8
    ldi r17, 0x02    ; 1
	sts tccr1b, r17  ; 2

;  LED 点灯・消灯
    in r17, portc
	ldi r18, 0x00
	sbr r18, (1<<B_LED)
	eor r17, r18
	out P_LED, r17

    ldi flag,0
    jmp end440
;--------------------------------------
;c440 32.7031956625748Hz 305780.514637714clk
;--------------------------------------
c440: 
    cpi flag,1       ; 1
	breq c440_led         ; 1/2

; カウント値をセット（上位、下位バイト）
; Y = 26
; X = 2Y + 254476 -clk
; X = 52 + 65536 + 254476 + 12 - 305780
; X = 14296 (0h37D8)
;+5
    ldi r17, 0x37    ; 1
	ldi r18, 0xdd    ; 1
	sts tcnt1H, r17  ; 2
	sts tcnt1L, r18  ; 2

;  プリスケーラ　1
    ldi r17, 0x01    ; 1
	sts tccr1b, r17  ; 2

    ldi flag,1       ;

    jmp end440    ;

c440_led:
; カウント値をセット（上位、下位バイト）
; 65536 - 0x83c0 = 31808 x 8 = 254464
    ldi r17, 0x83    ; 1
	ldi r18, 0xc0    ; 1
	sts tcnt1H, r17  ; 2
	sts tcnt1L, r18  ; 2

;  プリスケーラ　8
    ldi r17, 0x02    ; 1
	sts tccr1b, r17  ; 2

;  LED 点灯・消灯
    in r17, portc
	ldi r18, 0x00
	sbr r18, (1<<B_LED)
	eor r17, r18
	out P_LED, r17

    ldi flag,0
    jmp end440
;--------------------------------------
;cis440 34.647828872109Hz 288618.373085127clk
;--------------------------------------
cis440:
    cpi flag,1       ; 1
	breq cis440_led   ; 1/2

; Y = 28
; X = 2Y + 254476 -clk
; X = 56 + 65536 + 254476 + 12 - 288618
; X = 31462 (0h7AE6)
;+6
    ldi r17, 0x7a    ; 1
	ldi r18, 0xec    ; 1
	sts tcnt1H, r17  ; 2
	sts tcnt1L, r18  ; 2

;  プリスケーラ　1
    ldi r17, 0x01    ; 1
	sts tccr1b, r17  ; 2

    ldi flag,1       ;

    jmp end440    ;

cis440_led:
; カウント値をセット（上位、下位バイト）

    ldi r17, 0x83    ; 1
	ldi r18, 0xc0    ; 1
	sts tcnt1H, r17  ; 2
	sts tcnt1L, r18  ; 2

;  プリスケーラ　8
    ldi r17, 0x02    ; 1
	sts tccr1b, r17  ; 2

;  LED 点灯・消灯
    in r17, portc
	ldi r18, 0x00
	sbr r18, (1<<B_LED)
	eor r17, r18
	out P_LED, r17

    ldi flag,0
    jmp end440
;--------------------------------------
;d440 36.7080959896759Hz 272419.468523033clk
;--------------------------------------
d440:
    cpi flag,1      ; 1
	breq d440_led   ; 1/2

; カウント値をセット（上位、下位バイト）
; Y = 30
; X = 2Y + 254476 -clk
; X = 60 + 65536 + 254476 + 12 - 272419
; X = 47665 (0hBA31)

    ldi r17, 0xba    ; 1
	ldi r18, 0x31    ; 1
	sts tcnt1H, r17  ; 2
	sts tcnt1L, r18  ; 2

;  プリスケーラ　1
    ldi r17, 0x01    ; 1
	sts tccr1b, r17  ; 2

    ldi flag,1       ;

    jmp end440    ;

d440_led:
; カウント値をセット（上位、下位バイト）
    ldi r17, 0x83    ; 1
	ldi r18, 0xc0    ; 1
	sts tcnt1H, r17  ; 2
	sts tcnt1L, r18  ; 2

;  プリスケーラ　8
    ldi r17, 0x02    ; 1
	sts tccr1b, r17  ; 2

;  LED 点灯・消灯
    in r17, portc
	ldi r18, 0x00
	sbr r18, (1<<B_LED)
	eor r17, r18
	out P_LED, r17

    ldi flag,0
    jmp end440
;--------------------------------------
;dis440 38.8908729652601Hz 257129.73861329clk
;--------------------------------------
dis440:
    cpi flag,1       ; 1
    breq dis440_led  ; 1/2

; カウント値をセット（上位、下位バイト）
; Y = 32
; X = 2Y + 254476 -clk
; X = 64 + 65536 + 254476 + 12 - 257130
; X = 62958 (0hf5ee)
;+4
    ldi r17, 0xf5    ; 1
    ldi r18, 0xf2    ; 1
    sts tcnt1H, r17  ; 2
    sts tcnt1L, r18  ; 2

;  プリスケーラ　1
    ldi r17, 0x01    ; 1
    sts tccr1b, r17  ; 2

    ldi flag,1       ;
    jmp end440    ;

dis440_led:
; カウント値をセット（上位、下位バイト）
    ldi r17, 0x83    ; 1
    ldi r18, 0xc0    ; 1
    sts tcnt1H, r17  ; 2
    sts tcnt1L, r18  ; 2

;  プリスケーラ　8
    ldi r17, 0x02    ; 1
    sts tccr1b, r17  ; 2

;  LED 点灯・消灯
    in r17, portc
    ldi r18, 0x00
    sbr r18, (1<<B_LED)
    eor r17, r18
    out P_LED, r17

    ldi flag,0
    jmp end440
;--------------------------------------
;e440 41.2034446141087Hz 242698.155303643clk
;--------------------------------------
e440:
    cpi flag,1       ; 1
	breq e440_led    ; 1/2

; カウント値をセット（上位、下位バイト）
; Y = 34
; 2 + 34(Y) + 65536 - X + 9 + 188940 + 34(Y) - 242698
; X = 11857 (0x2E51)
;+6

    ldi r17, 0x2e    ; 1
	ldi r18, 0x57    ; 1
	sts tcnt1H, r17  ; 2
	sts tcnt1L, r18  ; 2

;  プリスケーラ　1
    ldi r17, 0x01    ; 1
	sts tccr1b, r17  ; 2

    ldi flag,1       ;

    jmp end440    ;

e440_led:
; カウント値をセット（上位、下位バイト）
    ldi r17, 0xa3    ; 1
	ldi r18, 0xc0    ; 1
	sts tcnt1H, r17  ; 2
	sts tcnt1L, r18  ; 2

;  プリスケーラ　8
    ldi r17, 0x02    ; 1
	sts tccr1b, r17  ; 2

;  LED 点灯・消灯
    in r17, portc
	ldi r18, 0x00
	sbr r18, (1<<B_LED)
	eor r17, r18
	out P_LED, r17

    ldi flag,0
    jmp end440
;--------------------------------------
;f440 43.6535289291255Hz 229076.554526341clk
;--------------------------------------
f440:
    cpi flag,1       ; 1
	breq f440_led   ; 1/2

; カウント値をセット（上位、下位バイト）
; Y = 36
; 2 + 36(Y) + 65536 - X + 9 + 188940 + 36(Y) - 229077
; X = 25482 (0x638A)

    ldi r17, 0x63    ; 1
	ldi r18, 0x8a    ; 1
	sts tcnt1H, r17  ; 2
	sts tcnt1L, r18  ; 2

;  プリスケーラ　1
    ldi r17, 0x01    ; 1
	sts tccr1b, r17  ; 2

    ldi flag,1       ;

    jmp end440    ;

f440_led:
; カウント値をセット（上位、下位バイト）
    ldi r17, 0xa3    ; 1
	ldi r18, 0xc0    ; 1
	sts tcnt1H, r17  ; 2
	sts tcnt1L, r18  ; 2

;  プリスケーラ　8
    ldi r17, 0x02    ; 1
	sts tccr1b, r17  ; 2

;  LED 点灯・消灯
    in r17, portc
	ldi r18, 0x00
	sbr r18, (1<<B_LED)
	eor r17, r18
	out P_LED, r17

    ldi flag,0
    jmp end440
;--------------------------------------
;fis440 46.2493028389543Hz 216219.47545504clk
;--------------------------------------
fis440:
    cpi flag,1       ; 1
	breq fis440_led   ; 1/2

; カウント値をセット（上位、下位バイト）
; Y = 38
; 2 + 38(Y) + 65536 - X + 9 + 188940 + 38(Y) - 216219
; X = 38344 (0x95C8)
;
    nop
    ldi r17, 0x95    ; 1
	ldi r18, 0xd0    ; 1
	sts tcnt1H, r17  ; 2
	sts tcnt1L, r18  ; 2

;  プリスケーラ　1
    ldi r17, 0x01    ; 1
	sts tccr1b, r17  ; 2

    ldi flag,1       ;

    jmp end440    ;

fis440_led:
; カウント値をセット（上位、下位バイト）
    ldi r17, 0xa3    ; 1
	ldi r18, 0xc0    ; 1
	sts tcnt1H, r17  ; 2
	sts tcnt1L, r18  ; 2

;  プリスケーラ　8
    ldi r17, 0x02    ; 1
	sts tccr1b, r17  ; 2

;  LED 点灯・消灯
    in r17, portc
	ldi r18, 0x00
	sbr r18, (1<<B_LED)
	eor r17, r18
	out P_LED, r17

    ldi flag,0
    jmp end440
;--------------------------------------
;g440 48.9994294977187Hz 204084.008783522clk
;--------------------------------------
g440:
    cpi flag,1       ; 1
	breq g440_led   ; 1/2

; カウント値をセット（上位、下位バイト）
; Y = 40
; 2 + 40(Y) + 65536 - X + 9 + 188940 + 40(Y) - 204084
; X = 50483 (0xC533)

    ldi r17, 0xc5    ; 1
	ldi r18, 0x33    ; 1
	sts tcnt1H, r17  ; 2
	sts tcnt1L, r18  ; 2

;  プリスケーラ　1
    ldi r17, 0x01    ; 1
	sts tccr1b, r17  ; 2

    ldi flag,1       ;

    jmp end440    ;

g440_led:
; カウント値をセット（上位、下位バイト）
    ldi r17, 0xa3    ; 1
	ldi r18, 0xc0    ; 1
	sts tcnt1H, r17  ; 2
	sts tcnt1L, r18  ; 2

;  プリスケーラ　8
    ldi r17, 0x02    ; 1
	sts tccr1b, r17  ; 2

;  LED 点灯・消灯
    in r17, portc
	ldi r18, 0x00
	sbr r18, (1<<B_LED)
	eor r17, r18
	out P_LED, r17

    ldi flag,0
    jmp end440
;--------------------------------------
;gis440 51.9130871974931Hz 192629.653519872clk
;--------------------------------------
gis440:
    cpi flag,1       ; 1
	breq gis440_led   ; 1/2

; カウント値をセット（上位、下位バイト）
; Y = 42
; 2 + 42(Y) + 65536 - X + 9 + 188940 + 42(Y) - 192629
; X = 61942 (0xF1F6)

    ldi r17, 0xf1    ; 1
	ldi r18, 0xf6    ; 1
	sts tcnt1H, r17  ; 2
	sts tcnt1L, r18  ; 2

;  プリスケーラ　1
    ldi r17, 0x01    ; 1
	sts tccr1b, r17  ; 2

    ldi flag,1       ;

    jmp end440    ;

gis440_led:
; カウント値をセット（上位、下位バイト）
; 65536 - 0xa3c0 = 23616
; 23616 x 8 = 188928
; 188928 + 9(set) = 188937
; 188937 + 3(breq) = 188940
; 188940 + 42(Y)
    ldi r17, 0xa3    ; 1
	ldi r18, 0xc0    ; 1
	sts tcnt1H, r17  ; 2
	sts tcnt1L, r18  ; 2

;  プリスケーラ　8
    ldi r17, 0x02    ; 1
	sts tccr1b, r17  ; 2

;  LED 点灯・消灯
    in r17, portc
	ldi r18, 0x00
	sbr r18, (1<<B_LED)
	eor r17, r18
	out P_LED, r17

    ldi flag,0
    jmp end440
;--------------------
;end440
;--------------------
end440:
	out sreg, r16
	reti
