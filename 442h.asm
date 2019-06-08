;---------------------------
;freq442.asm
; 2019-04-03 by penkich
;---------------------------
freq442:           ; 18
    cpi r21,'a'    ; 1
	breq a442_0    ; 1/2

    cpi r21,'b'    ; 1
	breq b442_0    ; 1/2

    cpi r21,'h'    ; 1
	breq h442_0    ; 1/2

    cpi r21,'c'    ; 1
 	breq c442_0    ; 1/2

    cpi r21,'C'    ; 1
	breq Cis442_0  ; 1/2

    cpi r21,'d'    ; 1
	breq d442_0    ; 1/2

    cpi r21,'D'    ; 1
	breq dis442_0  ; 1/2

    cpi r21,'e'    ; 1
	breq e442_0    ; 1/2

    cpi r21,'f'    ; 1
	breq f442_0    ; 1/2

    cpi r21,'F'    ; 1
	breq fis442_0  ; 1/2

    cpi r21,'g'    ; 1
	breq g442_0    ; 1/2

    cpi r21,'G'    ; 1
	breq gis442_0  ; 1/2

a442_0:
   jmp a442          ; 3 / 18 + 3 + 3     = 24
b442_0:
   jmp b442          ; 3 / 18 + 2 + 3 + 3 = 26
h442_0:
   jmp h442          ; 3 /                = 28
c442_0:
   jmp c442          ; 3 /                = 30
cis442_0:
   jmp cis442        ; 3 /                = 32
d442_0:
   jmp d442          ; 3 /                = 34
dis442_0:
   jmp dis442        ; 3 /                = 36
e442_0:
   jmp e442          ; 3 /                = 38
f442_0:
   jmp f442          ; 3 /                = 40
fis442_0:
   jmp fis442        ; 3 /                = 42
g442_0:
   jmp g442          ; 3 /                = 44
gis442_0:
   jmp gis442        ; 3 /                = 46

;--------------------------------------
;a442 27.625Hz 361990.950226244clk
;--------------------------------------
a442:
    cpi flag,1       ; 1
	breq a442_led    ; 1/2
; カウント値をセット（上位、下位バイト）
; Y = 24
; X = 2Y + 385559 -clk
; X = 48 + 385559 - 361991
; X = 23616 (0h5C40)
 
    ldi r17, 0x5c    ; 1
	ldi r18, 0x40    ; 1
	sts tcnt1H, r17  ; 2
	sts tcnt1L, r18  ; 2

;  プリスケーラ　1
    ldi r17, 0x01    ; 1
	sts tccr1b, r17  ; 2
; 20 + 2 + 43573 + 9 = 43604
; 20 + 2 + (65536 - X) +9

    ldi flag,1       ;

    jmp end442       ;

a442_led:
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

;  LED 点灯・消灯
    in r17, portc
	ldi r18, 0x00
	sbr r18, (1<<B_LED)
	eor r17, r18
	out P_LED, r17

    ldi flag,0
    jmp end442
;--------------------------------------
;b442 29.2676679816755Hz 341673.959341789clk
;--------------------------------------
b442: 
    cpi flag,1       ; 1
	breq b442_led         ; 1/2

; カウント値をセット（上位、下位バイト）
; Y = 26
; X = 2Y + 385559 -clk
; X = 52 + 385559 - 341674
; X = 43937 (0hABA1)

    ldi r17, 0xab    ; 1
	ldi r18, 0xa1    ; 1
	sts tcnt1H, r17  ; 2
	sts tcnt1L, r18  ; 2

;  プリスケーラ　1
    ldi r17, 0x01    ; 1
	sts tccr1b, r17  ; 2
;
    ldi flag,1       ;

    jmp end442 ;

b442_led:
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
    jmp end442
;--------------------------------------
;h442 31.0080140845464Hz 322497.273534964clk
;--------------------------------------
h442: 
    cpi flag,1       ; 1
	breq h442_led         ; 1/2

