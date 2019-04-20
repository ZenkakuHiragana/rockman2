
    VOL 15
    ENV 2, 3
.intro
    TEMPO 11
    n1 2
    TEMPO 5
    n1 2
    TEMPO 6
    n1 2
    TEMPO 11
    n1 2
    TEMPO 6
    n1 2
    n1 2
    LOOP 3, .intro

    TEMPO 11
    n1 12
    TEMPO 5
    n1 2
    TEMPO 6
    n1 2
    TEMPO 11
    n1 2
    TEMPO 12
    n1 12
    TEMPO 11
    n1 7
    TEMPO 5
    n1 2
    TEMPO 6
    n1 2
    TEMPO 11
    n1 12
    TEMPO 6
    n1 2
    n1 2

    TEMPO 22
    PITCH -2
    ENV 0, 0
    MOD 1
    n1 10
    TEMPO 23
    n1 10
    TEMPO 22
    n1 10
    TEMPO 6
    PITCH 0
    ENV 1, 2
    MOD 0
    n1 7
    TEMPO 5
    n1 7
    TEMPO 6
    n1 7
    n1 7

.noi_loop_start
    TEMPO 5
    n1 12
    TEMPO 6
    n1 2
    TEMPO 5
    n1 12
    TEMPO 6
    n1 2
    n1 7
    TEMPO 5
    n1 2
    TEMPO 6
    n1 12
    n1 12
    TEMPO 5
    n1 2
    TEMPO 6
    n1 7
    TEMPO 5
    n1 12
    TEMPO 6
    n1 2
    n1 7
    TEMPO 5
    n1 2
    TEMPO 6
    n1 12
    n1 2

    TEMPO 5
    n1 12
    TEMPO 6
    n1 2
    TEMPO 5
    n1 12
    TEMPO 6
    n1 2
    n1 7
    TEMPO 5
    n1 2
    TEMPO 6
    n1 12
    n1 12
    TEMPO 5
    n1 2
    TEMPO 6
    n1 7
    TEMPO 5
    n1 12
    TEMPO 6
    n1 2
    n1 7
    TEMPO 5
    n1 2
    TEMPO 6
    n1 12
    n1 2

    TEMPO 5
    n1 12
    TEMPO 6
    n1 2
    TEMPO 5
    n1 12
    TEMPO 6
    n1 2
    n1 7
    TEMPO 5
    n1 2
    TEMPO 6
    n1 2
    n1 12
    TEMPO 5
    n1 2
    TEMPO 6
    n1 12
    TEMPO 5
    n1 12
    TEMPO 6
    n1 2
    n1 7
    TEMPO 5
    n1 2
    TEMPO 6
    n1 2
    n1 2

    TEMPO 5
    n1 12
    TEMPO 6
    n1 2
    TEMPO 5
    n1 12
    TEMPO 6
    n1 2
    n1 7
    TEMPO 5
    n1 2
    TEMPO 6
    n1 2
    n1 12
    TEMPO 5
    n1 2
    TEMPO 6
    n1 12
    TEMPO 5
    n1 12
    TEMPO 6
    n1 2
    TEMPO 23
    PITCH -2
    ENV 0, 0
    MOD 1
    n1 10
    PITCH 0
    ENV 1, 2
    MOD 0
    LOOP 2, .noi_loop_start

    LOOP 0, .noi_miniloop_A
.noi_miniloop_A1
    TEMPO 11
    n1 12
    TEMPO 5
    n1 2
    TEMPO 6
    n1 2
    TEMPO 11
    n1 7
    TEMPO 12
    n1 12
    TEMPO 5
    n1 2
    TEMPO 6
    n1 2
    TEMPO 11
    n1 12
    n1 7
    TEMPO 6
    n1 2
    n1 2
