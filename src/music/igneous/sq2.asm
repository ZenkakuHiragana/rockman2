
.sq2_intro1
    n2 1
    n2 1
    n3 3 + 10
    n2 1
    n2 1
    n2 3 + 10
    n3 3 + 10
    n2 1
    n3 3 + 10
    n2 1
    n2 1
    n2 3 + 10
    n2 3 + 10
.sq2_intro1x
    LOOP2 1, .sq2_intro1
    RETURN
.sq2_intro2
    n2 3 + 4
    n2 3 + 4
    n3 3 + 4 + 12
    n2 3 + 4
    n2 3 + 4
    n2 3 + 4 + 12
    n3 3 + 10
    n2 1
    n3 3 + 10
    n2 1
    n2 1
    RETURN
.sq2_intro3
    n2 3 + 10
    n2 3 + 10
    n2 3 + 10
    n2 3 + 10
    n2 3 + 9
    n2 3 + 9
    n2 3 + 9
    n2 3 + 9
    n2 3 + 8
    n2 3 + 8
    n2 3 + 8
    n2 3 + 8
    n2 3 + 8
    n2 3 + 8
    n2 3 + 4
    n2 3 + 4
    RETURN
.sq2C1
    n3 3 + 10
    n1 1
    n1
    n1 1
    n1
    LOOP2 7, .sq2C1
    RETURN
.sq2C2
    n3 3 + 4 + 12
    n1 3 + 4
    n1
    n1 3 + 4
    n1
    n3 3 + 4 + 12
    n1 3 + 4
    n1
    n3 3 + 10
    n1 1
    n1
    n1 1
    n1
    n1 1
    n1
    n3 3 + 10
    n1 1
    n1
    n1 1
    n1
    n3 3 + 10
    n1 1
    n1
    n1 1
    n1
    n3 3 + 9
    n1 3 + 9
    n1
    n1 3 + 9
    n1
    n3 3 + 8
    n1 3 + 8
    n1
    DOT n3 3 + 7
    n3 3 + 5
    RETURN
.sq2_start
    TONE 0
    VOL 9
    ENV 12, 1
    KEY O1A + 7
.sq2_intro
    CALL .sq2_intro1
.sq2_loop
    CALL .sq2_intro2
    n2 3 + 10
    n2 3 + 10
    CALL .sq2_intro3
    LOOP 1, .sq2_intro
    VOL 6
    KEY O3 - 3 + 7
    CALL .sq2_intro1
    CALL .sq2_intro2
    n2 3 + 10
    n2 3 + 10
    CALL .sq2_intro3
    CALL .sq2_intro1
    CALL .sq2_intro2
    VOL 8
    KEY O4
    n2 10
    n2 10
    n2 10
    n2 10
    n2 10
    n2 10
    n2 9
    n2 9
    n2 9
    n2 9
    n2 8
    n2 8
    n2 8
    n2 8
    n2 8
    n2 8
    n2 7
    n2 7

    KEY O2
    CALL .triA1
    CALL .triA2
    
    KEY O3
    VOL 12
    n0
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
    DOT n1 1 + 12 + 12

    KEY O2
    VOL 8
    CALL .triA3

    n3 10
    n3
    n2 10
    n2
    n2 10
    n3 8
    n3
    n2 8
    n4

    TONE 2
    KEY O3
    VOL 10
    ENV 1, 1, 1
.sq2B2
    n3
    n2 1 + 12
    n2 1 + 12
    n3
    n2 1 + 12
    n2 1 + 12
    VOLUP
    LOOP2 4, .sq2B2
    n5
.sq2B3
    VOL 9
    n3
    n2 1 + 12
    n2 1 + 12
    LOOP 13, .sq2B3
    n5
    
    KEY O2
    TONE 0
    ENV 12, 1
    n3 10
    n3 10
    n3 10
    n3 10
    n3 8
    n3 8
    n3 8
    n3 8
    n3 7
    n3 7
    n3 7
    n3 7
    n3 6
    n3 6
    n3 5
    n3 5
    
    n3 10
    n3 10
    n3 10
    n3 10
    n3 8
    n3 8
    n3 8
    n3 8
    n3 3 + 12
    n3 3 + 12
    n3 3 + 12
    n3 3 + 12
    n3 3 + 12
    n3 3 + 12
    n3 5 + 12
    n3 5 + 12
