
.tri_intro
    n2 10
    n2 10
    n3 10
    n2 10
    n2 10
    n2 10
    n3 10
    n2 10
    n3 10
    n2 10
    n2 10
    n2 10
    n2 10
    LOOP2 1, .tri_intro

    n2 16
    n2 16
    n3 16
    n2 16
    n2 16
    n2 16
    n3 10
    n2 10
    n3 10
    n2 10
    n2 10
    n2 10
    n2 10
    RETURN
.triA1_loop
    n3 10
    n3 10
    n2 10
    n2 10
    n2 10
    n2 10
    n2 10
    n2 10
    n3 13
    n2 10
    n2 10
    n2 10
    n2 10
.triA1
    n3 10
    n3 10
    n2 10
    n2 10
    n2 10
    DOT
    n3 13
    n3 15
    n4 15

    n3 10 - 1
    n3 10 - 1
    n2 10 - 1
    n2 10 - 1
    n2 10 - 1
    DOT
    n3 13
    n3 15
    n4 15

    n3 10 - 2
    n3 10 - 2
    n2 10 - 2
    n2 10 - 2
    n2 10 - 2
    DOT
    n3 13
    n3 15
    n4 15
    LOOP2 1, .triA1_loop
    n3 10 - 3
    n2 10 - 3
    n3 10 - 3
    n2 10 - 3
    n2 10 - 3
    n2 10 - 3
    n2 10 - 3
    n2 10 - 3
    n3 1 + 12
    n2 10 - 3
    n2 10 - 3
    n3 3 + 12
    RETURN
.triA2
    n3 6
    n3 6
    n3 6
    n2 6
    n3 6
    n2 6
    n2 6
    n2 6
    n3 6
    n3 6
    
    n3 8
    n3 8
    n3 8
    n2 8
    n3 8
    n2 8
    n2 8
    n2 8
    n3 8
    n3 8

    n3 10
    n3 10
    n3 10
    n2 10
    n2 10
    n2 10
    n3 10
    n2 10
    n2 10
    n2 10
    n3 10
    RETURN
.triA3
    n3 6 + 12
    n3 6 + 12
    n3 6 + 12
    n2 6 + 12
    n3 6 + 12
    n2 6 + 12
    n2 6 + 12
    n2 6 + 12
    n3 6 + 12
    n3 6 + 12
    
    n3 8 + 12
    n3 8 + 12
    n3 8 + 12
    n2 8 + 12
    n3 8 + 12
    n2 8 + 12
    n2 8 + 12
    n2 8 + 12
    n3 8 + 12
    n3 8 + 12
    
    n3 3 + 12
    n2 3 + 12
    n2 3 + 12
    n2 3 + 12
    n2 3 + 12
    n2 3 + 12
    n3 3 + 12
    n2 3 + 12
    n2 3 + 12
    n2 3 + 12
    n3 3 + 12
    n3 3 + 12
    
    n3 5 + 12
    n3 5 + 12
    n3 5 + 12
    n2 5 + 12
    n3 5 + 12
    n2 5 + 12
    n2 5 + 12
    n2 5 + 12
    n3 5 + 12
    n3 5 + 12
    RETURN
.triD1
    n2 10
    n2 10
    n3 10
    n2 10
    n2 10
    n2 10
    n3 10
    n2 10
    n3 10
    n2 10
    n2 10
    n3 10
    RETURN
.tri_start
    KEY O3
    VOLRAW 40
    CALL .tri_intro

    n2 10
    n2 10
    n2 10
    n2 10
    n2 9
    n2 9
    n2 9
    n2 9
    n2 8
    n2 8
    n2 8
    n2 8
    n2 8
    n2 8
    n2 4
    n2 4
    LOOP 3, .tri_start

    CALL .triA1
    CALL .triA2

    n3 1 + 12
    n3 1 + 12
    n3 1 + 12
    n2 1 + 12
    n3 3 + 12
    n2 3 + 12
    n2 3 + 12
    n2 3 + 12
    n3 3 + 12
    n3 5 + 12

    CALL .triA3

.triB
    n4 10
    n3 10
    n2 10
    n4 8
    n2
    n3 8
    n2 8
    n4 7
    n2
    n3 7
    n2 7
    n4 6
    n2
    n3 6
    n3 5

    n4 10
    n3 10
    n2 10
    n4 8
    n2
    n3 8
    n3 8
    n4 7
    n3 7
    n3 6
    DOT n3 1 + 12
    DOT n3 10
    n3 10

    n3 10
    n3 10
    n3 10
    n2
    n3 8
    n2 8
    n3 8
    n3 8
    n3 8
    n3 7
    n3 7
    n3 7
    n2
    n3 6
    n3 6
    n2 6
    n3 6
    n3 5

    n3 10
    n3 10
    n3 10
    n2
    n3 8
    n2 8
    n2 8
    n2 8
    n3 8
    n3 8
    n2 7
    n2 7
    n3 7
    n3 7
    n2 7
    n3 6
    n2 6
    n2 6
    n2 6
    n3 6
    n3 5
