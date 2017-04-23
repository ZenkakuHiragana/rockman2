
	.catbank $18
	.inesprg $10 ;プログラムバンク数
	.ineschr $00 ;キャラクタバンク数
	.inesmir 1   ;
	.inesmap 1

	.incbin "music/music.prg"
	.include "music/libmusic.asm"
	.bank $18
	.org $8A50
	.dw FROZENHOTEL
;	.dw ETUDEFORGHOSTS
;	.dw HEARTACHE
;	.dw SBOMB1_1, SBOMB1_5, SBOMB1_6
	.org $8AD6
	
	.list
	mNULL
	.nolist
	
;SBOMB1_1:
;	.include "music/sbomb1_area1.asm"
;SBOMB1_5:
;	.include "music/sbomb1_area5.asm"
;SBOMB1_6:
;	.include "music/sbomb1_area6.asm"
;HEARTACHE:
;	.include "music/heartache.asm"
;ETUDEFORGHOSTS:
;	.include "music/etudeforghosts.asm"
FROZENHOTEL:
	.include "music/frozenhotel.asm"
	
	.list
	mNULL
	.nolist
	
	.bank $1F
	.org $FFE4
	lda #%00000111
	sta $4001
	sta $4005
	jmp $F300
	
	.org $FFFC
	.dw $FFE0, $FFE0
