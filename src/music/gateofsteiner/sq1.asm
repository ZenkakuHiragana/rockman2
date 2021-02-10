.sq1_part1_s
	n0 8 + 12
	n0 11 + 12
	n4 4 + 12 + 12
	n4 3 + 12 + 12
	n4 2 + 12 + 12
	TIE
	DOT n3 3 + 12 + 12
	DOT n1 3 + 12 + 12

	n0 10 + 12
	n4 4 + 12 + 12
	n4 3 + 12 + 12
	n4 2 + 12 + 12
	TIE
	DOT n3 3 + 12 + 12
	n1 3 + 12 + 12

	n0 9 + 12
	n0 1 + 12 + 12
	n4 4 + 12 + 12
	n4 3 + 12 + 12
	n4 1 + 12 + 12
	TIE
	DOT n3 3 + 12 + 12
	n1 3 + 12 + 12

	n0 6 + 12
	n0 9 + 12
	n4 1 + 12 + 12
	n4 1 + 12 + 12
	n4 3 + 12 + 12
	n2 6 + 12 + 12
	n2 4 + 12 + 12
	n2 3 + 12 + 12
	n1 1 + 12 + 12

	TONE 2
	KEY O4
.sq1_part1_s1
	n0 8 + 12
	n0 10 + 12
	n4 4 + 12 + 12
	n4 3 + 12 + 12
	n4 2 + 12 + 12
	TIE
	DOT n3 3 + 12 + 12
	n1 3 + 12 + 12
	LOOP 1, .sq1_part1_s1
	RETURN

.sq1_part2_s
	VOL 11
	KEY O4 - 5
	ENV 6,1
	DOT n3 6 + 5
	TIE
	n5 1 + 5
	n3 1 + 5
	n2 6 + 5
	n2 1 + 5
	n2 6 + 5
	DOT n3 8 + 5
	TIE
	n5 1 + 5
	n3 1 + 5
	n2 8 + 5
	n2 1 + 5
	n2 8 + 5
	n4 9 + 5
	n2
	n2 9 + 5
	n2 11 + 5
	n2 9 + 5
	n4 8 + 5
	n2
	n2 8 + 5
	n2 4 + 12 + 5
	TIE
	n2 1 + 12 + 5
	DOT n4 1 + 12 + 5
	n2 -1 + 5
	n2 1 + 5
	DOT n3
	n4 -1 + 5

	n1 -4 + 5
	n1 1 + 5
	DOT n3 6 + 5
	TIE
	n5 1 + 5
	n3 1 + 5
	n2 6 + 5
	n2 1 + 5
	n2 6 + 5
	n3 8 + 5
	n2 9 + 5
	n3 8 + 5
	n5 1 + 5
	n2 1 + 5
	n2 8 + 5
	n2 9 + 5
	n4 11 + 5
	n2
	n2 1 + 12 + 5
	n2 9 + 5
	n4 8 + 5
	n3 4 + 5
	n2 6 + 5
	n2 8 + 5
	n4 6 + 5
	DOT n3 1 + 5
	n3 4 + 5
	DOT n3 6 + 5
	RETURN

.sq1_part3_s1
	DOT n3 1 + 12 + 5
	DOT n3 11 + 5
	n3 4 + 12 + 5
	DOT n3 1 + 12 + 5
	DOT n3 11 + 5
	n2 8 + 5
	n2 9 + 5
	DOT n3 11 + 5
	DOT n3 9 + 5
	n3 4 + 12 + 5
	DOT n3 8 + 5
	n4 9 + 5
	n1
	RETURN

.sq1_part3_s2
	n1
	DOT n3 1 + 12 + 5
	DOT n3 11 + 5
	n3 4 + 12 + 5
	DOT n3 6 + 12 + 5
	n3 4 + 12 + 5
	n2 9 + 12 + 5
	n2 8 + 12 + 5
	n4 1 + 12 + 5
	RETURN

.sq1_part3_s3
	n0 2 + 5
	n0 6 + 5
	n3 11 + 5
	n2 1 + 12 + 5
	n3 2 + 12 + 5
	n3 4 + 12 + 5
	n4 6 + 12 + 5
	n2
	ENV 5,1
	n3 11 + 5
	n3 11 + 12 + 5
	RETURN

.sq1_start
	TONE 1
	VOL 10
	KEY O3
	ENV 4,1
