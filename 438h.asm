;---------------------------
;freq438.asm
; 2019-04-03 by penkich
;---------------------------
freq438:           ; 14
    cpi r21,'a'    ; 1
	breq a438_0    ; 1/2

    cpi r21,'b'    ; 1
	breq b438_0    ; 1/2

    cpi r21,'h'    ; 1
	breq h438_0    ; 1/2

    cpi r21,'c'    ; 1
 	breq c438_0    ; 1/2

    cpi r21,'C'    ; 1
	breq Cis438_0  ; 1/2

    cpi r21,'d'    ; 1
	breq d438_0    ; 1/2

    cpi r21,'D'    ; 1
	breq dis438_0  ; 1/2

    cpi r21,'e'    ; 1
	breq e438_0    ; 1/2

    cpi r21,'f'    ; 1
	breq f438_0    ; 1/2

    cpi r21,'F'    ; 1
	breq fis438_0  ; 1/2

    cpi r21,'g'    ; 1
	breq g438_0    ; 1/2

    cpi r21,'G'    ; 1
	breq gis438_0  ; 1/2

a438_0:
   jmp a438          ; 3 / 14 + 3 + 3     = 20
b438_0:
   jmp b438          ; 3 / 14 + 2 + 3 + 3 = 22
h438_0:
   jmp h438          ; 3 /                = 24
c438_0:
   jmp c438          ; 3 /                = 26
cis438_0:
   jmp cis438        ; 3 /                = 28
d438_0:
   jmp d438          ; 3 /                = 30
dis438_0:
   jmp dis438        ; 3 /                = 32
e438_0:
   jmp e438          ; 3 /                = 34
f438_0:
   jmp f438          ; 3 /                = 36
fis438_0:
   jmp fis438        ; 3 /                = 38
g438_0:
   jmp g438          ; 3 /                = 40
gis438_0:
   jmp gis438        ; 3 /                = 42

;--------------------------------------
;a438 27.375Hz 365296.803652968clk
;--------------------------------------
a438:
    cpi flag,1       ; 1
	breq a438_led    ; 1/2
; カウント値をセット（上位、下位バイト）
; Y = 20
; X = 2Y + 385559 -clk
; X = 40 + 385559 - 365297
; X = 20302 (0h4F4E)
 
    ldi r17, 0x4f    ; 1
	ldi r18, 0x4e    ; 1
	sts tcnt1H, r17  ; 2
	sts tcnt1L, r18  ; 2

;  プリスケーラ　1
    ldi r17, 0x01    ; 1
	sts tccr1b, r17  ; 2
; 20 + 2 + 43573 + 9 = 43604
; 20 + 2 + (65536 - X) +9

    ldi flag,1       ;

    jmp end438       ;

a438_led:
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
    jmp end438
;--------------------------------------
;b438 29.0028022080857Hz 344794.269472765
;--------------------------------------
b438: 
    cpi flag,1       ; 1
	breq b438_led         ; 1/2

; カウント値をセット（上位、下位バイト）
; Y = 22
; X = 2Y + 385559 -clk
; X = 44 + 385559 - 344794
; X = 40809 (0h9F69)

    ldi r17, 0x9f    ; 1
	ldi r18, 0x69    ; 1
	sts tcnt1H, r17  ; 2
	sts tcnt1L, r18  ; 2

;  プリスケーラ　1
    ldi r17, 0x01    ; 1
	sts tccr1b, r17  ; 2
;
    ldi flag,1       ;

    jmp end438 ;

b438_led:
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
    jmp end438
;--------------------------------------
;h438 30.7273985724691Hz 325442.454115192clk
;--------------------------------------
h438: 
    cpi flag,1       ; 1
	breq h438_led         ; 1/2

; カウント値をセット（上位、下位バイト）
; Y = 24
; X = 2Y + 385559 -clk
; X = 48 + 385559 - 325442
; X = 60165 (0hEB05)
    ldi r17, 0xeb    ; 1
	ldi r18, 0x05    ; 1
	sts tcnt1H, r17  ; 2
	sts tcnt1L, r18  ; 2

;  プリスケーラ　1
    ldi r17, 0x01    ; 1
	sts tccr1b, r17  ; 2

    ldi flag,1       ;

    jmp end438    ;

h438_led:
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
    jmp end438
;--------------------------------------
;c438 32.5545447731995Hz 307176.772695421clk
;--------------------------------------
c438: 
    cpi flag,1       ; 1
	breq c438_led         ; 1/2

; カウント値をセット（上位、下位バイト）
; Y = 26
; X = 2Y + 254476 -clk
; X = 52 + 65536 + 254476 + 12 - 307177
; X = 12899 (0h3263)
    ldi r17, 0x32    ; 1
	ldi r18, 0x63    ; 1
	sts tcnt1H, r17  ; 2
	sts tcnt1L, r18  ; 2

;  プリスケーラ　1
    ldi r17, 0x01    ; 1
	sts tccr1b, r17  ; 2

    ldi flag,1       ;

    jmp end438    ;

c438_led:
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
    jmp end438
;--------------------------------------
;cis438 34.4903387408722Hz 289936.265199671clk
;--------------------------------------
cis438:
    cpi flag,1       ; 1
	breq cis438_led   ; 1/2

; Y = 28
; X = 2Y + 254476 -clk
; X = 56 + 65536 + 254476 + 12 - 289936
; X = 30144 (0h75C0)

    ldi r17, 0x75    ; 1
	ldi r18, 0xc0    ; 1
	sts tcnt1H, r17  ; 2
	sts tcnt1L, r18  ; 2

