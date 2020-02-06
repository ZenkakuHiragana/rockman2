
	KEY O4
.tri_loop_start
	VOLRAW 25
	DOT	n4 1 + 12
	DOT	n4 8
	VOLRAW 50
	n4 6
	n4 6
	n4 6
	VOLRAW 25
	DOT	n4 11
	DOT	n4 6
	VOLRAW 50
	n4 4
	n4 4
	n4 4
	VOLRAW 25
	DOT	n4 9
	DOT	n4 4
	VOLRAW 50
	n4 6
	n4 6
	n4 6
	VOLRAW 25
	DOT	n4 3 + 12
	DOT	n4 10
	VOLRAW 50
	n4 8
	n4 8
	n4 8
	LOOP 2, .tri_loop_start

	LOOP 0, .triA
.triA1
	n4 10
.triA
	VOLRAW 25
	DOT	n4 9
	DOT	n4 4
	VOLRAW 50
	n4 9
	n4 9
	n4 9

	VOLRAW 25
	DOT	n4 4 + 12
	DOT	n4 11
	VOLRAW 50
	n4 4 + 12
	n4 4 + 12
	LOOP 1, .triA1
	n4 4 + 12

	VOLRAW 25
	DOT	n4 3 + 12
	DOT	n4 9
	VOLRAW 50
	n4 8
	n4 8
	n4 8

	VOLRAW 25
	DOT	n4 1 + 12
	DOT	n4 8
	VOLRAW 50
	n4 6
	n4 6
	n4 6

	VOLRAW 25
	DOT	n4 9
	DOT	n4 4
	VOLRAW 50
	n4 8
	n4 8
	n4 8

	VOLRAW 25
	DOT	n4 7
	DOT	n4 3 + 12
	VOLRAW 50
	n4 8
	n4 8
	n4 8

	VOLRAW 25
	DOT	n4 9
	DOT	n4 4
	DOT	n4 9
	DOT	n4 4
	VOLRAW 50
	n4 4 + 12
	n4 11
	n4 8
	VOLRAW 127
	DOT	n5 4
	LOOP 1, .tri_loop_start
