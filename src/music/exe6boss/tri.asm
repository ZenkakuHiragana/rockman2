
.tri_block1
	n3 6 + 12
	n3 7 + 12
	n3 6 + 12
	n2 6 + 12
	DOT n3 6 + 12
	n3 6 + 12
	n3 7 + 12
	n3 4 + 12
.tri_block1a
	n2 6 + 12
	n3 7 + 12
	n2 7 + 12
	n3 6 + 12
	n2 6 + 12
	DOT n3 6 + 12
	n3 6 + 12
	RETURN
.tri_block2
	VOLRAW 36 * 2
	DOT n4 2 + 12
	VOLRAW 36
	n2 2 + 12
	n2 2 + 12
	DOT n3 2 + 12 + 12
	DOT n3 9 + 12
	n3 6 + 12
	RETURN
.tri_start
	KEY O3
	VOLRAW 36
	n3 6 + 12
	TIE
	n3 6
	VOLRAW 6
	DOT n5
	VOLRAW -1
	DOT n4 2 + 12
	TIE
	n4 1 + 12
	n2 1 + 12
	n2 9 + 12
	n2 11 + 12
	n2 8 + 12
	n2 4 + 12
	n2
	n3 6 + 12
	DOT n3 6
	n2 6 + 12
	VOLRAW 36
	TIE
	n3 6
	VOLRAW 3
	n5
	VOLRAW 36
	DOT n3 12 + 12
	DOT n3 12 + 12
	n3 11 + 12
	DOT n3 9 + 12
	DOT n3 6 + 12
	n3 4 + 12
	LOOP 0, .tri_loop

.triA2
	CALL .tri_block1
	n3 4 + 12
	n3 7 + 12
	CALL .tri_block1
	n3 6 + 12
	n3 11
.tri_loop
	CALL .tri_block1
	n3 4 + 12
	n3 7 + 12
	CALL .tri_block1
	n3 9 + 12
	n3 11 + 12
	LOOP 1, .triA2

.triB1
	n4 2 + 12
	n3 9 + 12
	n2 2 + 12
	DOT n3 2 + 12 + 12
	n3 2 + 12
	n3 2 + 12 + 12
	n3 2 + 12
	KEY O3 + 2
	LOOP 1, .triB1

.triB2
	n4 4 + 12
	n3 11
	n2 4
	DOT n3 4 + 12
	n3 4 + 12
	n3 4 + 12 + 12
	n3 4 + 12
	KEY O3
	LOOP 1, .triB2

.triB3
	n4 3 + 12
	n3 3 + 12
	n2 3 + 12
	DOT n3 3 + 12 + 12
	n3 3 + 12
	n2 3 + 12 + 12
	n2 10 + 12
	n3 3 + 12
	KEY O3 - 1
	LOOP 1, .triB3
	
	KEY O3
	n4 3 + 12
	n3 3 + 12
	n2 3 + 12
	DOT n3 3 + 12 + 12
	n3 3 + 12
	n2 3 + 12 + 12
	n2 10 + 12
	n3 8 + 12
	
	n4 1 + 12
	n3 1 + 12
	n2 1 + 12
	n2 1 + 12 + 12
	DOT n3 1 + 12 + 12
	DOT n3 11 + 12
	n3 5 + 12

	CALL .tri_block2
	KEY O3 + 2
	CALL .tri_block2
	KEY O3
	CALL .tri_block2
	TIE
	n4 4 + 12
	VOLRAW 3
	DOT n5
	VOLRAW 36

	n3 6 + 12
	n3 7 + 12
	n3 6 + 12
	n2 4 + 12
	n4 6 + 12
	n2
	n3 7 + 12
	n3 4 + 12
	CALL .tri_block1a
	n3 4 + 12
	n3 7 + 12
	CALL .tri_block1
	n3 9 + 12
	n3 11 + 12

	n3 6 + 12
	n3 7 + 12
	n3 6 + 12
	n2 4 + 12
	VOLRAW 36 + 36 + 18
	TIE
	n3 6 + 12
	PITCH 80
	DOT n3 6 + 12
	PITCH 0
	VOLRAW 36
	n3 7 + 12
	n3 4 + 12
	CALL .tri_block1a
	n3 4 + 12
	n3 7 + 12
	CALL .tri_block1
	n3 9 + 12
	n3 11 + 12
	LOOP 0, .tri_loop
