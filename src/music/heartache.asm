
HEARTACHE:
	TRACK SQ1_HEART, 0, TRI_HEART, 0, BPM(120)
SQ1_HEART:
.vol = 11
.vol2 = 9
.vol3 = 5
	TONE 0
	VOL .vol
	KEY O3 - 2
	ENV 1, 2
.begin
	n2 1
	n2 4
	n2 3
	n2 4
	n3 1
	n2 1
	n2 3
	n2 4
	n2 11
	n3 8
	LOOP 2, .begin

	TONE 1
	ENV 1, 2, 1
	n3 6
	n3 15
	n3 13
	n2 11
	n2 9
	n3 8
	n3 11
	n3 13
	VOL .vol - 1
	n3 13
	VOL .vol - 2
	n3 13
	VOL .vol - 3
	n3 13
	VOL .vol - 4
	n3 13
	VOL .vol - 5
	n3 13
	VOL .vol - 6
	n3 13
	VOL .vol - 7
	n3 13
	VOL .vol - 8
	n3 13
	DOT
	n4
	VOL .vol - 9
	n3 16
	VOL .vol - 7
	n3 16
	VOL .vol - 9
	n3 16
	VOL .vol - 7
	n3 16
	VOL .vol - 5
	n3 16
	VOL .vol - 3
	n3 16
	VOL .vol

	KEY O4 - 2
	ENV 1, 7, 1
	n3 6 + 12
	n3 15 + 12
	n3 13 + 12
	n2 11 + 12
	n2 9 + 12
	n3 8 + 12
	n3 11 + 12
	TIE 1
	n4 13 + 12
	ENV 3, 1
	n4 13 + 12
	ENV 1, 7, 1
	n3 8 + 12
	n3 11 + 12
	n4 13 + 12
	n3 16 + 12
	n2 18 + 12
	n2 16 + 12
	n3 15 + 12
	n3 16 + 12
	TIE 1
	n4 13 + 12
	ENV 5, 1
	n5 13 + 12
	DOT
	n5
	; ---------------------------
	TONE 0
	ENV 1, 2
.1
	n2 1
	n2 4
	n2 3
	n2 4
	n3 1
	n2 1
	n2 3
	n2 4
	n2 11
	n3 8
	LOOP 2, .1

	ENV 1, 2, 1
	n3 6
	n3 15
	n3 13
	n2 11
	n2 9
	n3 8
	n3 11
	n3 13

	ENV 1, 2
	n2 3
	n2 4
	n3 1
	n2 1
	n2 3
	n2 4
	n2 11
	n3 8

	n2 1
	n2 4
	n2 3
	n2 4
	n3 1
	n2 1
	n2 3
	n2 4
	n2 11
	n3 8

	n2 6
	n2 8
	n2 11
	n2 13
	n2 15
	n2 16
	n2 18
	n2 16
	n2 15
	n2 13
	n2 11
	n2 8
	; ---------------------------- 

	TONE 1
	ENV 1, 7, 1
	n3 6 + 12
	n3 15 + 12
	n3 13 + 12
	n2 11 + 12
	n2 9 + 12
	n3 8 + 12
	n3 11 + 12
	TIE 1
	n4 13 + 12
	ENV 3, 1
	n4 13 + 12
	ENV 1, 7, 1
	n3 8 + 12
	n3 11 + 12
	n4 13 + 12
	n3 16 + 12
	n2 18 + 12
	n2 16 + 12
	n3 15 + 12
	n3 16 + 12
	TIE 1
	n4 13 + 12
	ENV 5, 1
	n5 13 + 12
	DOT
	n4

	ENV 1, 7, 1
	KEY O5 - 2
	n2 8
	n2
	n2 13
	n2
	n2 16
	n2
	TIE 1
	n4 20
	ENV 3, 1
	n4 20
	LOOP 0, .2a

.2b
	n4 13


	TONE 2
	VOL .vol2
	ENV 1, 4, 1
	n2 4
	n2
	n2 6
	n2
	n4 8
	n2 6
	n2
	n2 4
	n2 6
	n3 3
	n3 11
	TIE 1
	n4 8
	ENV 3, 1
	n4 8

