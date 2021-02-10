.tri_part1_s
    VOLRAW 96
    KEY O4
    n6 8
    n6 8
    n6 6
    n5 3
    n4 8
    n4 12
.tri_part1_s1
    n4 8
    LOOP 7, .tri_part1_s1
    RETURN

.tri_part2_s
    KEY O3
    DOT n3 6
    TIE
    n2 1 + 12
    n4 1 + 12
    DOT n3 6
    TIE
    n2 1 + 12
    n4 1 + 12
    DOT n3 1 + 12
    TIE
    n2 8 + 12
    n4 8 + 12
    DOT n3 1 + 12
    TIE
    n2 4 + 12
    n4 4 + 12
    DOT n3 2 + 12
    TIE
    n2 6 + 12
    n4 6 + 12
    DOT n3 4
    TIE
    n2 2 + 12
    n4 2 + 12
    DOT n3 6
    TIE
    n2 1 + 12
    n4 1 + 12
    DOT n3 1
    TIE
    n2 1 + 12
    n4 1 + 12

    DOT n3 6
    TIE
    n2 1 + 12
    n4 1 + 12
    DOT n3 6
    TIE
    n2 1 + 12
    n4 1 + 12
    DOT n3 1 + 12
    TIE
    n2 8 + 12
    n4 8 + 12
    DOT n3 1 + 12
    TIE
    n2 8 + 12
    n4 8 + 12

    DOT n3 11
    TIE
    n2 6 + 12
    n4 6 + 12
    DOT n3 4
    TIE
    n2 4 + 12
    n4 4 + 12
    DOT n3 6
    DOT n3 6 + 12
    n3 6 + 12
    n2 6 + 12
    n3 1 + 12
    RETURN

.tri_part3_s1
    VOLRAW -1
    DOT n3 2
    n4 9
    n2
    DOT n3 4
    n4 11
    n2
    DOT n3 1
    n3 1
    n3 8 + 12
    n2
    DOT n3 6
    n3 1 + 12
    n2 8 + 12
    n2 9 + 12
    n2 8 + 12
    RETURN

.tri_part3_s2
    DOT n3 2
    n4 9
    n2
    DOT n3 4
    n3 11 + 12
    n2
    n3 1 + 12 + 12
    DOT n3 6
    n3 6 + 12
    DOT n3
    n3 1
    DOT n3 8
    n2 8
    n2 4
    n2
    RETURN

.tri_part3_s3
    n3 7
    n2 7 + 12
    n2 11 + 12
    n2
    n3 1 + 12 + 12
    n3 2 + 12 + 12
    n2
    n2 2 + 12 + 12
    n2 1 + 12 + 12
    n2 11 + 12
    n3 4 + 12
    DOT n3 6
    n3 11 + 12
    n2
    n3 8 + 12
    RETURN

.tri_start
    n1
.tri_loop
    CALL .tri_part1_s

    n4 6
    DOT n3
    n2 9
    n4 5 + 12
    n4 1
    n5 6
    TIE
    n5 6
    n3 6
    n3 1

.tri_part2
    CALL .tri_part2_s
    DOT n3 6 + 12
    n3 4 + 12

    LOOP 0, .tri_part3
.tri_part3_1
    CALL .tri_part3_s2
.tri_part3
    CALL .tri_part3_s1
    LOOP 1, .tri_part3_1
    CALL .tri_part3_s3
    n3 6
    n3 10 + 12
    DOT n3
    n3 1 + 12 + 12
    n4

.tri_part4
    CALL .tri_part1_s
    n4 7
    n4 7
    n4 7
    n4 7
    VOLRAW 72
    n4 8
    n4 8
    n4 3
    n4 3
    KEY O4 - 3
    n4 -2 + 3
    n4 -2 + 3
    n4 5 + 3
    n4 5 + 3
    n4 3
    n4 3
    n4 3 + 3
    n4 3 + 3
    n4 6 + 3
    n4 6 + 3
    n4 6 + 3
    n4 6 + 3
    n4 1 + 3
    VOLRAW -1
    n6 1 + 3
    n6

.tri_part5
    VOLRAW 96
    CALL .tri_part2_s
    n4 6 + 12
    DOT n3 4 + 12

.tri_part6
    n6
    n6
    n6
    n5
    DOT n3
    VOLRAW -1
    TIE
    DOT n4 1
    n2 1

.tri_part7
    CALL .tri_part3_s1
    CALL .tri_part3_s3
    n2 6
    n2 1 + 12
    n2 10 + 12
    DOT n3 11 + 12
    DOT n3
    CALL .tri_part3_s1
    CALL .tri_part3_s2
    CALL .tri_part3_s1
    CALL .tri_part3_s3
    n2 6
    n2 1 + 12
    n2 10 + 12
    DOT n3 11 + 12
    DOT n3
    n6
    n6
    LOOP 0, .tri_start