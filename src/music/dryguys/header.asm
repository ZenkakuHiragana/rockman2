
    .beginregion "Dry Guys"
DRY_GUYS:
    TRACK .sq1, .sq2, .tri, .noi, .mod
.mod
    .dw $0000, $0080, $2201, $8000
.tri
    .include "src/music/dryguys/tri.asm"
.sq2
    .include "src/music/dryguys/sq2.asm"
.sq1
    .include "src/music/dryguys/sq1.asm"
.noi
    .include "src/music/dryguys/noi.asm"
    .endregion "Dry Guys"