; カウント値をセット（上位、下位バイト）
; Y = 28
; X = 2Y + 385559 -clk
; X = 56 + 385559 - 322497
; X = 63118 (0hF68E)
    ldi r17, 0xf6    ; 1
	ldi r18, 0x8e    ; 1
	sts tcnt1H, r17  ; 2
	sts tcnt1L, r18  ; 2

;  プリスケーラ　1
    ldi r17, 0x01    ; 1
	sts tccr1b, r17  ; 2

    ldi flag,1       ;

    jmp end442    ;

h442_led:
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
    jmp end442
;--------------------------------------
;c442 32.8518465519502Hz 304396.892399535clk
;--------------------------------------
c442: 
    cpi flag,1       ; 1
	breq c442_led         ; 1/2

; カウント値をセット（上位、下位バイト）
; Y = 30
; X = 2Y + 254476 -clk
; X = 60 + 65536 + 254476 + 12 - 304397
; X = 15687 (0h3D47)
    ldi r17, 0x3d    ; 1
	ldi r18, 0x47    ; 1
	sts tcnt1H, r17  ; 2
	sts tcnt1L, r18  ; 2

;  プリスケーラ　1
    ldi r17, 0x01    ; 1
	sts tccr1b, r17  ; 2

    ldi flag,1       ;

    jmp end442    ;

c442_led:
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
    jmp end442
;--------------------------------------
;cis442 34.8053190033459Hz 287312.407596054clk
;--------------------------------------
cis442:
    cpi flag,1       ; 1
	breq cis442_led   ; 1/2

; Y = 32
; X = 2Y + 254476 -clk
; X = 64 + 65536 + 254476 + 12 - 287312
; X = 32776 (0h8008)

    ldi r17, 0x80    ; 1
	ldi r18, 0x08    ; 1
	sts tcnt1H, r17  ; 2
	sts tcnt1L, r18  ; 2

;  プリスケーラ　1
    ldi r17, 0x01    ; 1
	sts tccr1b, r17  ; 2

    ldi flag,1       ;

    jmp end442    ;

cis442_led:
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
    jmp end442
;--------------------------------------
;d442 36.8749509714472Hz 271186.801244648clk
;--------------------------------------
d442:
    cpi flag,1      ; 1
	breq d442_led   ; 1/2

; カウント値をセット（上位、下位バイト）
; Y = 34
; X = 2Y + 254476 -clk
; X = 68 + 65536 + 254476 + 12 - 271187
; X = 48905 (0hBF09)

    ldi r17, 0xbf    ; 1
	ldi r18, 0x09    ; 1
	sts tcnt1H, r17  ; 2
	sts tcnt1L, r18  ; 2

;  プリスケーラ　1
    ldi r17, 0x01    ; 1
	sts tccr1b, r17  ; 2

    ldi flag,1       ;

    jmp end442    ;

d442_led:
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
    jmp end442
;--------------------------------------
;dis442 39.0676496605568Hz 255966.255633139clk
;--------------------------------------
dis442:
    cpi flag,1       ; 1
    breq dis442_led  ; 1/2

; カウント値をセット（上位、下位バイト）
; Y = 36
; X = 2Y + 254476 -clk
; X = 72 + 65536 + 254476 + 12 - 255966
; X = 64130 (0hfa82)
    ldi r17, 0xfa    ; 1
    ldi r18, 0x82    ; 1
    sts tcnt1H, r17  ; 2
    sts tcnt1L, r18  ; 2

;  プリスケーラ　1
    ldi r17, 0x01    ; 1
    sts tccr1b, r17  ; 2

    ldi flag,1       ;
    jmp end442    ;

dis442_led:
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
    jmp end442
;--------------------------------------
;e442 41.3907329987183 241599.973605436clk
;--------------------------------------
e442:
    cpi flag,1       ; 1
	breq e442_led    ; 1/2

