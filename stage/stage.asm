
	mBEGIN $00, $8000
	.incbin "stage/heatman.bin"
	mBEGIN $00, $A000
	.incbin "stage/chr/toku/heatman.toku"
	.incbin "stage/chr/toku/heatman2.toku"
	
	mBEGIN $01, $8000
	.incbin "stage/airman.bin"
	mBEGIN $01, $A000
	.incbin "stage/chr/toku/airman.toku"
	
	mBEGIN $02, $8000
	.incbin "stage/woodman.bin"
	mBEGIN $02, $A000
	.incbin "stage/chr/toku/woodman.toku"
	
	mBEGIN $03, $8000
	.incbin "stage/bubbleman.bin"
	mBEGIN $03, $A000
	.incbin "stage/chr/toku/bubbleman.toku"
	
	mBEGIN $04, $8000
	.incbin "stage/quickman.bin"
	mBEGIN $04, $A000
	.incbin "stage/chr/toku/quickman.toku"
	
	mBEGIN $05, $8000
	.incbin "stage/flashman.bin"
	mBEGIN $05, $A000
	.incbin "stage/chr/toku/flashman.toku"
	
	mBEGIN $06, $8000
	.incbin "stage/metalman.bin"
	mBEGIN $06, $A000
	.incbin "stage/chr/toku/metalman.toku"
	
	mBEGIN $07, $8000
	.incbin "stage/crashman.bin"
	mBEGIN $07, $A000
	.incbin "stage/chr/toku/crashman.toku"
