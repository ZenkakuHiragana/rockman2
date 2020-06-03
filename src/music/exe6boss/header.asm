
    .beginregion "Rockman EXE 6 Boss Battle"
EXE6BOSS:
    TRACK .sq1_start, .sq2_start, .tri_start, .noi_start, BPM(150)
.track_block1a
    ENV 4, 8
    KEY O3 + 5
    n2 1
    n2 4
    n2 1 + 12 - 5
    n2 4 + 12 - 5
    n2 6 + 12 - 5
    n2 9 + 12 - 5
    KEY O5 - 2
    n2 1 + 2
    n2 4 + 2
    n2 6 + 2
    n2 9 + 2
    n2 1 + 12 + 2
    n2 4 + 12 + 2
    n2 2 + 12 + 2
    n2 1 + 12 + 2
    n2 11 + 2
    n2 9 + 2
    RETURN
.track_block1b
    KEY O3 + 5
    n2 1
    n2 4
    n2 1 + 12 - 5
    n2 4 + 12 - 5
    n2 6 + 12 - 5
    n2 9 + 12 - 5
    KEY O5 - 2
    n2 1 + 2
    n2 4 + 2
    n2 6 + 2
    n2 9 + 2
    n2 1 + 12 + 2
    n2 4 + 12 + 2
    n2 2 + 12 + 2
    n2 1 + 12 + 2
    n2 11 + 2
    n2 6 + 2
    RETURN
.track_block1c
    KEY O3 + 5
    n2 1
    n2 4
    n2 1 + 12 - 5
    n2 4 + 12 - 5
    n2 6 + 12 - 5
    n2 9 + 12 - 5
    KEY O5 - 2
    n2 1 + 2
    n2 4 + 2
    n2 6 + 12 + 2
    n2 1 + 12 + 2
    n2 2 + 12 + 2
    n2 9 + 2
    n2 1 + 12 + 2
    n2 11 + 2
    n2 8 + 2
    n2 4 + 2
    RETURN
.track_block2
    n2 9 + 12 + 2
    n2 9 + 2
    n2 8 + 12 + 2
    n2 9 + 2
    n2 9 + 12 + 2
    n2 9 + 2
    n2 8 + 12 + 2
    n2 9 + 2
    n2 6 + 12 + 2
    n2 4 + 12 + 2
    n2 1 + 12 + 2
    n2 9 + 2
    n2 6 + 2
    n2 4 + 2
    n2 1 + 2
    n2 1
    RETURN
.track_block3a
    n3 2 + 12 + 2
    n2 6 + 2
    n3 2 + 12 + 2
    n2 6 + 2
    n2 2 + 12 + 2
    n2 6 + 2
    n3 4 + 12 + 2
    n2 7 + 2
    n3 4 + 12 + 2
    n2 7 + 2
    n2 4 + 12 + 2
    n2 7 + 2
    RETURN
.track_block3b
    n3 12 + 2
    n2 6 + 2
    n3 12 + 2
    n2 6 + 2
    n2 12 + 2
    n2 6 + 2
    n3 1 + 12 + 2
    n2 7 + 2
    n3 1 + 12 + 2
    n2 7 + 2
    n2 1 + 12 + 2
    n2 7 + 2
    RETURN
.track_block3c
    n3 12 + 2
    n2 6 + 2
    n3 12 + 2
    n2 6 + 2
    n2 12 + 2
    n2 6 + 2
    n3 1 + 12 + 2
    n2 1 + 2
    n3 7 + 2
    n2 1 + 2
    n2 4 + 2
    n2 1
    RETURN
.tri
    .include "src/music/exe6boss/tri.asm"
.sq2
    .include "src/music/exe6boss/sq2.asm"
.sq1
    .include "src/music/exe6boss/sq1.asm"
.noi
    .include "src/music/exe6boss/noi.asm"
    .endregion "Rockman EXE 6 Boss Battle"
