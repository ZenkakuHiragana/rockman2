
.sq2_guitar_hit
    TONE 1
    VOL 15
    KEY O4
    ENV 8, 1
.sq2_guitar_hit_loop
    n0 6 + 12
    n0 6 + 12 + 12
    VOLDOWN
    LOOP 7, .sq2_guitar_hit_loop
    TONE 0
    VOL 14
    KEY O3
    MOD MOD_3d1t1f
    LOOP 0, .sq2_guitar_continue
.sq2_guitar
    TONE 0
    VOL 14
    KEY O3
    ENV 8, 1
    MOD MOD_3d1t1f

    TIE
    n4 6 + 12
.sq2_guitar_continue
    n3 6 + 12
    n4 9
    n4 11
    n3 12
    DOT n4 6 + 12
    TIE
    n5 4 + 12
    n3 4 + 12
    RETURN
.sq2_start
    CALL .sq2_guitar_hit
    DOT n4 6 + 12
    n4 9
    n4 11
    n3 12
    n5 2 + 12
    n5 1 + 12

    MOD 0
.sq2_loop
    CALL .track_block1a_hit
    CALL .track_block1c
    CALL .track_block1b
    CALL .track_block3b
    CALL .track_block1a
    CALL .track_block1c
    CALL .track_block1b
    CALL .track_block3c
    CALL .track_block1a
    CALL .track_block1c
    CALL .track_block1b
    CALL .track_block3b
    
    TONE 1
    VOL 10
    KEY O4 + 1
    ENV 10, 1
    MOD MOD_1d1t2f
    n5 8 + 12 - 1
    n4 6 + 12 - 1
    n3
    n2 1 + 12 - 1
    n2 2 + 12 - 1
    n5 4 + 12 - 1
    n5 11 - 1
    DOT n4 4 + 12 - 1
    DOT n4 1 + 12 - 1
    n4 9 - 1
    n6 11 - 1

    TONE 2
    MOD 0
    n6 1 + 7 - 1
    n6 -1 + 7 - 1
    n4 -4 + 7 - 1

    TONE 0
    SHORT n2 8 + 12 + 12 - 1
    SHORT n2 3 + 12 + 12 - 1
    SHORT n2 12 + 12 - 1
    SHORT n2 3 + 12 + 12 - 1
    SHORT n2 12 + 12 - 1
    SHORT n2 8 + 12 - 1
    SHORT n2 6 + 12 - 1
    SHORT n2 3 + 12 - 1
    SHORT n2 12 - 1
    SHORT n2 8 - 1
    SHORT n2 6 - 1
    SHORT n2 8 - 1
    n2 6 - 1
    n2 8 - 1
    n2 12 - 1
    n2 3 + 12 - 1

    TONE 2
    KEY O4
    n6 -6 + 7

    TONE 1
    VOL 15
    ENV 3, 2
    KEY O3
    BENDSPEED 9
    TIE
    BEND n4 6 + 12, n4 6 + 12 - 3
    n3 6 + 12
    n5
    BEND n3 6 + 12, n3 6 + 12 - 3
    BEND n6 8 + 12, n6 8 + 12 - 3
    TIE
    BEND n4 6 + 12, n4 6 + 12 - 3
    n3 6 + 12
    n5
    BEND n3 6 + 12, n3 6 + 12 - 3
    BEND n6 11 + 12, n6 11 + 12 - 3

    CALL .sq2_guitar_hit
    n3 9
    n3 6
    n3
    n3 11
    n3 6
    n3
    n3 9
    n3 6

    TONE 2
    ENV 3, 8
    MOD 0
    n2 6 + 12
    n2 9 + 12
    n2 9 + 12
    n2 4 + 12
    n2 10 + 12
    n2 10 + 12
    n2 2 + 12
    n2 9 + 12
    n2 11 + 12
    n2 11 + 12
    n2 4 + 12
    n2 9 + 12
    n2 11 + 12
    n2 11 + 12
    n2 7 + 12
    n2 9 + 12
    CALL .sq2_guitar
    TONE 2
    ENV 3, 8
    MOD 0
    CALL .track_block1b
    CALL .track_block3a
    TONE 0
    LOOP 0, .sq2_loop