;  プリスケーラ　1
    ldi r17, 0x01    ; 1
	sts tccr1b, r17  ; 2

    ldi flag,1       ;

    jmp end438    ;

cis438_led:
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
    jmp end438
;--------------------------------------
;d438 36.5412410079047Hz 273663.393036837clk
;--------------------------------------
d438:
    cpi flag,1      ; 1
	breq d438_led   ; 1/2

; カウント値をセット（上位、下位バイト）
; Y = 30
; X = 2Y + 254476 -clk
; X = 60 + 65536 + 254476 + 12 - 273663
; X = 46421 (0hB555)

    ldi r17, 0xb5    ; 1
	ldi r18, 0x55    ; 1
	sts tcnt1H, r17  ; 2
	sts tcnt1L, r18  ; 2

;  プリスケーラ　1
    ldi r17, 0x01    ; 1
	sts tccr1b, r17  ; 2

    ldi flag,1       ;

    jmp end438    ;

d438_led:
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
    jmp end438
;--------------------------------------
;dis438 38.7140962699635Hz 258303.847008784clk
;--------------------------------------
dis438:
    cpi flag,1       ; 1
    breq dis438_led  ; 1/2

; カウント値をセット（上位、下位バイト）
; Y = 32
; X = 2Y + 254476 -clk
; X = 64 + 65536 + 254476 + 12 - 258304
; X = 61784 (0hF158)
    ldi r17, 0xf1    ; 1
    ldi r18, 0x58    ; 1
    sts tcnt1H, r17  ; 2
    sts tcnt1L, r18  ; 2

;  プリスケーラ　1
    ldi r17, 0x01    ; 1
    sts tccr1b, r17  ; 2

    ldi flag,1       ;
    jmp end438    ;

dis438_led:
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
    jmp end438
;--------------------------------------
;e438 41.0161562294992Hz 243806.366058454clk
;--------------------------------------
e438:
    cpi flag,1       ; 1
	breq e438_led    ; 1/2

; カウント値をセット（上位、下位バイト）
; Y = 34
; X = 2 + 34 + 65536 + 9 + 188940 + 34 - 243806
; X = 10749 (0x29FD)

    ldi r17, 0x29    ; 1
	ldi r18, 0xfd    ; 1
	sts tcnt1H, r17  ; 2
	sts tcnt1L, r18  ; 2

;  プリスケーラ　1
    ldi r17, 0x01    ; 1
	sts tccr1b, r17  ; 2

    ldi flag,1       ;

    jmp end438    ;

e438_led:
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
    jmp end438
;--------------------------------------
;f438 43.4551037976295Hz 230122.566190844clk
;--------------------------------------
f438:
    cpi flag,1       ; 1
	breq f438_led   ; 1/2

; カウント値をセット（上位、下位バイト）
; Y = 36
; X = 2 + 36 + 65536 + 9 + 188940 + 36 - 230123
; X = 24436 (0x5F74)

    ldi r17, 0x5f    ; 1
	ldi r18, 0x74    ; 1
	sts tcnt1H, r17  ; 2
	sts tcnt1L, r18  ; 2

;  プリスケーラ　1
    ldi r17, 0x01    ; 1
	sts tccr1b, r17  ; 2

    ldi flag,1       ;

    jmp end438    ;

f438_led:
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
    jmp end438
;--------------------------------------
;fis438 46.0390787351409Hz 217206.778995931clk
;--------------------------------------
fis438:
    cpi flag,1       ; 1
	breq fis438_led   ; 1/2

; カウント値をセット（上位、下位バイト）
; Y = 38
; X = 2 + 38 + 65536 + 9 + 188940 + 38 - 217207
; X = 37356 (0x91EC)

    ldi r17, 0x91    ; 1
	ldi r18, 0xec    ; 1
	sts tcnt1H, r17  ; 2
	sts tcnt1L, r18  ; 2

;  プリスケーラ　1
    ldi r17, 0x01    ; 1
	sts tccr1b, r17  ; 2

    ldi flag,1       ;

    jmp end438    ;

fis438_led:
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
    jmp end438
;--------------------------------------
;g438 48.7767048181836Hz 205015.899234589clk
;--------------------------------------
g438:
    cpi flag,1       ; 1
	breq g438_led   ; 1/2

; カウント値をセット（上位、下位バイト）
; Y = 40
; X = 2 + 40 + 65536 + 9 + 188940 + 40 - 205016
; X = 49551 (0xC18F)

    ldi r17, 0xc1    ; 1
	ldi r18, 0x8f    ; 1
	sts tcnt1H, r17  ; 2
	sts tcnt1L, r18  ; 2

;  プリスケーラ　1
    ldi r17, 0x01    ; 1
	sts tccr1b, r17  ; 2

    ldi flag,1       ;

    jmp end438    ;

g438_led:
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
    jmp end438
;--------------------------------------
;gis438 51.6771186193227Hz 193509.240978867clk
;--------------------------------------
gis438:
    cpi flag,1       ; 1
	breq gis438_led   ; 1/2

; カウント値をセット（上位、下位バイト）
; Y = 42
; X = 2 + 42 + 65536 + 9 + 188940 + 42 - 193509
; X = 61062 (0xEE86)

    ldi r17, 0xee    ; 1
	ldi r18, 0x86    ; 1
	sts tcnt1H, r17  ; 2
	sts tcnt1L, r18  ; 2

;  プリスケーラ　1
    ldi r17, 0x01    ; 1
	sts tccr1b, r17  ; 2

    ldi flag,1       ;

    jmp end438    ;

gis438_led:
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
    jmp end438
;--------------------
;end438
;--------------------
end438:
	out sreg, r16
	reti
