
    .beginregion "Gate of Steiner"
GATE_OF_STEINER:
    TRACK .sq1_start, .sq2_start, .tri_start, 0, BPM(77)
.sq1
    .include "src/music/gateofsteiner/sq1.asm"
.sq2
    .include "src/music/gateofsteiner/sq2.asm"
.tri
    .include "src/music/gateofsteiner/tri.asm"
.noi
    .include "src/music/gateofsteiner/noi.asm"
    .endregion "Gate of Steiner"
