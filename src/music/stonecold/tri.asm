
.tri_base
    n2 10
    n2 10
    n3 10 + 12
    n3 10
    n3 10
    RETURN
.tri_base2
    n2 10
    n2 10
    n3 10 + 12
    n2 9
    n2 9
    n3 9 + 12
    n2 8
    n2 8
    n3 8 + 12
    n2 7
    n2 7
    n3 7 + 12
    RETURN
.tri_start
    KEY O2
    VOLRAW 40
    LOOP 0, .tri_intro
.tri_intro2
    CALL .tri_base2
.tri_intro
    CALL .tri_base
    CALL .tri_base
    CALL .tri_base
    CALL .tri_base
    KEY O2 + 6
    CALL .tri_base
    KEY O2
    CALL .tri_base
    LOOP 1, .tri_intro2
    CALL .tri_base
    CALL .tri_base
    LOOP 0, .tri_intro3
.tri_intro4
    CALL .tri_base
    CALL .tri_base2
.tri_intro3
    CALL .tri_base
    CALL .tri_base
    CALL .tri_base
    CALL .tri_base
    KEY O2 + 6
    CALL .tri_base
    KEY O2
    LOOP 1, .tri_intro4
    n2 10
    n2 10
    n2 10 + 12
    n2 10
    n2 10 + 12
    n2 10 + 12
    n2 10 + 12
    n2 10 + 12
    n2 9 + 12
    n2 9 + 12
    n2 9 + 12
    n2 9 + 12
    n2 8 + 12
    n2 8 + 12
    n2 8 + 12
    n2 8 + 12
    n2 8 + 12
    n2 10 + 12
    n2 8 + 12
    n2 10 + 12
    n2 5 + 12
    n2 5 + 12
    n2 5 + 12
    n2 3 + 12 + 12

    LOOP 0, .triA1
.triA2
    KEY O3
    CALL .tri_base
    n2 1 + 12
    n2 1 + 12
    n3 1 + 12 + 12
    n2 3 + 12
    n2 3 + 12
    n3 3 + 12 + 12
.triA1
    KEY O3
    CALL .tri_base
    n2 1 + 12
    n2 1 + 12
    n3 1 + 12 + 12
    n2 3 + 12
    n2 3 + 12
    n3 3 + 12 + 12
    KEY O3 - 1
    CALL .tri_base
    n2 1 + 1 + 12
    n2 1 + 1 + 12
    n3 1 + 1 + 12 + 12
    n2 1 + 3 + 12
    n2 1 + 3 + 12
    n3 1 + 3 + 12 + 12
    KEY O3 - 2
    CALL .tri_base
    n2 2 + 1 + 12
    n2 2 + 1 + 12
    n3 2 + 1 + 12 + 12
    n2 2 + 3 + 12
    n2 2 + 3 + 12
    n3 2 + 3 + 12 + 12
    LOOP 1, .triA2
    KEY O3 - 3
    CALL .tri_base
    n2 3 + 3 + 12
    n2 3 + 3 + 12
    n3 3 + 3 + 12 + 12
    n2 3 + 5 + 12
    n2 3 + 5 + 12

    KEY O3 + 8
    n3 -8 + 5 + 12 + 12

    KEY O2 + 8
    CALL .tri_base
    CALL .tri_base
    KEY O2 + 10
    CALL .tri_base
    CALL .tri_base
    KEY O2 + 12
    CALL .tri_base
    CALL .tri_base
    KEY O2 + 3
    CALL .tri_base
    KEY O2 + 5
    CALL .tri_base
    KEY O2 + 8
    CALL .tri_base
    CALL .tri_base
    KEY O2 + 10
    CALL .tri_base
    CALL .tri_base
    KEY O2 + 5
    CALL .tri_base
    CALL .tri_base
    KEY O2 + 7
    CALL .tri_base
    CALL .tri_base

    LOOP 0, .triB1
.triB2
    n2 9
    n2 9
    n3 9 + 12
    n2 8
    n2 8
    n3 8 + 12
.triB1
    KEY O3
    CALL .tri_base
    KEY O3 - 2
    CALL .tri_base
    KEY O3 - 3
    CALL .tri_base
    LOOP 1, .triB2
    n2 4 + 12
    n2 4 + 12
    n3 4 + 12 + 12
    n2 1 + 12
    n2 1 + 12
    n3 1 + 12 + 12
.triB3
    KEY O3
    CALL .tri_base
    KEY O3 - 2
    CALL .tri_base
    KEY O3 - 3
    CALL .tri_base
    n2 9
    n2 9
    n3 9 + 12
    n2 8
    n2 8
    n3 8 + 12
    LOOP 2, .triB3
    KEY O3
    CALL .tri_base
    KEY O3 - 2
    CALL .tri_base
    KEY O3 + 5
    CALL .tri_base
    KEY O3
    n2 5 + 12
    n2 5 + 12
    n3 5 + 12 + 12
    n2 1 + 12
    n2 1 + 12
    n3 1 + 12 + 12
