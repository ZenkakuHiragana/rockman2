
    TEMPO 25
    VOL 9
    ENV 1, 2
.noi_intro
    n3 9
    n3 1
    n3 1
    n3 9
    n3 1
    n3 1
    n4 9
    n4 9
    n4 9
    LOOP 3, .noi_intro
.noi_loop_start
    n3 9
    n3 1
    n3 1
    n3 9
    n3 1
    n3 1
    n4 9
    n4 9
    n4 9
    LOOP 15, .noi_loop_start
.noiA
    n3 9
    n3 1
    n3 1
    LOOP 3, .noiA
    n4 9
    n4 9
    n4 9
.noiB
    n1 1
    LOOP 17, .noiB
    DOT
    n3 1
    LOOP 0, .noi_loop_start
