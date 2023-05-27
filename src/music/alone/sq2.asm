
.sq2_B
    n3 3 + 12 + 12
    n3 10
    n3 1 + 12 + 12
    n3 10
    n4 3 + 12 + 12
    n3 1 + 12
    RETURN
.sq2_start
    TONE 2
    VOL 8
    KEY O4
    ENV 3, 1
.sq2A1
    n3 6 + 12
    n3 10
    n3 5 + 12
    n3 10
    n3 3 + 12
    n3 10
    n3 1 + 12
    n3 8
    n6
    LOOP 6, .sq2A1
.sq2B1
    VOL 10
    CALL .sq2_B
    n3 8
    n3 6 + 12
    n3 10
    n3 5 + 12
    n3 10
    n3 3 + 12
    n3 10
    n3 1 + 12
    n3 8
    LOOP 1, .sq2B1
    CALL .sq2_B
    n3 6
    n3 6 + 12
    n3 11
    n3 5 + 12
    n3 11
    n3 3 + 12
    n3 6
    n3 1 + 12
    n3 6
    CALL .sq2_B
    n3 8
    n3 8 + 12
    n3 10
    n3 5 + 12
    n3 10
    n3 3 + 12
    n3 8
    n3 1 + 12
    n3 8
    LOOP2 1, .sq2B1
    END
