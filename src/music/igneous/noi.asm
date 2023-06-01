.noi_intro1
    TOMLOW
    TIE
    n3 3
    TOMLOW  n3 3
    TOMHIGH n2 5
    n3
    TOMLOW  n2 15
    n3 1
    TOMLOW  n2 15
    n2
    TOMHIGH n2 5
    DOT n3
    TOMLOW
    TIE
    n3 3
    TOMLOW  n3 3
    TOMHIGH n2 5
    n3
    TOMLOW  n2 15
    n3 1
    TOMLOW  n2 15
    n2
    TOMHIGH n2 5
    n2
    TOMHIGH n2 5
    TOMHIGH n2 5
    RETURN
.noi_intro2
    TOMLOW  n4 3
    TOMHIGH n2 5
    n3
    TOMLOW  n2 15
    n3 1
    TOMLOW  n2 15
    n2
    TOMHIGH n2 5
    n2
    TOMLOW  n2 15
    TOMLOW  n2 15
    RETURN
.noi_intro3
    TOMHIGH n2 5
    TOMLOW  n2 15
    TOMLOW  n2 15
    TOMLOW  n2 15
    TOMHIGH n2 5
    TOMLOW  n2 15
    TOMLOW  n2 15
    TOMLOW  n2 15
    TOMHIGH n2 5
    TOMLOW  n2 15
    TOMLOW  n2 15
    TOMLOW  n2 15
    TOMHIGH n2 5
    TOMHIGH n2 5
    TOMHIGH n2 5
    TOMHIGH n2 5
    RETURN
.noi_tail1
    TOMHIGH n2 5
    TOMHIGH n2 5
    TOMLOW  n2 15
    TOMHIGH n2 5
    n2
    TOMLOW  n2 15
    TOMHIGH n2 5
    TOMHIGH n2 5
    RETURN
.noi_tail2
    TOMLOW
    SHORT n2 15
    TOMLOW
    SHORT n2 15
    TOMLOW
    SHORT n2 15
    TOMHIGH n2 5
    n2
    TOMLOW
    SHORT n2 15
    TOMLOW
    SHORT n2 15
    TOMLOW
    SHORT n2 15
    TOMHIGH n2 5
    RETURN
.noiC3
    TOMLOW  n4 5
    TOMHIGH n4 3
    TOMLOW  n4 2
    TOMHIGH n4 3
    TOMLOW  n4 2
    TOMHIGH n4 3
    TOMLOW  n4 2
    TOMHIGH n3 3
    TOMHIGH n2 5
    TOMHIGH n2 5

    TOMLOW  n4 5
    TOMHIGH n2 5
    n2
    TOMHIGH n2 5
    TOMLOW  n3 5
    TOMLOW  n2 15
    TOMLOW  n2 15
    TOMLOW  n2 15
    TOMHIGH n2 5
    n2
    TOMLOW  n2 15
    TOMLOW  n2 15

    TOMHIGH n2 5
    TOMLOW  n2 15
    TOMLOW  n2 15
    TOMLOW  n2 15
    TOMHIGH n2 5
    TOMLOW  n2 15
    TOMLOW  n2 15
    TOMLOW  n2 15
    TOMHIGH n2 5
    TOMLOW  n2 15
    TOMLOW  n2 15
    TOMHIGH n2 5
    n2 15
    TOMLOW  n2 15
    TOMLOW  n2 15
    TOMLOW  n2 15
    RETURN
.noiD1
    TOMLOW
    TIE
    n3 3
    TOMLOW  n3 3
    TOMHIGH n2 5
    n3
    TOMLOW  n2 15
    n3 1
    TOMLOW  n2 15
    n2
    TOMHIGH n2 5
    DOT n3
