
.noi_start
    VOL 11
    ENV 1, 1
    TOMLOW  n2 1
    DOT n3
    TOMHIGH n4 5
    LOOP 15, .noi_start

    ENV 3, 1
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
    ENV 3, 1
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
    END