.sq1_loop
	CALL .sq1_part1_s
	n0 4 + 12
	n0 9 + 12
	n4 1 + 12 + 12
	n2
	TONE 1
	ENV 2,1
	n2 1 + 12
	n2 6 + 12
	n1 8 + 12
	n0 1 + 12
	n0 5 + 12
	ENV 3,1
	n4 1 + 12 + 12
	n4 11 + 12
	ENV 5,1
	n5 8 + 12
	DOT n5 1

.sq1_part2
	CALL .sq1_part2_s
	DOT n3 10 + 5
	n3 11 + 5

	LOOP 0, .sq1_part3_1
.sq1_part3
	CALL .sq1_part3_s2
	DOT n3 4 + 5
	n3 2 + 5
	DOT n3 1 + 5
	n4 -1 + 5
	n2
.sq1_part3_1
	VOL 15
	ENV 4,1
	CALL .sq1_part3_s1
	LOOP 1, .sq1_part3

	CALL .sq1_part3_s3
	TIE 2
	n4 11 + 12 + 5
	n3 11 + 12 + 5
	DOT n2 11 + 12 + 5
	n0 3 + 12 + 5
	n0 6 + 12 + 5
	TIE 3
	n5 10 + 12 + 5
	n3 10 + 12 + 5
	n2 10 + 12 + 5
	n1 10 + 12 + 5

.sq1_part4
	VOL 12
	KEY O3
	CALL .sq1_part1_s
	n0 8 + 12
	n0 10 + 12
	n4 4 + 12 + 12
	n4 3 + 12 + 12
	n4 2 + 12 + 12
	n0 10 + 12
	n0 3 + 12 + 12
	KEY O4 + 4
	DOT n3 10 + 12 + 12 - 4

	ENV 3,2
	n0 1 + 12 + 12 - 4
	n0 3 + 12 + 12 - 4
	n2 8 + 12 + 12 - 4
	n2 1 + 12 + 12 - 4
	n2 3 + 12 + 12 - 4
	n2 10 + 12 - 4
	n2 11 + 12 - 4
	n2 8 + 12 - 4
	n2 10 + 12 - 4
	n2 3 + 12 - 4
	n2 6 + 12 - 4
	n2 5 + 12 - 4
	n2 10 - 4
	n2 3 + 12 - 4
	n2 1 + 12 - 4
	n2 8 - 4
	n2 5 - 4
	n1 6 - 4

	n0 5 + 12 + 12 - 4
	n0 8 + 12 + 12 - 4
	n2 10 + 12 + 12 - 4
	n2 3 + 12 + 12 - 4
	n2 5 + 12 + 12 - 4
	n2 12 + 12 - 4
	n2 1 + 12 + 12 - 4
	n2 10 + 12 - 4
	n2 12 + 12 - 4
	n2 5 + 12 - 4
	n2 8 + 12 - 4
	n2 7 + 12 - 4
	n2 3 + 12 - 4
	n2 5 + 12 - 4
	n2 12 - 4
	n2 3 + 12 - 4
	n2 10 - 4
	n1 8 - 4

	KEY O4 + 5
	n0 5 + 12 + 12 - 5
	n0 8 + 12 + 12 - 5
	n2 12 + 12 + 12 - 5
	n2 5 + 12 + 12 - 5
	n2 7 + 12 + 12 - 5
	n2 2 + 12 + 12 - 5
	n2 3 + 12 + 12 - 5
	n2 12 + 12 - 5
	n2 2 + 12 + 12 - 5
	n2 10 + 12 - 5
	n2 8 + 12 - 5
	n2 6 + 12 - 5
	n2 5 + 12 - 5
	n2 3 + 12 - 5
	n2 1 + 12 - 5
	n2 5 + 12 - 5
	n2 10 - 5
	n1 6 - 5
	
	n0 3 + 12 - 5
	n0 6 + 12 - 5
	n2 9 + 12 - 5
	n2 3 + 12 - 5
	n2 6 + 12 - 5
	n2 9 + 12 - 5
	n2 1 + 12 + 12 - 5
	n2 6 + 12 - 5
	n2 9 + 12 - 5
	n2 3 + 12 + 12 - 5
	n2 9 + 12 - 5
	n2 1 + 12 + 12 - 5
	n2 6 + 12 + 12 - 5
	n2 9 + 12 - 5
	n2 1 + 12 + 12 - 5
	n2 6 + 12 + 12 - 5
	n2 9 + 12 - 5
	n2 9 + 12 + 12 - 5

	VOL 8
	n2 8 + 12 - 5
	n2 8 + 12 + 12 - 5
	SHORT n2 8 + 12 - 5
	SHORT n2 8 + 12 + 12 - 5
	SHORT n2 8 + 12 - 5
	SHORT n2 8 + 12 + 12 - 5
	VOL 10
	SHORT n2 8 + 12 - 5
	SHORT n2 8 + 12 + 12 - 5
	n1 8 + 12 - 5
	n1 8 + 12 + 12 - 5
	n1 8 + 12 - 5
	n1 8 + 12 + 12 - 5
	VOL 15
	n1 8 + 12 - 5
	n1 8 + 12 + 12 - 5
	n1 8 + 12 - 5
	n1 8 + 12 + 12 - 5
	n1 8 + 12 - 5
	n1 8 + 12 + 12 - 5
	n1 8 + 12 - 5
	n1 8 + 12 + 12 - 5
	
	VOL 10
	ENV 3,1
	SHORT n2 8 + 12 - 5
	SHORT n2 8 + 12 + 12 - 5
	SHORT n2 8 + 12 - 5
	SHORT n2 8 + 12 + 12 - 5
	SHORT n2 8 + 12 - 5
	SHORT n2 8 + 12 + 12 - 5

	VOL 5
	ENV 7,1
	n2 8 + 12 - 5
	n2 8 + 12 + 12 - 5
	n2 8 + 12 - 5
	n2 8 + 12 + 12 - 5
	ENV 8,1
	n6 8 + 12 - 5