.noiD1_loop
    TIE
    n3 3
    TOMLOW  n3 3
    TOMHIGH n2 5
    n3
    TOMLOW  n2 15
    n3 1
    TOMLOW  n2 15
    n2
    TOMHIGH n2 5
    DOT n3
    LOOP2 1, .noiD1_loop

    TOMLOW
    TIE
    n3 3
    TOMLOW  n3 3
    TOMHIGH n2 5
    n3
    TOMLOW  n2 15
    n3 1
    TOMLOW  n2 15
    n2
    TOMHIGH n2 5
    n2
    TOMHIGH n2 5
    TOMHIGH n2 5
    LOOP 1, .noiD1
    RETURN
.noi_start
    VOL 8
    ENV 2, 1

    CALL .noi_intro1
    CALL .noi_intro2
    CALL .noi_intro3

    CALL .noi_intro1
    TOMLOW
    TIE 2
    n2 3
    TOMLOW  n2 3
    TOMLOW  n3 3
    TOMHIGH n2 5
    TOMHIGH n2 5
    TOMHIGH n2 5
    TOMLOW  n3 15
    n2 14
    n2 14
    n2 15
    TOMHIGH n2 5
    n2
    TOMLOW  n2 15
    TOMLOW  n2 15
    CALL .noi_intro3
    
    CALL .noi_intro1
    TOMLOW
    TIE 2
    n2 3
    TOMLOW  n2 3
    TOMLOW  n3 3
    TOMHIGH n2 5
    TOMHIGH n2 5
    TOMHIGH n2 5
    TOMLOW  n3 3
    TOMLOW  n2 15
    n1 13
    n1 14
    n1 15
    n1 15
    TOMHIGH n2 5
    n2
    TOMLOW  n2 15
    TOMLOW  n2 15
    CALL .noi_intro3

    CALL .noi_intro1
    TOMLOW  n4 3
    TOMHIGH n2 5
    n3
    TOMLOW  n2 15
    n3 1
    TOMLOW  n2 15
    n2
    TOMHIGH n2 5
    n2
    TOMLOW  n2 15
    TOMLOW  n2 15
    CALL .noi_intro3

    TOMLOW  n4 3
    TOMHIGH n2 5
    n2
    n3 1
.noiA1
    TOMLOW  n2 15
    n2
    n3 1
    TOMHIGH n2 5
    n2
    n3 1
    LOOP2 5, .noiA1
    CALL .noi_tail1

    TOMLOW  n4 3
    TOMHIGH n2 5
    n2
    n3 1
.noiA2
    TOMLOW  n2 15
    n2
    n3 1
    TOMHIGH n2 5
    n2
    n3 1
    LOOP2 5, .noiA2
    CALL .noi_tail1

    TOMLOW  n3 3
.noiA3
    TOMHIGH n2 5
    n2 1
    TOMLOW  n2 15
    TOMLOW  n2 15
    TOMHIGH n2 5
    n2 1
    TOMLOW  n2 15
    TOMLOW  n2 15
    TOMHIGH n2 5
    TOMLOW  n2 15
    n2 1
    TOMLOW  n2 15
    TOMHIGH n2 5
    n2 1
    TOMLOW  n2 15
    n2 1
    LOOP2 2, .noiA3
    TOMHIGH n2 5
    n2 1
    TOMLOW  n2 15
    TOMLOW  n2 15
    TOMHIGH n2 5
    n2 1
    CALL .noi_tail2
    TOMHIGH n2 5

    TOMLOW  n3 3
    TOMHIGH n2 5
    n1 15
    n1
.noiA4
    TOMLOW  n1 15
    n1
    n1 15
    n1
    TOMHIGH n2 5
    n1 15
    n1
    LOOP 12, .noiA4
    CALL .noi_tail2
    n2

    TOMLOW  n3 3
    LOOP2 0, .noiB1
.noiB2
    TOMLOW  n2 15
    n2
.noiB1
    n3 1
    TOMHIGH n2 5
    n2
    n2 1
    n2 1
    LOOP2 6, .noiB2
    TOMHIGH n2 5
    TOMHIGH n2 5
    TOMLOW  n2 15
    TOMHIGH n2 5
    n2
    TOMLOW  n2 15
    TOMHIGH n2 5
    TOMHIGH n2 5

    TOMLOW  n3 3
    LOOP2 0, .noiB3
