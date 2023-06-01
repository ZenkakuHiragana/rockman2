
.noi_start
    VOL 8
    ENV 1, 1
    TOMLOW  n2 1
    DOT n3
    TOMHIGH n4 5
    LOOP 15, .noi_start

.noi_loop
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

    ENV 4, 1
    TOMLOW n4 5
    ENV 1, 2
.noiC1
    TOMLOW n4 10
    LOOP 30, .noiC1
    TOMLOW n4 10
    TOMLOW n4 10
    TOMLOW n4 10
    TOMLOW n4 10
.noiC2
    VOL 8
    TOMLOW n2 10
    VOL 2
    n2 10
    n2 10
    n2 10
    LOOP 3, .noiC2
    VOL 8
    TOMLOW n2 10
    VOL 3
    n2 10
    n2 10
    n2 10
    VOL 8
    TOMLOW n2 10
    VOL 4
    n2 10
    n2 10
    n2 10
    VOL 8
    TOMLOW n2 10
    VOL 5
    n2 10
    n2 10
    n2 10
    VOL 8
    TOMLOW n2 10
    VOL 6
    n2 10
    n2 10
    n2 10
    VOL 8
    TOMLOW n2 10
    VOL 7
    n2 10
    n2 10
    n2 10
    VOL 8
    TOMLOW n2 10
    n2 10
    n2 10
    n2 10
    VOL 10
    ENV 2, 6
.noiC3
    n1 10
    LOOP 15, .noiC3

; D part
    VOL 8
.noiD2
    ENV 4, 1
    TOMLOW n4 5
    ENV 1, 1
    TOMHIGH n3 5
    n3 3
.noiD1
    TOMLOW n3 1
    n3 3
    TOMHIGH n3 5
    n3 3
    LOOP 14, .noiD1
    LOOP2 1, .noiD2
.noiD3
    TOMLOW n3 1
    n3 3
    TOMHIGH n3 5
    n3 3
    LOOP 11, .noiD3

    ENV 1, 2
.noiD4
    TOMLOW n2 5
    n2 7
    n2 8
    n2 9
    TOMHIGH n3 5
    n2 8
    n2 8
    LOOP2 2, .noiD4
    TOMLOW n2 5
    n2 7
    n2 8
    n2 9
    TOMLOW n1 3
.noiD5
    n1 3
    LOOP2 6, .noiD5
    LOOP 2, .noiD4
    
    TOMLOW n2 5
    n2 7
    n2 8
    n2 9
    TOMHIGH n2 5
    n2 8
    n2 8
    n2 8
    TOMLOW n2 6
    n2 9
    n2 9
    n2 9
    TOMHIGH n2 7
    n2 10
    n2 10
    n2 10
    TOMLOW n2 9
    TOMLOW n2 10
    TOMLOW n2 10
    TOMLOW n2 10
    TOMHIGH n2 9
    TOMLOW n2 10
    TOMLOW n2 10
    TOMLOW n2 10
    TOMLOW n1 7
.noiD6
    n1 10
    LOOP 6, .noiD6
    TOMHIGH n1 7
.noiD7
    n1 10
    LOOP 6, .noiD7
    LOOP 0, .noi_loop
    END
