
	TEMPO 33
	VOLRAW 67
	KEY O3 + 4
	n1 -1 + 12
    TEMPO 34
	n1 -1 + 12 + 12
    TEMPO 11
    n1 2 + 12
    TEMPO 12
    n1 6 + 12

    TEMPO 33
    n1 2 + 12 + 12
    TEMPO 34
    n1 9
    TEMPO 23
    n1 10

    TEMPO 11
    n1 -1 + 12
    n1
    n1 -1 + 12 + 12
    TEMPO 23
    n1 2 + 12
    TEMPO 11
    n1 -1 + 12
    n1 9
    TEMPO 12
    n1 -1 + 12

    TEMPO 22
    n1 5 + 12
    TEMPO 23
    n1 4 + 12
    TEMPO 22
    n1 2 + 12
    TEMPO 23
    n1 -1 + 12

.tri_loop_start
    TEMPO 11
    n1 -1 + 12
    n1 2 + 12
    n1 -1 + 12 + 12
    TEMPO 23
    n1 -1 + 12
    TEMPO 11
    n1 2 + 12
    n1 -1 + 12 + 12
    TEMPO 12
    n1 2 + 12

    TEMPO 11
    n1 -1 + 12
    n1 2 + 12
    n1 -1 + 12 + 12
    TEMPO 23
    n1 -1 + 12
    TEMPO 11
    n1 1 + 12
    n1 2 + 12
    TEMPO 12
    n1 4 + 12

    TEMPO 22
    n1 6 + 12
    TEMPO 11
    n1 -1 + 12 + 12
    TEMPO 12
    n1 -1 + 12
    TEMPO 11
    n1
    n1 6 + 12
    n1 -1 + 12 + 12
    TEMPO 12
    n1 9 + 12

    TEMPO 22
    n1 6 + 12
    TEMPO 5
    n1 -1 + 12 + 12
    TEMPO 6
    n1
    n2 -1 + 12
    TEMPO 11
    n1
    n1 -1 + 12
    n1 9
    TEMPO 12
    n1 -1 + 12 + 12

    LOOP 1, .tri_loop_start
    LOOP 0, .tri_miniloop_A
.tri_miniloop_A1
    n1 2 + 12
    n1 9
    TEMPO 12
    n1 10
.tri_miniloop_A
    TEMPO 5
    n1 -1 + 12
    PITCH 1
    TEMPO 6
    n1 2 + 12
    TEMPO 5
    n1 2 + 12
    TEMPO 6
    n1
    PITCH 0
    n1 2 + 12
    TEMPO 5
    n1
    TEMPO 6
    n1 -1 + 12
    TEMPO 6 + 11
    n1 4 + 12

    TEMPO 11
    LOOP 1, .tri_miniloop_A1

    n1 5 + 12
    n1 4 + 12
    TEMPO 12
    n1 2 + 12

    TEMPO 5
    n1 -1 + 12
    PITCH 1
    TEMPO 6
    n1 2 + 12
    TEMPO 5
    n1 2 + 12
    TEMPO 6
    n1
    PITCH 0
    n1 2 + 12
    TEMPO 5
    n1
    TEMPO 6
    n1 -1 + 12
    TEMPO 6 + 11
    n1 4 + 12

    TEMPO 11
    n1 2 + 12
    n1 -1 + 12
    TEMPO 12
    n1 9

    TEMPO 11
    n1 -1 + 12
    n1 9
    n1 6
    TEMPO 12 + 11
    n1 5
    TEMPO 11
    n1 4
    n1 2
    TEMPO 12
    n1 1

    VOLRAW 101
    TEMPO 11
    n1 7
    n1 7
    n1 7
    TEMPO 12 + 22
    n1 7
    TEMPO 5
    n1 7 + 12
    TEMPO 6
    n1 7 + 12
    n2 7

    TEMPO 11
    n1 9
    n1 9
    n1 9
    TEMPO 12
    n1 9
    TEMPO 11
    n1 9
    n1 9
    TEMPO 5
    n1 9 + 12
    TEMPO 6
    n1 9 + 12
    n2 9

    TEMPO 11
    n1 10
    n1 10
    n1 10
    TEMPO 12 + 11
    n1 10
    TEMPO 11
    n1 6
    n1 4
    TEMPO 12
    n1 6

    VOLRAW 34
    TEMPO 22
    n1 -1 + 12
    TEMPO 23
    n1 -1 + 12
    TEMPO 11
    n1 -1 + 12
    TEMPO 5
    PITCH 16
    n1 7 + 12 + 12
    TEMPO 6
    n1
    VOLRAW 67
    TEMPO 23
    n1 7 + 12 + 12

    PITCH 0
    KEY O3
    LOOP 0, .tri_miniloop_B
