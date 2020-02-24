
.noi_sub1
    n2 5
    n2 1
    n2 1
    n2 1
    n2 5
    n2 1
    n2 5
    n2 1
    n2 7
    n2 1
    n2 7
    n2 7
    n2 7
    n2 1
    n2 7
    n2 1
.noi_sub3
    ENV 3, 1
    n4 4
    RETURN
.noi_sub2
    n3 5
    n3 1
    n3 7
    n3 7
    n3 5
    n3 1
    n3 7
    n3 1
    RETURN
.noi_start
    VOL 15
    ENV 1, 2
.noiIntro
    CALL .noi_sub2
    LOOP 1, .noiIntro
    CALL .noi_sub1
.noi_loop
    n4 1
    ENV 1, 2
    n3 1
    n3 1
    n4 7

.noiA
    CALL .noi_sub2
    LOOP 5, .noiA
    CALL .noi_sub1
    n4 7
    n4 3
    n4 5
    ENV 1, 2
.noiB
    CALL .noi_sub2
    LOOP 6, .noiB
    CALL .noi_sub3
    LOOP 0, .noi_loop
