
ETUDEFORGHOSTS:
	TRACK SQ1_ETUDE, SQ2_ETUDE, TRI_ETUDE, $0000, MODULATION_ETUDE
MODULATION_ETUDE:
	.dw $0000, $0080
TRI_ETUDE:
	TEMPO 6
	VOL $18
	LOOP 0,.begin
.1
	KEY O3 -5
	DOT
	n5 1
	n5
	n3
	KEY O4
	n4 1
	DOT
	n3 25
	KEY O3
	n4 1
	n4 25
	n1
	n3 1
	n3
.begin
	KEY O3 +3
	n1 10
	n1 25
	n1 22
	n1 17
	n1 25
	n1 22
	n1 10
	n1 25
	n1 22
	n1 17
	n1 25
	n1 22

	n1 9
	n1 27
	n1 24
	n1 8
	n1 27
	n1 24
	n1 7
	n1 29
	n1 22
	n1 6
	n1 25
	n1 22
	n1 3
	n1 24
	n1 6
	n1 3
	n1 30
	n1 10
	n1 1
	n1 22
	n1 5
	n1 10
	n1 29
	n1 25
	n1 16
	n1 28
	n1 22
	n1 12
	n1 31
	n1 24
	n1 5
	n1 29
	n1 24
	n1 17
	n2 29

	KEY O3
	n1 1
	n1 20
	n1 23
	DOT
	n2 29
	n1 6
	n1 18
	n1 21
	DOT
	n2 30
	n1 3
	n1 22
	n1 25
	DOT
	n2 31
	n1 8
	n1 20
	n1 23
	DOT
	n2 27
	n1 9
	n1 16
	n1 23
	DOT
	n2 25
	n1 4
	n1 16
	n1 21
	DOT
	n2 28
	n1 2
	n1 22
	n1 25
	DOT
	n2 31
	DOT
	n3 8
	LOOP 1,.1
	TEMPO 9
	n3
	n3 13
	n3 25
	n3 24
	n3 23
	n3 22
	n3 21
	n3 20
	n3 19
	n3 18
	TEMPO 6
	n1 20
	n1 8
	n1 3
	KEY O3 -6
	DOT
	n2 2
;2
	n1 7
	n2 7+12
	n1 7+12
	n2 7
	n1 7
	n2 7+12
	n1 7+12
	n2 7
	n1 6
	n2 6+12
	n1 6+12
	n2 6
	n1 5
	n2 5+12
	n1 5+12
	n2 5
	n1 4
	n2 4+12
	n1 4+12
	n2 4
	n1 3
	n2 3+12
	n1 3+12
	n2 3
	n1 2
	n2 2+12
	n1 2+12
	n2 2
	n1 1
	n2 1+12
	n1 1+12
	n2 1
	n1 2
	n2 2+12
	n1 2+12
	n2 2
	n2 2
	n3

	TEMPO 9
	n3 3
	n3 27
	n3 22
	n3 15
	n3 5
	n3 29
	n3 24
	n3 17
	n2 7
	n2 26

	KEY O3
	n2 25
	n2 29
	n2 20
	n2 20
	n2 13
	n2 29
	n5 1
	n4 1
	DOT
	n5
	KEY O3 -5
	n3 1
	KEY O4 -5
	n3 25
	n3 1
	KEY O3 -5
	n3 1
	DOT
	n5
	KEY O3
	n3 1
	KEY O5 -5
	n3 25
	KEY O3 -5
	n3 13
	n3 1
	DOT
	n3
	TEMPO 6
	n2
.2
	DOT
	n2 1
	LOOP 12,.2
	DOT
	n5
	n1

	n4 18
	DOT
	n3 30
	n1
	n4 6
	n4 30
	DOT
	n1
	n3 1
	DOT
	n1
	LOOP 0,.begin

SQ1_ETUDE:
	TEMPO 6
	TONE 2
	VOL 11
	KEY O5 -5
	ENV 2,1
	LOOP 0,.begin