.tri_miniloop_B1
    TEMPO 12
    n1 1 + 12
    TEMPO 11
    n1 3
    n1 3 + 12
    n1 1 + 12
    TEMPO 12
    n1 6 + 12
.tri_miniloop_B
.d = 2
    TEMPO 11
    n1 3 + 12
    PITCH 21
    n1 3 + 12 + 12
    PITCH 0
    n1 3
    TEMPO 12
    PITCH 0
    TIE 1
    n1 3 + 12 + 12
    TEMPO 11
    PITCH 13
    n1 3 + 12 + 12
    PITCH 0
    TEMPO .d
    n1 1
    TEMPO 11 - .d
    n1 3
    TEMPO .d
    n1 1
    TEMPO 11 - .d
    n1 3
    TEMPO .d
    n1 5
    TEMPO 12 - .d
    n1 3

    TEMPO .d
    n1 5
    TEMPO 11 - .d
    n1 3
    TEMPO 11
    n1 3 + 12
    n1 3
    TEMPO 12
    n1 1 + 12
    TEMPO 11
    n1 3
    n1 10
    n1 9
    TEMPO 12
    n1 8

    TEMPO 11
    n1 3 + 12
    PITCH 21
    n1 3 + 12 + 12
    PITCH 0
    n1 3
    TEMPO 12
    PITCH 0
    TIE 1
    n1 3 + 12 + 12
    TEMPO 11
    PITCH 13
    n1 3 + 12 + 12
    PITCH 0
    TEMPO .d
    n1 1
    TEMPO 11 - .d
    n1 3
    TEMPO .d
    n1 1
    TEMPO 11 - .d
    n1 3
    TEMPO .d
    n1 5
    TEMPO 12 - .d
    n1 3

    TEMPO .d
    n1 5
    TEMPO 11 - .d
    n1 3
    TEMPO 11
    n1 3 + 12
    n1 3
    LOOP 3, .tri_miniloop_B1

    TEMPO 6
    PITCH 20
    KEY O5
    n1 11
    n1 11
    PITCH 16
    TEMPO 22
    n1 11
    TEMPO 23
    n1 11

    PITCH 0
    KEY O3
    LOOP 0, .tri_miniloop_C
.tri_miniloop_C1
    TEMPO 12 + 11
    n1 9
    TEMPO 11
    n1 8
    n1 1
    TEMPO 12
    n1 2
.tri_miniloop_C
    TEMPO 11
    n1 11
    n1 11 + 12
    n1 3
    TEMPO 12
    n1 11
    TEMPO 11
    n1 6 + 12
    n1 11
    TEMPO .d
    n1 12
    TEMPO 11 - .d
    n1 11
    TEMPO 12
    n1 1 + 12

    TEMPO 11
    n1 1 + 12 + 12
    n1 1 + 12
    n1 3
    TEMPO 12
    n1 10
    TEMPO 11
    n1 10 + 12
    n1 10
    n1 1 + 12
    TEMPO 12
    n1 10

    TEMPO 11
    n1 3
    n1 6
    n1 3
    TEMPO 12 + 11
    n1 10
    TEMPO 11
    n1 8
    n1 6
    TEMPO 12
    n1 8

    TEMPO 11
    n1 3 + 12
    n1 1 + 12
    n1 3
    LOOP 3, .tri_miniloop_C1

    TEMPO 12
    n1 9
    TEMPO 5
    PITCH 14
    KEY O5
    n1 9
    TEMPO 6
    n1 9
    TEMPO 5
    n1 9
    TEMPO 6
    n1 9
    n1 9
    TEMPO 5
    n1 9
    TEMPO 6
    n1 9
    n1 9
    PITCH 0
	VOLRAW 67
	KEY O3 + 4
    LOOP 0, .tri_loop_start
