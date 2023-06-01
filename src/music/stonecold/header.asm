
    .beginregion "Stone Cold"
STONE_COLD_LOOP:
STONE_COLD:
    TRACK .sq1_start, .sq2_start, .tri_start, .noi_start, BPM(135)
.sq1
    .include "src/music/stonecold/sq1.asm"
    ; mBEGIN #$0C, .sq1 + $0400
.sq2
    .include "src/music/stonecold/sq2.asm"
    ; mBEGIN #$0C, .sq1 + $0800
.noi
    .include "src/music/stonecold/noi.asm"
    ; mBEGIN #$0C, .sq1 + $0C00
.tri
    .include "src/music/stonecold/tri.asm"
    ; mBEGIN #$0C, .sq1 + $1000
    .endregion "Stone Cold"