.1
	n1 18
	n1 16
	n1 11
	n1 6
	n1 4
	n1 11
	n1 6
	n1 4
	KEY O2 +1
	n1 31
	n1 26
	n1 24
	n1 19
	n1 26
	n1 24
	n1 19
	n1 14
	n1 12
	n1 7
	n1 2
	KEY O2 -5
	n1 6
	n1 4
	n1 6
	n1 8
	n1 13
	n1 18
	n1 20
	KEY O4 -5
	n1 13
	n1 8
	n1 6
	n1 1
	n1 6
	n1 8
	n1 13
	n1 18
	n1 20
	n1 25
	n1 30
	KEY O6 -5
	n1 8
	n1 13
	n1 18
	n1 20
	n4 25

	KEY O5
	n4 1
	DOT
	n3 25
	KEY O4
	n4 1
	n4 25
	n1
	KEY O5 -5
	n3 30
	n3
.begin
	n1 1
	n1 9
	n1 13
	n2 25
	n1 13
	n2 26
	n1 14
	n2 25
	n1 13
	n2 17
	n1 5
	n2 16
	n1 4
	n2 25
	n1 13
	n2 23
	n1 11
	DOT
	n2 23
	DOT
	n2 20
	DOT
	n2 21
	DOT
	n2 18
	DOT
	n2 20
	DOT
	n2 24
	TIE 1
	DOT
	n3 13
	n1 13
;2
	n2 25
	n1 25
	n1 23
	n1 22
	DOT
	n2 23
	TIE 1
	DOT
	n2 26
	n1 26
	n2 27
	n1 27
	n1 25
	n1 24
	DOT
	n2 25
	TIE 1
	DOT
	n2 28
	n1 28
	n2 30
	n1 30
	n1 28
	n1 26
	DOT
	n2 28
	KEY O5 -3
	TIE 1
	DOT
	n2 31
	n1 31
	n1 30
	n1 28
	n1 25
	n1 22
	n1 18
;3
	n1 23
	LOOP 1,.1

	KEY O4 -3
	n1 1
	n1 3
	n1 4
	n1 6
	n1 8
	n1 9+12
	n1 11+12
	n1 13+12
	n1 15+12
	n1 16+12
	n1 18+12
;4
	KEY O4
	n2 17
	n1 17+12
	n2 17
	n1 17+12
	n2 18
	n1 18+12
	n2 17
	n1 17+12
	n2 17
	n1 17+12
	n2 15
	n1 15+12
	n2 15
	n1 15+12
	n2 17
	n1 17+12
	n2 15
	n1 15+12
	n2 13
	n1 13+12
	n2 13
	n1 13+12
	n2 15
	n1 15+12
	n2 13
	n1 13+12
	n2 13
	n1 13+12
	n2 13
	n1 13+12

	n1 13
	n1 17
	n1 22
	n1 24
	n1 25
	n1 25
	n1 22
	n1 18
	n1 15
	n1 13
	n1 10
	n1 6
	n1 3
	n2 1
;5
	n2 8
	n1 8+12
	n2 8
	n1 8+12
	n2 9
	n1 9+12
	n2 8
	n1 8+12
	n2 8
	n1 8+12
	n2 6
	n1 6+12
	n2 6
	n1 6+12
	n2 8
	n1 8+12
	n2 4
	n1 4+12+2
	n2 4
	n1 4+12
	n2 4
	n1 4+12
	n2 4
	n1 4+12-3
	n2 4
	n1 4+12
	n2 4
	n1 4+12
	n2 3
	n1 3+12

	n1 3
	n1 7+12
	n1 10+12
	n1 12+12
	n1 20
	n1 18
	n1 15
	n1 12
	n1 8
	n1 6
	KEY O3 -5
	n1 13
	n1 11
	n1 8
	n1 1
