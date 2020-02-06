
    TONE 2
    VOL 9
    KEY O4 - 1
    ENV 1, 3, 1
    n3
    n2 5
    n2
    n2 5
    n2
    n3
    n2 5
    n2
    n2 5
    n2
    ENV 8, 1
    n4 5
    n4 5
    n4 5

    ENV 1, 3, 1
    n3
    n2 2
    n2
    n2 2
    n2
    n3
    n2 2
    n2
    n2 2
    n2
    ENV 8, 1
    n4 4
    n4 4
    n4 4

    ENV 1, 3, 1
    n3
    n2 5
    n2
    n2 5
    n2
    n3
    n2 5
    n2
    n2 5
    n2
    ENV 8, 1
    n4 5
    n4 5
    n4 5

    ENV 1, 3, 1
    n3
    n2 2
    n2
    n2 2
    n2
    n3
    n2 2
    n2
    n2 2
    n2
    ENV 8, 1
    n4 2
    n4 2
    n4 1

.sq2_loop_start
    KEY O4
    ENV 1, 4, 1
    n3
    n2 8
    n2
    n2 8
    n2
    n3
    n2 8
    n2
    n2 8
    n2
    ENV 8, 1
    n4 8
    n4 8
    n4 8

    ENV 1, 4, 1
    n3
    n2 6
    n2
    n2 6
    n2
    n3
    n2 6
    n2
    n2 6
    n2
    ENV 8, 1
    n4 6
    n4 6
    n4 6

    ENV 1, 4, 1
    n3
    n2 8
    n2
    n2 8
    n2
    n3
    n2 8
    n2
    n2 8
    n2
    ENV 8, 1
    n4 8
    n4 8
    n4 8

    ENV 1, 4, 1
    n3
    n2 7
    n2
    n2 7
    n2
    n3
    n2 7
    n2
    n2 7
    n2
    ENV 8, 1
    n4 6
    n4 6
    n4 6
    LOOP 1, .sq2_loop_start

    LOOP 0, .sq2B
.sq2B1
    n4 7
.sq2B
    ENV 1, 4, 1
    n3
    n2 8
    n2
    n2 8
    n2
    n3
    n2 6
    n2
    n2 6
    n2
    ENV 8, 1
    n4 8
    n4 8
    n4 8

    ENV 1, 4, 1
    n3
    n2 6
    n2
    n2 6
    n2
    n3
    n2 4
    n2
    n2 4
    n2
    ENV 8, 1
    n4 6
    n4 6
    LOOP 1, .sq2B1
    n4 6

    LOOP 0, .sq2C
.sq2C1
    n2 6
    n2
    n2 6
    n2
    ENV 8, 1
    n4 4
    n4 4
    n4 3
.sq2C
    ENV 1, 4, 1
    n3
    n2 6
    n2
    n2 6
    n2
    n3
    LOOP 1, .sq2C1

    n2 4
    n2
    n2 4
    n2
    ENV 8, 1
    n4 8
    n4 8
    n4 6

    ENV 1, 4, 1
    n3
    n2 8
    n2
    n2 8
    n2
    n3
    n2 6
    n2
    n2 6
    n2
    ENV 8, 1
    n4 6
    n4 6
    n4 4

    ENV 1, 4, 1
    n3
    n2 7
    n2
    n2 7
    n2
    n3
    n2 7
    n2
    n2 7
    n2
    ENV 8, 1
    n4 6
    n4 6
    n4 6

    KEY O3 + 2
    n3 11 + 12 - 2
    n2 8 + 12 + 12 - 2
    n2
    n2 8 + 12 + 12 - 2
    n2

    n3 4 - 2
    n2 4 + 12 + 12 - 2
    n2
    n2 4 + 12 + 12 - 2
    n2

    n3 9 - 2
    n2 4 + 12 + 12 - 2
    n2
    n2 4 + 12 + 12 - 2
    n2

    n3 4 - 2
    n2 4 + 12 + 12 - 2
    n2
    n2 4 + 12 + 12 - 2
    n2

    n4 3 + 12 + 12 - 2
    n4 11 + 12 - 2
    n4 11 + 12 - 2
    DOT n5 11 + 12 - 2
    LOOP 0, .sq2_loop_start
