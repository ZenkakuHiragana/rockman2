
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

    KEY O3 + 8
    CALL .tri_base
    CALL .tri_base
    KEY O3 + 10
    CALL .tri_base
    CALL .tri_base
    KEY O3 + 12
    CALL .tri_base
    CALL .tri_base
    KEY O3 + 3
    CALL .tri_base
    KEY O3 + 5
    CALL .tri_base
    KEY O3 + 8
    CALL .tri_base
    CALL .tri_base
    KEY O3 + 10
    CALL .tri_base
    CALL .tri_base
    KEY O3 + 5
    CALL .tri_base
    CALL .tri_base
    KEY O3 + 7
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
    END
