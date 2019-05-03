
	TEMPO 45
	VOLRAW 67
	KEY O3 + 4
    DOT
	n3 -1 + 12
    DOT
	n3 -1 + 12 + 12
    n2 2 + 12
    n2 6 + 12

    DOT
    n3 2 + 12 + 12
    DOT
    n3 9
    n3 10

    n2 -1 + 12
    n2
    n2 -1 + 12 + 12
    n3 2 + 12
    n2 -1 + 12
    n2 9
    n2 -1 + 12

    n3 5 + 12
    n3 4 + 12
    n3 2 + 12
    n3 -1 + 12

.tri_loop_start
    n2 -1 + 12
    n2 2 + 12
    n2 -1 + 12 + 12
    n3 -1 + 12
    n2 2 + 12
    n2 -1 + 12 + 12
    n2 2 + 12

    n2 -1 + 12
    n2 2 + 12
    n2 -1 + 12 + 12
    n3 -1 + 12
    n2 1 + 12
    n2 2 + 12
    n2 4 + 12

    n3 6 + 12
    n2 -1 + 12 + 12
    n2 -1 + 12
    n2
    n2 6 + 12
    n2 -1 + 12 + 12
    n2 9 + 12

    n3 6 + 12
    n1 -1 + 12 + 12
    n1
    n2 -1 + 12
    n2
    n2 -1 + 12
    n2 9
    n2 -1 + 12 + 12

    LOOP 1, .tri_loop_start
    LOOP 0, .tri_miniloop_A
.tri_miniloop_A1
    n2 2 + 12
    n2 9
    n2 10
.tri_miniloop_A
    n1 -1 + 12
    PITCH 1
    n1 2 + 12
    n1 2 + 12
    n1
    PITCH0
    n1 2 + 12
    n1
    n1 -1 + 12
    DOT
    n2 4 + 12

    LOOP 1, .tri_miniloop_A1

    n2 5 + 12
    n2 4 + 12
    n2 2 + 12

    n1 -1 + 12
    PITCH 1
    n1 2 + 12
    n1 2 + 12
    n1
    PITCH0
    n1 2 + 12
    n1
    n1 -1 + 12
    DOT
    n2 4 + 12

    n2 2 + 12
    n2 -1 + 12
    n2 9

    n2 -1 + 12
    n2 9
    n2 6
    n3 5
    n2 4
    n2 2
    n2 1

    VOLRAW 101
    n2 7
    n2 7
    n2 7
    DOT
    n3 7
    n1 7 + 12
    n1 7 + 12
    n2 7

    n2 9
    n2 9
    n2 9
    n2 9
    n2 9
    n2 9
    n1 9 + 12
    n1 9 + 12
    n2 9

    n2 10
    n2 10
    n2 10
    n3 10
    n2 6
    n2 4
    n2 6

    VOLRAW 34
    n3 -1 + 12
    n3 -1 + 12
    n2 -1 + 12
    PITCH 16
    n1 7 + 12 + 12
    n1
    VOLRAW 67
    n3 7 + 12 + 12

    PITCH0
    KEY O3
    LOOP 0, .tri_miniloop_B
.tri_miniloop_B1
    n2 1 + 12
    n2 3
    n2 3 + 12
    n2 1 + 12
    n2 6 + 12
.tri_miniloop_B
.d = 2
    n2 3 + 12
    PITCH 21
    n2 3 + 12 + 12
    PITCH0
    n2 3
    PITCH0
    TIE
    n2 3 + 12 + 12
    PITCH 13
    n2 3 + 12 + 12
    PITCH0
    TIE 2
    n0 1
    DOT
    n1 3
    n0 1
    DOT
    n1 3
    n0 5
    DOT
    n1 3

    n0 5
    DOT
    n1 3
    n2 3 + 12
    n2 3
    n2 1 + 12
    n2 3
    n2 10
    n2 9
    n2 8

    n2 3 + 12
    PITCH 21
    n2 3 + 12 + 12
    PITCH0
    n2 3
    PITCH0
    TIE
    n2 3 + 12 + 12
    PITCH 13
    n2 3 + 12 + 12
    PITCH0
    n0 1
    DOT
    n1 3
    n0 1
    DOT
    n1 3
    n0 5
    DOT
    n1 3

    n0 5
    DOT
    n1 3
    n2 3 + 12
    n2 3
    LOOP 3, .tri_miniloop_B1

    PITCH 20
    KEY O5
    n1 11
    n1 11
    PITCH 16
    n3 11
    n3 11

    PITCH0
    KEY O3
    LOOP 0, .tri_miniloop_C
.tri_miniloop_C1
    n3 9
    n2 8
    n2 1
    n2 2
.tri_miniloop_C
    n2 11
    n2 11 + 12
    n2 3
    n2 11
    n2 6 + 12
    n2 11
    n0 12
    DOT
    n1 11
    n2 1 + 12

    n2 1 + 12 + 12
    n2 1 + 12
    n2 3
    n2 10
    n2 10 + 12
    n2 10
    n2 1 + 12
    n2 10

    n2 3
    n2 6
    n2 3
    n3 10
    n2 8
    n2 6
    n2 8

    n2 3 + 12
    n2 1 + 12
    n2 3
    LOOP 3, .tri_miniloop_C1

    n2 9
    PITCH 14
    KEY O5
    n1 9
    n1 9
    n1 9
    n1 9
    n1 9
    n1 9
    n1 9
    n1 9
    PITCH0
	VOLRAW 67
	KEY O3 + 4
    LOOP 0, .tri_loop_start
