
	.bank $18
	.org $8A50
Bank0C_BeginMusicPtr:
	.dw Music_FROZENHOTEL
;	.dw SBOMB15
;	.dw SBOMB16
;	
	.org $8AD6
;Bank0C_BeginMusicData:
Music_FROZENHOTEL:
	.include "music/heartache.asm"
;SBOMB15:
;	.include "music/sbomb1_area5.asm"
;SBOMB16:
;	.include "music/sbomb1_area6.asm"
