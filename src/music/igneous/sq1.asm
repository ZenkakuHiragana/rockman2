
.sq1_start
    TONE 0
    VOL 11
    ENV 12, 1
    KEY O3 - 3
.sq1_intro
    CALL .sq2_intro1
.sq1_loop
    CALL .sq2_intro2
    n2 3 + 10
    n2 3 + 10
    CALL .sq2_intro3
    LOOP 3, .sq1_intro

    KEY O4
    BENDSPEED 1
    TIE
    BEND n5 10, n5 8
    n4 10
    n4 5
    BEND n5 12, n5 10
    TIE
    DOT n4 1 + 12
    PITCH 5
    n3 1 + 12
    PITCH 0
    DOT n5 10
    BENDSPEED 2
    BEND n4 5, n4 3
    n5 3
    n5 5

    TIE
    BEND n5 10, n5 8
    n4 10
    n4 5
    BEND n5 12, n5 10
    n5 1 + 12
    TIE
    BENDSPEED 1
    BEND n5 3 + 12, n5 1 + 12
    n4 3 + 12 + 12
    BEND n4 5 + 12 + 12, n4 1 + 12 + 12
    n5 3 + 12 + 12
    n4 10
    n4 12

    ENV 24, 1
    TIE
    n6 1 + 12
    n5 1 + 12
    BENDSPEED 2
    BEND n4 3 + 12, n4 1 + 12
    n4 1 + 12
    TIE
    DOT n5 10
    PITCH 5
    n4 10
    PITCH 0

    KEY O3
    VOL 12
    ENV 5, 1
    TONE 1
    n2 1
    n2 1
    n2 1
    n2 3
    n2 5
    n2 6
    n2 8
    n2 10
    n2 1 + 12
    n2 1 + 12
    n2 1 + 12
    n2 3 + 12
    n2 5 + 12
    n2 8 + 12
    n2 10 + 12
    n2 1 + 12 + 12

    VOL 11
    ENV 24, 1
    TONE 0
    TIE 2
    n5 3 + 12 + 12
    n4 3 + 12 + 12
    n3 3 + 12 + 12
    n2 1 + 12 + 12
    n2 3 + 12 + 12
    TIE 2
    BEND n4 5 + 12 + 12, n4 3 + 12 + 12
    n3 5 + 12 + 12
    PITCH 5
    n3 5 + 12 + 12
    PITCH 0
    TIE
    DOT n4 1 + 12 + 12
    PITCH 5
    n3 1 + 12 + 12
    PITCH 0
    n5 12 + 12
    n4 10 + 12
    n4 1 + 12 + 12
    DOT n4 12 + 12
    n3 10 + 12
    n5 9 + 12

.sq1B1
    TIE
    n3 10 + 12
    PITCH 8
    n3 10 + 12
    PITCH 0
    VOLDOWN
    VOLDOWN
    VOLDOWN
    VOLDOWN
    LOOP2 2, .sq1B1

    KEY O2
    VOL 11
    ENV 8, 1
    n2
    n2 8
    n2 8
    n3 7
    n3
    n2 7
    n2
    n3 7
    n3 6
    DOT n3
    n2 6
    n2 6
    n3 5

    n3 10
    n3
    n2 10
    n2
    n2 10
    n3 8
    DOT n3
    n2 8
    n2
    n2 8
    n2 8
    n3 7
    n3
    n2 7
    n2
    n2 5
    n2 5
    DOT n3 1 + 12
    DOT n3 10
    n3 10

    n3 10
    n2 10
    n2
    n2 10
    n2
    n2 10
    n4 8
    n2
    n2 8
    n2
    n2 8
    n2 8
    n2 7
    n2 7
    n2 7
    n2
    n2 7
    n2
    n2 7
    n4 6
    n2
    n2 6
    n2
    n2 5
    n2 5

    n2 10
    n2
    n2 10
    n2
    n2 10
    n2
    n2 10
    n2 10
    n2 8
    n2
    n2 8
    n2
    n2 8
    n2
    n3 8
    n2 7
    n2
    n2 7
    n2
    n3 7
    n3 7
    n3 6
    n3 6
    n3 6
    n3 5

    KEY O4
    ENV 24, 1
    BENDSPEED 0
    n5 1 + 12
    BEND n5 12, n5 11
    DOT n5 10
    n4 9
    n5 1 + 12
    n5 12
    TIE
    BEND n5 3 + 12, n5 2 + 12
    n4 3 + 12
    n4 5 + 12
    TONE 1
    n5 10 + 12
    n5 12 + 12
    n5 1 + 12 + 12
    n5 3 + 12 + 12
    TIE 2
    BEND n5 5 + 12 + 12, n5 3 + 12 + 12
    MOD MOD_1d1t2f
    DOT n5 5 + 12 + 12
    MOD 0
    PITCH 1
    n4 5 + 12 + 12
    PITCH 0
    BEND n4 1 + 12 + 12, n4 11 + 12
    n4 12 + 12
    TIE 2
    n6 10 + 12
    DOT n5 10 + 12
    PITCH 5
    n4 10 + 12
    PITCH 0

    KEY O3 - 3
    VOL 12
    ENV 12, 1
    TONE 0
    CALL .sq2C2
    CALL .sq2C1
    CALL .sq2C2
    CALL .sq2_intro1
    CALL .sq2_intro2
    n2 3 + 10
    n2 3 + 10
    n3 3 + 10
    n2
    n2
    n3 3 + 9
    n2
    n2
    n3 3 + 8
    n2
    n3 3 + 7
    DOT n3

; D part
    KEY O3 - 3
    CALL .sq2_intro1
    KEY O3 - 5
    CALL .sq2_intro1
    KEY O3 - 6
    CALL .sq2_intro1
    KEY O3 - 7
    CALL .sq2_intro1x
    n2 3 + 1
    n2 3 + 1
    n3 3 + 3 + 10
    n2 3 + 1
    n2 3 + 1
    n2 3 + 3 + 10
    KEY O3 - 8
    n3 3 + 10
    n2 1
    n3 3 + 10
    n2 1
    n2 1
    n2 3 + 10
    n2 3 + 10

    TONE 2
    VOL 8
    ENV 2, 1, 1
    KEY O5
    DOT n5 10
    n3 9
    n3 10
    n5 12
    n4 10
    n4 12
    n5 1 + 12
    n4 3 + 12
    n4 5 + 12
    DOT n4 3 + 12
    n3 1 + 12
    n4 10
    n3 12
    n3 1 + 12
    n4 1 + 12
    n4 3 + 12
    n4 5 + 12
    n4 1 + 12
    n4 3 + 12
    n4 5 + 12
    n4 6 + 12
    n4 8 + 12
    n6 10 + 12
    n6 8 + 12
    n6 7 + 12
    n5 6 + 12
    n5 5 + 12
    n5 5 + 12
    n5 1 + 12
    n5 10
    n4 10
    n4 12
    n5 10
    n5 6
    n5 8
    n5 5
    TIE
    n6 10
    ENV 24, 1
    n6 10

    TONE 0
    VOL 11
    ENV 12, 1
    KEY O3 - 3
    LOOP 0, .sq1_loop
