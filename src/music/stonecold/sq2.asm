
.sq2_start
    n6
    LOOP 15, .sq2_start
    TONE 1
    ENV 1, 3, 1
    VOL 9
    KEY O3
    LOOP 0, .sq2A1
.sq2A2
    n2 10 + 12
    n2 5 + 12
    n2 5 + 12
    n2 5 + 12
    n2 1 + 12
    n2 10
    n2 5 + 12
    n2 5 + 12
    n2 10 + 12
    n1 1 + 12 + 12
    n1 5 + 12 + 12
.sq2A1
    n2 5 + 12 + 12
    n2 10 + 12
    n2 10 + 12
    n2 10 + 12
    n3
    n2 5 + 12 + 12
    n2 10 + 12
    n2 10 + 12
    n2
    n3
    n2 5 + 12 + 12
    n2 10 + 12
    n2 10 + 12
    n2 5 + 12 + 12
    n2 5 + 12 + 12
    n2 10 + 12
    n2 10 + 12
    n2 10 + 12
    n3
    n2 5 + 12 + 12
    n2 10 + 12
    n2 10 + 12
    n2 10 + 12
    n2 10 + 12
    n2 5 + 12
    n2 1 + 12 + 12
    n2 10 + 12
    n2 1 + 12 + 12
    n2 3 + 12 + 12

    n2 5 + 12 + 12
    n2 10 + 12
    n2 10 + 12
    n2 10 + 12
    n3
    n2 5 + 12 + 12
    n2 10 + 12
    n2 10 + 12
    n2
    n3
    n2 5 + 12 + 12
    n2 10 + 12
    n2 10 + 12
    n2 5 + 12 + 12
    n2 1 + 12 + 12
    n2 10 + 12
    n2 10 + 12
    n2 10 + 12
    n3
    LOOP 1, .sq2A2
    n2 1 + 12 + 12
    n2 10 + 12
    n2 10 + 12
    n2 10 + 12
    n2 10 + 12
    n2
    n2 5 + 12
    n2 10 + 12
    n2 12 + 12
    n2 1 + 12 + 12
    
    KEY O5
    VOL 9
    ENV 13, 5
    MOD MOD_1d1t2f
    n3 1 + 12
    n4 1 + 12
    n4 1 + 12
    n4 1 + 12
    n3 1 + 12
    n3 12
    n4 12
    n4 12
    n4 12
    n3 12
    n3 10
    n4 10
    n4 10
    n4 10
    n3 10
    n3 10
    n4 10
    n4 10
    n4 10
    n3 10
    
    n3 10
    n4 10
    n4 10
    n4 10
    n4 10
    n4 10
    n4 8
    n4 8
    n3 8
    n3 10
    n4 10
    n4 10
    n4 10
    n4 10
    n4 9
    n4 10
    n4 12
    n3 5 + 12

    TONE 2
    VOL 3
    KEY O4
    ENV 2, 3, 1
    MOD 0
.sq2B1
    n3
    n2 10
    n2 10
    VOLUP
    VOLUP
    LOOP 5, .sq2B1
    n3
    n2 1 + 12
    n2 1 + 12
    n3
    n2 12
    n2 12
.sq2B2
    n3
    n2 1 + 12
    n2 1 + 12
    LOOP 5, .sq2B2
    n3
    n2 3 + 12
    n2 3 + 12
    n3
    n2 3 + 12
    n2 3 + 12
.sq2B3
    n3
    n2 5 + 12
    n2 5 + 12
    LOOP 6, .sq2B3
    n3
    n2 3 + 12
    n2 3 + 12
.sq2B4
    n3
    n2 1 + 12
    n2 1 + 12
    LOOP 3, .sq2B4
    n3
    n2 3 + 12
    n2 3 + 12
    n3
    n2 3 + 12
    n2 3 + 12
    n3
    n2 1 + 12
    n2 1 + 12
    n3
    n2 12
    n2 12

    TONE 0
    KEY O1A
    ENV 6, 5
    VOL 12
    CALL .sq1_base
    CALL .sq1B1
    CALL .sq1B2
    CALL .sq1_base
    VOL 8
    n2 3 + 8
    n2 3 + 8
    VOL 12
    n3 3 + 8
    VOL 8
    n3 3 + 8
    n3 3 + 8
    
    VOL 8
    n2 3 + 3 + 12
    n2 3 + 3 + 12
    VOL 12
    n3 3 + 3 + 12
    VOL 8
    n3 3 + 3 + 12
    n3 3 + 3 + 12
    n2 3 + 5 + 12
    n2 3 + 5 + 12
    VOL 12
    n3 3 + 5 + 12
    VOL 8
    n2 3 + 1 + 12
    n2 3 + 1 + 12
    VOL 12
    n3 3 + 1 + 12

    KEY O5
    n2 10
    ENV 13, 9, 1
    VOL 12
    MOD MOD_STONECOLD
    PITCH -1
    TIE 2
    n6 10
    DOT n5 10
    DOT n3 10
    PITCH 0
    
    KEY O1A
    ENV 6, 5
    VOL 12
    CALL .sq1_base
    CALL .sq1B1
    CALL .sq1B2
    END
