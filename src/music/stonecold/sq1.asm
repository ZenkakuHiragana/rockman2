
.sq1_base
    n1 1
    n1
    n1 1
    n1
    n3 1 + 12
    n3 1
    n3 1
    RETURN
.sq1_base2
    n1 1
    n1
    n1 1
    n1
    n3 1 + 12
    VOL 5
    n1 12
    n1
    n1 12
    n1
    VOL 10
    n3 12
    VOL 5
    n1 11
    n1
    n1 11
    n1
    VOL 10
    n3 11
    VOL 5
    n1 10
    n1
    n1 10
    n1
    VOL 10
    n3 10
    RETURN
.sq1B1
    VOL 8
    n2 3 + 8
    n2 3 + 8
    VOL 12
    n3 3 + 8
    VOL 8
    n3 3 + 8
    n3 3 + 8
    n2 3 + 7
    n2 3 + 7
    VOL 12
    n3 3 + 7
    VOL 8
    n3 3 + 7
    n3 3 + 7
    RETURN
.sq1B2
    n2 3 + 6
    n2 3 + 6
    VOL 12
    n3 3 + 6
    VOL 8
    n2 3 + 5
    n2 3 + 5
    VOL 12
    n3 3 + 5
    RETURN
.sq1_start
    TONE 0
    KEY O1A
    ENV 6, 5
    VOL 10
    LOOP 0, .sq1_intro
.sq1_intro1
    CALL .sq1_base2
.sq1_intro
    CALL .sq1_base
    CALL .sq1_base
    CALL .sq1_base
    CALL .sq1_base
    KEY O1A + 6
    CALL .sq1_base
    KEY O1A
    CALL .sq1_base
    LOOP 1, .sq1_intro1
    CALL .sq1_base
    CALL .sq1_base
    LOOP 0, .sq1_intro3
.sq1_intro4
    CALL .sq1_base
    CALL .sq1_base2
