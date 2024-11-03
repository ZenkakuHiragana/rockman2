
	mBEGIN $08, $8000
	.ds $2000
	mBEGIN $08, $A000
	.ds $1000
	mBEGIN $08, $8000
Graphics_StageSelect:
	.incbin "graphs/toku/stageselect-spr.toku"
	.incbin "graphs/toku/stageselect-bg.toku"
	mBEGIN $08, $8800
Graphics_WilyCastle:
	.incbin "graphs/toku/wilycastle-spr.toku"
	.incbin "graphs/toku/wilycastle-bg.toku"
	mBEGIN $08, $9400
Graphics_Ending:
	.incbin "graphs/toku/ending.toku"
	mBEGIN $08, $A000
Graphics_Dogeza:
	.incbin "graphs/dogeza.chr"

	
	mBEGIN $09, $8000
	.ds $2000
	mBEGIN $09, $A000
	.ds $1000
	mBEGIN $09, $8000
Graphics_CommonBG:
	.incbin "stage/chr/toku/common.toku"
Graphics_Password:
	.incbin "graphs/toku/password-spr.toku"
	.incbin "graphs/toku/password-bg.toku"
Table_StageSelectNameTable:
	.incbin "src/bin/StageSelectNameTable.toku"
Table_WilyCastleNameTable:
	.incbin "src/bin/WilyCastleNameTable.toku"

	mBEGIN $09, $A000
Graphics_Opening:
	.incbin "graphs/toku/opening-spr.toku"
	.incbin "graphs/toku/opening-bg.toku"
