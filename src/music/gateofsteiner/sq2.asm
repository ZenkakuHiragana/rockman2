.sq2_part1_s
    TONE 2
    VOL 10
    KEY O3
    ENV 4,3
.sq2_part1_s_A1
    n2
	n2 3 + 12
	n2 8 + 12
	n2 11 + 12
    LOOP 3, .sq2_part1_s_A1
.sq2_part1_s_A2
    n2
    n2 3 + 12
    n2 8 + 12
    n2 10 + 12
    LOOP 3, .sq2_part1_s_A2
.sq2_part1_s_A3
    n2
    n2 1 + 12
    n2 8 + 12
    n2 9 + 12
    LOOP 3, .sq2_part1_s_A3

    n2
    n2 10
    n2 6 + 12
    n2 8 + 12
    n2
    n2 10
    n2 6 + 12
    n2 8 + 12
    n2
    n2 3 + 12
    n2 6 + 12
    n2 8 + 12
    ENV 5,1
    n4 3 + 12
    ENV 4,3

.sq2_part1_s_B1
    n2 8
    n2 3 + 12
    n2 10 + 12
    n2 11 + 12
    LOOP 3, .sq2_part1_s_B1
.sq2_part1_s_B2
    n2 8
    n2 2 + 12
    n2 8 + 12
    n2 10 + 12
    LOOP 3, .sq2_part1_s_B2
    RETURN

.sq2_part2_s
    TONE 1
    DOT n3
    n5 9
    n5 9
    n5 11
    n5 8
    n5 9
    n5 8
    n5 9
    n5 8

    n5 9
    n5 9
    n5 11
    n5 11
    DOT n3 4 + 12
    n3 2 + 12
    DOT n3
    DOT n3 1 + 12
    n3 11
    DOT n3
    DOT n3 9
    n3 9
    DOT n3 10
    RETURN

.sq2_part3_s1
    DOT n3 6 + 12
    DOT n3 6 + 12
    n3 11 + 12
    DOT n3 9 + 12
    DOT n3 8 + 12
    n3
    DOT n3 4 + 12
    DOT n3 4 + 12
    n3 8 + 12
    DOT n3 4 + 12
    n4 4 + 12
    n2
    RETURN
.sq2_part3_s2
    DOT n3 6 + 12
    DOT n3 6 + 12
    n3 11 + 12
    DOT n3 7 + 12
    n4 7 + 12
    n4
    n4 9
    n2
    n4 8
    n2
    n2 8
    n3 4
    RETURN
.sq2_part3_s3
    n3 6 + 12
    n2 9 + 12
    n3 11 + 12
    n3 1 + 12 + 12
    DOT n3 11 + 12
    n2 9 + 12
    n2 2 + 12
    n3 6 + 12 + 12
    n3 4 + 12 + 12
    n5 6 + 12 + 12
    DOT n4 4 + 12 + 12
    RETURN

.sq2_start
    n1
.sq2_loop
    CALL .sq2_part1_s
    ENV 5,1
    n2
    n2 1 + 12
    n2 8 + 12
    n4 9 + 12
    n2
    n4 5 + 12 + 12
    n4 11 + 12
    n2
    n2 1 + 12
    n2 4 + 12
    TIE
    n2 8 + 12
    n4 8 + 12
    DOT n5 8

.sq2_part2
    CALL .sq2_part2_s
    DOT n3 1 + 12
    n3 4 + 12

    LOOP 0, .sq2_part3
.sq2_part3_1
    CALL .sq2_part3_s2
.sq2_part3
    TONE 2
    ENV 6,1
    CALL .sq2_part3_s1
    LOOP 1, .sq2_part3_1
    CALL .sq2_part3_s3
    n4 6 + 12
    n3

.sq2_part4
    CALL .sq2_part1_s