.sq1_part5
	TONE 1
	CALL .sq1_part2_s
	n4 10 + 5
	DOT n3 11 + 5

.sq1_part6
	TONE 2
	VOL 13
	KEY O5 - 5
	ENV 7,3
	
	DOT n3 1 + 12 + 5
	n0
	DOT n3 11 + 5
	n0
	n3 4 + 12 + 5
	DOT n3 1 + 12 + 5
	n0
	DOT n3 11 + 5
	n0
	n2 8 + 5
	n2 9 + 5
	DOT n3 11 + 5
	n0
	n3 9 + 5
	n0
	n2 8 + 5
	n2 9 + 5
	n2 4 + 12 + 5
	DOT n3 8 + 5
	n0
	n4 9 + 5
	n2

	DOT n3 1 + 12 + 5
	DOT n3 11 + 5
	n0
	n3 4 + 12 + 5
	DOT n3 6 + 12 + 5
	n3 4 + 12 + 5
	n2 9 + 12 + 5
	n2 8 + 12 + 5
	n4 1 + 12 + 5

	TONE 1
	KEY O4 - 5
	DOT n3 4 + 12 + 5
	n3 2 + 12 + 5
	DOT n3 1 + 12 + 5
	n3 11 + 5
	n2 8 + 5
	n3 4 + 5

	LOOP 0, .sq1_part7_1
.sq1_part7
	CALL .sq1_part3_s1
	CALL .sq1_part3_s2
	DOT n3 4 + 5
	n3 2 + 5
	DOT n3 1 + 5
	n4 -1 + 5
	n2
.sq1_part7_1
	TONE 1
	KEY O4 - 5
	VOL 15
	ENV 4,1
	CALL .sq1_part3_s1
	CALL .sq1_part3_s3
	TIE 2
	n4 11 + 12 + 5
	n3 11 + 12 + 5
	DOT n2 11 + 12 + 5
	n0 3 + 12 + 5
	n0 6 + 12 + 5
	TIE
	n4 10 + 12 + 5
	n2 10 + 12 + 5
	n2 6 + 5
	n2 10 + 5
	n2 4 + 12 + 5
	LOOP 1, .sq1_part7

.sq1_final
	TONE 2
	KEY O5 - 5
	VOL 9
	ENV 12, 1
	n5 11 + 12 + 5
	n0 1 + 12 + 5
	n0 4 + 12 + 5
	TIE
	DOT n4 10 + 12 + 5
	DOT n2 10 + 12 + 5
	TONE 1
	KEY O4
	n6 1
	LOOP 0, .sq1_start