;
    n3 10
    n3 10
    n3 10
    n3 10
    n3 8
    n3 8
    n3 8
    n3 8
    n3 7
    n3 7
    n3 7
    n3 7
    n3 6
    n3 6
    n3 6
    n3 5
    
    n3 10
    n3 10
    n3 10
    n3 10
    n3 8
    n3 8
    n3 8
    n3 8
    n3 3 + 12
    n3 3 + 12
    n3 3 + 12
    n3 3 + 12
    n3 5 + 12
    n3 5 + 12
    n3 5 + 12
    n3 5 + 12

    n2 10
    n2 10
    n2 10
    n2 10
    n2 10
    n3 10
    n2 9
    n2 8
    n2 8
    n2 8
    n2 8
    n2 8
    n3 8
    n2 7
    n2 7
    n2 7
    n2 7
    n2 7
    n3 7
    n2 7
    n3 6
    n3 6
    n2 6
    n3 5
    n3 5

    n2 10
    n2 10
    n2 10
    n2 10
    n4 10
    n2 8
    n2 8
    n2 8
    n2 8
    n2 8
    n2 8
    n2 8
    n3 7
    n3 7
    n3 7
    n3 7
    n2 6
    n3 6
    n2 6
    n2 6
    n2 6
    n2 5
    n2 5
    n2 5

.triC1
    n3 10
    n2 10
    n2 10
    LOOP2 3, .triC1
    n2 10
    n2 10
    n2 10
    n3 10
    n2 10
    n2 10
    n2 10
    n3 10
    n2 10
    n2 10
    n3 10
    n2 10
    n2 10

    n3 4 + 12
    n2 4 + 12
    n2 4 + 12
    n2 4 + 12
    n3 4 + 12
    n2 4 + 12
    n3 10
    n2 10
    n2 10
    n3 10
    n2 10
    n2 10
    n2 10
    n2 10
    n2 10
    n2 10
    n2 9
    n2 9
    n2 9
    n2 9
    n3 8
    n2 8
    n3 8
    n2 8
    n3 5
    LOOP 1, .triC1

    CALL .tri_intro
    n2 10
    n2 10
    n2 10
    n2 9
    n2 9
    n2
    n2 9
    n2 8
    n2 8
    n2 8
    n2
    n2 8
    n3
    n3 1

; D part
    CALL .triD1
    CALL .triD1
    KEY O3 - 2
    CALL .triD1
    CALL .triD1
    KEY O3 - 3
    CALL .triD1
    CALL .triD1
    KEY O3 - 4
    CALL .triD1
    n2 12
    n2 12
    n3 12
    n3 12
    n2 12
    n3 9
    n2 9
    n3 9
    n3 9
    n3 9

    KEY O3
    n3 10
    n3 10
    n2 10
    n2 10
    n2 10
    DOT
    n3 13
    n3 15
    n4 15

    n2 10 - 1
    DOT n3 10 - 1
    n2 10 - 1
    n2 10 - 1
    n2 10 - 1
    DOT
    n3 13
    n3 15
    n4 15

    n2 8
    n2 8
    n3 8
    n2 8
    n2 8
    n2 8
    DOT n3 8
    n3 8
    n4 8

    n2 7
    n2 7
    n3 7
    n2 7
    n2 7
    n3 7
    n2 10
    n2 10
    n3 10
    n3 1 + 12
    n2 1 + 12
    n2 1 + 12

    n2 6
    n2 6
    n3 6
    n3 6
    n3 6
    n2 6
    DOT n3 6
    n4 6
    n3 8
    n3 8
    n2 8
    n2 8
    n2 8
    n2 8
    n3 8
    n3 8
    n4 8
    n3 10
    n3 10
    n2 10
    n3 10
    n3 10
    n2 10
    n3 10
    n2 10
    n2 10
    n3 10
    n2 10
    n2 10
    n3 10
    n2 10
    n3 10
    n3 10
    n2 10
    n3 10
    n4 10

    KEY O3 - 2
.triD2
    CALL .triD1
    n2 10
    n2 10
    n3 10
    n2 10
    n2 10
    n2 10
    n3 10
    n2 10
    n3 10
    n2 10
    n2 10
    n2 10
    n2 9
    KEY O3 - 3
    LOOP2 1, .triD2

    KEY O3
    n3 6
    n3 6
    n2 6
    n2 6
    n2 6
    n3 6
    n2 6
    n3 6
    n2 6
    n2 6
    n3 6
    n3 8
    n3 8
    n2 8
    n2 8
    n2 8
    n3 5
    n2 5
    n3 5
    n2 5
    n2 5
    n3 5
    LOOP 0, .tri_start
