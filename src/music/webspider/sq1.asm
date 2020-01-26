
    TONE 2
    VOL 12
    KEY O4
.sq1Intro
    ENV 1, 1
    n3 3 + 12
    ENV 3, 4
    n3 8
    n3 10
    n3 1 + 12
    ENV 1, 1
    n3 3 + 12
    ENV 3, 4
    n3 8
    n3 10
    n3 1 + 12
    ENV 1, 1
    n3 4 + 12
    ENV 3, 4
    n3 8
    n3 10
    n3 1 + 12
    ENV 1, 1
    n3 4 + 12
    ENV 3, 4
    n3 8
    n3 10
    n3 1 + 12
    LOOP 1, .sq1Intro

.sq1_loop
    ENV 7, 1
    n6 3 + 12
    n6 4 + 12
    n6 5 + 12
    n6 4 + 12
    n6 3 + 12
    n6 4 + 12
    n6 5 + 12
    n6 6 + 12

    TONE 1
    VOL 15
    MOD 1
    LOOP 0, .sq1A2
.sq1A1
    TIE
    n5 4
    n3 4
    BENDSPEED 0
    BEND n3 6 + 12 + 12, n3 4 + 12 + 12
    n2 5 + 12 + 12
    n2
    n2 4 + 12 + 12
    n2
.sq1A2
    TIE
    n5 3
    n3 3
    n3 3 + 12 + 12
    n4
    TIE
    n5 4
    n3 4
    TIE
    DOT n3 4 + 12 + 12
    PITCH 1
    DOT n3 4 + 12 + 12
    PITCH0
    TIE
    n5 5
    n3 5
    n3 5 + 12 + 12
    n4
    LOOP 1, .sq1A1
    TIE
    n5 6
    n3 6
    DOT n4 6 + 12 + 12

    
    TONE 2
    VOL 12
    MOD 0
    n6 3 + 12
    n6 4 + 12
    n6 5 + 12
    n6 4 + 12
    n6 3 + 12
    n6 4 + 12
    n6 5 + 12
    n6 6 + 12
    

    TONE 1
    VOL 15
    MOD 1
    LOOP 0, .sq1B2
.sq1B1
    TIE
    n5 4
    n3 4
    BENDSPEED 0
    BEND n3 6 + 12 + 12, n3 4 + 12 + 12
    n2 5 + 12 + 12
    n2
    n2 4 + 12 + 12
    n2
.sq1B2
    TIE
    n5 3
    n3 3
    n3 3 + 12 + 12
    n4
    TIE
    n5 4
    n3 4
    TIE
    DOT n3 4 + 12 + 12
    PITCH 1
    DOT n3 4 + 12 + 12
    PITCH0
    TIE
    n5 5
    n3 5
    n3 5 + 12 + 12
    n4
    LOOP 1, .sq1B1
    n5 6
    n3 5
    n3

    KEY O2
    TIE
    n2 8
    PITCH 48
    DOT n3 8
    PITCH0
    KEY O4


    TONE 2
    VOL 13
    KEY O4
    ENV 7, 1
    MOD 0
    n6 4 + 12
    n6 6 + 12
    n6 7 + 12
    n6 6 + 12
    n6 4 + 12
    n6 6 + 12
    n6 7 + 12
    n6 9 + 12

    TONE 1
    MOD 1
    ENV 28, 1
    DOT n4 9
    DOT n4 9 + 12
    TIE 4
    n5 9
    PITCH 1
    n5 9
    PITCH0
    n4 9

    PITCH -1
    n5 9
    PITCH0
    n6 9

    TONE 0
    n5 9 + 12

    n2 9
    n2 4
    n2 9
    n2 4 + 12
    n2 9
    n2 4
    n2 9
    n2 4 + 12
    n2 9
    n2 4
    n2 9
    n2 4 + 12
    SHORT n2 9
    SHORT n2 4
    SHORT n2 9
    SHORT n2 9 + 12
    SHORT n2 4 + 12
    SHORT n2 12
    n2 11
    n2 2 + 12
    n2 11 + 12
    n2 6 + 12
    n2 11
    n2 2 + 12
    n2 11 + 12
    n2 6 + 12
    n2 11
    n2 2 + 12
    n2 11 + 12
    n2 6 + 12
    SHORT n2 11
    SHORT n2 2 + 12
    SHORT n2 6 + 12
    SHORT n2 11 + 12
    SHORT n2 6 + 12
    SHORT n2 2 + 12
    n2 12
    n2 4 + 12
    n2 12 + 12
    n2 7 + 12
    n2 12
    n2 4 + 12
    n2 12 + 12
    n2 7 + 12
    n2 12
    n2 4 + 12
    n2 12 + 12
    n2 7 + 12
    SHORT n2 12
    SHORT n2 4 + 12
    SHORT n2 7 + 12
    SHORT n2 12 + 12
    SHORT n2 7 + 12
    SHORT n2 4 + 12
    n2 2 + 12
    n2 6 + 12
    n2 2 + 12 + 12
    n2 9 + 12
    n2 2 + 12
    n2 6 + 12
    n2 2 + 12 + 12
    n2 9 + 12
    ENV 2, 1
    n4 9 + 12
    ENV 5, 1
    n4 4 + 12 + 12
    TONE 2
    MOD 0
    LOOP 0, .sq1_loop
