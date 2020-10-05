.tri_s
    VOLRAW 24
    n3 1 + 12
    LOOP 23, .tri_s
    VOLRAW 32
    n3 9
    n3 8
    n3 11
    n3 8
    n3 1 + 12
    n3 8
    n3 11
    n3 1 + 12
    RETURN
.triA_s
    VOLRAW 24
.triA_s1
    n3 1 + 12
    LOOP 15, .triA_s1
.triA_s2
    n3 11
    LOOP 15, .triA_s2
.triA_s3
    n3 9
    LOOP 15, .triA_s3
    RETURN
.tri_start
    KEY O3
.tri_intro
    CALL .tri_s
    LOOP2 2, .tri_intro

    CALL .triA_s
    CALL .tri_s
    CALL .triA_s
.triA1
    n3 1 + 12
    LOOP 31, .triA1

.triB1
    n3 9
    LOOP 31, .triB1
.triB2
    n3 1 + 12
    LOOP 7, .triB2
    END
