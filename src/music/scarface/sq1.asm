.sq1_intro_s
	n3
	n3 1 + 12 + 12
	n3
	DOT n4 1 + 12 + 12
.sq1_intro_s2
	n3 11 + 12
	n3 11 + 12
	n3
	n3 11 + 12
	n3
	TIE
	n3 11 + 12
	PITCH 1
	n4 11 + 12
	PITCH 0

	n3 8 + 12
	n3 8 + 12
	n3
	n3 8 + 12
	n3
	DOT n4 8 + 12
	RETURN
.sq1A_s
	TONE 1
	MOD MOD_2d2t2f
	n3 4 + 12
	n3 4 + 12
	n3 3 + 12
	n3 -1 + 12
	n3 1 + 12
	n3 1 + 12
	MOD 0

	n4 1
	n1 1
	DOT n2
	n1 1
	DOT n2
	n4 1
	n1 1
	DOT n2
	n3 1
	n4
	n3 1
	n3 1
	n4
	RETURN
.sq1_start
	TONE 0
	VOL 15
	KEY O3
	ENV 8,1
	LOOP 0, .sq1_intro2
.sq1_intro1
	n6 1 + 12 + 12
.sq1_intro2
	n3 1 + 12 + 12
	n3 1 + 12 + 12
	CALL .sq1_intro_s
	LOOP 2, .sq1_intro1
	n5 1 + 12 + 12

	CALL .sq1A_s
	LOOP 0, .sq1A2
.sq1A1
	DOT n4
.sq1A2
	MOD MOD_2d2t2f
	n4 6 + 12
	n4 6 + 12
	n4 6 + 12
	n3 8 + 12
	n4 6 + 12
	n4 4 + 12
	n4 1 + 12
	LOOP 1, .sq1A1
	n3 1 + 12
	n3 11
	n3 8
	n3 4 + 12
	n3 1 + 12
	MOD 0
	TONE 0
	CALL .sq1_intro_s
	n5 1 + 12 + 12
	CALL .sq1A_s
	MOD MOD_2d2t2f
	n4 6 + 12
	n3 6 + 12
	n4 6 + 12
	n4 8 + 12
	n4 6 + 12
	n4 4 + 12
	n4 1 + 12
	DOT n4
	n4 6 + 12
	n3 6 + 12
	n4 6 + 12
	n4 8 + 12
	n4 6 + 12
	n3 6 + 12
	n3 4 + 12
	n3 4 + 12
	n4 1 + 12
	n3 4 + 12
	n3 4 + 12
	n3 8 + 12
	TIE
	BEND n3 8 + 12, n3 7 + 12
	MOD MOD_3d3t1f
	DOT n5 8 + 12
	MOD 0
	TONE 0
	CALL .sq1_intro_s2
	n6 1 + 12 + 12
	END