.sq1_intro3
    CALL .sq1_base
    CALL .sq1_base
    CALL .sq1_base
    CALL .sq1_base
    KEY O1A + 6
    CALL .sq1_base
    KEY O1A
    LOOP 1, .sq1_intro4
    ENV 3, 6
    n2 1
    n2 1
    n2 1 + 12
    n2 1
    n2 1 + 12
    n2 1 + 12
    n2 1 + 12
    n2 1 + 12
    n2 12
    n2 12
    n2 12
    n2 12
    n2 11
    n2 11
    n2 11
    n2 11
    n2 11
    n2 1 + 12
    n2 11
    n2 1 + 12
    n2 8
    n2 8
    n2 8
    n2 6 + 12

    TONE 3
    KEY O5
    ENV 1, 2, 1
    MOD MOD_1d1t2f
    VOL 9
    DOT n5 10
    n4 5
    n5 12
    n5 1 + 12
    DOT n5 10
    n4 5
    n5 3
    n5 5
    DOT n5 10
    n4 5
    n5 12
    n5 1 + 12
    DOT n5 3 + 12
    n4 5 + 12
    n5 3 + 12
    n4 10
    n4 12

    KEY O4
    VOL 10
    ENV 1, 3, 1
    MOD 0
    n2 10
    n2 5
    n2 10
    n2 12
    n2 1 + 12
    n2 3 + 12
    n2 5 + 12
    n2 10 + 12
    n2 10
    n2 5
    n2 10
    n2 12
    n2 1 + 12
    n2 3 + 12
    n2 5 + 12
    n2 10 + 12

    n2 8
    n2 5
    n2 8
    n2 10
    n2 12
    n2 1 + 12
    n2 3 + 12
    n2 5 + 12
    n2 8
    n2 5
    n2 8
    n2 10
    n2 12
    n2 1 + 12
    n2 3 + 12
    n2 5 + 12
    
    n2 10
    n2 5
    n2 10
    n2 12
    n2 1 + 12
    n2 3 + 12
    n2 5 + 12
    n2 10 + 12
    n2 10
    n2 5
    n2 10
    n2 12
    n2 1 + 12
    n2 3 + 12
    n2 5 + 12
    n2 10 + 12

    KEY O5 - 3
    n2 3 + 1
    n2 1
    n2 3 + 1
    n2 3 + 3
    n2 3 + 5
    n2 3 + 6
    n2 3 + 8
    n2 3 + 10
    n2 3 + 1 + 12
    n2 3 + 10
    n2 3 + 1 + 12
    n2 3 + 3 + 12
    n2 3 + 5 + 12
    n2 3 + 8 + 12
    n2 3 + 10 + 12
    n2 3 + 1 + 12 + 12

    KEY O4
    n2 10
    n2 5
    n2 10
    n2 12
    n2 1 + 12
    n2 3 + 12
    n2 5 + 12
    n2 10 + 12
    n2 10
    n2 5
    n2 10
    n2 12
    n2 1 + 12
    n2 3 + 12
    n2 5 + 12
    n2 10 + 12

    n2 8
    n2 5
    n2 8
    n2 10
    n2 12
    n2 1 + 12
    n2 3 + 12
    n2 5 + 12
    n2 8
    n2 5
    n2 8
    n2 10
    n2 12
    n2 1 + 12
    n2 3 + 12
    n2 5 + 12

    n2 10
    n2 5
    n2 10
    n2 12
    n2 1 + 12
    n2 3 + 12
    n2 5 + 12
    n2 8 + 12
    n2 10 + 12
    n2 1 + 12
    n2 3 + 12
    n2 5 + 12
    n2 8 + 12
    n2 10 + 12
    n2 12 + 12
    n2 10 + 12

    KEY O5
    n2 9
    n2 5
    n2 9
    n2 10
    n2 12
    n2 9
    n2 10
    n2 12
    n2 5 + 12
    n2 12
    n2 5 + 12
    n2 7 + 12
    n2 9 + 12
    n2 5 + 12
    n2 9 + 12
    n2 12 + 12

    KEY O1A
    ENV 6, 5
    VOL 12
    CALL .sq1_base
    CALL .sq1B1
    CALL .sq1B2
    
    CALL .sq1_base
    CALL .sq1B1
    n2 3 + 1 + 12
    n2 3 + 1 + 12
    VOL 12
    n3 3 + 1 + 12
    VOL 8
    n2 3 + 10
    n2 3 + 10
    VOL 12
    n3 3 + 10

    CALL .sq1_base
    CALL .sq1B1
    CALL .sq1B2
    CALL .sq1_base
    CALL .sq1B1
    CALL .sq1B2

    KEY O4
    TONE 1
    ENV 1, 2, 1
    MOD MOD_1d1t2f
    VOL 9
    n5 1 + 12
    n5 12
    DOT n5 10
    n4 9
    n5 1 + 12
    n5 12
    DOT n5 3 + 12
    n4 5 + 12
    n5 1 + 12
    n5 3 + 12
    n5 5 + 12
    n4 6 + 12
    n4 12 + 12
    VOL 9
    n5 1 + 12 + 12
    n5 3 + 12 + 12
    n5 5 + 12 + 12
    n5 1 + 12 + 12
    
    VOL 10
    TONE 1
    ENV 3, 2
    MOD 0
    LOOP2 0, .sq1C1
.sq1C2
    n3
    n2 1 + 12
    n2 1 + 12
    LOOP 3, .sq1C2
.sq1C1
    n3
    n2 1 + 12
    n2 1 + 12
    LOOP 5, .sq1C1
    VOLDOWN
    n3
    n2 3 + 12
    n2 3 + 12
    n3
    n2 1 + 12
    n2 1 + 12
    n3
    n2 4 + 12
    n2 4 + 12
    n3
    n2 4 + 12
    n2 4 + 12
    n3
    n2 1 + 12
    n2 1 + 12
    n3
    n2 1 + 12
    n2 1 + 12
    VOLDOWN
    LOOP2 1, .sq1C2