.noi_miniloop_A
    TEMPO 11
    n1 12
    TEMPO 5
    n1 2
    TEMPO 6
    n1 2
    TEMPO 11
    n1 7
    TEMPO 12
    n1 12
    TEMPO 5
    n1 2
    TEMPO 6
    n1 2
    TEMPO 5
    n1 2
    TEMPO 6
    n1 2
    TEMPO 11
    n1 7
    TEMPO 12
    n1 12
    LOOP 1, .noi_miniloop_A1

    TEMPO 11
    n1
    TEMPO 11 + 11
    n1 2
    TEMPO 12 + 11
    n1 2
    TEMPO 11 + 11
    n1 2
    TEMPO 12
    n1 2

    LOOP 0, .noi_miniloop_B
.noi_miniloop_B1
    TEMPO 23
    PITCH -2
    ENV 0, 0
    MOD 1
    n1 10
    PITCH 0
    ENV 1, 2
    MOD 0
.noi_miniloop_B
    TEMPO 22
    ENV 1, 1
    n1 7
    TEMPO 6
    ENV 2, 1
    n1 2
    TEMPO 5
    n1 2
    TEMPO 12
    ENV 1, 1
    n1 7
    TEMPO 5
    ENV 2, 1
    n1 2
    TEMPO 6
    n1 2
    TEMPO 5
    n1 12
    TEMPO 6
    n1 2
    n1 7
    TEMPO 5
    n1 2
    TEMPO 6
    n1 12
    n1 2

    TEMPO 5
    n1 2
    TEMPO 6
    n1 2
    TEMPO 5
    n1 12
    TEMPO 6
    n1 2
    n1 7
    TEMPO 5
    n1 2
    TEMPO 6
    n1 12
    n1 2
    TEMPO 5
    n1 2
    TEMPO 6
    n1 2
    TEMPO 5
    n1 12
    TEMPO 6
    n1 2
    LOOP 1, .noi_miniloop_B1
    PITCH -2
    ENV 0, 0
    MOD 1
    n1 10
    TEMPO 5
    n1 10
    TEMPO 6
    n1 10
    n1 10
    PITCH 0
    ENV 1, 2
    MOD 0

    LOOP 0, .noi_miniloop_C
.noi_miniloop_C1
    n1 2
    TEMPO 6
    n1 2
    TEMPO 5
    PITCH -2
    ENV 0, 0
    MOD 1
    n1 10
    PITCH 0
    ENV 1, 2
    MOD 0
    TEMPO 6
    n1 2
    TEMPO 11
    PITCH -2
    ENV 0, 0
    MOD 1
    n1 10
    TEMPO 6
    n1 10
    n1 10
    PITCH 0
    ENV 1, 2
    MOD 0
.noi_miniloop_C
    TEMPO 22
    ENV 1, 1
    n1 7
    TEMPO 6
    ENV 2, 1
    n1 2
    TEMPO 5
    n1 2
    TEMPO 12
    ENV 1, 1
    n1 7
    TEMPO 5
    ENV 2, 1
    n1 2
    TEMPO 6
    n1 2
    TEMPO 5
    n1 12
    TEMPO 6
    n1 2
    n1 7
    TEMPO 5
    n1 2
    TEMPO 6
    n1 12
    n1 2

    TEMPO 5
    n1 2
    TEMPO 6
    n1 2
    TEMPO 5
    n1 12
    TEMPO 6
    n1 2
    n1 7
    TEMPO 5
    n1 2
    TEMPO 6
    n1 12
    n1 2
    TEMPO 5
    LOOP 1, .noi_miniloop_C1
    PITCH -2
    ENV 0, 0
    MOD 1
    n1 10
    TEMPO 6
    n1 10
    TEMPO 11
    n1 10
    TEMPO 23
    n1 10
    PITCH 0
    ENV 1, 2
    MOD 0

    LOOP 0, .noi_miniloop_D
.noi_miniloop_D1
    n1 12
    TEMPO 6
    n1 2
    TEMPO 23
    PITCH -2
    ENV 0, 0
    MOD 1
    n1 10
    PITCH 0
    ENV 1, 2
    MOD 0