;6
	KEY O5 -6
	n1 31
	n1 27
	n1 26
	n1 22
	n1 19
	n1 15
	n1 14
	n1 10
	n1 7
	n1 3
	n1 2
	KEY O4
	n1 4
	n1 1
	n1 4
	n1 8
	n1 9
	n1 13
	n1 16
	n1 20
	n1 21
	n1 25
	n1 28
	KEY O5 -4
	n1 24
	n1 25
	n1 31
	n1 27
	n1 26
	n1 22
	n1 19
	n1 15
	n1 14
	n1 10
	n1 7
	n1 3
	n1 2
	KEY O4 +2
	n1 4
	n1 1
	n1 4
	n1 8
	n1 9
	n1 13
	n1 16
	n1 20
	n1 21
	n1 25
	n1 28
	KEY O5 -2
	n1 24
	n1 25
.2
	n1 20
	n1 22
	n1 27
	n1 19
	n1 22
	n1 27
	n1 18
	n1 22
	n1 27
	n1 19
	n1 22
	n1 27
	LOOP 1,.2

	n1 31
	n1 27
	n1 26
	n1 22
	n1 19
	n1 15
	n1 14
	n1 10
	n1 7
	n1 3
	n1 2
	KEY O4 +4
	n1 4
	n1 1
	n1 4
	n1 8
	n1 9
	n1 13
	n1 16
	n1 20
	n1 21
	n1 25
	n1 28
	KEY O4 +6
	n1 30
	n1 31
.3
	n1 14
	n1 12
	n2 10
	n1 10
	n1 12
	LOOP 4,.3
	n1 14
	n1 12
	n3 10
	KEY O4 -5
	n1 1
	n1 8
	n1 13
	n1 20
	n1 25
	KEY O5 -5
	n1 20
	DOT
	n3 25
	KEY O4 -5
	DOT
	n3 1
	KEY O4 +2
	DOT
	n3 30
	n1 30
	n1 25
	n1 23
	n1 18
	n1 13
	n1 11
	n1 18
	n1 13
	n1 11
	n1 6
	n1 1
	KEY O3 -5
	n1 30
	KEY O4 +2
	n1 6
	n1 1
	KEY O2 -5
	n1 30
	n1 25
	n1 20
	n1 18
	n1 13
	n1 8
	n1 6
	n1 4
	n1 6
	n1 8
	n1 13
	n1 18
	n1 20
	KEY O4 -5
	n1 13
	n1 8
	n1 6
	n1 1
	n1 6
	n1 8
	n1 13
	n1 18
	n1 20
	n1 25
	n1 30
	KEY O5 +1
	n1 14
	n1 19
	n1 24
	n1 26
	DOT
	n3 31
	KEY O4
	DOT
	n3 1
	KEY O4 +1
	DOT
	n3 31
	n1 31
	n1 26
	n1 24
	n1 19
	n1 14
	n1 12
	n1 19
	n1 14
	n1 12
	KEY O2 +1
	n1 31
	n1 26
	n1 24
	n1 31
	n1 26
	n1 24
	n1 19
	n1 14
	n1 12
	n1 7
	n1 2
	KEY O2
	n1 1
.4
	n1 8
	n2 3
	LOOP 12,.4
	n1 8
	n1 1
	n1 3
	n1 8
	n1 13
	n1 15
	KEY O4 -5
	n1 13
	n1 8
	n1 6
	n1 1
	n1 6
	n1 8
	n1 13
	n1 18
	n1 20
	n1 25
	n1 30
	KEY O5 +1
	n1 14
	n1 19
	n1 24
	n1 26
	DOT
	n3 31
	n1

	KEY O5
	n4 1
	DOT
	n3 25
	n1
	KEY O4
	n4 1
	n4 25
	DOT
	n1
	KEY O5 -5
	n3 30
	DOT
	n1
	LOOP 0,.begin

SQ2_ETUDE:
	TEMPO 6
	TONE 2
	VOL 10
	ENV 2,1
	LOOP 0,.begin
