
.noi_start
    VOL 8
    ENV 1, 1
    TOMLOW  n2 1
    DOT n3
    TOMHIGH n4 5
    LOOP 15, .noi_start

    ENV 4, 1
    TOMLOW  n4 5
    ENV 1, 1
    TOMHIGH n3 5
    n2 3
    n2 3
.noi_intro1
    TOMLOW  n2 1
    n2
    n2 3
    n2 3
    TOMHIGH n3 5
    n2 3
    n2 3
    LOOP 11, .noi_intro1
.noi_intro2
    TOMLOW  n2 1
    DOT n3
    TOMHIGH n4 5
    LOOP 2, .noi_intro2

.noiA2
    ENV 4, 1
    TOMLOW  n4 5
    ENV 1, 1
    TOMHIGH n3 5
    n2 3
    n2 3
.noiA1
    TOMLOW  n2 1
    n2
    n2 3
    n2 3
    TOMHIGH n3 5
    n2 3
    n2 3
    LOOP 14, .noiA1
    LOOP2 1, .noiA2


    ENV 4, 1
    TOMLOW  n4 5
    ENV 1, 2
    TOMHIGH n3 5
    n2 8
    n2 8
    LOOP2 1, .noiB1
.noiB2
    TOMHIGH n3 5
    n2 8
    n2 8
.noiB1
    TOMLOW  n2 5
    n2 7
    n2 8
    n2 9
    LOOP2 3, .noiB2
    TOMLOW  n1 3
.noiB3
    n1 3
    LOOP2 6, .noiB3
    LOOP 7, .noiB1
    END