.sq2C0
    n3 10
    n3 10
    n3 10
    n3 10
    n3 8
    n3 8
    n3 8
    n3 8
    n3 7
    n3 7
    n3 7
    n3 7
    n3 6
    n3 6
    n3 6
    n3 5
    LOOP2 1, .sq2C0

    KEY O3 - 3
    VOL 14
    CALL .sq2C1
    KEY O1A + 7
    VOL 8
    CALL .sq2C2
    CALL .sq2C1
    CALL .sq2C2
    CALL .sq2_intro1
    CALL .sq2_intro2
    KEY O1A
    n2 3 + 7 + 10
    n2 3 + 7 + 10
    n3 3 + 7 + 10
    n2 3 + 7 + 9 - 12
    n2 3 + 7 + 9 - 12
    n3 3 + 7 + 9
    n2 3 + 7 + 8 - 12
    n2 3 + 7 + 8 - 12
    n3 3 + 7 + 8
    n2 3 + 7 + 7 - 12
    n3 3 + 7 + 7
    DOT n3

; D part
    VOL 5
    KEY O3 - 3 + 7
    CALL .sq2_intro1
    KEY O3 - 5 + 7
    CALL .sq2_intro1
    KEY O3 - 6 + 7
    CALL .sq2_intro1
    KEY O3 - 7 + 7
    CALL .sq2_intro1x
    n2 3 + 1
    n2 3 + 1
    n3 3 + 3 + 10
    n2 3 + 1
    n2 3 + 1
    n2 3 + 3 + 10
    KEY O3 - 8 + 7
    n3 3 + 10
    n2 1
    n3 3 + 10
    n2 1
    n2 1
    n2 3 + 10
    n2 3 + 10

    KEY O2
    VOL 12
    n4 10
    n2 10
    n2 10
    n2 10
    DOT n3 1 + 12
    TIE
    n4 3 + 12
    PITCH 20
    n3 3 + 12
    PITCH 0
    n4 9
    n2 9
    n2 9
    n2 9
    DOT n3 1 + 12
    TIE
    n4 3 + 12
    PITCH 20
    n3 3 + 12
    PITCH 0
    n3 8
    n2 8
    n2 8
    n2 8
    n2 8
    n2 8
    DOT n3 8
    n3 8
    TIE
    n3 8
    PITCH 20
    n3 8
    PITCH 0
    n3 7
    n2 7
    n2 7
    n2 7
    n2 7
    n2 7
    n2 7
    n3 10
    n3 10
    n3 1 + 12
    n2 10
    n2 10

    n3 6
    n2 6
    n2
    n2 6
    n2 6
    n2 6
    n2 6
    n2 6
    n3 1 + 12
    TIE
    n3 1 + 12
    PITCH 20
    DOT n3 1 + 12
    PITCH 0
    n3 8
    n2 8
    n2
    n2 8
    n2 8
    n2 8
    n2 8
    n2 8
    n3 3 + 12
    TIE
    n3 3 + 12
    PITCH 20
    DOT n3 3 + 12
    PITCH 0

    KEY O3 - 3
    CALL .sq2_intro1
    KEY O3 - 5
    CALL .sq2_intro1
    KEY O3 - 6
    CALL .sq2_intro1
    KEY O3 - 7
    CALL .sq2_intro1x
    n2 2 + 1
    n2 2 + 1
    n3 2 + 3 + 10
    n2 2 + 1
    n2 2 + 1
    n2 2 + 3 + 10
    KEY O3 - 8
    n3 3 + 10
    n2 1
    n3 3 + 10
    n2 1
    n2 1
    n2 3 + 10
    n2 3 + 10

    KEY O3 - 3
    CALL .sq2_intro1
    KEY O1A + 7
    VOL 9
    LOOP 0, .sq2_loop