.1
	n4
	n1
	KEY O3 -5
	TEMPO 9
	n2 1
	n2 13
	n2 1
	n2 13
	n2 13
	n2 1
	n2 13
	n2 25
	KEY O5 -5
	n2 13
	TEMPO 6
	n4 25

	KEY O4 -5
	n4 13
	DOT
	n3 25
	n4 1
	n4 25
	n1
	KEY O5 -5
	n2 25
	DOT
	n3
.begin
	KEY O4 +4
	DOT
	n2
	n2 24
	n1 12
	n2 21
	n1 9
	n2 24
	n1 12
	n2 28
	n1 16
	n2 28
	n1 16
	n2 21
	n1 9
	n3 21
	n1
	n1 14
	n2
	DOT
	n2 11
	DOT
	n2 12
	DOT
	n2 9
	DOT
	n2 11
	n1 15
	DOT
	n3 8

	n2
	n1 16
	n1 4
	n1 2
	n1 1
	DOT
	n2 2
	TIE 1
	n3 5
	n1 5
	n1 18
	n1 6
	n1 4
	n1 3
	DOT
	n2 4
	TIE 1
	n3 7
	n1 7
	n1 21
	n1 9
	n1 7
	n1 5
	DOT
	n2 7
	n3 12
	n4
	n2
	n1
	LOOP 1,.1
;2
	n1 6
	n1 8
	n1 9
	n1 11
	n1 13
	n1 14

	n2 9
	n1 21
	n2 9
	n1 21
	n2 9
	n1 21
	n2 9
	n1 21
	n2 8
	n1 20
	n2 8
	n1 20
	n2 7
	n1 19
	n2 7
	n1 19
	n2 6
	n1 18
	n2 6
	n1 18
	n2 5
	n1 17
	n2 5
	n1 17
	n2 4
	n1 16
	n2 4
	n1 16
	n2 3
	n1 15
	n1 3
	n1 25
	n1 30
	KEY O4 +6
	n1 30
	n2 31
	n4
	n1
	KEY O4 -6
	n2 10
	n1 22
	n2 10
	n1 22
	n2 12
	n1 24
	n2 10
	n1 22
	n2 6
	n1 21
	n2 6
	n1 21
	n2 5
	n1 21
	n2 5
	n1 21
	n2 4
	n1 19
	n2 4
	n1 19
	n2 3
	n1 15
	n2 3
	n1 15
	n2 2
	n1 17
	n2 2
	n1 17
	n2 1
	n1 16
	n1 1
	n1 13
	n1 16
	n1 21
	n1 18
	n1
	TEMPO 9
	DOT
	n5
	n5
	n3 11
	n3 14
	n3 11
	n3 14
;3
	TEMPO 6
	n4
;	n1
	n1 2
	n1 6
	n1 9
	n1 11
	n1 14
	n1 18
	n1 21
	n1 23
	n1 26
	n1 30
	KEY O4
	n1 27
	n1 29
	TEMPO 9
	n2
	n3 13
	n3 12
	n3 11
	n3 10
	n3 9
	SHORT
	n3 8
	DOT
	n3
	SHORT
	n2
	KEY O3 -5
	n3 1
	KEY O4 -5
	n3 25
	KEY O3 -5
	n4
	n2 13
	n2 1
	n2 13
	n2 1
	n2 13
	n2 13
	n2 1
	n2 13
	n2 25
	KEY O5 -5
	n2 13
	n2 25
	n2
	KEY O2
	n3 1
	KEY O6 -5
	n3 1
	n2 25
	KEY O3 -5
	DOT
	n3
	n2 13
	n2 1
	n2 13
	n3
	DOT
	n5
	n2 13
	n2 13
	n2 1
	n2 13
	n2 25
	KEY O5 -5
	n2 13
	n2 25

	TEMPO 6
	n3
	KEY O4 -5
	n4 13
	DOT
	n3 25
	n1
	n4 1
	n4 25
	DOT
	n1
	KEY O5 -5
	n2 25
	n2
	DOT
	n1
	LOOP 0,.begin
