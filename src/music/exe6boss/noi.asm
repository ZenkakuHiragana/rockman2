
.noi_block_intro
    ENV 2, 1
    TOMLOW
    n4 4
    ENV 1, 2
    n3 7
    TOMLOW
    n2 4
    TOMLOW
    n2 4
    n2 2
    n2 2
    TOMLOW
    n3 4
    n3 7
    TOMLOW
    n3 4
    RETURN
.noi_block_repetition
    ENV 2, 1
    TOMLOW
    n4 4
.noi_block_repetition2
    ENV 1, 2
    n3 7
    TOMLOW
    n3 4
.noi_block_rep
    n1 7
    LOOP 7, .noi_block_rep
    n2 7
    n2 2
    TOMLOW
    n3 4
    RETURN
.noi_block1a
    TOMLOW
    n3 4
    n3 2
    n3 7
    TOMLOW
    n2 4
    TOMLOW
    n2 4
    n2 2
    n2 2
    TOMLOW
    n3 4
    n3 7
    TOMLOW
    n2 4
    RETURN
.noi_block1b
    TOMLOW
    n2 4
    n2 7
    n3 2
    n3 7
    TOMLOW
    n2 4
    TOMLOW
    n2 4
    n2 2
    n2 2
    TOMLOW
    n3 4
    n3 7
    TOMLOW
    n3 4
    RETURN
.noi_start
    VOL 15
    ENV 2, 1
    TOMLOW
    n4 4
    ENV 1, 2
    n2 2
    n2 2
    TOMLOW
    n3 4
.noi_intro1
    n1 7
    LOOP 7, .noi_intro1
    n2 7
    n2 2
    TOMLOW
    n3 4
    
    TOMLOW
    n3 4
    n3 2
    n2 2
    n2 2
    TOMLOW
    n3 4
    n2 2
    n2 2
    n3 2
    n2 2
    n2 2
    TOMLOW
    n3 4

    TOMLOW
    n3 4
    n3 2
    n3 7
    TOMLOW
    n2 4
    TOMLOW
    n2 4
    n2 2
    n2 2
    n3 2
    n2 2
    n2 2
    ENV 3, 1
    n3 2
    ENV 1, 2

    TOMLOW
    n3 4
    n2 2
    n2 7
    n2 2
    n2 2
    TOMLOW
    n2 4
    TOMLOW
    n2 4
    TOMLOW
    n2 4
    n2 2
    n2 2
    n2 7
    n2 2
    n2 2
    ENV 3, 1
    n3 2
    ENV 1, 2

.noi_loop
    CALL .noi_block_intro
    LOOP 0, .noiA1
.noiA2
    CALL .noi_block1a
    n2
.noiA1
    CALL .noi_block1b
    CALL .noi_block1a
    n2
    CALL .noi_block1a
    n2 9
    LOOP 1, .noiA2
    
    CALL .noi_block_repetition
    CALL .noi_block1b
    CALL .noi_block1a
    n2
    CALL .noi_block1a
    n2 12

    CALL .noi_block_intro
.noiB2
    CALL .noi_block1a
    n2
    LOOP 5, .noiB2
    
    TOMLOW
    n3 4
    n3 2
    n3 7
    TOMLOW
    n2 4
    TOMLOW
    n2 4
    n2 2
    n2 2
    n3 2
    n2 2
    n2 2
    ENV 3, 1
    n3 2

.noiC
    ENV 2, 1
    TOMLOW
    n4 4
    ENV 1, 2
    n3 7
    n3 2
    n2 2
    n2 2
    n3 2
    n3 7
    TOMLOW
    n3 4
    LOOP 1, .noiC

    TOMLOW
    n3 4
    n3 2
    n3 7
    n3 2
    n2 2
    n2 2
    n3 2
    n3 7
    TOMLOW
    n3 4

    TOMLOW
    n3 4
    n3 2
    n3 7
    TOMLOW
    n2 4
    TOMLOW
    DOT n3 4

    ENV 3, 2, 1
    DOT n4 4

    CALL .noi_block_repetition
    CALL .noi_block1b
    CALL .noi_block1a
    n2
    CALL .noi_block1a
    n2 12

    TOMLOW
    n2 4
    n2 7
    n3 4
    CALL .noi_block_repetition2
    CALL .noi_block1b
    CALL .noi_block1a
    n2
    CALL .noi_block1a
    TOMLOW
    n2 4
    LOOP 0, .noi_loop
