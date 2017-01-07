	
	TRACK SQ1_HEART, $0000, TRI_HEART, $0000, MOD_HEART
MOD_HEART:
	.dw $0000, $0080
	.dw $2101, $0080
SQ1_HEART:
.vol = 11
.vol2 = 9
.vol3 = 5
	TONE 0
	VOL .vol
	KEY O3 -2
	ENV 1,2
.begin
	TEMPO 7
	n1 1
	TEMPO 8
	n1 4
	TEMPO 7
	n1 3
	TEMPO 8
	n1 4
	TEMPO 15
	n1 1
	TEMPO 7
	n1 1
	TEMPO 8
	n1 3
	TEMPO 7
	n1 4
	TEMPO 8
	n1 11
	TEMPO 15
	n1 8
	LOOP 2,.begin
	
	TONE 1
	ENV 1,2,1
	n1 6
	n1 15
	n1 13
	TEMPO 7
	n1 11
	TEMPO 8
	n1 9
	TEMPO 15
	n1 8
	n1 11
	n1 13
	VOL .vol -1
	n1 13
	VOL .vol -2
	n1 13
	VOL .vol -3
	n1 13
	VOL .vol -4
	n1 13
	VOL .vol -5
	n1 13
	VOL .vol -6
	n1 13
	VOL .vol -7
	n1 13
	VOL .vol -8
	n1 13
	DOT
	n2
	VOL .vol -9
	n1 16
	VOL .vol -7
	n1 16
	VOL .vol -9
	n1 16
	VOL .vol -7
	n1 16
	VOL .vol -5
	n1 16
	VOL .vol -3
	n1 16
	VOL .vol
	
	KEY O4 -2
	ENV 1,7,1
	n1 6+12
	n1 15+12
	n1 13+12
	TEMPO 7
	n1 11+12
	TEMPO 8
	n1 9+12
	TEMPO 15
	n1 8+12
	n1 11+12
	TIE 1
	n2 13+12
	ENV 3,1
	n2 13+12
	ENV 1,7,1
	n1 8+12
	n1 11+12
	n2 13+12
	n1 16+12
	TEMPO 7
	n1 18+12
	TEMPO 8
	n1 16+12
	TEMPO 15
	n1 15+12
	n1 16+12
	TIE 1
	n2 13+12
	ENV 5,1
	n3 13+12
	DOT
	n3
	;---------------------------
	TONE 0
	ENV 1,2
.1
	TEMPO 7
	n1 1
	TEMPO 8
	n1 4
	TEMPO 7
	n1 3
	TEMPO 8
	n1 4
	TEMPO 15
	n1 1
	TEMPO 7
	n1 1
	TEMPO 8
	n1 3
	TEMPO 7
	n1 4
	TEMPO 8
	n1 11
	TEMPO 15
	n1 8
	LOOP 2,.1
	
	ENV 1,2,1
	n1 6
	n1 15
	n1 13
	TEMPO 7
	n1 11
	TEMPO 8
	n1 9
	TEMPO 15
	n1 8
	n1 11
	n1 13
	
	ENV 1,2
	TEMPO 7
	n1 3
	TEMPO 8
	n1 4
	TEMPO 15
	n1 1
	TEMPO 7
	n1 1
	TEMPO 8
	n1 3
	TEMPO 7
	n1 4
	TEMPO 8
	n1 11
	TEMPO 15
	n1 8
	
	TEMPO 7
	n1 1
	TEMPO 8
	n1 4
	TEMPO 7
	n1 3
	TEMPO 8
	n1 4
	TEMPO 15
	n1 1
	TEMPO 7
	n1 1
	TEMPO 8
	n1 3
	TEMPO 7
	n1 4
	TEMPO 8
	n1 11
	TEMPO 15
	n1 8
	
	TEMPO 7
	n1 6
	TEMPO 8
	n1 8
	TEMPO 7
	n1 11
	TEMPO 8
	n1 13
	TEMPO 7
	n1 15
	TEMPO 8
	n1 16
	TEMPO 7
	n1 18
	TEMPO 8
	n1 16
	TEMPO 7
	n1 15
	TEMPO 8
	n1 13
	TEMPO 7
	n1 11
	TEMPO 8
	n1 8
	;----------------------------
	
	TEMPO 15
	TONE 1
	ENV 1,7,1
	n1 6+12
	n1 15+12
	n1 13+12
	TEMPO 7
	n1 11+12
	TEMPO 8
	n1 9+12
	TEMPO 15
	n1 8+12
	n1 11+12
	TIE 1
	n2 13+12
	ENV 3,1
	n2 13+12
	ENV 1,7,1
	n1 8+12
	n1 11+12
	n2 13+12
	n1 16+12
	TEMPO 7
	n1 18+12
	TEMPO 8
	n1 16+12
	TEMPO 15
	n1 15+12
	n1 16+12
	TIE 1
	n2 13+12
	ENV 5,1
	n3 13+12
	DOT
	n2
	
	ENV 1,7,1
	KEY O5 -2
	TEMPO 7
	n1 8
	TEMPO 8
	n1
	TEMPO 7
	n1 13
	TEMPO 8
	n1
	TEMPO 7
	n1 16
	TEMPO 8
	n1
	TEMPO 15
	TIE 1
	n2 20
	ENV 3,1
	n2 20
	LOOP 0,.2a
	