; カウント値をセット（上位、下位バイト）
; Y = 38
; X = 2 + 38 + 65536 + 9 + 188940 + 38 - 241600
; X = 12963 (0x32A3)

    ldi r17, 0x32    ; 1
	ldi r18, 0xa3    ; 1
	sts tcnt1H, r17  ; 2
	sts tcnt1L, r18  ; 2

;  プリスケーラ　1
    ldi r17, 0x01    ; 1
	sts tccr1b, r17  ; 2

    ldi flag,1       ;

    jmp end442    ;

e442_led:
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
    jmp end442
;--------------------------------------
;f442 43.8519540606215Hz 228040.009030746clk
;--------------------------------------
f442:
    cpi flag,1       ; 1
	breq f442_led   ; 1/2

; カウント値をセット（上位、下位バイト）
; Y = 40
; X = 2 + 40 + 65536 + 9 + 188940 + 40 - 228040
; X = 26527 (0x679F)

    ldi r17, 0x67    ; 1
	ldi r18, 0x9f    ; 1
	sts tcnt1H, r17  ; 2
	sts tcnt1L, r18  ; 2

;  プリスケーラ　1
    ldi r17, 0x01    ; 1
	sts tccr1b, r17  ; 2

    ldi flag,1       ;

    jmp end442    ;

f442_led:
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
    jmp end442
;--------------------------------------
;fis442 46.4595269427677 215241.106787823clk
;--------------------------------------
fis442:
    cpi flag,1       ; 1
	breq fis442_led   ; 1/2

; カウント値をセット（上位、下位バイト）
; Y = 42
; X = 2 + 42 + 65536 + 9 + 188940 + 42 - 215241
; X = 39330 (0x99A2)

    ldi r17, 0x99    ; 1
	ldi r18, 0xa2    ; 1
	sts tcnt1H, r17  ; 2
	sts tcnt1L, r18  ; 2

;  プリスケーラ　1
    ldi r17, 0x01    ; 1
	sts tccr1b, r17  ; 2

    ldi flag,1       ;

    jmp end442    ;

fis442_led:
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
    jmp end442
;--------------------------------------
;g442 49.2221541772537Hz 203160.551730203clk
;--------------------------------------
g442:
    cpi flag,1       ; 1
	breq g442_led   ; 1/2

; カウント値をセット（上位、下位バイト）
; Y = 44
; X = 2 + 44 + 65536 + 9 + 188940 + 44 - 203161
; X = 51414 (0xC8D6)

    ldi r17, 0xc8    ; 1
	ldi r18, 0xd6    ; 1
	sts tcnt1H, r17  ; 2
	sts tcnt1L, r18  ; 2

;  プリスケーラ　1
    ldi r17, 0x01    ; 1
	sts tccr1b, r17  ; 2

    ldi flag,1       ;

    jmp end442    ;

g442_led:
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
    jmp end442
;--------------------------------------
;gis442 52.1490557756636Hz 191758.026128379
;--------------------------------------
gis442:
    cpi flag,1       ; 1
	breq gis442_led   ; 1/2

; カウント値をセット（上位、下位バイト）
; Y = 46
; X = 2 + 46 + 65536 + 9 + 188940 + 46 - 191758
; X = 62821 (0xF565)

    ldi r17, 0xf5    ; 1
	ldi r18, 0x65    ; 1
	sts tcnt1H, r17  ; 2
	sts tcnt1L, r18  ; 2

;  プリスケーラ　1
    ldi r17, 0x01    ; 1
	sts tccr1b, r17  ; 2

    ldi flag,1       ;

    jmp end442    ;

gis442_led:
; カウント値をセット（上位、下位バイト）
; 65536 - 0xa3c0 = 23616
; 23616 x 8 = 188928
; 188928 + 9(set) = 188937
; 188937 + 3(breq) = 188940
; 188940 + 46(Y)
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
    jmp end442
;--------------------
;end442
;--------------------
end442:
	out sreg, r16
	reti
