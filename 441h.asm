;---------------------------
;freq441.asm
; 2019-04-03 by penkich
;---------------------------
freq441:           ; 16 
    cpi r21,'a'    ; 1
	breq a441_0    ; 1/2

    cpi r21,'b'    ; 1
	breq b441_0    ; 1/2

    cpi r21,'h'    ; 1
	breq h441_0    ; 1/2

    cpi r21,'c'    ; 1
 	breq c441_0    ; 1/2

    cpi r21,'C'    ; 1
	breq Cis441_0  ; 1/2

    cpi r21,'d'    ; 1
	breq d441_0    ; 1/2

    cpi r21,'D'    ; 1
	breq dis441_0  ; 1/2

    cpi r21,'e'    ; 1
	breq e441_0    ; 1/2

    cpi r21,'f'    ; 1
	breq f441_0    ; 1/2

    cpi r21,'F'    ; 1
	breq fis441_0  ; 1/2

    cpi r21,'g'    ; 1
	breq g441_0    ; 1/2

    cpi r21,'G'    ; 1
	breq gis441_0  ; 1/2

a441_0:
   jmp a441          ; 3 / 16 + 3 + 3     = 22
b441_0:
   jmp b441          ; 3 / 16 + 2 + 3 + 3 = 24
h441_0:
   jmp h441          ; 3 /                = 26
c441_0:
   jmp c441          ; 3 /                = 28
cis441_0:
   jmp cis441        ; 3 /                = 30
d441_0:
   jmp d441          ; 3 /                = 32
dis441_0:
   jmp dis441        ; 3 /                = 34
e441_0:
   jmp e441          ; 3 /                = 36
f441_0:
   jmp f441          ; 3 /                = 38
fis441_0:
   jmp fis441        ; 3 /                = 40
g441_0:
   jmp g441          ; 3 /                = 42
gis441_0:
   jmp gis441        ; 3 /                = 44

;--------------------------------------
;a441 27.5625Hz 362811.79138322clk
;--------------------------------------
a441:
    cpi flag,1       ; 1
	breq a441_led    ; 1/2
; カウント値をセット（上位、下位バイト）
; Y = 22
; X = 2Y + 385559 -clk
; X = 44 + 385559 - 362812
; X = 22791 (0h5907)
 
    ldi r17, 0x59    ; 1
	ldi r18, 0x07    ; 1
	sts tcnt1H, r17  ; 2
	sts tcnt1L, r18  ; 2

;  プリスケーラ　1
    ldi r17, 0x01    ; 1
	sts tccr1b, r17  ; 2
; 22 + 2 + 43573 + 9 = 43606
; 22 + 2 + (65536 - X) +9

    ldi flag,1       ;

    jmp end441       ;

a441_led:
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
; 22 + 3 + 320000 + 9 = 320034
; 43606 + 320034 = 363640
;
; 22 + 2 + (65536 -X ) + 9 + 320000 + 20 + 3 + 9 = clk
; X = 320000 + 2Y + 23 + 65536 -clk
; X = 2Y + 385559 -clk
; X = 44 + 385559 - 362812
; X = 22791 (0x5907)

;  LED 点灯・消灯
    in r17, portc
	ldi r18, 0x00
	sbr r18, (1<<B_LED)
	eor r17, r18
	out P_LED, r17

    ldi flag,0
    jmp end441
;--------------------------------------
;b441 29.2014515382781Hz 342448.730224651clk
;--------------------------------------
b441: 
    cpi flag,1       ; 1
	breq b441_led         ; 1/2

; カウント値をセット（上位、下位バイト）
; Y = 24
; X = 2Y + 385559 -clk
; X = 48 + 385559 - 342449
; X = 43158 (0hA896)

    ldi r17, 0xa8    ; 1
	ldi r18, 0x96    ; 1
	sts tcnt1H, r17  ; 2
	sts tcnt1L, r18  ; 2

;  プリスケーラ　1
    ldi r17, 0x01    ; 1
	sts tccr1b, r17  ; 2
