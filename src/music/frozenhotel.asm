
FROZENHOTEL:
.tempo = 150
FROZEN_TEMPO = 3600 / .tempo / 4
	TRACK SQ1_FROZEN, SQ2_FROZEN, TRI_FROZEN, NOI_FROZEN, MOD_FROZEN
MOD_FROZEN:
	.dw $0000, $0080
	.dw $2101, $0080
	.dw $8202, $0108
	.dw $0000, $1081
	.dw $5F03, $0080
	.dw $A301, $0188
	.dw $3F02, $1081
	.dw $3F04, $0080
	.dw $A201, $0080
SQ1_FROZEN:
	.beginregion "sq1"
.vol = 11
.vol2 = 9
	TEMPO FROZEN_TEMPO
	TONE 1
	VOL .vol
	KEY O6 -3
	ENV 3, 1
	MOD 1
.1
	n2 8
	n2
	n2 6
	n2 8
	n2
	n2 1
	n2 6
	n2 8
	n2
	n2 6
	n2 8
	n2 13
	n2 15
	n2 13
	n2 8
	n2 6
	LOOP 3, .1

	TONE 0
	KEY O4 -3
	VOL .vol2
	ENV 1, 1, 1
	TIE 1
	DOT
	n4 3
	n2

	VOL 15
	ENV 3, 1
	n1 8 +12
	n1 8 +12
	n1 8 +12
	DOT
	n2 8 +12
	TEMPO FROZEN_TEMPO / 2
	n1 15 +12
.2
	n1 17 +12
	DOT
	n2 18 +12
	n1 17 +12
	n1 16 +12
	n2 15 +12
	VOL 11
	LOOP 1, .2
	VOL 7
	n1 17 +12
	DOT
	n2 18 +12
	n1 17 +12
	n1 16 +12
	n1 15 +12

	VOL .vol2
	ENV 1, 1, 1
	TIE 4
	n5 3
	n5
	n5
	n5
	n5
	DOT
	n4

	VOL 15
	ENV 3, 1
	n2 15 +12
	n2 15 +12

	n2 13 +12
	n1 14 +12
	n3 15 +12
	n1 14 +12
	VOL 11
	n2 13 +12
	n1 14 +12
	n3 15 +12
	n1 14 +12
	VOL 7
	n2 13 +12
	n1 14 +12
	n3 15 +12
	n1 14 +12
	VOL 3
	n2 13 +12
	n1 14 +12
	n3 15 +12
	n1 14 +12

	VOL .vol2
	ENV 1, 1, 1
	TIE 1
	DOT
	n5 3
	n3

	VOL 15
	ENV 6, 1
	SHORT
	n2 6 +12
	SHORT
	n2 7 +12
	TIE 2
	n4 8 +12
	SHORT
	n2
	MOD 4
	n5
	n4

	TEMPO FROZEN_TEMPO
	TONE 1
	VOL .vol
	KEY O6 - 3
	ENV 3, 1
	MOD 1
.3
	n2 8
	n2
	n2 6
	n2 8
	n2
	n2 1
	n2 6
	n2 8
	n2
	n2 6
	n2 8
	n2 13
	n2 15
	n2 13
	n2 8
	n2 6
	LOOP 1, .3

	VOL 15
	KEY O5 -3
	ENV 7, 1
	MOD 1
	n4
	n4 13
	n5 8
	n4
	n4 11
	n5 6
	n4
	n4 4
	n4 6
	n5 3
	n4 1
	n4 4
	n5 6

	TONE 0
	ENV 1, 13 , 1
	n2
.4
	n1 4 +12
	LOOP 6, .4
	MOD 3
	TIE 4
	n2 4 +12
	PITCH -1
	n2
	PITCH 0
	n2
	n4
	MOD 6
	n3
	MOD 3
	TIE 1
	n3 4 +12
	n1

	MOD 1
	SHORT
	n3 9
	SHORT
	n3 10
	SHORT
	n3 9
	DOT
	n2 7
	TIE 2
	n3 4
	n1
	MOD 5
	n4

	MOD 1
	n4
	n2
	TIE 1
	n2 4
	SHORT
	n2
	SHORT
	n2 7
	SHORT
	n2 4
	SHORT
	n2 7
	SHORT
	n2 9
	PITCH -1
	TIE 1
	SHORT
	n2 8
	n2 8
	PITCH 0
	DOT
	n2 9
	n2 7
	TIE 1
	n3 4
	n1

	MOD 3
	TIE 2
	PITCH -1
	n3 11
	PITCH 0
	n4
	MOD 4
	n3
	MOD 1
	TIE 1
	n3 11
	MOD 2
	DOT
	n4 11

	MOD 0
	n4
	n2
	SHORT
	n2 7
	SHORT
	n2 10
	SHORT
	n2 12
	n2 14
	n2 17
	n2 19
	TIE 4
	n2 19
	PITCH -1
	TEMPO 10
	n1
	PITCH 0
	TEMPO 2
	n1
	TEMPO FROZEN_TEMPO
	DOT
	n3
	MOD 7
	DOT
	n3

	MOD 0
	n3 19
	DOT
	n2 17
	DOT
	n2 19
	n2 14
	DOT
	n2 17
	DOT
	n2 12
	n2 14
	DOT
	n2 10
	DOT
	n2 12
	n2 7
	n3 2

	DOT
	n3
	SHORT
	n2 7
	SHORT
	n2 10
	SHORT
	n2 12
	TEMPO 10
	n1 14
	TEMPO 9
	n1 17
	TEMPO 10
	n1 19
	TEMPO 9
	n1 21
	TEMPO 10
	n1 22
	TEMPO FROZEN_TEMPO
	TIE 4
	n2 22
	PITCH -1
	DOT
	n1
	PITCH 0
	n0
	DOT
	n3
	MOD 7
	DOT
	n3
	MOD 0
	n2 22
	SHORT
	n3 21
	SHORT
	n3 22
	SHORT
	n3 21
	TIE 1
	n3 14
	MOD 2
	DOT
	n4
	LOOP 0, SQ1_FROZEN
	.endregion "sq1"