.2b
	n2 13
	
	
	TONE 2
	VOL .vol2
	ENV 1,4,1
	TEMPO 7
	n1 4
	TEMPO 8
	n1
	TEMPO 7
	n1 6
	TEMPO 8
	n1
	TEMPO 15
	n2 8
	TEMPO 7
	n1 6
	TEMPO 8
	n1
	TEMPO 7
	n1 4
	TEMPO 8
	n1 6
	TEMPO 15
	n1 3
	n1 11
	TIE 1
	n2 8
	ENV 3,1
	n2 8
	
.2a
	TONE 1
	VOL .vol
	ENV 1,7,1
	TEMPO 7
	n1 16
	TEMPO 8
	n1
	TEMPO 7
	n1 18
	TEMPO 8
	n1
	TEMPO 15
	n2 20
	n1 18
	TEMPO 7
	n1 16
	TEMPO 8
	n1 18
	TEMPO 7
	n1 15
	TEMPO 8
	n1
	TEMPO 7
	n1 11
	TEMPO 8
	n1
	TEMPO 15
	TIE 1
	n2 13
	ENV 4,1
	LOOP 1,.2b
	n3 13
	
	TONE 2
	VOL .vol3
	ENV 1,2,1
	DOT
	n2 9
	DOT
	n2 16
	LOOP 0,.2c

.2d
	TEMPO 7
	n1 18
	TEMPO 8
	n1
	TEMPO 7
	n1 18
	TEMPO 8
	n1
.2c
	TEMPO 7
	n1 18
	TEMPO 8
	n1 18
	TEMPO 7
	n1
	TEMPO 8
	n1 18
	TEMPO 7
	n1
	TEMPO 8
	n1 18
	TEMPO 7
	n1 18
	TEMPO 8
	n1
	LOOP 1,.2d
	
	TEMPO 7
	n1 21
	TEMPO 8
	n1
	TEMPO 7
	n1 23
	TEMPO 8
	n1
	
	;----------------------------
	
	TONE 0
	VOL .vol
	KEY O3 -2
	ENV 1,2
	TEMPO 7
	n1 2
	TEMPO 8
	n1 6
	TEMPO 7
	n1 4
	TEMPO 8
	n1 6
	TEMPO 15
	n1 2
	TEMPO 7
	n1 2
	TEMPO 8
	n1 4
	LOOP 0,.3a