.2a
	TONE 1
	VOL .vol
	ENV 1, 7, 1
	n2 16
	n2
	n2 18
	n2
	n4 20
	n3 18
	n2 16
	n2 18
	n2 15
	n2
	n2 11
	n2
	TIE 1
	n4 13
	ENV 4, 1
	LOOP 1, .2b
	n5 13

	TONE 2
	VOL .vol3
	ENV 1, 2, 1
	DOT
	n4 9
	DOT
	n4 16
	LOOP 0, .2c

.2d
	n2 18
	n2
	n2 18
	n2
.2c
	n2 18
	n2 18
	n2
	n2 18
	n2
	n2 18
	n2 18
	n2
	LOOP 1, .2d

	n2 21
	n2
	n2 23
	n2

	; ---------------------------- 

	TONE 0
	VOL .vol
	KEY O3 - 2
	ENV 1, 2
	n2 2
	n2 6
	n2 4
	n2 6
	n3 2
	n2 2
	n2 4
	LOOP 0, .3a
.3b
	SHORT n2
	SHORT n1 19
	SHORT n1 20
	SHORT n1 21
	SHORT n1 22
	n2 23
	n2
	VOL .vol2 - 2
	n2 23
	n2

	VOL .vol
	n3 23
	n2 22
	n2 20
	n3 18
	SHORT n3 20
	VOL .vol - 2
	SHORT n3 20
	VOL .vol - 4
	SHORT n3 20
	VOL .vol - 6
	SHORT n3 20
	VOL .vol - 8
	SHORT n3 20
	VOL .vol - 10
	SHORT n3 20

	TONE 0
	VOL .vol
	KEY O3 - 2
	ENV 1, 2
.3a
	n2 6
	n2 14
	n3 9

	n2 2
	n2 6
	n2 4
	n2 6
	n3 2
	n2 2
	n2 4
	n2 6
	n2 14
	n3 9

	TONE 1
	KEY O4 - 2
	ENV 3, 1
	n1 19
	n1 20
	n1 21
	n1 22
	n2 23
	n2
	VOL .vol2 - 2
	n2 23
	n2
	VOL .vol
	n2 22
	n2
	VOL .vol2 - 2
	n2 22
	n2
	VOL .vol
	n3 22
	LOOP 1, .3b

	; ---------------------------

	TONE 1
	KEY O4 - 2
	ENV 1, 7, 1
	n3 6
	n3 15
	n3 13
	n2 11
	n2 9
	n3 8
	n3 11
	LOOP 0, .4a
.4b
	TONE 1
	ENV 3, 1
	SHORT n2
	SHORT n1 19
	SHORT n1 20
	SHORT n1 21
	SHORT n1 22
	n2 23
	n2
	VOL .vol2 - 2
	n2 23
	n2

	VOL .vol
	n3 23
	n2 22
	n2 20

	TONE 1
	ENV 1, 7, 1
	n3 11
.4a
	TIE 1
	n2 13
	ENV 2, 1
	DOT n3 13
	TIE 1
	ENV 1, 7, 1
	n2 14
	ENV 1, 1
	n2 14
	TIE 1
	ENV 1, 7, 1
	n2 18
	ENV 1, 1
	n2 18
	TIE 1
	ENV 1, 7, 1
	n2 16
	ENV 1, 1
	n2 16
	TIE 1
	ENV 1, 7, 1
	n2 18
	ENV 1, 1
	n2 18
	ENV 1, 7, 1
	n4 20
	n3 18
	n3 21
	n3 20
	n3 18
	n4 20
	n3 21
	n2 20
	n2 21
	n3 18
	n3 20
	n4 16
	n3 18
	n2 15
	n2 16
	n3 13
	n3 11

	TONE 0
	n4 8
	n3 9
	n4 11
	n3 13
	n4 8
	n3 9
	n4 11
	n3 13
	n2 8
	n2 9
	n5 8
	LOOP 1, .4b

	; --------------------------------

	TONE 1
	KEY O5 - 2
	n3
	n3 6
	n3 15
	n3 13
	n2 11
	n2 9
	n3 8
	n3 11
	TIE 1
	n4 13
	ENV 3, 1
	n4 13
	ENV 1, 7, 1
	n3 8
	n3 11
	n4 13
	n3 16
	n2 18
	n2 16
	n3 15
	n3 16
	TIE 1
	n4 13
	ENV 5, 1
	n5 13
	DOT
	n4

	ENV 1, 7, 1
	n2 8
	n2
	n2 13
	n2
	n2 16
	n2
	TIE 1
	n4 20
	ENV 3, 1
	n4 20
	LOOP 0, .5a

