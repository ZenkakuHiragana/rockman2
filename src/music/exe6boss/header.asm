
    .beginregion "Rockman EXE 6 Boss Battle"
EXE6BOSS:
    TRACK .sq1_start, .sq2_start, .tri_start, .noi_start, BPM(150)
.tri
    .include "src/music/exe6boss/tri.asm"
.sq2
    .include "src/music/exe6boss/sq2.asm"
.sq1
    .include "src/music/exe6boss/sq1.asm"
.noi
    .include "src/music/exe6boss/noi.asm"
    .endregion "Rockman EXE 6 Boss Battle"
