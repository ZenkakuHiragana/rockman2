
	.catbank $00
	.catbank $02
	.catbank $04
	.catbank $06
	.catbank $08
	.catbank $0A
	.catbank $0C
	.catbank $0E
	.catbank $10
	.catbank $12
	.catbank $14
	.catbank $16
	.catbank $18
	.catbank $1A
	.catbank $1C
	.catbank $1E
	.inesprg $10 ;プログラムバンク数
	.ineschr $00 ;キャラクタバンク数
	.inesmir 1   ;
	.inesmap 1
	
	.incbin "rockman2.prg"
	.include "src/labels.asm"
	.include "src/lib.asm"
	mBEGIN $00, $8000
	.incbin "stage/test.bin"
;	.include "src/bank0C.asm"
	.include "src/bank0D.asm"
	.include "src/bank0E.asm"
	.include "src/bank0F.asm"
;	.include "src/patch.asm"
	
;	.include "music/music.asm"
