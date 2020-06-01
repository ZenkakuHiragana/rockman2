
    TONE 2
    VOL 15
    KEY O2
    ENV 3, 2
    MOD MOD_1d2t1f
    BENDSPEED 2
    DOT n3 1
    DOT n3 7
    DOT n3 1 + 12
    DOT n3 7
    n3 6
    n3 4
    DOT n3 1
    DOT n3 7
    DOT n3 1 + 12
    DOT n3 4 + 12
    n3 10
    n3 11
    DOT n3 1
    DOT n3 7
    DOT n3 1 + 12
    DOT n3 7
    n3 6
    n3 4
    DOT n3 1
    DOT n3 7
    n3 11
    DOT n3 10
    n2 9

    ENV 8, 1
.sq1_loop_start
    KEY O3
    n2 11
    n2 12
    n2 1 + 12
    n2 2 + 12

    DOT n4 3 + 12
    DOT n4 4 + 12
    n4 11 + 12
    MOD MOD_1d1t1f
    DOT n3 10 + 12
    MOD MOD_1d2t1f
    DOT n3 4 + 12 + 12
    TIE
    n5 3 + 12 + 12
    n3 3 + 12 + 12

    n3
    BEND n4 1 + 12 + 12, n4 11 + 12
    n3 9 + 12
    DOT n3 8 + 12
    DOT n3 9 + 12
    n3 6 + 12
    DOT n4 7 + 12
    DOT n4 8 + 12
    n4

    DOT n4 3 + 12
    DOT n4 4 + 12
    n4 11 + 12
    MOD MOD_1d1t1f
    DOT n3 10 + 12
    MOD MOD_1d2t1f
    DOT n3 4 + 12 + 12
    TIE
    n5 3 + 12 + 12
    n3 3 + 12 + 12

    n3
    BEND n4 1 + 12 + 12, n4 11 + 12
    KEY O4
    n3 7 + 12
    DOT n3 6 + 12
    DOT n3 4 + 12
    n3 1 + 12
    DOT n4 12
    DOT n4 1 + 12
    LOOP 1, .sq1_loop_start

.sq1A
    n2 4
    n2 8
    n2 1 + 12
    n2 4 + 12
    TIE
    DOT n5 7 + 12
    n2 7 + 12
    n2 4 + 12
    n2 1 + 12
    n2 8
    MOD MOD_1d1t1f
    DOT n5 7
    MOD MOD_1d2t1f

    n2 4
    n2 8
    n2 1 + 12
    n2 4 + 12
    TIE
    DOT n5 7 + 12
    n2 7 + 12
    n2 4 + 12
    n2 1 + 12
    n2 10 + 12
    DOT n5 7 + 12

    KEY O4 + 3
    LOOP 1, .sq1A

    KEY O4
    LOOP 0, .sq1B
.sq1B1
    DOT n3 6 + 12
    n3 7 + 12
    n4 8 + 12
.sq1B
    n2 9
    MOD MOD_1d1t1f
    n2 10
    MOD MOD_1d2t1f
    n2 11
    n2 12
    DOT n3 1 + 12
    DOT n3 8 + 12
    n3 1 + 12
    DOT n3 7 + 12
    DOT n3 1 + 12
    n3 7 + 12
    DOT n3 6 + 12
    DOT n3 1 + 12
    n3 6 + 12
    DOT n3 4 + 12
    DOT n3 6 + 12
    n3 8 + 12
    DOT n3 9 + 12
    DOT n3 11 + 12
    n3 9 + 12
    DOT n3 8 + 12
    DOT n3 9 + 12
    n3 8 + 12
    DOT n3 7 + 12
    LOOP 1, .sq1B1

    DOT n3 8 + 12
    n3 9 + 12
    DOT n3 10 + 12
    DOT n3 11 + 12
    n3 12 + 12

    LOOP 0, .sq1C
.sq1C1
    n4
.sq1C
    DOT n3 1 + 12 + 12
    DOT n3 7 + 12
    DOT n3 8 + 12
    TIE
    DOT n3 1 + 12
    PITCH 10
    n4 1 + 12
    PITCH0
    DOT n5
    LOOP 1, .sq1C1
    LOOP 0, .sq1_loop_start