.3b
	TEMPO 5
	n1
	TEMPO 3
	n1 19
	TEMPO 2
	n1 20
	TEMPO 3
	n1 21
	TEMPO 2
	n1 22
	TEMPO 8
	n1 23
	TEMPO 7
	n1
	VOL .vol2 - 2
	TEMPO 8
	n1 23
	TEMPO 7
	n1
	
	VOL .vol
	TEMPO 15
	n1 23
	TEMPO 7
	n1 22
	TEMPO 8
	n1 20
	TEMPO 15
	n1 18
	SHORT
	n1 20
	VOL .vol - 2
	SHORT
	n1 20
	VOL .vol - 4
	SHORT
	n1 20
	VOL .vol - 6
	SHORT
	n1 20
	VOL .vol - 8
	SHORT
	n1 20
	VOL .vol - 10
	SHORT
	n1 20
	
	TONE 0
	VOL .vol
	KEY O3 -2
	ENV 1,2
.3a
	TEMPO 7
	n1 6
	TEMPO 8
	n1 14
	TEMPO 15
	n1 9
	
	TEMPO 7
	n1 2
	TEMPO 8
	n1 6
	TEMPO 7
	n1 4
	TEMPO 8
	n1 6
	TEMPO 15
	n1 2
	TEMPO 7
	n1 2
	TEMPO 8
	n1 4
	TEMPO 7
	n1 6
	TEMPO 8
	n1 14
	TEMPO 15
	n1 9
	
	TONE 1
	KEY O4 -2
	ENV 3,1
	TEMPO 4
	n1 19
	n1 20
	n1 21
	TEMPO 3
	n1 22
	TEMPO 8
	n1 23
	TEMPO 7
	n1
	VOL .vol2 - 2
	TEMPO 8
	n1 23
	TEMPO 7
	n1
	VOL .vol
	TEMPO 8
	n1 22
	TEMPO 7
	n1
	VOL .vol2 - 2
	TEMPO 8
	n1 22
	TEMPO 7
	n1
	VOL .vol
	TEMPO 15
	n1 22
	LOOP 1,.3b
	
	;---------------------------
	
	TEMPO 15
	TONE 1
	KEY O4 -2
	ENV 1,7,1
	n1 6
	n1 15
	n1 13
	TEMPO 7
	n1 11
	TEMPO 8
	n1 9
	TEMPO 15
	n1 8
	n1 11
	LOOP 0,.4a
.4b
	TONE 1
	ENV 3,1
	TEMPO 5
	n1
	TEMPO 3
	n1 19
	TEMPO 2
	n1 20
	TEMPO 3
	n1 21
	TEMPO 2
	n1 22
	TEMPO 8
	n1 23
	TEMPO 7
	n1
	VOL .vol2 - 2
	TEMPO 8
	n1 23
	TEMPO 7
	n1
	
	VOL .vol
	TEMPO 15
	n1 23
	TEMPO 7
	n1 22
	TEMPO 8
	n1 20
	
	TONE 1
	ENV 1,7,1
	TEMPO 15
	n1 11