.triB4
    CALL .tri_base
    KEY O3 - 2
    CALL .tri_base
    KEY O3 - 3
    CALL .tri_base
    n2 9
    n2 9
    n3 9 + 12
    n2 8
    n2 8
    n3 8 + 12
    KEY O3
    LOOP 1, .triB4

    LOOP 0, .triC1
.triC2
    CALL .tri_base
    LOOP2 3, .triC2
    KEY O3 + 6
    CALL .tri_base
    KEY O3
    CALL .tri_base
    CALL .tri_base
    CALL .tri_base
.triC1
    CALL .tri_base
    LOOP2 3, .triC1
    KEY O3 + 6
    CALL .tri_base
    KEY O3
    CALL .tri_base
    CALL .tri_base2
    LOOP 1, .triC2

; D part
.triD1
    CALL .tri_base
    LOOP 3, .triD1
    KEY O3 - 2
.triD2
    CALL .tri_base
    LOOP 3, .triD2
    KEY O3 - 3
.triD3
    CALL .tri_base
    LOOP 3, .triD3
    KEY O3 - 4
    CALL .tri_base
    CALL .tri_base
    KEY O3 - 2
    CALL .tri_base
    KEY O3 - 5
    CALL .tri_base

    KEY O3
    CALL .tri_base
    n2 1 + 12
    n2 1 + 12
    n3 1 + 12 + 12
    n2 3 + 12
    n2 3 + 12
    n3 3 + 12 + 12
    KEY O3 - 1
    CALL .tri_base
    n2 1 + 1 + 12
    n2 1 + 1 + 12
    n3 1 + 1 + 12 + 12
    n2 1 + 3 + 12
    n2 1 + 3 + 12
    n3 1 + 3 + 12 + 12
    KEY O3 - 2
    CALL .tri_base
    n2 2 + 1 + 12
    n2 2 + 1 + 12
    n3 2 + 1 + 12 + 12
    n2 2 + 3 + 12
    n2 2 + 3 + 12
    n3 2 + 3 + 12 + 12
    KEY O3 - 3
    CALL .tri_base
    n2 3 + 1 + 12
    n2 3 + 1 + 12
    n3 3 + 1 + 12 + 12
    n2 3 + 3 + 12
    n2 3 + 3 + 12
    n3 3 + 3 + 12 + 12

    KEY O3 - 4
    CALL .tri_base
    n2 4 + 6
    n2 4 + 6
    n3 4 + 6 + 12
    n2 4 + 6
    n2 4 + 6
    n3 4 + 6 + 12
    KEY O3 - 2
    CALL .tri_base
    n2 2 + 10
    n2 2 + 10
    n3 2 + 10 + 12
    n2 2 + 12
    n2 2 + 12
    n3 2 + 12 + 12

    KEY O3
.triD4
    CALL .tri_base
    n2 1 + 12
    n2 1 + 12
    n3 1 + 12 + 12
    n2 3 + 12
    n2 3 + 12
    n3 3 + 12 + 12
    LOOP 1, .triD4
    KEY O3 - 2
.triD5
    CALL .tri_base
    n2 2 + 1 + 12
    n2 2 + 1 + 12
    n3 2 + 1 + 12 + 12
    n2 2 + 3 + 12
    n2 2 + 3 + 12
    n3 2 + 3 + 12 + 12
    LOOP 1, .triD5
    KEY O3 - 3
.triD6
    CALL .tri_base
    n2 3 + 1 + 12
    n2 3 + 1 + 12
    n3 3 + 1 + 12 + 12
    n2 3 + 3 + 12
    n2 3 + 3 + 12
    n3 3 + 3 + 12 + 12
    LOOP 1, .triD6
    KEY O3 - 4
    CALL .tri_base
    n2 4 + 1 + 12
    n2 4 + 1 + 12
    n3 4 + 1 + 12 + 12
    n2 4 + 3 + 12
    n2 4 + 3 + 12
    n3 4 + 3 + 12 + 12
    KEY O3 - 2
    CALL .tri_base
    n2 2 + 10
    n2 2 + 10
    n3 2 + 10 + 12
    n2 2 + 12
    n2 2 + 12
    n3 2 + 12 + 12

    KEY O2
    LOOP 0, .triD7
.triD8
    CALL .tri_base
    CALL .tri_base2
.triD7
    CALL .tri_base
    CALL .tri_base
    CALL .tri_base
    CALL .tri_base
    KEY O2 + 6
    CALL .tri_base
    KEY O2
    LOOP 1, .triD8
    n2 10
    n2 10
    n2 10 + 12
    n2 10
    n2 10 + 12
    n2 10 + 12
    n2 10 + 12
    n2 10 + 12
    n2 9 + 12
    n2 9 + 12
    n2 9 + 12
    n2 9 + 12
    n2 8 + 12
    n2 8 + 12
    n2 8 + 12
    n2 8 + 12
    n2 8 + 12
    n2 10 + 12
    n2 8 + 12
    n2 10 + 12
    n2 5 + 12
    n2 5 + 12
    n2 5 + 12
    n2 5 + 12
; end of the track
    n1 1
    END
;
    LOOP 0, .tri_intro3
    END