.noi_miniloop_D
    TEMPO 22
    ENV 1, 1
    n1 7
    TEMPO 6
    ENV 2, 1
    n1 2
    TEMPO 5
    n1 2
    TEMPO 12
    ENV 1, 1
    n1 7
    TEMPO 5
    ENV 2, 1
    n1 2
    TEMPO 6
    n1 7
    TEMPO 5
    n1 12
    TEMPO 6
    n1 2
    n1 7
    TEMPO 5
    n1 2
    TEMPO 6
    n1 12
    n1 2

    TEMPO 5
    n1 12
    TEMPO 6
    n1 2
    TEMPO 5
    n1 12
    TEMPO 6
    n1 2
    n1 7
    TEMPO 5
    n1 2
    TEMPO 6
    n1 12
    n1 12
    TEMPO 5
    n1 2
    TEMPO 6
    n1 7
    TEMPO 5
    LOOP 1, .noi_miniloop_D1
    PITCH -2
    ENV 0, 0
    MOD 1
    n1 10
    TEMPO 6
    n1 10
    TEMPO 11
    n1 10
    TEMPO 12
    n1 10

    TEMPO 45
    n1 10
    n1 10

    n1 10
    TEMPO 11
    n1 10
    n1 10
    n1 10
    TEMPO 12
    n1 10

.noi_miniloop_E
    TEMPO 22
    n1 10
    TEMPO 23
    n1 10
    LOOP 2, .noi_miniloop_E

    TEMPO 11
    PITCH 0
    ENV 1, 2
    MOD 0
    n1 7
    n1 2
    n1 7
    TEMPO 12
    n1 2

    LOOP 0, .noi_miniloop_F
.noi_miniloop_F1
    n1 10
    n1 10
    n1 10
    TEMPO 12 + 11
    n1 10
    TEMPO 11
    n1 10
    n1 10
    TEMPO 12
    n1 10
    PITCH 0
    ENV 1, 2
    MOD 0
.noi_miniloop_F
    TEMPO 5
    n1 12
    TEMPO 6
    n1 2
    TEMPO 5
    n1 12
    TEMPO 6
    n1 2
    n1 7
    TEMPO 5
    n1 2
    TEMPO 6
    n1 12
    n1 12
    TEMPO 5
    n1 2
    TEMPO 6
    n1 7
    TEMPO 5
    n1 12
    TEMPO 6
    n1 2
    n1 7
    TEMPO 5
    n1 2
    TEMPO 6
    n1 12
    n1 2

    TEMPO 5
    n1 12
    TEMPO 6
    n1 2
    TEMPO 5
    n1 12
    TEMPO 6
    n1 2
    n1 7
    TEMPO 5
    n1 2
    TEMPO 6
    n1 12
    n1 12
    TEMPO 5
    n1 2
    TEMPO 6
    n1 7
    TEMPO 5
    n1 12
    TEMPO 6
    n1 2
    n1 7
    TEMPO 5
    n1 2
    TEMPO 6
    n1 12
    n1 2

    TEMPO 11
    n1 12
    PITCH -2
    ENV 0, 0
    MOD 1
    n1 10
    n1 10
    TEMPO 12 + 11
    n1 10
    TEMPO 11
    n1 10
    n1 10
    TEMPO 12
    n1 10

    TEMPO 11
    LOOP 3, .noi_miniloop_F1
    PITCH 0
    ENV 1, 2
    MOD 0
    n1 2
    n1 1
    n1 2
    TEMPO 12
    n1 1
    TEMPO 5
    n1 10
    TEMPO 6
    n1 10
    TEMPO 5
    n1 10
    TEMPO 6
    n1 10
    n1 10
    TEMPO 5
    n1 10
    TEMPO 6
    n1 10
    n1 10
    LOOP 0, .noi_loop_start
