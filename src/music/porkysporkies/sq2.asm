.sq2_loop
    TONE 1
    VOL 9
    KEY O4
    ENV 0, 0
    
    n1 4
    n1 1
    KEY O4 + 1
    n1 8 + 12 + 12 - 1
    n1 6 + 12 + 12 - 1
    n1 3 + 12 + 12 - 1
    n1 12 + 12 - 1
    n1 9 + 12 - 1
    n1 6 + 12 - 1
    n1 3 + 12 - 1
    n1 12 - 1
    n1 12 + 12 - 1
    n1 9 + 12 - 1
    n1 6 + 12 - 1
    n1 3 + 12 - 1
    n1 12 - 1
    n1 9 - 1
    n1 6 - 1
    n1 3 - 1
    n1 6 + 12 - 1
    n1 3 + 12 - 1
    n1 12 - 1
    n1 9 - 1
    n1 6 - 1
    n1 3 - 1
    KEY O2 + 5
    n1 12 + 12 - 5
    n1 9 + 12 - 5
    n1 12 + 12 + 12 - 5
    n1 9 + 12 + 12 - 5
    n1 6 + 12 + 12 - 5
    n1 3 + 12 + 12 - 5
    n1 12 + 12 - 5
    n1 9 + 12 - 5
    n1 6 + 12 - 5
    n1 3 + 12 - 5
    n1 6 + 12 + 12 - 5
    n1 3 + 12 + 12 - 5
    n1 12 + 12 - 5
    n1 9 + 12 - 5
    n1 6 + 12 - 5
    n1 3 + 12 - 5
    n1 12 - 5
    n1 9 - 5
    n1 12 + 12 - 5
    n1 9 + 12 - 5
    n1 6 + 12 - 5
    n1 3 + 12 - 5
    n1 12 - 5
    n1 9 - 5

.sq2A1
    n2 4 + 12 - 5
    n2 8 + 12 - 5
    LOOP 7, .sq2A1
.sq2A2
    n2 12 + 12 - 5
    n2 9 + 12 - 5
    LOOP 7, .sq2A2
.sq2A3
    n2 1 + 12 + 12 - 5
    n2 4 + 12 + 12 - 5
    LOOP 7, .sq2A3

    KEY O4
    n2 3
    n2 6
    n2 9
    n2 12
    n2 3 + 12
    n2 6 + 12
    n2 9 + 12
    n2 12 + 12
    n2 3 + 12 + 12
    n2 12 + 12
    n2 9 + 12
    n2 6 + 12
    n2 3 + 12
    n2 12
    n2 9
    n2 6

    TONE 0
    SHORT n3
    TIE
    n3 1
    VOL 3
    n3 1
    VOL 9
    TIE
    n3 3
    VOL 3
    n3 3
    VOL 9
    TIE
    n4 4
    VOL 5
    DOT n3 4
    
    VOL 9
    n2 1
    TIE
    n3 4
    VOL 3
    n3 4
    VOL 9
    TIE
    n3 6
    VOL 3
    n3 6
    VOL 9
    TIE 4
    n2 8
    MOD MOD_4d2t1f
    n3 8
    MOD 0
    n2 8
    VOL 5
    SHORT n2 8
    n3 8
    VOL 9

    KEY O2
    n3 4
    KEY O4 - 1
    MOD MOD_4d2t1f
    n4 4 + 1
    MOD 0
    n2 4 + 1
    n2 6 + 1
    n2 8 + 1
    n2
    n2 9 + 1
    n2
    n2 11 + 1
    n2
    n2 4 + 1
    n2
    
    TONE 2
.sq2B1
    n2 1 + 1
    n2 7 + 1
    LOOP 7, .sq2B1
.sq2B2
    n2 1
    n2 6 + 1
    LOOP 7, .sq2B2
.sq2B3
    n2 1 + 1
    n2 4 + 1
    LOOP 15, .sq2B3
.sq2B4
    n2 1 + 1
    n2 7 + 1
    LOOP 7, .sq2B4
.sq2B5
    n2 1
    n2 6 + 1
    LOOP 7, .sq2B5
.sq2B6
    n2 1 + 1
    n2 4 + 1
    LOOP 7, .sq2B6

    KEY O2 + 3
    n2 4 + 12 + 12 - 3
    n2 4 - 3
    n2 8 - 3
    n2 1 + 12 - 3
    n2 4 + 12 - 3
    n2 1 + 12 - 3
    n2 4 + 12 - 3
    n2 8 + 12 - 3
    n2 1 + 12 + 12 - 3
    n2 8 + 12 - 3
    n2 1 + 12 + 12 - 3
    n2 4 + 12 + 12 - 3
    n2 8 + 12 + 12 - 3
    n2 4 + 12 + 12 - 3
    n2 8 + 12 + 12 - 3
    KEY O4
    n2 1 + 12

    TEMPO BPM(130)
    TIE
    n2 4 + 12
    VOL 3
    DOT n3 4 + 12
    VOL 9
    n4 4
    n4 4 + 12
    n4 1 + 12
    TEMPO BPM(144)

    TONE 0
    ENV 1, 1
.sq2C1
    n2 6 + 12
    n2 1 + 12
    n2 9
    n2 6
    LOOP 3, .sq2C1
.sq2C2
    n2 6 + 12
    n2 3 + 12
    n2 9
    n2 6
    LOOP 3, .sq2C2
.sq2C3
    n2 8 + 12
    n2 4 + 12
    n2 11
    n2 8
    LOOP 3, .sq2C3
.sq2C4
    n2 8 + 12
    n2 5 + 12
    n2 11
    n2 8
    LOOP 3, .sq2C4
.sq2C5
    n2 6 + 12
    n2 1 + 12
    n2 9
    n2 6
    LOOP 3, .sq2C5
.sq2C6
    n2 7 + 12
    n2 1 + 12
    n2 10
    n2 7
    LOOP 3, .sq2C6
.sq2C7
    n2 6 + 12
    n2 12
    n2 8
    n2 6
    LOOP 3, .sq2C7

    n3
    ENV 0, 0
    MOD MOD_4d2t1f
    n4 4
    MOD 0
    n2 4
    n2 6
    n2 8
    n2
    n2 9
    n2
    n2 11
    n2
    n2 4
    n5

    n2 4
    TIE
    n3 8
    VOL 3
    n3 8
    VOL 9
    TIE
    n3 9
    VOL 3
    n3 9
    VOL 9
    TIE
    DOT n3 11
    VOL 5
    n4 11
    VOL 9

    n2 8
    TIE
    n3 1 + 12
    VOL 3
    n3 1 + 12
    VOL 9
    TIE
    n3 3 + 12
    VOL 3
    n3 3 + 12
    VOL 9
    MOD MOD_4d2t1f
    TIE 2
    DOT n3 4 + 12
    VOL 3
    n2 4 + 12
    DOT n5 4 + 12
    MOD 0
    LOOP 0, .sq2_loop
