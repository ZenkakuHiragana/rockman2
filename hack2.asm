
;	.catbank $1A
;;	.catbank $1B
;	.catbank $1C
;;	.catbank $1D
;	.catbank $1E
;;	.catbank $1F
	.inesprg $10 ;プログラムバンク数
	.ineschr $00 ;キャラクタバンク数
	.inesmir 1   ;
	.inesmap 1

	.incbin "rockman2.prg"
	.include "src/labels.asm"
	.include "src/lib.asm"
;	.include "src/bank0C.asm"
	.include "src/bank0D.asm"
	.include "src/bank0E.asm"
	.include "src/bank0F.asm"
	.include "src/patch.asm"
	
	.bank $1F