.4a
	TIE 1
	TEMPO 7
	n1 13
	ENV 2,1
	TEMPO 8+15
	n1 13
	TIE 1
	ENV 1,7,1
	TEMPO 7
	n1 14
	TEMPO 8
	ENV 1,1
	n1 14
	TIE 1
	ENV 1,7,1
	TEMPO 7
	n1 18
	TEMPO 8
	ENV 1,1
	n1 18
	TIE 1
	ENV 1,7,1
	TEMPO 7
	n1 16
	TEMPO 8
	ENV 1,1
	n1 16
	TIE 1
	ENV 1,7,1
	TEMPO 7
	n1 18
	TEMPO 8
	ENV 1,1
	n1 18
	ENV 1,7,1
	TEMPO 15
	n2 20
	n1 18
	n1 21
	n1 20
	n1 18
	n2 20
	n1 21
	TEMPO 7
	n1 20
	TEMPO 8
	n1 21
	TEMPO 15
	n1 18
	n1 20
	n2 16
	n1 18
	TEMPO 7
	n1 15
	TEMPO 8
	n1 16
	TEMPO 15
	n1 13
	n1 11
	
	TONE 0
	n2 8
	n1 9
	n2 11
	n1 13
	n2 8
	n1 9
	n2 11
	n1 13
	TEMPO 7
	n1 8
	TEMPO 8
	n1 9
	TEMPO 15
	n3 8
	LOOP 1,.4b
	
	;--------------------------------
	
	TONE 1
	KEY O5 -2
	n1
	n1 6
	n1 15
	n1 13
	TEMPO 7
	n1 11
	TEMPO 8
	n1 9
	TEMPO 15
	n1 8
	n1 11
	TIE 1
	n2 13
	ENV 3,1
	n2 13
	ENV 1,7,1
	n1 8
	n1 11
	n2 13
	n1 16
	TEMPO 7
	n1 18
	TEMPO 8
	n1 16
	TEMPO 15
	n1 15
	n1 16
	TIE 1
	n2 13
	ENV 5,1
	n3 13
	DOT
	n2
	
	ENV 1,7,1
	TEMPO 7
	n1 8
	TEMPO 8
	n1
	TEMPO 7
	n1 13
	TEMPO 8
	n1
	TEMPO 7
	n1 16
	TEMPO 8
	n1
	TEMPO 15
	TIE 1
	n2 20
	ENV 3,1
	n2 20
	LOOP 0,.5a
	
.5b
	TONE 2
	VOL .vol2
	ENV 1,4,1
	TEMPO 7
	n1 4
	TEMPO 8
	n1
	TEMPO 7
	n1 6
	TEMPO 8
	n1
	TEMPO 15
	n2 8
	TEMPO 7
	n1 6
	TEMPO 8
	n1
	TEMPO 7
	n1 4
	TEMPO 8
	n1 6
	TEMPO 15
	n1 3
	n1 11
	TIE 1
	n2 8
	ENV 3,1
	n2 8
	
.5a
	TONE 1
	VOL .vol
	ENV 1,7,1
	TEMPO 7
	n1 16
	TEMPO 8
	n1
	TEMPO 7
	n1 18
	TEMPO 8
	n1
	TEMPO 15
	n2 20
	n1 18
	TEMPO 7
	n1 16
	TEMPO 8
	n1 18
	TEMPO 7
	n1 15
	TEMPO 8
	n1
	TEMPO 7
	n1 11
	TEMPO 8
	n1
	TEMPO 15
	TIE 1
	n2 13
	ENV 4,1
	n2 13
	LOOP 1,.5b
	
	ENV 1,7,1
	TEMPO 7
	n1 16
	TEMPO 8
	n1
	TEMPO 7
	n1 18
	TEMPO 8
	n1
	TEMPO 15
	n2 20
	n1 18
	TEMPO 7
	n1 16
	TEMPO 8
	n1 18
	TEMPO 7
	n1 15
	TEMPO 8
	n1
	TEMPO 7
	n1 11
	TEMPO 8
	n1
	TEMPO 15
	TIE 1
	n2 13
	ENV 8,1
	n3 13
	DOT
	n3
	LOOP 0,SQ1_HEART



TRI_HEART:
.vol = -$30 +48
.vol2 = -$30 +14
	TEMPO 15
	VOL .vol
	KEY O3 +3
	LOOP 0,.begin
.1
	DOT
	n2 8
	DOT
	n2 8
	DOT
	n2 10
	n2 18
	n1 10
.begin
	DOT
	n2 4
	DOT
	n2 4
	DOT
	n2 4
	DOT
	n2 4
	LOOP 1,.1
	
	TEMPO 15+7
	n1 8
	TEMPO 15+8
	n1 8
	TEMPO 15
	n1 8
	n1 8
	n1 8
	
	VOL .vol +20
	n1 6
	n1 1
	n1 3
	TEMPO 7
	n1 6
	TEMPO 8
	n1 8
	TEMPO 15
	n1 10
	n1 13
	
	;----------------------
	VOL .vol2
	LOOP 0,.2a
