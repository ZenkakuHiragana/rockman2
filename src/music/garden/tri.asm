
    VOLRAW 40
.tri_loop_start
    KEY O4
    TOMHIGH
    DOT n3 1
    TOMLOW
    DOT n3 7
    TOMHIGH
    DOT n3 1 + 12
    TOMLOW
    DOT n3 7
    TOMLOW
    n3 6
    TOMLOW
    n3 4

    TOMHIGH
    DOT n3 1
    TOMLOW
    DOT n3 7
    TOMHIGH
    DOT n3 1 + 12
    TOMLOW
    DOT n3 4 + 12
    TOMLOW
    n3 10
    TOMLOW
    n3 11

    TOMHIGH
    DOT n3 1
    TOMLOW
    DOT n3 7
    TOMHIGH
    DOT n3 1 + 12
    TOMLOW
    DOT n3 7
    TOMLOW
    n3 6
    TOMLOW
    n3 4

    TOMHIGH
    DOT n3 1
    TOMHIGH
    DOT n3 7
    TOMHIGH
    n3 11
    TOMHIGH
    DOT n3 10
    TOMHIGH
    DOT n3 9
    TOMHIGH
	n3 8

.triA
    TOMHIGH
    DOT n3 1
    TOMLOW
    DOT n3 7
    TOMLOW
    n3 8
    TOMHIGH
    DOT n3 1 + 12
    TOMLOW
    DOT n3 7
    TOMLOW
    n3 8

    TOMHIGH
    DOT n3 3
    TOMLOW
    DOT n3 7
    TOMLOW
    n3 10
    TOMHIGH
    DOT n3 3 + 12
    TOMLOW
    DOT n3 7
    TOMLOW
    n3 10

    TOMHIGH
    DOT n3 6
    TOMLOW
    DOT n3 9
    TOMLOW
    n3 1 + 12
    TOMHIGH
    DOT n3 4 + 12
    TOMLOW
    DOT n3 9
    TOMLOW
    n3 6

    TOMHIGH
    DOT n3 1
    TOMLOW
    DOT n3 7
    TOMLOW
    n3 11
    TOMHIGH
    DOT n3 10
    TOMHIGH
    DOT n3 9
    TOMHIGH
    n3 8
    LOOP 3, .triA

.triB
    DOT n3 1
    DOT n3 7
    DOT n3 1 + 12
    n3 7 + 12
    n2 7 + 12
    n2 7 + 12
    DOT n3
    n6
    DOT n3 1
    DOT n3 7
    DOT n3 1 + 12
    n3 7 + 12
    n2 7 + 12
    n2 7 + 12
    DOT n3
    n6
    KEY O4 + 3
    LOOP 1, .triB

    KEY O4
.triC
    TOMLOW
    n2 1
    n2 5
    n2 7
    n2 1 + 12
    TOMLOW
    n3 1 + 12
    n2 1
    n2 7
    TOMLOW
    n2 10
    n3 3 + 12
    n2 3 + 12
    TOMLOW
    n3 10
    n3 3

    TOMLOW
    n2 1
    n2 6
    n2 9
    n2 1 + 12
    TOMLOW
    n3 1 + 12
    n2 1
    n2 7
    TOMLOW
    n2 8
    n3 1 + 12
    n2 1 + 12
    TOMLOW
    n3 8
    n3 4

    TOMLOW
    n2 5
    n2 6
    n2 9
    n2 2 + 12
    TOMLOW
    n3 2 + 12
    n2 2
    n2 6
    TOMLOW
    n2 8
    n3 1 + 12
    n2 1 + 12
    TOMLOW
    n3 8
    n3 4

    TOMLOW
    n2 3
    n2 8
    n2 10
    n2 3 + 12
    TOMLOW
    n2 3 + 12
    n2 3 + 12
    n2 3
    n2 7
    TOMLOW
    n2 8
    n3 3 + 12
    n2 3 + 12
    TOMLOW
    n3 8
    n3 3
    LOOP 1, .triC
	LOOP 0, .tri_loop_start