.5b
	TONE 2
	VOL .vol2
	ENV 1, 4, 1
	n2 4
	n2
	n2 6
	n2
	n4 8
	n2 6
	n2
	n2 4
	n2 6
	n3 3
	n3 11
	TIE 1
	n4 8
	ENV 3, 1
	n4 8

.5a
	TONE 1
	VOL .vol
	ENV 1, 7, 1
	n2 16
	n2
	n2 18
	n2
	n4 20
	n3 18
	n2 16
	n2 18
	n2 15
	n2
	n2 11
	n2
	TIE 1
	n4 13
	ENV 4, 1
	n4 13
	LOOP 1, .5b

	ENV 1, 7, 1
	n2 16
	n2
	n2 18
	n2
	n4 20
	n3 18
	n2 16
	n2 18
	n2 15
	n2
	n2 11
	n2
	TIE 1
	n4 13
	ENV 8, 1
	n5 13
	DOT
	n5
	LOOP 0, SQ1_HEART



TRI_HEART:
.vol = - $30 + 48
.vol2 = - $30 + 14
	VOL .vol
	KEY O3 + 3
	LOOP 0, .begin
.1
	DOT n4 8
	DOT n4 8
	DOT n4 10
	n4 18
	n3 10
.begin
	DOT n4 4
	DOT n4 4
	DOT n4 4
	DOT n4 4
	LOOP 1, .1

	DOT n3 8
	DOT n3 8
	n3 8
	n3 8
	n3 8

	VOL .vol + 20
	n3 6
	n3 1
	n3 3
	n2 6
	n2 8
	n3 10
	n3 13

	; ----------------------
	VOL .vol2
	LOOP 0, .2a
.2b
	n2 4
.2a
	n2 4
	n2 20
	n2 10
	n2 11
	n2 8
	LOOP 1, .2b
	n2 13
	n2 6
	n2 22
	n2 1
	n2 4
	n2 6
	n2 3
	VOL .vol
	n3 1
	n3 3
	n3 6
	VOL .vol2
.2c
	n2 8
	n2 20
	n2 13
	n2 15
	n2 11
	n2 3
	LOOP 2, .2c

	n2 6
	n2 18
	VOL .vol
	n3 1
	n3 6

	DOT n4 4
	DOT n4 4
	DOT n4 4
	DOT n4 4
	DOT n4 8
	DOT n4 8
	DOT n4 10
	n2 18
	n2 6
	n2 8
	n2 10
	VOL .vol2
	n2 13
	n2 10
	VOL .vol
	n3 4
	VOL .vol2
	n2 4 + 24
	n2 4 + 24
	n3 4 + 12
	VOL .vol
	n2 4
	VOL .vol2
	n2 20
	n2 18
	n3 20
	VOL .vol
	n3 4
	VOL .vol2
	n2 4 + 24
	n2 3 + 24
	KEY O3 + 4
	n2 31
	KEY O3 + 3
	n2 3 + 24
	VOL .vol
	n2 4
	VOL .vol2
	n2 23
	n2 20
	n2 6
	n2 8
	n2 10

	n3 8
	n3 8
	n3 8
	n2 8
	n2 8
	n2 8
	n2 8 + 12
	n2 8
	n2 8 + 12
	VOL .vol + 20
	n3 6
	n3 1
	n3 3
	n2 6
	n2 8
	n3 10
	n3 13

	; ----------------------- 

	VOL .vol2
	LOOP 0, .3a
.3b
	n2 4
.3a
	n2 4
	n2 20
	n2 10
	n2 11
	n2 8
	LOOP 1, .3b
	n2 13
	n2 6
	n2 22
	n2 1
	n2 4
	n2 6
	n2 3
	VOL .vol
	n3 1
	n3 3
	n3 6
	VOL .vol2
.3c
	n2 8
	n2 20
	n2 13
	n2 15
	n2 11
	n2 3
	LOOP 2, .3c
	VOL .vol
	n3 6
	n3 1
	n3 3
	END