SQ2_FROZEN:
	.beginregion "sq2"
.vol = 9
	TEMPO FROZEN_TEMPO * 2
	TONE 0
	VOL .vol
	KEY O4 -1
	ENV 9, 1
	MOD 1
.1
	n3 9
	n3 7
	n3 12
	n3 5
	n3 5
	n3 3
	n3 4
	n3 2
	LOOP 1, .1

	VOL 5
	KEY O5 -1
.2
	n2 1 +24
	n2 6 +24
	n1 1 +24
	n2 6 +24
	n2 1 +24
	n2 6 +24
	n2 1 +24
	n2 6 +24
	n1 1 +24
	LOOP 3, .2

	VOL .vol
	KEY O4 -1
	n3 9
	n3 7
	n3 12
	n3 5
	n3 5
	n3 3
	n3 4
	n3 2

	TONE 2
	VOL 5
	ENV 1, 1, 1
	n5 6 +12
	n5 6 +12
	n5 6 +12
	n5 6 +12

	TONE 1
	KEY O3 -1
	VOL 15
	ENV 1, 1
.3
	n1 2
	n0 2 +12
	n0 2 +12
	LOOP 31, .3
.4
	n1 5
	n0 5 +12
	n0 5 +12
	LOOP 31, .4
	LOOP 0, SQ2_FROZEN
	.endregion "sq2"

TRI_FROZEN:
	.beginregion "tri"
	TEMPO FROZEN_TEMPO * 2
	VOL $FF - $30
	KEY O3
	MOD 8
.1
	n3 22
	n3 15
	n3 20
	n3 13
	n3 17
	n3 11
	n3 15
	n3 10
	LOOP 1, .1

	n5 5
	n5 5
	n5 5
	n5 5

	n3 22
	n3 15
	n3 20
	n3 13
	n3 17
	n3 11
	n3 15
	n3 10

	n5 20
	n5 19
	n5 20
	n5 19

.2
	n5 10
	LOOP 7, .2
	LOOP 0, .1
	.endregion "tri"

NOI_FROZEN:
	.beginregion "noise"
	TEMPO FROZEN_TEMPO
	VOL 15
.begin
	ENV 3, 1

	n5 5
	n5
	n5 5
	ENV 4, 1, 1
	n5 5
	ENV 1, 1
.1
	n3 5
	n2 12
	n2 8
	n1 8
	n1 12
	n2 12
	n1 1
	n1 12
	n2 8
	n1 12
	n1 8
	n1 1
	n1 12
	n2 1
	n2 8
	n2 1
	n2 1
	n2 12
	n2 8

	n1 12
	n1 8
	n2 1
	n2 12
	n2 8
	n2 1
	n1 12
	n1 8
	n1 1
	n1 12
	n2 8
	n2 12
	n1 1
	n1 12
	n2 1
	n2 8
	n1 1
	n1 1
	n1 1
	n1 1
	n2 12
	n2 8
	LOOP 1, .1

.2
	n3 5
	n2 12
	n2 8
	n1 8
	n1 12
	n2 12
	n1 1
	n1 12
	n2 8
	n1 12
	n1 8
	n1 1
	n1 12
	n2 1
	n2 8
	n2 1
	n2 1
	n2 12
	n2 8

	n1 12
	n1 8
	n2 1
	n2 12
	n2 8
	n2 1
	n1 12
	n1 8
	n1 1
	n1 12
	n2 8
	n2 12
	n1 1
	n1 12
	n2 1
	n2 8
	n1 12
	n1 8
	n1 8
	n1 8
	n1 12
	n1 8
	n1 8
	n1 8
	LOOP 1, .2

	LOOP 0, .3_1
.3
	n1 1
	n1 1
	n1 1
	n1 1
	n2 12
	n2 8
.3_1
	n3 5
	n2 12
	n2 8
	n1 8
	n1 12
	n2 12
	n1 1
	n1 12
	n2 8
	n1 12
	n1 8
	n1 1
	n1 12
	n2 1
	n2 8
	n2 1
	n2 1
	n2 12
	n2 8

	n1 12
	n1 8
	n2 1
	n2 12
	n2 8
	n2 1
	n1 12
	n1 8
	n1 1
	n1 12
	n2 8
	n2 12
	n1 1
	n1 12
	n2 1
	n2 8
	LOOP 1, .3
	n1 12
	n1 8
	n1 8
	n1 8
	n1 8
	n1 8
	n1 8
	n1 8

	LOOP 0, .4_1
.4
	n1 1
	n1 1
	n1 1
	n1 1
	n2 12
	n2 8
.4_1
	n3 5
	n2 12
	n2 8
	n1 8
	n1 12
	n2 12
	n1 1
	n1 12
	n2 8
	n1 12
	n1 8
	n1 1
	n1 12
	n2 1
	n2 8
	n2 1
	n2 1
	n2 12
	n2 8

	n1 12
	n1 8
	n2 1
	n2 12
	n2 8
	n2 1
	n1 12
	n1 8
	n1 1
	n1 12
	n2 8
	n2 12
	n1 1
	n1 12
	n2 1
	n2 8
	LOOP 3, .4
	n1 12
	n1 8
	n1 8
	n1 8
	n1 12
	n1 8
	n1 8
	n1 8
	LOOP 0, .begin
	.endregion "noise"
