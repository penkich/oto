;---------------------------
;freq439.asm
; 2019-04-03 by penkich
;---------------------------
freq439:           ; 14
    cpi r21,'a'    ; 1
	breq a439_0    ; 1/2

    cpi r21,'b'    ; 1
	breq b439_0    ; 1/2

    cpi r21,'h'    ; 1
	breq h439_0    ; 1/2

    cpi r21,'c'    ; 1
 	breq c439_0    ; 1/2

    cpi r21,'C'    ; 1
	breq Cis439_0  ; 1/2

    cpi r21,'d'    ; 1
	breq d439_0    ; 1/2

    cpi r21,'D'    ; 1
	breq dis439_0  ; 1/2

    cpi r21,'e'    ; 1
	breq e439_0    ; 1/2

    cpi r21,'f'    ; 1
	breq f439_0    ; 1/2

    cpi r21,'F'    ; 1
	breq fis439_0  ; 1/2

    cpi r21,'g'    ; 1
	breq g439_0    ; 1/2

    cpi r21,'G'    ; 1
	breq gis439_0  ; 1/2

a439_0:
   jmp a439          ; 3 / 14 + 3 + 3     = 20
b439_0:
   jmp b439          ; 3 / 14 + 2 + 3 + 3 = 22
h439_0:
   jmp h439          ; 3 /                = 24
c439_0:
   jmp c439          ; 3 /                = 26
cis439_0:
   jmp cis439        ; 3 /                = 28
d439_0:
   jmp d439          ; 3 /                = 30
dis439_0:
   jmp dis439        ; 3 /                = 32
e439_0:
   jmp e439          ; 3 /                = 34
f439_0:
   jmp f439          ; 3 /                = 36
fis439_0:
   jmp fis439        ; 3 /                = 38
g439_0:
   jmp g439          ; 3 /                = 40
gis439_0:
   jmp gis439        ; 3 /                = 42

;--------------------------------------
;a439 27.4375Hz 364464.692482916
;--------------------------------------
a439:
    cpi flag,1       ; 1
	breq a439_led    ; 1/2
; カウント値をセット（上位、下位バイト）
; Y = 20
; X = 2Y + 385559 -clk
; X = 40 + 385559 - 364465
; X = 21134 (0h528E)
 
    ldi r17, 0x52    ; 1
	ldi r18, 0x8e    ; 1
	sts tcnt1H, r17  ; 2
	sts tcnt1L, r18  ; 2

;  プリスケーラ　1
    ldi r17, 0x01    ; 1
	sts tccr1b, r17  ; 2
; 20 + 2 + 43573 + 9 = 43604
; 20 + 2 + (65536 - X) +9

    ldi flag,1       ;

    jmp end439       ;

a439_led:
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
    jmp end439
;--------------------------------------
;b439 29.0690186514832Hz 344008.861114057clk
;--------------------------------------
b439: 
    cpi flag,1       ; 1
	breq b439_led         ; 1/2

; カウント値をセット（上位、下位バイト）
; Y = 22
; X = 2Y + 385559 -clk
; X = 44 + 385559 - 344009
; X = 41594 (0hA27A)

    ldi r17, 0xa2    ; 1
	ldi r18, 0x7a    ; 1
	sts tcnt1H, r17  ; 2
	sts tcnt1L, r18  ; 2

;  プリスケーラ　1
    ldi r17, 0x01    ; 1
	sts tccr1b, r17  ; 2
;
    ldi flag,1       ;

    jmp end439 ;

b439_led:
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
    jmp end439
;--------------------------------------
;h439 30.7975524504884Hz 324701.127340443clk
;--------------------------------------
h439: 
    cpi flag,1       ; 1
	breq h439_led         ; 1/2

; カウント値をセット（上位、下位バイト）
; Y = 24
; X = 2Y + 385559 -clk
; X = 48 + 385559 - 324701
; X = 60906 (0hEDEA)
    ldi r17, 0xed    ; 1
	ldi r18, 0xea    ; 1
	sts tcnt1H, r17  ; 2
	sts tcnt1L, r18  ; 2

;  プリスケーラ　1
    ldi r17, 0x01    ; 1
	sts tccr1b, r17  ; 2

    ldi flag,1       ;

    jmp end439    ;

h439_led:
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
    jmp end439
;--------------------------------------
;c439 32.6288702178872Hz 306477.053395431clk
;--------------------------------------
c439: 
    cpi flag,1       ; 1
	breq c439_led         ; 1/2

; カウント値をセット（上位、下位バイト）
; Y = 26
; X = 2Y + 254476 -clk
; X = 52 + 65536 + 254476 + 12 - 306477
; X = 13599 (0h351F)
    ldi r17, 0x35    ; 1
	ldi r18, 0x1F    ; 1
	sts tcnt1H, r17  ; 2
	sts tcnt1L, r18  ; 2

;  プリスケーラ　1
    ldi r17, 0x01    ; 1
	sts tccr1b, r17  ; 2

    ldi flag,1       ;

    jmp end439    ;

c439_led:
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
    jmp end439
;--------------------------------------
;cis439 34.5690838064906Hz 289275.818126323clk
;--------------------------------------
cis439:
    cpi flag,1       ; 1
	breq cis439_led   ; 1/2

; Y = 28
; X = 2Y + 254476 -clk
; X = 56 + 65536 + 254476 + 12 - 289276
; X = 30804 (0h7854)

    ldi r17, 0x78    ; 1
	ldi r18, 0x54    ; 1
	sts tcnt1H, r17  ; 2
	sts tcnt1L, r18  ; 2

