
	.catbank $08 * 2
	.catbank $09 * 2
	.catbank $0A * 2
	.catbank $0B * 2
	.catbank $0C * 2
	.catbank $0D * 2
	.catbank $0E * 2
	.catbank $0F * 2
	.inesprg $10 ;プログラムバンク数
	.ineschr $00 ;キャラクタバンク数
	.inesmir 1   ;
	.inesmap 1

	.incbin "rockman2.prg"
	.include "src/labels.asm"
	.include "src/lib.asm"
	.include "src/music/libmusic.asm"
	.include "src/bank09.asm"
	.include "src/bank0B.asm"
	.include "src/bank0C.asm"
	.include "src/bank0D.asm"
	.include "src/bank0E.asm"
	.include "src/bank0F.asm"
	.include "src/patch.asm"
	.include "src/music/music.asm"