;
    ldi flag,1       ;

    jmp end441 ;

b441_led:
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
    jmp end441
;--------------------------------------
;h441 30.9378602065271Hz 323228.559869511
;--------------------------------------
h441: 
    cpi flag,1       ; 1
	breq h441_led         ; 1/2

; カウント値をセット（上位、下位バイト）
; Y = 26
; X = 2Y + 385559 -clk
; X = 52 + 385559 - 323229
; X = 62382 (0hF3AE)
    ldi r17, 0xf3    ; 1
	ldi r18, 0xae    ; 1
	sts tcnt1H, r17  ; 2
	sts tcnt1L, r18  ; 2

;  プリスケーラ　1
    ldi r17, 0x01    ; 1
	sts tccr1b, r17  ; 2

    ldi flag,1       ;

    jmp end441    ;

h441_led:
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
    jmp end441
;--------------------------------------
;c441 32.7775211072625Hz 305087.134785928clk
;--------------------------------------
c441: 
    cpi flag,1       ; 1
	breq c441_led         ; 1/2

; カウント値をセット（上位、下位バイト）
; Y = 28
; X = 2Y + 254476 -clk
; X = 56 + 65536 + 254476 + 12 - 305087
; X = 14993 (0h3A91)
    ldi r17, 0x3a    ; 1
	ldi r18, 0x91    ; 1
	sts tcnt1H, r17  ; 2
	sts tcnt1L, r18  ; 2

;  プリスケーラ　1
    ldi r17, 0x01    ; 1
	sts tccr1b, r17  ; 2

    ldi flag,1       ;

    jmp end441    ;

c441_led:
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
    jmp end441
;--------------------------------------
;cis441 34.7265739377274Hz 287963.909654095clk
;--------------------------------------
cis441:
    cpi flag,1       ; 1
	breq cis441_led   ; 1/2

; Y = 30
; X = 2Y + 254476 -clk
; X = 60 + 65536 + 254476 + 12 - 287964
; X = 32120 (0h7d78)

    ldi r17, 0x7d    ; 1
	ldi r18, 0x78    ; 1
	sts tcnt1H, r17  ; 2
	sts tcnt1L, r18  ; 2

;  プリスケーラ　1
    ldi r17, 0x01    ; 1
	sts tccr1b, r17  ; 2

    ldi flag,1       ;

    jmp end441    ;

cis441_led:
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
    jmp end441
;--------------------------------------
;d441 36.7915234805616Hz 271801.737301892
;--------------------------------------
d441:
    cpi flag,1      ; 1
	breq d441_led   ; 1/2

; カウント値をセット（上位、下位バイト）
; Y = 32
; X = 2Y + 254476 -clk
; X = 64 + 65536 + 254476 + 12 - 271801
; X = 48287 (0hBC9F)

    ldi r17, 0xbc    ; 1
	ldi r18, 0x9f    ; 1
	sts tcnt1H, r17  ; 2
	sts tcnt1L, r18  ; 2

;  プリスケーラ　1
    ldi r17, 0x01    ; 1
	sts tccr1b, r17  ; 2

    ldi flag,1       ;

    jmp end441    ;

d441_led:
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
    jmp end441
;--------------------------------------
;dis441 38.9792613129084Hz 256546.677981514clk
;--------------------------------------
dis441:
    cpi flag,1       ; 1
    breq dis441_led  ; 1/2

; カウント値をセット（上位、下位バイト）
; Y = 34
; X = 2Y + 254476 -clk
; X = 68 + 65536 + 254476 + 12 - 256546
; X = 63546 (0hF83A)
    ldi r17, 0xf8    ; 1
    ldi r18, 0x3a    ; 1
    sts tcnt1H, r17  ; 2
    sts tcnt1L, r18  ; 2

;  プリスケーラ　1
    ldi r17, 0x01    ; 1
    sts tccr1b, r17  ; 2

    ldi flag,1       ;
    jmp end441    ;

