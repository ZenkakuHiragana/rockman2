
    VOL 15
    ENV 2, 3
.intro
    n3 2
    n2 2
    n2 2
    n3 2
    n2 2
    n2 2
    LOOP 3, .intro

    n3 12
    n2 2
    n2 2
    n3 2
    n3 12
    n3 7
    n2 2
    n2 2
    n3 12
    n2 2
    n2 2

    PITCH -2
    ENV 0, 0
    MOD 4
    n4 10
    n4 10
    n4 10
    PITCH0
    ENV 1, 2
    MOD 0
    n2 7
    n2 7
    n2 7
    n2 7

.noi_loop_start
    n2 12
    n2 2
    n2 12
    n2 2
    n2 7
    n2 2
    n2 12
    n2 12
    n2 2
    n2 7
    n2 12
    n2 2
    n2 7
    n2 2
    n2 12
    n2 2

    n2 12
    n2 2
    n2 12
    n2 2
    n2 7
    n2 2
    n2 12
    n2 12
    n2 2
    n2 7
    n2 12
    n2 2
    n2 7
    n2 2
    n2 12
    n2 2

    n2 12
    n2 2
    n2 12
    n2 2
    n2 7
    n2 2
    n2 2
    n2 12
    n2 2
    n2 12
    n2 12
    n2 2
    n2 7
    n2 2
    n2 2
    n2 2

    n2 12
    n2 2
    n2 12
    n2 2
    n2 7
    n2 2
    n2 2
    n2 12
    n2 2
    n2 12
    n2 12
    n2 2
    PITCH -2
    ENV 0, 0
    MOD 4
    n4 10
    PITCH0
    ENV 1, 2
    MOD 0
    LOOP 2, .noi_loop_start

    LOOP 0, .noi_miniloop_A
.noi_miniloop_A1
    n3 12
    n2 2
    n2 2
    n3 7
    n3 12
    n2 2
    n2 2
    n3 12
    n3 7
    n2 2
    n2 2
.noi_miniloop_A
    n3 12
    n2 2
    n2 2
    n3 7
    n3 12
    n2 2
    n2 2
    n2 2
    n2 2
    n3 7
    n3 12
    LOOP 1, .noi_miniloop_A1

    n3
    n4 2
    n4 2
    n4 2
    n3 2

    LOOP 0, .noi_miniloop_B
.noi_miniloop_B1
    PITCH -2
    ENV 0, 0
    MOD 4
    n4 10
    PITCH0
    ENV 1, 2
    MOD 0
.noi_miniloop_B
    ENV 1, 1
    n4 7
    ENV 1, 2
    n2 2
    n2 2
    ENV 1, 1
    n3 7
    ENV 1, 2
    n2 2
    n2 2
    n2 12
    n2 2
    n2 7
    n2 2
    n2 12
    n2 2

    n2 2
    n2 2
    n2 12
    n2 2
    n2 7
    n2 2
    n2 12
    n2 2
    n2 2
    n2 2
    n2 12
    n2 2
    LOOP 1, .noi_miniloop_B1
    PITCH -2
    ENV 0, 0
    MOD 4
    n2 10
    n2 10
    n2 10
    n2 10
    PITCH0
    ENV 1, 2
    MOD 0

    LOOP 0, .noi_miniloop_C
.noi_miniloop_C1
    n2 2
    n2 2
    PITCH -2
    ENV 0, 0
    MOD 4
    n2 10
    PITCH0
    ENV 1, 2
    MOD 0
    n2 2
    PITCH -2
    ENV 0, 0
    MOD 4
    n3 10
    n2 10
    n2 10
    PITCH0
    ENV 1, 2
    MOD 0
.noi_miniloop_C
    ENV 1, 1
    n4 7
    ENV 1, 2
    n2 2
    n2 2
    ENV 1, 1
    n3 7
    ENV 1, 2
    n2 2
    n2 2
    n2 12
    n2 2
    n2 7
    n2 2
    n2 12
    n2 2

    n2 2
    n2 2
    n2 12
    n2 2
    n2 7
    n2 2
    n2 12
    n2 2
    LOOP 1, .noi_miniloop_C1
    PITCH -2
    ENV 0, 0
    MOD 4
    n2 10
    n2 10
    n3 10
    n4 10
    PITCH0
    ENV 1, 2
    MOD 0

    LOOP 0, .noi_miniloop_D
.noi_miniloop_D1
    n2 12
    n2 2
    PITCH -2
    ENV 0, 0
    MOD 4
    n4 10
    PITCH0
    ENV 1, 2
    MOD 0
.noi_miniloop_D
    ENV 1, 1
    n4 7
    ENV 1, 2
    n2 2
    n2 2
    ENV 1, 1
    n3 7
    ENV 1, 2
    n2 2
    n2 7
    n2 12
    n2 2
    n2 7
    n2 2
    n2 12
    n2 2

    n2 12
    n2 2
    n2 12
    n2 2
    n2 7
    n2 2
    n2 12
    n2 12
    n2 2
    n2 7
    LOOP 1, .noi_miniloop_D1
    PITCH -2
    ENV 0, 0
    MOD 4
    n2 10
    n2 10
    n3 10
    n3 10

    n5 10
    n5 10

    n5 10
    n3 10
    n3 10
    n3 10
    n3 10

.noi_miniloop_E
    n4 10
    n4 10
    LOOP 2, .noi_miniloop_E

    PITCH0
    ENV 1, 2
    MOD 0
    n3 7
    n3 2
    n3 7
    n3 2

    LOOP 0, .noi_miniloop_F
.noi_miniloop_F1
    n3 10
    n3 10
    n3 10
    n4 10
    n3 10
    n3 10
    n3 10
    PITCH0
    ENV 1, 2
    MOD 0
.noi_miniloop_F
    n2 12
    n2 2
    n2 12
    n2 2
    n2 7
    n2 2
    n2 12
    n2 12
    n2 2
    n2 7
    n2 12
    n2 2
    n2 7
    n2 2
    n2 12
    n2 2

    n2 12
    n2 2
    n2 12
    n2 2
    n2 7
    n2 2
    n2 12
    n2 12
    n2 2
    n2 7
    n2 12
    n2 2
    n2 7
    n2 2
    n2 12
    n2 2

    n3 12
    PITCH -2
    ENV 0, 0
    MOD 4
    n3 10
    n3 10
    n4 10
    n3 10
    n3 10
    n3 10

    LOOP 3, .noi_miniloop_F1
    PITCH0
    ENV 1, 2
    MOD 0
    n3 2
    n3 1
    n3 2
    n3 1
    n2 10
    n2 10
    n2 10
    n2 10
    n2 10
    n2 10
    n2 10
    n2 10
    LOOP 0, .noi_loop_start