.sq1C3
    n3
    n2 1 + 12
    n2 1 + 12
    n3
    n2 1 + 12
    n2 1 + 12
    VOLDOWN
    LOOP 4, .sq1C3
    n5
    n6
    n6

; D part
    TONE 1
    KEY O4
    VOL 10
    ENV 13, 6
    MOD MOD_1d1t1f
    n3 10
    n4 10
    n4 10
    n4 10
    n3 8
    n3 10
    n4 10
    n4 10
    n4 10
    n3 8
    n3 10
    n4 10
    n4 10
    n4 10
    n3 10
    n3 8
    n4 8
    n4 8
    n4 8
    n3 8
    n3 1 + 12
    n4 1 + 12
    n4 1 + 12
    n4 1 + 12
    n3 1 + 12
    n3 1 + 12
    n4 1 + 12
    n4 1 + 12
    n4 1 + 12
    n3 1 + 12
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
    
    TONE 1
    ENV 1, 2, 1
    MOD MOD_1d1t2f
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
    TIE
    n5 1 + 12
    n3 1 + 12

    n4 1 + 12
    n4 3 + 12
    n4 5 + 12
    n4 1 + 12
    n4 3 + 12
    n4 5 + 12
    n4 6 + 12
    n4 8 + 12

    TONE 1
    VOL 12
    ENV 13, 6
    MOD MOD_1d1t1f
    n3 10 + 12
    n4 10 + 12
    n4 10 + 12
    n4 10 + 12
    n3 8 + 12
    n3 10 + 12
    n4 10 + 12
    n4 10 + 12
    n4 10 + 12
    n3 8 + 12

    n3 10 + 12
    n4 10 + 12
    n4 10 + 12
    n4 10 + 12
    n3 1 + 12 + 12
    n3 10 + 12
    n4 10 + 12
    n4 10 + 12
    n4 10 + 12
    n3 8 + 12
    n3 10 + 12
    n4 10 + 12
    n4 10 + 12
    n4 10 + 12
    n3 8 + 12
    n3 10 + 12
    n4 10 + 12
    n4 10 + 12
    n4 10 + 12
    n3 8 + 12
    n3 10 + 12
    n4 10 + 12
    n4 10 + 12
    n4 10 + 12
    n3 8 + 12
    n3 8 + 12
    n4 8 + 12
    n3 8 + 12
    n3 9 + 12
    n4 9 + 12
    n3 9 + 12

    TONE 2
    VOL 8
    ENV 13, 5
    n3 10 + 12
    n4 10 + 12
    n4 10 + 12
    n4 10 + 12
    n3 8 + 12
    n3 10 + 12
    n4 10 + 12
    n4 10 + 12
    n4 10 + 12
    n3 8 + 12
    n3 8 + 12
    n4 8 + 12
    n4 8 + 12
    n4 9 + 12
    n3 9 + 12
    n3 10 + 12
    n4 10 + 12
    n4 10 + 12
    n4 10 + 12
    n3 8 + 12

    TONE 0
    KEY O1A
    ENV 6, 5
    VOL 10
    MOD 0
    CALL .sq1_base
    CALL .sq1_base
    CALL .sq1_base
    CALL .sq1_base
    KEY O1A + 6
    CALL .sq1_base
    KEY O1A
    ENV 3, 6
    n2 1
    n2 1
    n2 1 + 12
    n2 1
    n2 1 + 12
    n2 1 + 12
    n2 1 + 12
    n2 1 + 12
    n2 12
    n2 12
    n2 12
    n2 12
    n2 11
    n2 11
    n2 11
    n2 11
    n2 11
    n2 1 + 12
    n2 11
    n2 1 + 12
    n2 8
    n2 8
    n2 8
    n2 8
    ENV 6, 5
; end of the track
    .ifndef STONE_COLD_LOOP
    END
    .endif
;
    LOOP 0, .sq1_intro3
