
    TONE 1
    VOL 15
    KEY O3 + 9
    ENV 4, 1
.sq2_A
    n2 6 + 12 + 12
    n2 4 + 12 + 12
    n2 1 + 12 + 12
    n2 0 + 12 + 12
    VOLDOWN
    VOLDOWN
    LOOP 7, .sq2_A
    VOL 15
.sq2_A1
    n2 6 + 12 + 12
    n2 4 + 12 + 12
    n2 1 + 12 + 12
    n2 0 + 12 + 12
    VOLDOWN
    VOLDOWN
    LOOP 3, .sq2_A1

    TONE 0
    VOL 15
    KEY O3
    n3 3
    n2 6
    n2 3
    n3 3 + 12
    n3 3
    n2 3
    n2 5
    n2 6
    n2 5
    n2 6
    n2 8
    n2 10
    n2 3 + 12

.sq2_loop_start
    TONE 0
    KEY O3
    VOL 12
    ENV 4, 1
    BENDSPEED 4
    BEND n4 3 + 12, n4 1 + 12
    DOT n3 1 + 12
    n2 3 + 12
    n2
    n2 3 + 12
    n3 1 + 12
    n2 3 + 12
    n2 1 + 12
    n2 10
    n2 1 + 12

    SLUR n4 3 + 12
    DOT n3 1 + 12
    n2 3 + 12
    n2
    n2 3 + 12
    n2 6 + 12
    n2 10
    n2 5 + 12
    n2 10
    n2 3 + 12
    n2 1 + 12

    n3 10
    n3 3
    n3 6
    n2 3
    DOT n3 8
    n3 6
    n3 1
    n3 2

    BENDSPEED 1
    BEND n3 10 + 12, n3 9 + 12
    n4 3 + 12
    BEND n4 6 + 12, n4 5 + 12
    n3 8 + 12
    n3 6 + 12
    n3 5 + 12

    BENDSPEED 4
    BEND n4 3 + 12, n4 1 + 12
    DOT n3 1 + 12
    n2 3 + 12
    n2
    n2 3 + 12
    n3 1 + 12
    n2 3 + 12
    n2 1 + 12
    n2 10
    n2 1 + 12

    BEND n4 6 + 12, n4 5 + 12
    DOT n3 5 + 12
    ENV 6, 8
    n3 6 + 12
    n3 8 + 12
    n3 10 + 12
    n3 1 + 12 + 12
    ENV 4, 1
    n2 10 + 12

    BENDSPEED 0
    BEND n4 3 + 12 + 12, n4 2 + 12 + 12
    DOT n3 1 + 12 + 12
    n2 3 + 12 + 12
    n2
    n2 3 + 12 + 12
    n2 6 + 12 + 12
    n2 10 + 12
    n2 5 + 12 + 12
    n2 10 + 12
    n2 3 + 12 + 12
    n2 1 + 12 + 12

    BEND n4 3 + 12 + 12, n4 2 + 12 + 12
    BEND n3 5 + 12 + 12, n3 4 + 12 + 12
    n2 1 + 12 + 12
    DOT n3 3 + 12 + 12
    n3 6 + 12 + 12
    BEND n3 5 + 12 + 12, n3 4 + 12 + 12
    n3 4 + 12 + 12

    TONE 2
    VOL 15
    ENV 9, 1
    BENDSPEED 9
    BEND n3 3 + 12, n3 1 + 12
    n3 10
    BEND n3 10 + 12, n3 6 + 12
    TIE
    n5 9 + 12
    n3 9 + 12

    BEND n3 6 + 12, n3 4 + 12
    n3 3 + 12
    BEND n3 1 + 12 + 12, n3 6 + 12
    n5 12 + 12
    n3 1 + 12 + 12

    n3 3 + 12 + 12
    ENV 12, 9
.sq2_vol_fade1
    n4 10 + 12
    VOLDOWN
    VOLDOWN
    VOLDOWN
    LOOP 2, .sq2_vol_fade1

    KEY O5
.sq2_vol_fade2
    n4 3 + 12
    VOLDOWN
    VOLDOWN
    LOOP 2, .sq2_vol_fade2

    n3 3 + 12
    PITCH -2
    KEY O3
    VOL 15
    ENV 0, 0
    n4 10

    TONE 0
    PITCH0
    ENV 9, 1
    DOT n4 6 + 12
    n2 5 + 12
    n2 6 + 12
    DOT n4 10 + 12
    n3

    DOT n4 1 + 12 + 12
    n2 1 + 12 + 12
    n2 3 + 12 + 12
    BENDSPEED 3
    SLUR n3 6 + 12 + 12
    n3 5 + 12 + 12
    n3 3 + 12 + 12
    n4 1 + 12 + 12

    n2 1 + 12 + 12
    n2 1 + 12 + 12
    n3 1 + 12 + 12
    n2 1 + 12 + 12
    n2 1 + 12 + 12
    n3 1 + 12 + 12
    n3 3 + 12 + 12
    n3 1 + 12 + 12
    n3 10 + 12

    VOL 12
    TIE
    PITCH -9
    n2 2
    PITCH0
    n3 3
    n2
    n2 3
    n2
    n2 1
    n2 3
    n2 3
    n2 3
    n2 3 + 12
    n2 3
    n2 10
    n2 3
    n2 6
    n2 3

    LOOP 0, .sq2_B
.sq2_B1
    PITCH -2
    n4 10
    PITCH0
    TONE 0
    VOL 12
    ENV 9, 1