.noiB4
    TOMLOW  n2 15
    n2
.noiB3
    n3 1
    TOMHIGH n2 5
    n2
    n2 1
    n2 1
    LOOP2 3, .noiB4
;
    n4 3
    VOL 4
    n3 14
    n3 14
    n3 14
    n3 14
    VOL 6
    n3 14
    n3 14
    n3 14
    n3 14
    VOL 8
    n3 14
    n3 14
    TOMHIGH n2 5
    TOMHIGH n2 5
    TOMLOW  n2 15
    TOMHIGH n2 5
    n2
    TOMLOW  n2 15
    TOMLOW  n2 15
    TOMLOW  n2 15

.noiC1
    TOMLOW  n4 3
    n3 1
    TOMLOW  n2 15
    n2
    TOMHIGH n2 5
    n2
    n3
    TOMLOW  n3 1
    TOMLOW  n3 1
    TOMLOW  n4 1
    n3 1
    TOMLOW  n2 15
    TOMLOW  n2 15
    TOMHIGH n3 5
    TOMLOW  n2 15
    n2
    TOMLOW  n3 3
    TOMLOW  n2 15
    n2

    TOMHIGH n4 3
    TOMHIGH n3 3
    n2
    TOMLOW  n2 15
    TOMHIGH n3 3
    TOMLOW  n2 15
    n2
    TOMHIGH n3 3
    TOMLOW  n2 15
    n2
    LOOP2 1, .noiC1
.noiC2
    TOMHIGH n3 3
    TOMLOW  n2 15
    n2
    LOOP2 3, .noiC2

    TOMHIGH n2 3
    TOMHIGH n2 5
    TOMLOW  n2 14
    TOMLOW  n2 14
    TOMLOW  n2 15
    TOMLOW  n2 15
    TOMHIGH n2 5
    TOMHIGH n2 5
    TOMLOW  n2 14
    TOMLOW  n2 14
    TOMLOW  n2 15
    TOMLOW  n2 15
    TOMHIGH n2 5
    TOMHIGH n2 5
    TOMHIGH n2 5
    TOMHIGH n2 5
    CALL .noiC3
    CALL .noiC3

    CALL .noi_intro1
    CALL .noi_intro2
    TOMHIGH n2 5
    TOMLOW  n2 15
    TOMLOW  n2 15
    TOMLOW  n2 15
    TOMHIGH n2 5
    TOMLOW  n2 15
    TOMLOW  n2 15
    TOMLOW  n2 15
    TOMHIGH n2 5
    n2
    TOMLOW  n2 15
    TOMHIGH n2 5
    n3
    TOMHIGH n2 5
    TOMHIGH n2 5
; D part
    CALL .noiD1

    TOMLOW  n4 3
    TOMHIGH n2 5
    n2
    n3 1
.noiD2
    TOMLOW  n2 15
    n2
    n3 1
    TOMHIGH n2 5
    n2
    n3 1
    LOOP2 5, .noiD2
    CALL .noi_tail1
    TOMLOW  n4 3
    TOMHIGH n2 5
    n2
    n3 1
.noiD3
    TOMLOW  n2 15
    n2
    n3 1
    TOMHIGH n2 5
    n2
    n3 1
    LOOP2 2, .noiD3

    CALL .noiD1
; end of the track
    .ifndef IGNEOUS_ROCK_LOOP
    CALL .noi_intro1
    CALL .noi_intro2
    CALL .noi_intro3
    CALL .noi_intro1
    CALL .noi_intro2
    CALL .noi_intro3

    TOMHIGH n2 5
    TOMHIGH n2 5
    TOMHIGH n2 5
    TOMLOW  n2 15
    TOMHIGH n2 5
    n2 14
    n2 15
    TOMHIGH n2 5
    n6
    n5
    TOMLOW  n1 15
    TOMLOW  n1 15
    TOMHIGH n4 5
    END
    .endif
;
    LOOP 0, .noi_start
