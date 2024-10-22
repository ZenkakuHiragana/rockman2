
	mBEGIN $00, $8000
	.incbin "stage/heatman.bin"
	mBEGINRAW $01, $A000
	.incbin "stage/chr/toku/heatman.toku"
	.incbin "stage/chr/toku/heatman2.toku"
	
	mBEGIN $01, $8000
	.incbin "stage/airman.bin"
	mBEGINRAW $03, $A000
	.incbin "stage/chr/toku/airman.toku"
	
	mBEGIN $02, $8000
	.incbin "stage/woodman.bin"
	mBEGINRAW $05, $A000
	.incbin "stage/chr/toku/woodman.toku"
	
	mBEGIN $03, $8000
	.incbin "stage/bubbleman.bin"
	mBEGINRAW $07, $A000
	.incbin "stage/chr/toku/bubbleman.toku"
	
	mBEGIN $04, $8000
	.incbin "stage/quickman.bin"
	mBEGINRAW $09, $A000
	.incbin "stage/chr/toku/quickman.toku"
	
	mBEGIN $05, $8000
	.incbin "stage/flashman.bin"
	mBEGINRAW $0B, $A000
	.incbin "stage/chr/toku/flashman.toku"
	
	mBEGIN $06, $8000
	.incbin "stage/metalman.bin"
	mBEGINRAW $0D, $A000
	.incbin "stage/chr/toku/metalman.toku"
	
	mBEGIN $07, $8000
	.incbin "stage/crashman.bin"
	mBEGINRAW $0F, $A000
	.incbin "stage/chr/toku/crashman.toku"
	
	
	mBEGIN $09, $8000
	.incbin "stage/chr/toku/common.toku"
	mBEGIN $09, $9000
	.incbin "graphs/wilycastle.chr"
	mBEGINRAW $13, $A000
	.incbin "graphs/opening.chr"

