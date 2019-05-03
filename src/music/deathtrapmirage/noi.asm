
    TEMPO 45
    VOL 15
    ENV 2, 3
.intro
    n2 2
    n1 2
    n1 2
    n2 2
    n1 2
    n1 2
    LOOP 3, .intro

    n2 12
    n1 2
    n1 2
    n2 2
    n2 12
    n2 7
    n1 2
    n1 2
    n2 12
    n1 2
    n1 2

    PITCH -2
    ENV 0, 0
    MOD 1
    n3 10
    n3 10
    n3 10
    PITCH0
    ENV 1, 2
    MOD 0
    n1 7
    n1 7
    n1 7
    n1 7

.noi_loop_start
    n1 12
    n1 2
    n1 12
    n1 2
    n1 7
    n1 2
    n1 12
    n1 12
    n1 2
    n1 7
    n1 12
    n1 2
    n1 7
    n1 2
    n1 12
    n1 2

    n1 12
    n1 2
    n1 12
    n1 2
    n1 7
    n1 2
    n1 12
    n1 12
    n1 2
    n1 7
    n1 12
    n1 2
    n1 7
    n1 2
    n1 12
    n1 2

    n1 12
    n1 2
    n1 12
    n1 2
    n1 7
    n1 2
    n1 2
    n1 12
    n1 2
    n1 12
    n1 12
    n1 2
    n1 7
    n1 2
    n1 2
    n1 2

    n1 12
    n1 2
    n1 12
    n1 2
    n1 7
    n1 2
    n1 2
    n1 12
    n1 2
    n1 12
    n1 12
    n1 2
    PITCH -2
    ENV 0, 0
    MOD 1
    n3 10
    PITCH0
    ENV 1, 2
    MOD 0
    LOOP 2, .noi_loop_start

    LOOP 0, .noi_miniloop_A
.noi_miniloop_A1
    n2 12
    n1 2
    n1 2
    n2 7
    n2 12
    n1 2
    n1 2
    n2 12
    n2 7
    n1 2
    n1 2
.noi_miniloop_A
    n2 12
    n1 2
    n1 2
    n2 7
    n2 12
    n1 2
    n1 2
    n1 2
    n1 2
    n2 7
    n2 12
    LOOP 1, .noi_miniloop_A1

    n2
    n3 2
    n3 2
    n3 2
    n2 2

    LOOP 0, .noi_miniloop_B
.noi_miniloop_B1
    PITCH -2
    ENV 0, 0
    MOD 1
    n3 10
    PITCH0
    ENV 1, 2
    MOD 0
.noi_miniloop_B
    ENV 1, 1
    n3 7
    ENV 1, 2
    n1 2
    n1 2
    ENV 1, 1
    n2 7
    ENV 1, 2
    n1 2
    n1 2
    n1 12
    n1 2
    n1 7
    n1 2
    n1 12
    n1 2

    n1 2
    n1 2
    n1 12
    n1 2
    n1 7
    n1 2
    n1 12
    n1 2
    n1 2
    n1 2
    n1 12
    n1 2
    LOOP 1, .noi_miniloop_B1
    PITCH -2
    ENV 0, 0
    MOD 1
    n1 10
    n1 10
    n1 10
    n1 10
    PITCH0
    ENV 1, 2
    MOD 0

    LOOP 0, .noi_miniloop_C
.noi_miniloop_C1
    n1 2
    n1 2
    PITCH -2
    ENV 0, 0
    MOD 1
    n1 10
    PITCH0
    ENV 1, 2
    MOD 0
    n1 2
    PITCH -2
    ENV 0, 0
    MOD 1
    n2 10
    n1 10
    n1 10
    PITCH0
    ENV 1, 2
    MOD 0
.noi_miniloop_C
    ENV 1, 1
    n3 7
    ENV 1, 2
    n1 2
    n1 2
    ENV 1, 1
    n2 7
    ENV 1, 2
    n1 2
    n1 2
    n1 12
    n1 2
    n1 7
    n1 2
    n1 12
    n1 2

    n1 2
    n1 2
    n1 12
    n1 2
    n1 7
    n1 2
    n1 12
    n1 2
    LOOP 1, .noi_miniloop_C1
    PITCH -2
    ENV 0, 0
    MOD 1
    n1 10
    n1 10
    n2 10
    n3 10
    PITCH0
    ENV 1, 2
    MOD 0

    LOOP 0, .noi_miniloop_D
.noi_miniloop_D1
    n1 12
    n1 2
    PITCH -2
    ENV 0, 0
    MOD 1
    n3 10
    PITCH0
    ENV 1, 2
    MOD 0
.noi_miniloop_D
    ENV 1, 1
    n3 7
    ENV 1, 2
    n1 2
    n1 2
    ENV 1, 1
    n2 7
    ENV 1, 2
    n1 2
    n1 7
    n1 12
    n1 2
    n1 7
    n1 2
    n1 12
    n1 2

    n1 12
    n1 2
    n1 12
    n1 2
    n1 7
    n1 2
    n1 12
    n1 12
    n1 2
    n1 7
    LOOP 1, .noi_miniloop_D1
    PITCH -2
    ENV 0, 0
    MOD 1
    n1 10
    n1 10
    n2 10
    n2 10

    n4 10
    n4 10

    n4 10
    n2 10
    n2 10
    n2 10
    n2 10

.noi_miniloop_E
    n3 10
    n3 10
    LOOP 2, .noi_miniloop_E

    PITCH0
    ENV 1, 2
    MOD 0
    n2 7
    n2 2
    n2 7
    n2 2

    LOOP 0, .noi_miniloop_F
.noi_miniloop_F1
    n2 10
    n2 10
    n2 10
    n3 10
    n2 10
    n2 10
    n2 10
    PITCH0
    ENV 1, 2
    MOD 0
.noi_miniloop_F
    n1 12
    n1 2
    n1 12
    n1 2
    n1 7
    n1 2
    n1 12
    n1 12
    n1 2
    n1 7
    n1 12
    n1 2
    n1 7
    n1 2
    n1 12
    n1 2

    n1 12
    n1 2
    n1 12
    n1 2
    n1 7
    n1 2
    n1 12
    n1 12
    n1 2
    n1 7
    n1 12
    n1 2
    n1 7
    n1 2
    n1 12
    n1 2

    n2 12
    PITCH -2
    ENV 0, 0
    MOD 1
    n2 10
    n2 10
    n3 10
    n2 10
    n2 10
    n2 10

    LOOP 3, .noi_miniloop_F1
    PITCH0
    ENV 1, 2
    MOD 0
    n2 2
    n2 1
    n2 2
    n2 1
    n1 10
    n1 10
    n1 10
    n1 10
    n1 10
    n1 10
    n1 10
    n1 10
    LOOP 0, .noi_loop_start
