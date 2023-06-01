
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
    TONE 1
    ENV 13, 5
    VOL 9
    MOD MOD_STONECOLD
    n2 10
    n2
    PITCH -1
    n4 10
    n4 11
    n4 12
    n4 1 + 12
    n4 3 + 12
    n4 5 + 12
    n4 7 + 12
    n3 9 + 12
    PITCH 0
    MOD 0
    
    KEY O1A
    TONE 0
    ENV 6, 5
    VOL 12
    CALL .sq1_base
    CALL .sq1B1
    CALL .sq1B2
    
    VOL 8
    TONE 2
    KEY O4
    ENV 1, 2, 1
.sq2C1
    n3
    n2 10
    n2 10
    LOOP 11, .sq2C1
    VOLDOWN
    n3
    n2 9
    n2 9
    n3
    n2 8
    n2 8
    n3
    n2 7
    n2 7
    n3
    n2 6
    n2 6
    VOLDOWN
    LOOP2 1, .sq2C1
.sq2C2
    n3
    n2 10
    n2 10
    VOLDOWN
    LOOP 3, .sq2C2
    
    TONE 0
    KEY O1A
    ENV 6, 5
    VOL 10
    CALL .sq1_base
    CALL .sq1_base
    KEY O1A + 6
    CALL .sq1_base
    KEY O1A
    CALL .sq1_base
    CALL .sq1_base2

; D part
    TONE 1
    KEY O3 + 4
    ENV 1, 3, 1
    VOL 7
.sq2D1
    n2 6 + 12 + 12
    n2 1 + 12 + 12
    n2 8 + 12
    n2 6 + 12
    n2 1 + 12
    n2 9
    n2 6
    n2 1
    LOOP 3, .sq2D1
.sq2D2
    n2 4 + 12 + 12
    n2 1 + 12 + 12
    n2 8 + 12
    n2 4 + 12
    n2 1 + 12
    n2 9
    n2 6
    n2 1
    LOOP 3, .sq2D2
.sq2D3
    n2 3 + 12 + 12
    n2 1 + 12 + 12
    n2 8 + 12
    n2 6 + 12
    n2 1 + 12
    n2 9
    n2 6
    n2 1
    LOOP 3, .sq2D3
.sq2D4
    n2 2 + 12 + 12
    n2 1 + 12 + 12
    n2 8 + 12
    n2 2 + 12
    n2 1 + 12
    n2 9
    n2 6
    n2 1
    LOOP 1, .sq2D4
    TONE 2
    VOL 6
    n5 11
    n5 1 + 12
    
    TONE 1
    VOL 10
    KEY O4
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
    n4 12 + 12
    n4 1 + 12 + 12
    n3 3 + 12 + 12
    n3 1 + 12 + 12
    n4 1 + 12 + 12
    n3 1 + 12 + 12
    n3 12 + 12
    n4 12 + 12
    n3 12 + 12

    TONE 2
    VOL 8
    ENV 1, 3, 1
    MOD 0
    n4 10
    n4 12
    n4 1 + 12
    n4 10
    n4 12
    n4 1 + 12
    n4 3 + 12
    n4 3 + 12
    
    TONE 2
    VOL 4
    ENV 1, 1, 1
    MOD MOD_1d2t1f
    TIE
    n6 5 + 12
    n6 5 + 12
    VOL 3
    n6 3 + 12
    n6 1 + 12
    TIE
    n6 10
    n6 10
    n6 1 + 12
    n6 12

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
    CALL .sq1_base
    CALL .sq1_base2
    
    TONE 2
    VOL 4
    KEY O4
    MOD MOD_1d1t2f
    ENV 13, 2
    n3 5
    n4 5
    n4 5
    n4 5
    n3 5
    n3 5
    n4 5
    n4 5
    n4 5
    n3 5
    TIE
    ENV 1, 1, 1
    n5 5
    ENV 24, 1
    n6 5
    n5
.sq2D5
    n6
    LOOP 7, .sq2D5
    TONE 1
    ENV 1, 3, 1
    VOL 9
    KEY O3
    MOD 0
; end of the track
    .ifndef STONE_COLD_LOOP
    END
    .endif
;
    LOOP 0, .sq2A1
