
	.catbank $18
	.inesprg $10 ;プログラムバンク数
	.ineschr $00 ;キャラクタバンク数
	.inesmir 1   ;
	.inesmap 1

	.incbin "rockman2.prg"
	.include "src/labels.asm"
	.include "src/lib.asm"
	.include "src/bank09.asm"
	.include "src/bank0B.asm"
	.include "src/bank0C.asm"
	.include "src/bank0D.asm"
	.include "src/bank0E.asm"
	.include "src/bank0F.asm"
	.include "src/patch.asm"

	.bank $1F
	.org $FFE4
	lda #%00000111
	sta $4001
	sta $4005
	jmp $F300

	.org $FFFC
	.dw $FFE0, $FFE0