.sq2_B
    n3 10
    n2 3 + 12
    n2 3
    n3 3 + 12
    n3 1 + 12
    n2 9
    n2 3
    n2 3 + 12
    n2 3
    n2 1 + 12
    n2 3
    n2 10
    n2 3

    n2 9
    n2 3
    n2 3 + 12
    n2 3
    n2 1 + 12
    n2 3
    n2 10
    n2 3
    n2 9
    n2 10
    n2 3
    n2 10

    TONE 2
    VOL 15
    ENV 0, 0
    LOOP 1, .sq2_B1
    PITCH -9
    n2 10
    n2 10
    n2 10
    n2 10
    PITCH0
    ENV 9, 1

    LOOP 0, .sq2_C
.sq2_C1
    n2 9
    n2 10
    PITCH -9
    TONE 2
    VOL 15
    ENV 0, 0
    n2 10
    PITCH0
    TONE 0
    VOL 12
    ENV 9, 1
    n2 10
    PITCH -4
    TONE 2
    VOL 15
    ENV 0, 0
    n3 10
    PITCH -9
    n2 10
    n2 10
    PITCH0
    ENV 9, 1
.sq2_C
    TONE 1
    n3 10
    TONE 0
    VOL 12
    n2 3 + 12
    n2 3
    TONE 1
    VOL 15
    n3 3 + 12
    n3 1 + 12
    TONE 0
    VOL 12
    n2 9
    n2 3
    n2 3 + 12
    n2 3
    n2 1 + 12
    n2 3
    n2 10
    n2 3

    n2 9
    n2 3
    n2 3 + 12
    n2 3
    n2 1 + 12
    n2 3
    n2 10
    n2 3
    LOOP 1, .sq2_C1
    PITCH -9
    TONE 2
    VOL 15
    ENV 0, 0
    n2 10
    n2 10
    PITCH -4
    n3 10
    PITCH -2
    n4 10

    LOOP 0, .sq2_D
.sq2_D1
    n2 3
    n2 10
    PITCH -2
    TONE 2
    VOL 15
    ENV 0, 0
    n4 10
.sq2_D
    PITCH0
    TONE 1
    ENV 9, 1
    n3 10 + 12
    TONE 0
    VOL 12
    n2 3 + 12
    n2 3
    TONE 1
    VOL 15
    n3 3 + 12 + 12
    n3 1 + 12 + 12
    TONE 0
    VOL 12
    n2 9
    n2 3
    n2 3 + 12
    n2 3
    n2 1 + 12
    n2 3
    n2 10
    n2 3

    n2 9
    n2 3
    n2 3 + 12
    n2 3
    n2 1 + 12
    n2 3
    n2 10
    n2 3
    n2 9
    n2 10
    LOOP 1, .sq2_D1
    PITCH -9
    TONE 2
    VOL 15
    ENV 0, 0
    n2 10
    n2 10
    PITCH -4
    n3 10
    n3 10

    PITCH -2
    n5 10
    n5 10

    n5 10
    PITCH -4
    n3 10
    n3 10
    n3 10
    n3 10

.sq2_E
    PITCH -2
    n4 10
    n4 10
    LOOP 2, .sq2_E

    PITCH0
    TONE 2
    VOL 12
    KEY O4
    ENV 9, 1
    n3
    n2 6 + 12 + 12
    n2 5 + 12 + 12
    n2 3 + 12 + 12
    n2 1 + 12 + 12
    n2 10 + 12
    n2 8 + 12

    LOOP 0, .sq2_F
.sq2_F1
    PITCH -4
    VOL 15
    KEY O3
    ENV 0, 0
    n3 10
    n3 10
    n3 10
    PITCH -2
    n4 10
    PITCH -4
    n3 10
    n3 10
    n3 10
    PITCH0
    KEY O4
    ENV 9, 1
.sq2_F
    VOL 15
    n3 6
    n3
    n3 11
    n3 10
    n3
    n3 11
    n3 1 + 12
    SLUR n4 3 + 12

    n3 1 + 12
    n3 3 + 12
    SLUR n4 5 + 12
    n4 6 + 12
    n3 5 + 12

    ENV 12, 9
    n4 3 + 12 + 12
    VOL 13
    n4 3 + 12 + 12
    VOL 11
    n4 3 + 12 + 12
    VOL 9
    n4 3 + 12 + 12

    TONE 0
    KEY O3
    VOL 12
    ENV 9, 1
    n1 1 + 12
    n1 1
    n1 3 + 12
    n1 3
    n1 3 + 12
    n1 3
    n1 3 + 12
    n1 3

    n1 3 + 12
    n1 3
    n1 3 + 12
    n1 3
    n1 3 + 12
    n1 3
    n1 3 + 12
    n1 3

    n1 5 + 12
    n1 5
    n1 6 + 12
    n1 6
    n1 6 + 12
    n1 6
    n1 6 + 12
    n1 6

    n1 6 + 12
    n1 6
    n1 6 + 12
    n1 6
    n1 6 + 12
    n1 6
    n1 5 + 12
    n1 5

    TONE 2
    VOL 15
    KEY O4
    n3 6
    n3
    n3 11
    n3 10
    n3
    n3 11
    n3 1 + 12
    SLUR n4 3 + 12

    n3 1 + 12
    n3 11
    BEND n4 10, n4 8
    n3 6
    n3 1 + 12
    n3 8

    ENV 12, 9
    n4 3 + 12
    VOL 13
    n4 3 + 12
    VOL 11
    n4 3 + 12
    VOL 9
    n4 3 + 12

    LOOP 1, .sq2_F1

    KEY O2
    ENV 9, 1
    n3 3 + 12
    n3 1 + 12
    n3 3
    n4 9
    n3 8
    n3 1
    n3 2
    LOOP 0, .sq2_loop_start
