
;曲の定義
	mBEGIN #$0C, Table_TrackStartPointers
	; .dw DRY_GUYS
	; .dw DEATHTRAP_MIRAGE
	; .dw ETUDEFORGHOSTS
	; .dw FROZENHOTEL
	; .dw HEARTACHE
	; .dw SBOMB1_1
	; .dw SBOMB1_5
	; .dw SBOMB1_6

	mBEGIN #$0C, #$8AD6
    ; .include "src/music/dryguys/header.asm"
    ; .include "src/music/deathtrapmirage/header.asm"
	; .include "src/music/etudeforghosts.asm"
	; .include "src/music/frozenhotel.asm"
	; .include "src/music/heartache.asm"
	; .include "src/music/sbomb1_area1.asm"
	; .include "src/music/sbomb1_area5.asm"
	; .include "src/music/sbomb1_area6.asm"

	mBEGINRAW $1F, Reset_Start
	sei
	inc $FFE1
	lda #%00000111
	sta $4001
	sta $4005
	jmp Reset_JMP