;  プリスケーラ　1
    ldi r17, 0x01    ; 1
	sts tccr1b, r17  ; 2

    ldi flag,1       ;

    jmp end439    ;

cis439_led:
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
    jmp end439
;--------------------------------------
;d439 36.6246684987903Hz 273040.014009418clk
;--------------------------------------
d439:
    cpi flag,1      ; 1
	breq d439_led   ; 1/2

; カウント値をセット（上位、下位バイト）
; Y = 30
; X = 2Y + 254476 -clk
; X = 60 + 65536 + 254476 + 12 - 273040
; X = 47044 (0hB7C4)

    ldi r17, 0xb7    ; 1
	ldi r18, 0xc4    ; 1
	sts tcnt1H, r17  ; 2
	sts tcnt1L, r18  ; 2

;  プリスケーラ　1
    ldi r17, 0x01    ; 1
	sts tccr1b, r17  ; 2

    ldi flag,1       ;

    jmp end439    ;

d439_led:
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
    jmp end439
;--------------------------------------
;dis439 38.8024846176118Hz 257715.455557739clk
;--------------------------------------
dis439:
    cpi flag,1       ; 1
    breq dis439_led  ; 1/2

; カウント値をセット（上位、下位バイト）
; Y = 32
; X = 2Y + 254476 -clk
; X = 64 + 65536 + 254476 + 12 - 257715
; X = 62373 (0hF3A5)
    ldi r17, 0xf3    ; 1
    ldi r18, 0xa5    ; 1
    sts tcnt1H, r17  ; 2
    sts tcnt1L, r18  ; 2

;  プリスケーラ　1
    ldi r17, 0x01    ; 1
    sts tccr1b, r17  ; 2

    ldi flag,1       ;
    jmp end439    ;

dis439_led:
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
    jmp end439
;--------------------------------------
;e439 41.109800421804Hz 243250.998482011clk
;--------------------------------------
e439:
    cpi flag,1       ; 1
	breq e439_led    ; 1/2

; カウント値をセット（上位、下位バイト）
; Y = 34
; X = 2 + 34 + 65536 + 9 + 188940 + 34 - 243250
; X = 11305 (0x2C29)

    ldi r17, 0x2c    ; 1
	ldi r18, 0x29    ; 1
	sts tcnt1H, r17  ; 2
	sts tcnt1L, r18  ; 2

;  プリスケーラ　1
    ldi r17, 0x01    ; 1
	sts tccr1b, r17  ; 2

    ldi flag,1       ;

    jmp end439    ;

e439_led:
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
    jmp end439
;--------------------------------------
;f439 43.5543163633775Hz 229598.369001344clk
;--------------------------------------
f439:
    cpi flag,1       ; 1
	breq f439_led   ; 1/2

; カウント値をセット（上位、下位バイト）
; Y = 36
; X = 2 + 36 + 65536 + 9 + 188940 + 36 - 229598
; X = 24961 (0x6181)

    ldi r17, 0x61    ; 1
	ldi r18, 0x81    ; 1
	sts tcnt1H, r17  ; 2
	sts tcnt1L, r18  ; 2

;  プリスケーラ　1
    ldi r17, 0x01    ; 1
	sts tccr1b, r17  ; 2

    ldi flag,1       ;

    jmp end439    ;

f439_led:
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
    jmp end439
;--------------------------------------
;fis439 46.1441907870476Hz 216712.002733981clk
;--------------------------------------
fis439:
    cpi flag,1       ; 1
	breq fis439_led   ; 1/2

; カウント値をセット（上位、下位バイト）
; Y = 38
; X = 2 + 38 + 65536 + 9 + 188940 + 38 - 216712
; X = 37851 (0x93DB)

    ldi r17, 0x93    ; 1
	ldi r18, 0xdb    ; 1
	sts tcnt1H, r17  ; 2
	sts tcnt1L, r18  ; 2

;  プリスケーラ　1
    ldi r17, 0x01    ; 1
	sts tccr1b, r17  ; 2

    ldi flag,1       ;

    jmp end439    ;

fis439_led:
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
    jmp end439
;--------------------------------------
;g439 48.8880671579511Hz 204548.89263041
;--------------------------------------
g439:
    cpi flag,1       ; 1
	breq g439_led   ; 1/2

; カウント値をセット（上位、下位バイト）
; Y = 40
; X = 2 + 40 + 65536 + 9 + 188940 + 40 - 204549
; X = 50018 (0xC362)

    ldi r17, 0xc3    ; 1
	ldi r18, 0x62    ; 1
	sts tcnt1H, r17  ; 2
	sts tcnt1L, r18  ; 2

;  プリスケーラ　1
    ldi r17, 0x01    ; 1
	sts tccr1b, r17  ; 2

    ldi flag,1       ;

    jmp end439    ;

g439_led:
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
    jmp end439
;--------------------------------------
;gis439 51.7951029084079Hz 193068.445441329clk
;--------------------------------------
gis439:
    cpi flag,1       ; 1
	breq gis439_led   ; 1/2

; カウント値をセット（上位、下位バイト）
; Y = 42
; X = 2 + 42 + 65536 + 9 + 188940 + 42 - 193068
; X = 61503 (0xF03F)

    ldi r17, 0xf0    ; 1
	ldi r18, 0x3f    ; 1
	sts tcnt1H, r17  ; 2
	sts tcnt1L, r18  ; 2

;  プリスケーラ　1
    ldi r17, 0x01    ; 1
	sts tccr1b, r17  ; 2

    ldi flag,1       ;

    jmp end439    ;

gis439_led:
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
    jmp end439
;--------------------
;end439
;--------------------
end439:
	out sreg, r16
	reti
