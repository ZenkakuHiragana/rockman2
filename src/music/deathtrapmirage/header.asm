
    .beginregion "Deathtrap"
DEATHTRAP_MIRAGE:
    TRACK .sq1, .sq2, .tri, .noi, .mod
.mod
    .dw 0, $8000, $4304, $8000
.tri
    .include "src/music/deathtrapmirage/tri.asm"
.sq2
    .include "src/music/deathtrapmirage/sq2.asm"
.sq1
    .include "src/music/deathtrapmirage/sq1.asm"
.noi
    .include "src/music/deathtrapmirage/noi.asm"
    .endregion "Deathtrap"
