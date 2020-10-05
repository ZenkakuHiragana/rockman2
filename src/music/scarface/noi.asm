.noi_intro_s
    TOMLOW
    n4 6
    TOMHIGH
    n4 5
    TOMLOW
    n4 6
    TOMHIGH
    n3 5
    n3 3
    TOMLOW
    n4 6
    TOMHIGH
    n4 5
    TOMLOW
    n4 6
    TOMHIGH
    n4 5
    TOMLOW
    n4 6
    TOMHIGH
    n4 5
    TOMLOW
    n4 6
    TOMHIGH
    n3 5
    n3 3
    RETURN
.noi_s
    TOMLOW
    n4 6
.noi_s2
    TOMHIGH
    n4 5
    TOMLOW
    n4 6
    TOMHIGH
    n4 5
    RETURN
.noi_start
    VOL 12
    ENV 1,2
    CALL .noi_intro_s
    CALL .noi_s

.noi_intro1
    CALL .noi_intro_s
    TOMLOW
    n3 3
    TOMLOW
    n3 4
    TOMLOW
    n4 3
    TOMLOW
    n4 4
    TOMHIGH
    n4 3
    LOOP 1, .noi_intro1

.noiAA
    TOMLOW
    n4 6
    TOMHIGH
    n3 5
    ENV 3,2
    VOL 15
    TIE
    n3 7
    TOMLOW
    n3 7
    n3
    TOMHIGH
    VOL 12
    n3 5
    VOL 15
    TIE
    n3 7
    TOMLOW
    n3 7
    n3
    ENV 1,2
    VOL 12
    CALL .noi_s2
.noiA1
    CALL .noi_intro_s
    CALL .noi_s
    LOOP 1, .noiA1
    LOOP2 1, .noiAA
    END