.2b
	TEMPO 8
	n1 4
.2a
	TEMPO 7
	n1 4
	TEMPO 8
	n1 20
	TEMPO 7
	n1 10
	TEMPO 8
	n1 11
	TEMPO 7
	n1 8
	LOOP 1,.2b
	TEMPO 8
	n1 13
	TEMPO 7
	n1 6
	TEMPO 8
	n1 22
	TEMPO 7
	n1 1
	TEMPO 8
	n1 4
	TEMPO 7
	n1 6
	TEMPO 8
	n1 3
	TEMPO 15
	VOL .vol
	n1 1
	n1 3
	n1 6
	VOL .vol2
.2c
	TEMPO 7
	n1 8
	TEMPO 8
	n1 20
	TEMPO 7
	n1 13
	TEMPO 8
	n1 15
	TEMPO 7
	n1 11
	TEMPO 8
	n1 3
	LOOP 2,.2c
	
	TEMPO 7
	n1 6
	TEMPO 8
	n1 18
	TEMPO 15
	VOL .vol
	n1 1
	n1 6
	
	DOT
	n2 4
	DOT
	n2 4
	DOT
	n2 4
	DOT
	n2 4
	DOT
	n2 8
	DOT
	n2 8
	DOT
	n2 10
	TEMPO 7
	n1 18
	TEMPO 8
	n1 6
	TEMPO 7
	n1 8
	TEMPO 8
	n1 10
	TEMPO 7
	VOL .vol2
	n1 13
	TEMPO 8
	n1 10
	TEMPO 15
	VOL .vol
	n1 4
	TEMPO 7
	VOL .vol2
	n1 4+24
	TEMPO 8
	n1 4+24
	TEMPO 15
	n1 4+12
	VOL .vol
	n1 4
	TEMPO 7
	VOL .vol2
	n1 20
	TEMPO 8
	n1 18
	TEMPO 15
	n1 20
	VOL .vol
	n1 4
	TEMPO 7
	VOL .vol2
	n1 4+24
	TEMPO 8
	n1 3+24
	TEMPO 7
	KEY O3 +4
	n1 31
	TEMPO 8
	KEY O3 +3
	n1 3+24
	TEMPO 7
	VOL .vol
	n1 4
	TEMPO 8
	VOL .vol2
	n1 23
	TEMPO 7
	n1 20
	TEMPO 8
	n1 6
	TEMPO 7
	n1 8
	TEMPO 8
	n1 10
	
	TEMPO 15
	n1 8
	n1 8
	n1 8
	TEMPO 7
	n1 8
	n1 8
	n1 8
	TEMPO 8
	n1 8+12
	n1 8
	n1 8+12
	TEMPO 15
	VOL .vol +20
	n1 6
	n1 1
	n1 3
	TEMPO 7
	n1 6
	TEMPO 8
	n1 8
	TEMPO 15
	n1 10
	n1 13
	
	;-----------------------
	
	VOL .vol2
	LOOP 0,.3a
.3b
	TEMPO 8
	n1 4
.3a
	TEMPO 7
	n1 4
	TEMPO 8
	n1 20
	TEMPO 7
	n1 10
	TEMPO 8
	n1 11
	TEMPO 7
	n1 8
	LOOP 1,.3b
	TEMPO 8
	n1 13
	TEMPO 7
	n1 6
	TEMPO 8
	n1 22
	TEMPO 7
	n1 1
	TEMPO 8
	n1 4
	TEMPO 7
	n1 6
	TEMPO 8
	n1 3
	TEMPO 15
	VOL .vol
	n1 1
	n1 3
	n1 6
	VOL .vol2
.3c
	TEMPO 7
	n1 8
	TEMPO 8
	n1 20
	TEMPO 7
	n1 13
	TEMPO 8
	n1 15
	TEMPO 7
	n1 11
	TEMPO 8
	n1 3
	LOOP 2,.3c
	TEMPO 15
	VOL .vol
	n1 6
	n1 1
	n1 3
	END
