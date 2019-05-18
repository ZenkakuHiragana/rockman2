
	TEMPO 180
	VOLRAW 67
	KEY O3 + 4
    DOT	n4 -1 + 12
    DOT	n4 -1 + 12 + 12
    n3 2 + 12
    n3 6 + 12

    DOT n4 2 + 12 + 12
    DOT n4 9
    n4 10

    n3 -1 + 12
    n3
    n3 -1 + 12 + 12
    n4 2 + 12
    n3 -1 + 12
    n3 9
    n3 -1 + 12

    n4 5 + 12
    n4 4 + 12
    n4 2 + 12
    n4 -1 + 12

.tri_loop_start
    n3 -1 + 12
    n3 2 + 12
    n3 -1 + 12 + 12
    n4 -1 + 12
    n3 2 + 12
    n3 -1 + 12 + 12
    n3 2 + 12

    n3 -1 + 12
    n3 2 + 12
    n3 -1 + 12 + 12
    n4 -1 + 12
    n3 1 + 12
    n3 2 + 12
    n3 4 + 12

    n4 6 + 12
    n3 -1 + 12 + 12
    n3 -1 + 12
    n3
    n3 6 + 12
    n3 -1 + 12 + 12
    n3 9 + 12

    n4 6 + 12
    n2 -1 + 12 + 12
    n2
    n3 -1 + 12
    n3
    n3 -1 + 12
    n3 9
    n3 -1 + 12 + 12

    LOOP 1, .tri_loop_start
    LOOP 0, .tri_miniloop_A
.tri_miniloop_A1
    n3 2 + 12
    n3 9
    n3 10
.tri_miniloop_A
    n2 -1 + 12
    PITCH 1
    n2 2 + 12
    n2 2 + 12
    n2
    PITCH0
    n2 2 + 12
    n2
    n2 -1 + 12
    DOT n3 4 + 12

    LOOP 1, .tri_miniloop_A1

    n3 5 + 12
    n3 4 + 12
    n3 2 + 12

    n2 -1 + 12
    PITCH 1
    n2 2 + 12
    n2 2 + 12
    n2
    PITCH0
    n2 2 + 12
    n2
    n2 -1 + 12
    DOT n3 4 + 12

    n3 2 + 12
    n3 -1 + 12
    n3 9

    n3 -1 + 12
    n3 9
    n3 6
    n4 5
    n3 4
    n3 2
    n3 1

    VOLRAW 101
    n3 7
    n3 7
    n3 7
    DOT n4 7
    n2 7 + 12
    n2 7 + 12
    n3 7

    n3 9
    n3 9
    n3 9
    n3 9
    n3 9
    n3 9
    n2 9 + 12
    n2 9 + 12
    n3 9

    n3 10
    n3 10
    n3 10
    n4 10
    n3 6
    n3 4
    n3 6

    VOLRAW 34
    n4 -1 + 12
    n4 -1 + 12
    n3 -1 + 12
    PITCH 16
    n2 7 + 12 + 12
    n2
    VOLRAW 67
    n4 7 + 12 + 12

    PITCH0
    KEY O3
    LOOP 0, .tri_miniloop_B
.tri_miniloop_B1
    n3 1 + 12
    n3 3
    n3 3 + 12
    n3 1 + 12
    n3 6 + 12
.tri_miniloop_B
.d = 2
    n3 3 + 12
    PITCH 21
    n3 3 + 12 + 12
    PITCH0
    n3 3
    PITCH0
    TIE
    n3 3 + 12 + 12
    PITCH 13
    n3 3 + 12 + 12
    PITCH0
    TIE 2
    n1 1
    DOT n2 3
    n1 1
    DOT n2 3
    n1 5
    DOT n2 3

    n1 5
    DOT n2 3
    n3 3 + 12
    n3 3
    n3 1 + 12
    n3 3
    n3 10
    n3 9
    n3 8

    n3 3 + 12
    PITCH 21
    n3 3 + 12 + 12
    PITCH0
    n3 3
    PITCH0
    TIE
    n3 3 + 12 + 12
    PITCH 13
    n3 3 + 12 + 12
    PITCH0
    n1 1
    DOT n2 3
    n1 1
    DOT n2 3
    n1 5
    DOT n2 3

    n1 5
    DOT n2 3
    n3 3 + 12
    n3 3
    LOOP 3, .tri_miniloop_B1

    PITCH 20
    KEY O5
    n2 11
    n2 11
    PITCH 16
    n4 11
    n4 11

    PITCH0
    KEY O3
    LOOP 0, .tri_miniloop_C
.tri_miniloop_C1
    n4 9
    n3 8
    n3 1
    n3 2
.tri_miniloop_C
    n3 11
    n3 11 + 12
    n3 3
    n3 11
    n3 6 + 12
    n3 11
    n1 12
    DOT n2 11
    n3 1 + 12

    n3 1 + 12 + 12
    n3 1 + 12
    n3 3
    n3 10
    n3 10 + 12
    n3 10
    n3 1 + 12
    n3 10

    n3 3
    n3 6
    n3 3
    n4 10
    n3 8
    n3 6
    n3 8

    n3 3 + 12
    n3 1 + 12
    n3 3
    LOOP 3, .tri_miniloop_C1

    n3 9
    PITCH 14
    KEY O5
    n2 9
    n2 9
    n2 9
    n2 9
    n2 9
    n2 9
    n2 9
    n2 9
    PITCH0
	VOLRAW 67
	KEY O3 + 4
    LOOP 0, .tri_loop_start
