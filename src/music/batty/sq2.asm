
.sq2_sub
    n3 3 + 12 - 5
    n3 3 + 12 - 5
    TONE 0
    n3 3 + 12 - 5
    n3 3 + 12 - 5
    TONE 1
    n3 3 + 12 - 5
    n3 3 + 12 - 5
    TONE 0
    n3 3 + 12 - 5
    TONE 1
    n3 3 + 12 - 5
    RETURN

.sq2_start
    TONE 1
    VOL 9
    KEY O3 + 5
    ENV 7, 1
.sq2Intro
    n3 4 + 12 - 5
    n3 4 + 12 - 5
    n3 3 + 12 - 5
    n3 3 + 12 - 5
    n3 2 + 12 - 5
    n3 2 + 12 - 5
    n3 3 + 12 - 5
    n3 3 + 12 - 5
    LOOP 2, .sq2Intro
    n3 4 + 12 - 5

.sq2_loop
    n3

    TONE 0
    DOT n3 8 + 12 - 5
    n2 1 + 12 + 12 - 5
    n2 3 + 12 + 12 - 5
    n3 4 + 12 + 12 - 5
    n3 6 + 12 + 12 - 5
    n3 8 + 12 + 12 - 5
    n2 1 + 12 + 12 - 5

    TONE 1
    LOOP 0, .sq2A1
.sq2A
    CALL .sq2_sub
.sq2A1
    KEY O3 + 5
    CALL .sq2_sub
    KEY O3 + 5 - (3 + 12 - 5) + (8 - 5)
    CALL .sq2_sub
    KEY O3 + 5 - (3 + 12 - 5) + (1 + 12 - 5)
    CALL .sq2_sub
    LOOP 1, .sq2A
    
    n3 1 + 12 - 5 - (-(3 + 12 - 5) + (1 + 12 - 5))
    n3
    n4 1 + 12 - 5 - (-(3 + 12 - 5) + (1 + 12 - 5))
    n4 1 + 12 - 5 - (-(3 + 12 - 5) + (1 + 12 - 5))
    n4 1 + 12 - 5 - (-(3 + 12 - 5) + (1 + 12 - 5))
    
    KEY O3 + 5 - (3 + 12 - 5) + (6 - 5)
    CALL .sq2_sub
    KEY O3 + 5 - (3 + 12 - 5) + (11 - 5)
    CALL .sq2_sub
    KEY O3 + 5 - (3 + 12 - 5) + (4 + 12 - 5)
    CALL .sq2_sub
    KEY O3 + 5 - (3 + 12 - 5) + (1 + 12 - 5)
    CALL .sq2_sub
    KEY O3 + 5 - (3 + 12 - 5) + (6 - 5)
    CALL .sq2_sub
    KEY O3 + 5
    CALL .sq2_sub

    n3 8 + 12 - 5
    n3 8 + 12 - 5
    n3 7 + 12 - 5
    n3 7 + 12 - 5
    n3 6 + 12 - 5
    n3 6 + 12 - 5
    n3 7 + 12 - 5
    n3 7 + 12 - 5
    n3 8 + 12 - 5
    LOOP 0, .sq2_loop