dis441_led:
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
    jmp end441
;--------------------------------------
;e441 41.2970888064135Hz 242147.819350573clk
;--------------------------------------
e441:
    cpi flag,1       ; 1
	breq e441_led    ; 1/2

; カウント値をセット（上位、下位バイト）
; Y = 36
; X = 2 + 36 + 65536 + 9 + 188940 + 36 - 242148
; X = 12411 (0x307B)

    ldi r17, 0x30    ; 1
	ldi r18, 0x7b    ; 1
	sts tcnt1H, r17  ; 2
	sts tcnt1L, r18  ; 2

;  プリスケーラ　1
    ldi r17, 0x01    ; 1
	sts tccr1b, r17  ; 2

    ldi flag,1       ;

    jmp end441    ;

e441_led:
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
    jmp end441
;--------------------------------------
;f441 43.7527414948735Hz 228557.106556893clk
;--------------------------------------
f441:
    cpi flag,1       ; 1
	breq f441_led   ; 1/2

; カウント値をセット（上位、下位バイト）
; Y = 38
; X = 2 + 38 + 65536 + 9 + 188940 + 38 - 228557
; X = 26006 (0x6596)

    ldi r17, 0x65    ; 1
	ldi r18, 0x96    ; 1
	sts tcnt1H, r17  ; 2
	sts tcnt1L, r18  ; 2

;  プリスケーラ　1
    ldi r17, 0x01    ; 1
	sts tccr1b, r17  ; 2

    ldi flag,1       ;

    jmp end441    ;

f441_led:
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
    jmp end441
;--------------------------------------
;fis441 46.354414890861 215729.181859904clk
;--------------------------------------
fis441:
    cpi flag,1       ; 1
	breq fis441_led   ; 1/2

; カウント値をセット（上位、下位バイト）
; Y = 40
; X = 2 + 40 + 65536 + 9 + 188940 + 40 - 215729
; X = 38838 (0x97B6)

    ldi r17, 0x97    ; 1
	ldi r18, 0xb6    ; 1
	sts tcnt1H, r17  ; 2
	sts tcnt1L, r18  ; 2

;  プリスケーラ　1
    ldi r17, 0x01    ; 1
	sts tccr1b, r17  ; 2

    ldi flag,1       ;

    jmp end441    ;

fis441_led:
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
    jmp end441
;--------------------------------------
;g441 49.1107918374862Hz 203621.233253401clk
;--------------------------------------
g441:
    cpi flag,1       ; 1
	breq g441_led   ; 1/2

; カウント値をセット（上位、下位バイト）
; Y = 42
; X = 2 + 42 + 65536 + 9 + 188940 + 42 - 203621
; X = 50950 (0xC706)

    ldi r17, 0xc7    ; 1
	ldi r18, 0x06    ; 1
	sts tcnt1H, r17  ; 2
	sts tcnt1L, r18  ; 2

;  プリスケーラ　1
    ldi r17, 0x01    ; 1
	sts tccr1b, r17  ; 2

    ldi flag,1       ;

    jmp end441    ;

g441_led:
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
    jmp end441
;--------------------------------------
;gis441 52.0310714865784Hz 192192.851584453
;--------------------------------------
gis441:
    cpi flag,1       ; 1
	breq gis441_led   ; 1/2

; カウント値をセット（上位、下位バイト）
; Y = 44
; X = 2 + 44 + 65536 + 9 + 188940 + 44 - 192193
; X = 62382 (0xF3AE)

    ldi r17, 0xf3    ; 1
	ldi r18, 0xae    ; 1
	sts tcnt1H, r17  ; 2
	sts tcnt1L, r18  ; 2

;  プリスケーラ　1
    ldi r17, 0x01    ; 1
	sts tccr1b, r17  ; 2

    ldi flag,1       ;

    jmp end441    ;

gis441_led:
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
    jmp end441
;--------------------
;end441
;--------------------
end441:
	out sreg, r16
	reti
