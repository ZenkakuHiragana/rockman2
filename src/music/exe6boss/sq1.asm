
.sq1_start
    TONE 1
    VOL 15
    CALL .track_block1a
    CALL .track_block2
    CALL .track_block1b
    CALL .track_block3a
    LOOP 0, .sq1_loop
.sq1A
    TIE
    n3 7 + 4
    MOD 3
    n3 7 + 4
    MOD 0
    TIE 2
    n4 4 + 4
    MOD 3
    DOT n5 4 + 4
    ENV 1, 1
    n4 4 + 4
    MOD 0
    ENV 0, 0
    n2 2 + 4
    n2 4 + 4
.sq1_loop
    TONE 2
    ENV 0, 0
    KEY O4 - 4
    TIE
    n4 6 + 4
    MOD 3
    n3 6 + 4
    MOD 0
    TIE
    n3 2 + 12 + 4
    MOD 3
    n3 2 + 12 + 4
    MOD 0
    TIE 2
    n4 1 + 12 + 4
    MOD 3
    DOT n5 1 + 12 + 4
    ENV 1, 1
    n4 1 + 12 + 4
    MOD 0
    ENV 0, 0
    
    n2 9 + 4
    n2 11 + 4
    TIE
    n3 1 + 12 + 4
    MOD 3
    n4 1 + 12 + 4
    MOD 0
    LOOP 1, .sq1A

    TIE
    n3 5 + 12 + 4
    MOD 3
    n3 5 + 12 + 4
    MOD 0
    TIE 2
    n4 4 + 12 + 4
    MOD 3
    n5 4 + 12 + 4
    ENV 1, 1
    DOT n4 4 + 12 + 4
    MOD 0
    ENV 0, 0

    TONE 0
    MOD MOD_3d1t1f
    TIE
    n3 1 + 4
    PITCH 8
    n3 1 + 4
    PITCH 0

    DOT n4 6 + 4
    n4 1
    n4 3
    n3 4
    DOT n4 6 + 4
    TIE
    n5 4 + 4
    n3 4 + 4

    TONE 2
    ENV 3, 1
    MOD 0
    DOT n4 3 + 12 - 3
    TIE
    n5 4 + 12 - 3
    n3 4 + 12 - 3
    DOT n4 2 + 12 + 4 - 3
    DOT n4 1 + 12 - 3

    TONE 1
    ENV 0, 0
    n2 4 + 12 + 4
    n2 6 + 12 + 4
    n2 8 + 12 + 4
    n2 9 + 12 + 4
    TIE
    n3 11 + 12 + 4
    MOD 3
    DOT n4 11 + 12 + 4
    MOD 0
    ENV 24, 7
    TIE
    n3 9 + 12 + 4
    MOD 3
    n4 9 + 12 + 4
    MOD 0
    ENV 0, 0

    n2 4 + 12 + 4
    n2 6 + 12 + 4
    n3 8 + 12 + 4
    n3 9 + 12 + 4
    n3 11 + 12 + 4
    ENV 18, 7
    n4 1 + 12 + 12 + 4
    ENV 0, 0
    n3 11 + 12 + 4
    n3 9 + 12 + 4
    ENV 6, 7
    n3 8 + 12 + 4
    ENV 0, 0

    TIE
    n3 8 + 12 + 4
    MOD 3
    n4 8 + 12 + 4
    MOD 0
    ENV 30, 7
    TIE
    n3 6 + 12 + 4
    MOD 3
    n4 6 + 12 + 4
    MOD 0
    ENV 0, 0
    n4 1 + 12 + 4
    n4 8 + 12 + 4
    n3 9 + 12 + 4
    ENV 36, 7
    TIE
    n3 6 + 12 + 4
    MOD 3
    DOT n4 6 + 12 + 4
    MOD 0
    n3
    ENV 0, 0

    KEY O5
    TONE 2
    TIE 2
    n3 6 + 12
    MOD 3
    n5 6 + 12
    n3 6 + 12
    MOD 0
    n4 4 + 12
    n4 2 + 12
    n4 11
    n4 6
    n4 7
    ENV 72, 7
    TIE
    n3 8
    MOD 3
    DOT n5 8
    MOD 0
    ENV 0, 0
    n3

    TIE
    n3 6
    MOD 3
    DOT n4 6
    MOD 0
    TIE
    n3 5
    MOD 3
    DOT n4 5
    MOD 0
    TIE 2
    n3 6
    MOD 3
    n5 6
    ENV 1, 1
    n4 6
    MOD 0
    
    VOL 10
    KEY O4
    ENV 3, 5
    n2 9
    n2 6

    n2
    n2 4
    n2 8
    n2 11
.sq1B
    n2 3 + 12
    n2 11
    n2 8
    n2 4
    LOOP 2, .sq1B

    n2
    n2 8
    n2 9
    n2 1 + 12
    n2 6 + 12
    n2 1 + 12
    n2 9
    n2 6
    n2 8 + 12
    n2 1 + 12
    n2 9
    n2 6
    n2 9 + 12
    n2 1 + 12
    n2 9
    n2 6

    n2 11
    n2
    n2 11 + 12
    n2 8 + 12
    n2 4 + 12
    n2 8 + 12
    n2 4 + 12
    n2 11
    n2 8
    n2 11
    n2 8
    n2 6
    n2 4
    n2 8
    n2 11
    n2 2 + 12

    TONE 2
    VOL 15
    CALL .track_block1a
    CALL .track_block2
    CALL .track_block1a
    KEY O3 + 9
    ENV 3, 1
.sq1C1
    SHORT n1 6 + 12 + 5
    SHORT n2 6 + 12
    LOOP 5, .sq1C1
.sq1C2
    SHORT n1 9  + 5
    SHORT n2 9
    LOOP 3, .sq1C2
.sq1C3
    SHORT n1 11 + 5
    SHORT n2 11
    LOOP 3, .sq1C3
.sq1C4
    SHORT n1 12 + 5
    SHORT n2 12
    LOOP 1, .sq1C4

    CALL .track_block1a
    n2 9 + 12 + 2
    n2 9 + 2
    n2 8 + 12 + 2
    n2 9 + 2
    n2 9 + 12 + 2
    n2 9 + 2
    n2 11 + 12 + 2
    n2 9 + 2
    n2 9 + 12 + 2
    n2 4 + 12 + 2
    n2 1 + 12 + 2
    n2 9 + 2
    n2 6 + 2
    n2 4 + 2
    n2 1 + 2
    n2 1

    KEY O4 - 3
    ENV 3, 1
    DOT n3 3
    DOT n3 9
    n3 8
    DOT n3 1 + 12
    DOT n3 12
    n3 5 + 12
    DOT n3 3 + 12
    DOT n3 8 + 12
    n3 6 + 12
    DOT n3 12 + 12
    DOT n3 11 + 12
    n3 3 + 12 + 12
    TONE 1
    LOOP 0, .sq1_loop
