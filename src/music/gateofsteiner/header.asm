
    .beginregion "Gate of Steiner"
GATE_OF_STEINER:
    TRACK .sq1, .sq2, .tri, 0, BPM(76)
.tri
    .include "src/music/gateofsteiner/tri.asm"
.sq2
    .include "src/music/gateofsteiner/sq2.asm"
.sq1
    .include "src/music/gateofsteiner/sq1.asm"
.noi
    .include "src/music/gateofsteiner/noi.asm"
    .endregion "Gate of Steiner"
