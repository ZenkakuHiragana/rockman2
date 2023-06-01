
    .beginregion "Igneous Rock"
IGNEOUS_ROCK_LOOP:
IGNEOUS_ROCK:
    TRACK .sq1_start, .sq2_start, .tri_start, .noi_start, BPM(135)
.sq1
    .include "src/music/igneous/sq1.asm"
    ; mBEGIN #$0C, .sq1 + $0400
.sq2
    .include "src/music/igneous/sq2.asm"
    ; mBEGIN #$0C, .sq1 + $0800
.noi
    .include "src/music/igneous/noi.asm"
    ; mBEGIN #$0C, .sq1 + $0C00
.tri
    .include "src/music/igneous/tri.asm"
    .endregion "Igneous Rock"
