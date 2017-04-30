
	.bank $18
	.org $8A50
Bank0C_BeginMusicPtr:
	.dw Music_FROZENHOTEL
	
	.org $8AD6
Bank0C_BeginMusicData:
Music_FROZENHOTEL:
	.include "music/frozenhotel.asm"
