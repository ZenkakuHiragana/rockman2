.tri_loop
	KEY O3 - 5
	VOLRAW $81
	n3 1
	n3 8 + 5
	n3 8 + 12 + 5
	n3 8 + 5
	n3 8 + 12 + 5
	n3 8 + 5
	n3
	n3 8 + 5
	n3 8 + 12 + 5
	n3 8 + 5
	n3 8 + 12 + 5
	n3 8 + 5

.triA1
	n3 1 + 12 + 5
	n2 8 + 12 + 5
	n2 1 + 12 + 12 + 5
	n3 1 + 12 + 5
	n2 8 + 12 + 5
	n2 1 + 12 + 12 + 5
	n3 1 + 12 + 5
	n2 8 + 12 + 5
	n2 1 + 12 + 12 + 5
	n3 1 + 12 + 5
	n2 8 + 12 + 5
	n2 1 + 12 + 12 + 5
	n3 8 + 5
	n2 3 + 12 + 5
	n2 8 + 12 + 5
	n3 8 + 5
	n2 3 + 12 + 5
	n2 8 + 12 + 5
	n3 8 + 5
	n2 3 + 12 + 5
	n2 8 + 12 + 5
	n3 8 + 5
	n2 3 + 12 + 5
	n2 8 + 12 + 5
	LOOP 1, .triA1

	n6
	n6
	n3 1 + 12 + 5
	n3
	n4
	n5

	KEY O3
.triB1
	n3 3 + 12
	n2 10 + 12
	n2 3 + 12 + 12
	LOOP 3, .triB1
.triB2
	n3 8
	n2 3 + 12
	n2 8 + 12
	LOOP 3, .triB2
.triB3
	n3 1 + 12
	n2 8 + 12
	n2 1 + 12 + 12
	LOOP 7, .triB3
.triB4
	n3 3 + 12
	n2 10 + 12
	n2 3 + 12 + 12
	LOOP 3, .triB4
.triB5
	n3 8
	n2 3 + 12
	n2 8 + 12
	LOOP 3, .triB5
.triB6
	n3 1 + 12
	n2 8 + 12
	n2 1 + 12 + 12
	LOOP 7, .triB6

	n3 1 + 12
	n3
.triB7
	DOT n3 1 + 12
	n2
	LOOP 2, .triB7

.triC1
	n3 6
	n2 1 + 12
	n2 6 + 12
	LOOP 3, .triC1
.triC2
	n3 11
	n2 6 + 12
	n2 11 + 12
	LOOP 3, .triC2
.triC3
	n3 4 + 12
	n2 11 + 12
	n2 4 + 12 + 12
	LOOP 3, .triC3
.triC4
	n3 1 + 12
	n2 8 + 12
	n2 1 + 12 + 12
	LOOP 3, .triC4
.triC5
	n3 6
	n2 1 + 12
	n2 6 + 12
	LOOP 3, .triC5
.triC6
	n3 3 + 12
	n2 10 + 12
	n2 3 + 12 + 12
	LOOP 3, .triC6
.triC7
	n3 8
	n2 3 + 12
	n2 8 + 12
	LOOP 3, .triC7

	n6
	n5
	n4
	n3
	n2

	KEY O5
	n2 6
	n5 8
	n5 4
	MOD MOD_4d2t1f
	n6 1
	MOD 0
	LOOP 0, .tri_loop
