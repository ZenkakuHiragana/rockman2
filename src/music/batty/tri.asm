
.tri_sub1
	n3 1 + 12
	n3 1 + 12
	n3 4 + 12
	n3 4 + 12
	n3 8 + 12
	n3 8 + 12
	n3 4 + 12
	n3 8 + 12
	RETURN
.tri_sub2
	n3 6 + 12
	n3 6 + 12
	n3 6
	n3 6
	n3 1 + 12
	n3 1 + 12
	n3 6 + 12
	n3 1 + 12
	RETURN
.tri_start
	KEY O3
	VOLRAW $20
.triA
	n3 8
	n3 8
	n3 7
	n3 7
	n3 6
	n3 6
	n3 7
	n3 7
	LOOP 2, .triA

	VOLRAW $40
	TIE
	n3 1 + 12
	PITCH 30
	n3 1 + 12
	PITCH 0

.tri_loop
	VOLRAW 8
	DOT n5 1
	VOLRAW $20
	LOOP 0, .triB1
.triB
	CALL .tri_sub1
	CALL .tri_sub1
.triB1
	n3 3 + 12
	n3 3 + 12
	n3 7 + 12
	n3 7 + 12
	n3 10 + 12
	n3 10 + 12
	n3 7 + 12
	n3 10 + 12

	n3 8
	n3 8
	n3 12
	n3 12
	n3 3 + 12
	n3 3 + 12
	n3 12
	n3 3 + 12
	LOOP 1, .triB
	
	n3 1 + 12
	n3 1 + 12
	n3 4 + 12
	n3 4 + 12
	n3 8 + 12
	n2 8 + 12
	n2 8 + 12
	n3 4 + 12
	n3 8 + 12

	n4 1 + 12
	VOLRAW $40
	n4 1 + 12
	n4 1 + 12
	n4 1 + 12
	VOLRAW $20

	CALL .tri_sub2
	
	n3 11
	n3 11
	n3 6 + 12
	n3 6 + 12
	n3 11
	n3 11
	n3 3 + 12
	n3 6 + 12
	
	n3 4 + 12
	n3 4 + 12
	n3 11
	n3 11
	n3 8
	n3 8
	n3 9
	n3 11

	CALL .tri_sub1
	CALL .tri_sub2
	
	n3 3 + 12
	n3 3 + 12
	n3 10
	n3 10
	n3 1 + 12
	n3 1 + 12
	n3 3 + 12
	n3 3 + 12
	
	n3 8 + 12
	n3 8 + 12
	n3 7 + 12
	n3 7 + 12
	n3 6 + 12
	n3 6 + 12
	n3 7 + 12
	n3 7 + 12

	VOLRAW $40
	TIE
	n3 8 + 12
	PITCH 30
	n3 8 + 12
	PITCH 0
	LOOP 0, .tri_loop
