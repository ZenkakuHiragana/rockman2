
	.catbank $1E
	.inesprg $10 ;�v���O�����o���N��
;	.ineschr $00 ;�L�����N�^�o���N��
;	.inesmir 1   ;
;	.inesmap 1

;	.incbin "rockman2.prg"
;	.include "src/labels.asm"
;	.include "src/lib.asm"
;	.include "src/bank0C.asm"
;	.include "src/bank0D.asm"
;	.include "src/bank0E.asm"
;	.include "src/bank0F.asm"
;	.include "src/patch.asm"

	.bank $1E
	.org $DFFE
	beq Test
Test:
	.list
	nop
