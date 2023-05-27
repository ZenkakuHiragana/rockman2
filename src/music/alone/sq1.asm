
.sq1_intro1
    VOL 13
    n4 3 + 12 + 12
    n4 1 + 12 + 12
    n5 3 + 12 + 12
    VOL 10
    n3 6 + 12
    n3 10
    n3 5 + 12
    n3 10
    n5 3 + 12
    RETURN
.sq1_intro2
    VOL 13
    n4 3 + 12 + 12
    n4 1 + 12 + 12
    n5 3 + 12 + 12
    VOL 8
    n3 6 + 12
    n3 8
    n3 5 + 12
    n3 8
    n3 3 + 12
    n3 8
    n3 1 + 12
    n3 8
    RETURN

.sq1_B1
    n5 1 + 12
    n3
    DOT n4 1 + 12 + 12
    n3 10 + 12
    n3 1 + 12 + 12
    n4 3 + 12 + 12
    n4 10 + 12
    n3 8 + 12
    n3 6 + 12
    n3 3 + 12
    n3 5 + 12
    n3 6 + 12
    n3 8 + 12
    n3 6 + 12
    DOT n4 10 + 12
    n4 8 + 12
    n3 6 + 12
    n6 5 + 12
    n4
.sq1_B
    n5 10
    DOT n4 6 + 12
    n3 5 + 12
    n3 3 + 12
    n4 1 + 12
    n5 10
    n3
    n5 10
    DOT n4 6 + 12
    n3 5 + 12
    n3 8 + 12
    n4 10 + 12
    LOOP2 1, .sq1_B1
    n4 1 + 12
    n3 3 + 12
    n3 6 + 12
    n3 10 + 12
    n3 1 + 12 + 12
    n4 3 + 12 + 12
    n4 10 + 12
    n3 6 + 12
    n3 8 + 12
    n3 6 + 12
    n3 10 + 12
    n3 8 + 12
    n3 6 + 12
    n4 3 + 12
    n3 5 + 12
    n4 6 + 12
    DOT n4 8 + 12
    TIE
    DOT n4 1 + 12
    MOD MOD_1d1t2f
    n6 1 + 12
    MOD 0
    n4
    
    n5
    n3 11
    n3 1 + 12
    n3 3 + 12
    n3 6 + 12
    n4 8 + 12
    n3 6 + 12
    n4 5 + 12
    n3 3 + 12
    n4 1 + 12
    n5
    n3 2 + 12
    n3 4 + 12
    n3 6 + 12
    n3 9 + 12
    DOT n3 11 + 12
    DOT n3 1 + 12 + 12
    n3 11 + 12
    n4 9 + 12
    n4 8 + 12
    DOT n3 6 + 12
    DOT n3 5 + 12
    RETURN
.sq1_start
    TONE 2
    ENV 3, 1
    KEY O4
    CALL .sq1_intro1
    CALL .sq1_intro1
    CALL .sq1_intro2
    CALL .sq1_intro2
.sq1A1
    CALL .sq1_intro1
    LOOP 2, .sq1A1
.sq1B1
    VOL 15
    KEY O5
    ENV 1, 3, 1
    CALL .sq1_B
    n2 8 + 12
    n2 6 + 12
    TIE
    n5 3 + 12
    MOD MOD_1d1t2f
    n6 3 + 12
    MOD 0

    KEY O3
    ENV 1, 4, 1
    SHORT n4 1 + 12 + 12
    SHORT n4 12 + 12
    SHORT n4 10 + 12
    SHORT n4 12 + 12
    SHORT n4 10 + 12
    SHORT n4 8 + 12
    SHORT n4 10 + 12
    SHORT n4 8 + 12
    SHORT n4 6 + 12
    SHORT n4 5 + 12
    SHORT n4 3 + 12
    SHORT n4 1 + 12
    CALL .sq1_B
    n3 3 + 12
    n5 1 + 12
    DOT n3 6 + 12
    DOT n3 5 + 12
    TIE 2
    n3 3 + 12
    n5 3 + 12
    MOD MOD_1d1t2f
    n6 3 + 12
    MOD 0
    END
