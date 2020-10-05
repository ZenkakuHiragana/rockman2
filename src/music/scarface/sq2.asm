.sq2_intro_s
    VOL 15
    ENV 13,1
    TONE 2
    n2 8 + 12
    n2 1 + 12 + 12
    TIE
    n5 8 + 12
    PITCH 1
    DOT n5 8 + 12
    PITCH 0
    TONE 1
    VOL 10
.sq2_intro_s1
	n3
	n3 11 - 5
	n3
	TIE
	n3 11 - 5
	PITCH 1
	n4 11 - 5
	PITCH 0

	n3 8 - 5
	n3 8 - 5
	n3
	n3 8 - 5
	n3
	DOT n4 8 - 5
    TIE
	DOT n5 9 - 5
    n3 9 - 5
    RETURN
.sq2A1_s
    n1 1 + 12
    DOT n2
    n1 1 + 12
    DOT n2
    n4 1 + 12
    LOOP2 1, .sq2A1_s
    RETURN
.sq2A2_s
    n1 1 + 12
    DOT n2
    n3 1 + 12
    n1 1 + 12
    DOT n2
    n1 1 + 12
    DOT n2
    n3 1 + 12
    n3 1 + 12
    n1 1 + 12
    DOT n2
    n1 1 + 12
    DOT n2
    RETURN
.sq2_start
    TONE 1
    VOL 10
    KEY O4
    ENV 10,1
	n3 1 + 12 - 5
	n3 1 + 12 - 5
	n3
	n3 1 + 12 - 5
	n3
	DOT n4 1 + 12 - 5

	n3 11 - 5
	n3 11 - 5
    CALL .sq2_intro_s1
    CALL .sq2_intro_s
    CALL .sq2_intro_s
.sq2A1
    n3
    TONE 0
    VOL 15
    KEY O2
    CALL .sq2A1_s
    CALL .sq2A2_s
    KEY O2 - 2
    CALL .sq2A1_s
    CALL .sq2A1_s
    KEY O2 - 2 - 2
    CALL .sq2A1_s
    n1 1 + 12
    DOT n2
    n1 1 + 12
    DOT n2
    n4 1 + 12
    n1 1 + 12
    DOT n2
    n1 1 + 12
    DOT n2
    n3 1 + 12
    KEY O4
    CALL .sq2_intro_s
    LOOP 1, .sq2A1
    TONE 0
    KEY O2
    n3

    END
