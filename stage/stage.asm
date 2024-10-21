
	mBEGIN $00, $8000
	.incbin "stage/heatman.bin"
	mBEGINRAW $01, $A000
	.incbin "stage/chr/lz77/heatman.lz77"
	
	mBEGIN $01, $8000
	.incbin "stage/airman.bin"
	mBEGINRAW $03, $A000
	.incbin "stage/chr/lz77/airman.lz77"
	
	mBEGIN $02, $8000
	.incbin "stage/woodman.bin"
	mBEGINRAW $05, $A000
	.incbin "stage/chr/lz77/woodman.lz77"
	
	mBEGIN $03, $8000
	.incbin "stage/bubbleman.bin"
	mBEGINRAW $07, $A000
	.incbin "stage/chr/lz77/bubbleman.lz77"
	
	mBEGIN $04, $8000
	.incbin "stage/quickman.bin"
	mBEGINRAW $09, $A000
	.incbin "stage/chr/lz77/quickman.lz77"
	
	mBEGIN $05, $8000
	.incbin "stage/flashman.bin"
	mBEGINRAW $0B, $A000
	.incbin "stage/chr/lz77/flashman.lz77"
	
	mBEGIN $06, $8000
	.incbin "stage/metalman.bin"
	mBEGINRAW $0D, $A000
	.incbin "stage/chr/lz77/metalman.lz77"
	
	mBEGIN $07, $8000
	.incbin "stage/crashman.bin"
	mBEGINRAW $0F, $A000
	.incbin "stage/chr/lz77/crashman.lz77"
	
	
	mBEGIN $09, $8000
	.incbin "stage/chr/lz77/common.lz77"
	mBEGIN $09, $9000
	.incbin "graphs/wilycastle.chr"
	mBEGINRAW $13, $A000
	.incbin "graphs/opening.chr"

