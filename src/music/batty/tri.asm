
.tri_sub1
	TOMLOW
	n3 1 + 12
	n3 1 + 12
	TOMHIGH
	n3 4 + 12
	TOMHIGH
	n3 4 + 12
	TOMLOW
	n3 8 + 12
	n3 8 + 12
	TOMHIGH
	n3 4 + 12
	n3 8 + 12
	RETURN
.tri_sub2
	TOMLOW
	n3 6 + 12
	n3 6 + 12
	TOMHIGH
	n3 6
	TOMHIGH
	n3 6
	TOMLOW
	n3 1 + 12
	n3 1 + 12
	TOMHIGH
	n3 6 + 12
	n3 1 + 12
	RETURN
.tri_start
	KEY O3
	VOLRAW $20
.triA
	TOMLOW
	n3 8
	n3 8
	TOMHIGH
	n3 7
	TOMHIGH
	n3 7
	TOMLOW
	n3 6
	n3 6
	TOMHIGH
	n3 7
	n3 7
	LOOP 1, .triA
	
	TOMLOW
	n3 8
	n3 8
	TOMHIGH
	n3 7
	TOMHIGH
	n3 7
	TOMLOW
	n3 6
	TOMHIGH
	n2 6
	TOMHIGH
	n2 6
	TOMHIGH
	n3 7
	TOMHIGH
	n3 7

	VOLRAW $40
	TIE
	n3 1 + 12
	PITCH 30
	n3 1 + 12
	PITCH 0

.tri_loop
	n5
	TOMHIGH
	n3 1
	n3
	VOLRAW $20
	LOOP 0, .triB1
.triB
	CALL .tri_sub1
	CALL .tri_sub1
.triB1
	TOMLOW
	n3 3 + 12
	n3 3 + 12
	TOMHIGH
	n3 7 + 12
	TOMHIGH
	n3 7 + 12
	TOMLOW
	n3 10 + 12
	n3 10 + 12
	TOMHIGH
	n3 7 + 12
	n3 10 + 12

	TOMLOW
	n3 8
	n3 8
	TOMHIGH
	n3 12
	TOMHIGH
	n3 12
	TOMLOW
	n3 3 + 12
	n3 3 + 12
	TOMHIGH
	n3 12
	n3 3 + 12
	LOOP 1, .triB
	
	TOMLOW
	n3 1 + 12
	n3 1 + 12
	TOMHIGH
	n3 4 + 12
	n3 4 + 12
	TOMHIGH
	n3 8 + 12
	TOMHIGH
	n2 8 + 12
	TOMHIGH
	n2 8 + 12
	TOMHIGH
	n3 4 + 12
	TOMHIGH
	n3 8 + 12

	TOMHIGH
	n4 1 + 12
	VOLRAW $40
	n4 1 + 12
	n4 1 + 12
	n4 1 + 12
	VOLRAW $20

	CALL .tri_sub2
	
	TOMLOW
	n3 11
	n3 11
	TOMHIGH
	n3 6 + 12
	TOMHIGH
	n3 6 + 12
	TOMLOW
	n3 11
	n3 11
	TOMHIGH
	n3 3 + 12
	n3 6 + 12
	
	TOMLOW
	n3 4 + 12
	n3 4 + 12
	TOMHIGH
	n3 11
	TOMHIGH
	n3 11
	TOMLOW
	n3 8
	n3 8
	TOMHIGH
	n3 9
	n3 11

	CALL .tri_sub1
	CALL .tri_sub2
	
	TOMLOW
	n3 3 + 12
	n3 3 + 12
	TOMHIGH
	n3 10
	TOMHIGH
	n3 10
	TOMLOW
	n3 1 + 12
	n3 1 + 12
	TOMHIGH
	n3 3 + 12
	n3 3 + 12
	
	TOMLOW
	n3 8 + 12
	n3 8 + 12
	TOMHIGH
	n3 7 + 12
	TOMHIGH
	n3 7 + 12
	TOMLOW
	n3 6 + 12
	n3 6 + 12
	TOMHIGH
	n3 7 + 12
	n3 7 + 12

	VOLRAW $40
	TIE
	n3 8 + 12
	PITCH 30
	n3 8 + 12
	PITCH 0
	LOOP 0, .tri_loop