.sq2_part4_A1
    n2 7
    n2 1 + 12
    n2 7 + 12
    n2 9 + 12
    LOOP 3, .sq2_part4_A1
    n2 8
    n2 3 + 12
    n2 10 + 12
    n2 11 + 12
    n2 8
    n2 3 + 12
    n2 10 + 12
    n2 11 + 12
    n2 3
    n2 10
    n2 5 + 12
    n2 6 + 12
    n2 3
    n2 10
    n2 5 + 12
    n2 6 + 12

    KEY O3 - 3
    n2 -2 + 3
    n2 5 + 3
    n2 12 + 3
    n2 1 + 12 + 3
    n2 -2 + 3
    n2 5 + 3
    n2 12 + 3
    n2 1 + 12 + 3
    n2 5 + 3
    n2 12 + 3
    n2 7 + 12 + 3
    n2 8 + 12 + 3
    n2 5 + 3
    n2 12 + 3
    n2 7 + 12 + 3
    n2 8 + 12 + 3
    
    n2 3
    n2 7 + 3
    n2 2 + 12 + 3
    n2 3 + 12 + 3
    n2 3
    n2 7 + 3
    n2 2 + 12 + 3
    n2 3 + 12 + 3
    n2 3 + 3
    n2 10 + 3
    n2 5 + 12 + 3
    n2 6 + 12 + 3
    n2 3 + 3
    n2 10 + 3
    n2 5 + 12 + 3
    n2 6 + 12 + 3
    
.sq2_part4_A2
    n2 6 + 3
    n2 1 + 12 + 3
    n2 8 + 12 + 3
    n2 9 + 12 + 3
    LOOP 3, .sq2_part4_A2
    ENV 9,1
    n2 1 + 3
    n2 8 + 3
    n2 11 + 3
    n2 8 + 12 + 3
    n2 1 + 3
    n2 8 + 3
    n2 11 + 3
    n2 2 + 12 + 3
    SHORT n3 1 + 12 + 3
    SHORT n3 2 + 12 + 3
    SHORT n3 11 + 3
    n3 1 + 12 + 3
    n3 9 + 3
    n3 11 + 3
    n3 8 + 3
    n6 9 + 3

.sq2_part5
    KEY O3
    CALL .sq2_part2_s
    n4 1 + 12
    DOT n3 4 + 12

.sq2_part6
    VOL 10
    ENV 5,1
    n0 1 + 12
    n0 6 + 12
    n5 9 + 12
    n2 4 + 12
    TIE
    n3 11 + 12
    n0 11 + 12
    TIE 2
    n4 1 + 12 + 12
    n2 1 + 12 + 12
    n0 1 + 12 + 12
    n2 1 + 12
    TIE
    DOT n4 8 + 12
    DOT n2 8 + 12
    n2 6 + 12
    n3 11 + 12
    TIE
    n3 6 + 12
    n0 6 + 12
    n2 8 + 12
    n2 9 + 12
    n2 8 + 12

    DOT n3 2 + 12
    TIE 2
    n4 9 + 12
    n2 9 + 12
    n0 9 + 12
    DOT n3 4 + 12
    DOT n3 11 + 12
    n3 1 + 12 + 12

    n2 6 + 12
    n3 1 + 12
    n3 11
    n2 9
    n3 4
    n2 1
    KEY O2
    TIE
    DOT n4 1
    n2 1

.sq2_part7
    TONE 2
    KEY O3
    ENV 6,1
    CALL .sq2_part3_s1
    CALL .sq2_part3_s3
    n3
    CALL .sq2_part3_s1
    CALL .sq2_part3_s2
    CALL .sq2_part3_s1
    CALL .sq2_part3_s3
    n3
    TONE 1
    VOL 12
	ENV 4,1
    n3 6 + 12 + 12
    n2 1 + 12 + 12
    TIE
    n4 6 + 12
    n2 6 + 12

    TONE 1
    VOL 6
    ENV 12,1
    n5 6 + 12 + 12
    n6 6
    LOOP 0, .sq2_start