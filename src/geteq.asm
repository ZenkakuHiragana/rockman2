
;B9F9
;武器取得処理
___Bank0D_BeginGetEquipment:
	lda #$03
	jsr LoadGraphicsSet
	lda <zStage
	pha
	mMOV #$05, <zStage
	lda #$F0
	jsr WriteMapAddressOffScreen1A
	lda #$F1
	jsr WriteMapAddressOffScreen1A
	pla
	sta <zStage
	mPLAYTRACK #$17
	jsr ResetScrollPosition1A
	lda #$01
	jsr Password_SetScreenPalette
	ldx #$0F
	txa
.loop_initpalette
	sta aPaletteSpr,x
	dex
	bpl .loop_initpalette
	mMOV #$06, aObjAnim
	jsr ChangeBank_ShowEndingRockman
	mMOV #$05, <$FD
.loop_fadein
	lda <zFrameCounter
	and #$07
	bne .wait_fadein
	ldx #$1B
	ldy #$3B
	lda #$0F
	jsr FadeinPaletteSpecified
	dec <$FD
	beq .end_fadein
.wait_fadein
	jsr FrameAdvance1A
	jmp .loop_fadein
.end_fadein
	jsr WaitForAWhile1A
	jsr WriteMinus1A
	jsr WaitForAWhile1A
	inc aPPULinearlo
	ldx <zStage
	mMOV Table_GetEqWeaponLetter,x, aPPULinearData
	inc <zPPULinear
	jsr WaitForAWhile1A
	jsr WriteMinus1A
	inc aPPULinearlo
	inc aPPULinearlo
	jsr FrameAdvance1A
	lda <zStage
	jsr WriteWeaponName1A
	lda #$08
	jsr WriteWeaponName1A
	mMOV #$9C, <$FD
.loop_changecolor
	ldx #$00
	lda <$FD
	and #$01
	beq .changecolor
	ldx <zStage
	inx
	txa
	asl a
	tax
.changecolor
	lda Table_GetEqRockmanColor,x
	sta aPaletteSpr + $02
	sta aPaletteSpr + $0A
	lda Table_GetEqRockmanColor + 1,x
	sta aPaletteSpr + $03
	sta aPaletteSpr + $0B
	jsr FrameAdvance1A
	dec <$FD
	bne .loop_changecolor
	ldx <zStage
	lda ItemBitTable,x
	beq .noitem
	jsr GetEquipment_Item
.noitem
	ldx #$08
	jsr WriteKeyword1A
	jsr FrameAdvance1A
	ldx #$09
	jsr WriteKeyword1A
	jsr FrameAdvance1A
.begin_select
	ldx #$03
.loop_curspr
	mMOV Table_GetEqCursorSprite,x, aSprite + $FC,x
	dex
	bpl .loop_curspr
	mMOV #$30, aPaletteSpr + $0E
	mSTZ <$FD
.loop_select
	ldx <$FD
	mMOV Table_GetEqCursorY,x, aSprite + $FC
	lda <zFrameCounter
	and #$08
	bne .hide
	mMOV #$F8, aSprite + $FC
.hide
	lda <zKeyPress
	and #$3C
	beq .noinput
	and #$08
	bne .decided
	mPLAYTRACK #$2F
	lda <$FD
	eor #$01
	sta <$FD
.noinput
	jsr FrameAdvance1A
	jmp .loop_select
.decided
	lda <$FD
	beq .password
	jmp .stageselect
.password
	ldx #$1F
.loop_backup
	mMOV aPalette,x, aPaletteBackup,x
	dex
	bpl .loop_backup
	jsr ShowPassword
	jsr ChangeBank_ShowEndingRockman
	mMOV #$05, <$FD
.loop_password
	lda <zFrameCounter
	and #$03
	bne .wait
	ldx #$1F
;なにやってんのこれ
.loop_palette
	lda aPalette,x
	cmp #$0F
	bne .jump1
	lda aPaletteBackup,x
	and #$0F
	sta aPalette,x
	jmp .jump3
.jump1
	clc
	adc #$10
	cmp aPaletteBackup,x
	beq .jump2
	bcs .jump3
.jump2
	sta aPalette,x
.jump3
	dex
	bpl .loop_palette
	dec <$FD
	beq .end
.wait
	jsr FrameAdvance1A
	jmp .loop_password
.end
	jmp .begin_select
.stageselect
	mJSR_NORTS DisableScreen1A

;BB6B
;アイテム入手の処理
GetEquipment_Item:
	lda #$0F
	sta aPalette + 6
	sta aPalette + 7
	ldx #$02
.loop_palette
	mMOV Table_GetEqDrRightColor,x, aPaletteSpr + $0D,x
	dex
	bpl .loop_palette
	jsr ClearSprite1A
	jsr GetEquipment_ClearScreen
	mMOV #$7D, <$FD
.loop_flash
	ldx #$0F
	lda <$FD
	and #$08
	beq .flash
	ldx #$15
.flash
	stx aPaletteSpr
	jsr FrameAdvance1A
	dec <$FD
	bne .loop_flash
	mMOV #$07, aObjAnim
	jsr ChangeBank_ShowEndingRockman
	lda #$09
	jsr WriteWeaponName1A
	lda #$0A
	jsr WriteWeaponName1A
	jsr Wait7DFrames1A
	jsr GetEquipment_ClearScreen
	ldx <zStage
	lda ItemBitTable,x
	lsr a
	clc
	adc #$68
	sta aObjFlags
	jsr WriteMinus_Item_1A
	lda #$0E
	jsr WriteWeaponName1A
	lda #$0B
	jsr WriteWeaponName1A
	lda #$0C
	jsr WriteWeaponName1A
	lda #$0D
	jsr WriteWeaponName1A
	jsr Wait7DFrames1A
	jsr GetEquipment_ClearScreen
	jsr ClearSprite1A
	mMOV #$06, aObjAnim
	jsr ChangeBank_ShowEndingRockman
	jsr WriteMinus_Item_1A
	lda aObjFlags
	and #$03
	clc
	adc #$0E + 1
	jsr WriteWeaponName1A
	lda #$08
	jsr WriteWeaponName1A
	mMOV #$7D, <$FD
.loop_changecolor
	ldx #$12
	lda <$FD
	and #$01
	bne .changecolor
	ldx <zStage
	inx
	txa
	asl a
	tax
.changecolor
	lda Table_GetEqRockmanColor,x
	sta aPaletteSpr + $02
	sta aPaletteSpr + $0A
	lda Table_GetEqRockmanColor + 1,x
	sta aPaletteSpr + $03
	sta aPaletteSpr + $0B
	jsr FrameAdvance1A
	dec <$FD
	bne .loop_changecolor
	rts

;BC29
;頭文字の左の-を描く
WriteMinus1A:
	mMOVWB $24CD, aPPULinearhi
	mMOV #$54, aPPULinearData
	inc <zPPULinear
	rts
;BC3B
;少し待つ
WaitForAWhile1A:
	jsr FrameAdvance1A
	lda <zFrameCounter
	and #$07
	bne WaitForAWhile1A
	rts

;BC45
;武器名を書く
WriteWeaponName1A:
	asl a
	asl a
	sta <$00
	asl a
	adc <$00
	tax
	mMOV Table_GetEqKeywords,x, aPPULinearhi
	mMOV Table_GetEqKeywords + 1,x, aPPULinearlo
	inx
	inx
	stx <$FE
	mMOV #$0A, <$FD
.loop_write_weaponname
	jsr WaitForAWhile1A
	ldx <$FE
	cpx #(($0E * $0C) + 2 + 4) ;0E: アイテム○コ゛ウの数字部分の分岐
	bne .skip
	lda aObjFlags
	bne .skip2
.skip
	lda Table_GetEqKeywords,x
.skip2
	sta aPPULinearData
	inc <zPPULinear
	inc aPPULinearlo
	inc <$FE
	dec <$FD
	bne .loop_write_weaponname
	mJSR_NORTS FrameAdvance1A

;BC84
;7Dhフレーム待つ
Wait7DFrames1A:
	mMOV #$7D, <$FD
.loop
	jsr FrameAdvance1A
	dec <$FD
	bne .loop
	rts

;BC90
;文字を消す
GetEquipment_ClearScreen:
	ldx #$1F
	lda #$00
.loop_init
	sta aPPULinearData,x
	dex
	bpl .loop_init
	mMOV #$09, <$FD
	mMOVWB $24AD, aPPULinearhi
.loop
	clc
	lda aPPULinearlo
	adc #$20
	sta aPPULinearlo
	lda aPPULinearhi
	adc #$00
	sta aPPULinearhi
	mMOV #$0C, <zPPULinear
	jsr FrameAdvance1A
	dec <$FD
	bpl .loop
	rts

;BCC5
;アイテム入手時の、-?-の描画
WriteMinus_Item_1A:
	jsr WaitForAWhile1A
	jsr WriteMinus1A
	jsr WaitForAWhile1A
	inc aPPULinearlo
	ldx <zStage
	mMOV aObjFlags, aPPULinearData
	inc <zPPULinear
	jsr WaitForAWhile1A
	jsr WriteMinus1A
	inc aPPULinearlo
	inc aPPULinearlo
	mJSR_NORTS FrameAdvance1A

;BCEB
;武器取得の時に出る頭文字
Table_GetEqWeaponLetter:
	.db $08, $01, $17, $02, $11, $06, $0D, $03

;BCF3
;武器名や「ヲ ソウビシマス..」などの文字列
Table_GetEqKeywords:
;アトミックファイヤー
	.db $25, $0D
	.db $20, $33, $3F, $4E, $27, $3B, $55, $21, $43, $54
;エアーシューター　　
	.db $25, $0D
	.db $23, $20, $54, $2B, $50, $54, $2F, $54, $00, $00
;リーフシールト゛　　
	.db $25, $0D
	.db $47, $54, $3B, $2B, $54, $48, $33, $52, $00, $00
;ハ゛フ゛ルリート゛　
	.db $25, $0D
	.db $39, $52, $3B, $52, $48, $47, $54, $33, $52, $00
;クイックフ゛ーメラン
	.db $25, $0D
	.db $27, $21, $4E, $27, $3B, $52, $54, $41, $46, $4D
;タイムストッハ゜ー　
	.db $25, $0D
	.db $2F, $21, $40, $2C, $33, $4E, $39, $53, $54, $00
;メタルフ゛レート゛　
	.db $25, $0D
	.db $41, $2F, $48, $3B, $52, $49, $54, $33, $52, $00
;クラッシュホ゛ム　　
	.db $25, $0D
	.db $27, $46, $4E, $2B, $50, $3D, $52, $40, $00, $00
;ヲ　ソウヒ゛シマス　
	.db $25, $4D
	.db $4B, $00, $2E, $22, $3A, $52, $2B, $3E, $2C, $00
;Ｄr.ライト　カラ　ノ
	.db $25, $2D
	.db $04, $1B, $46, $21, $33, $00, $25, $46, $00, $38
;メッセーシ゛　テ゛ス
	.db $25, $6D
	.db $41, $4E, $2D, $54, $2B, $52, $00, $32, $52, $2C
;カンセイシタ！　　　
	.db $25, $4D
	.db $25, $4D, $2D, $21, $2B, $2F, $1F, $00, $00, $00
;タタ゛チニ　ソウヒ゛
	.db $25, $8D
	.db $2F, $2F, $52, $30, $35, $00, $2E, $22, $3A, $52
;シタマエ！！　　　　
	.db $25, $CD
	.db $2B, $2F, $3E, $23, $1F, $1F, $00, $00, $00, $00
;アイテム　コ゛ウカ゛
	.db $25, $0D
	.db $20, $21, $32, $40, $00, $29, $52, $22, $25, $52
;アイテム１コ゛ウ　　
	.db $25, $0D
	.db $20, $21, $32, $40, $68, $29, $52, $22, $00, $00
;アイテム２コ゛ウ　　
	.db $25, $0D
	.db $20, $21, $32, $40, $69, $29, $52, $22, $00, $00
;アイテム３コ゛ウ　　
	.db $25, $0D
	.db $20, $21, $32, $40, $6A, $29, $52, $22, $00, $00

;BDCB
;武器取得ロックマンの色
Table_GetEqRockmanColor:
	.db $2C, $11
	.db $28, $15
	.db $20, $11
	.db $20, $19
	.db $20, $00
	.db $34, $25
	.db $34, $14
	.db $37, $18
	.db $20, $26
	.db $20, $16

;BDDF
;武器取得カーソルのY位置
Table_GetEqCursorY:
	.db $B0, $C0

;BDE1
;武器取得カーソルのスプライト情報
Table_GetEqCursorSprite
	.db $B0, $0F, $03, $40

;BDE5
;アイテム入手時の博士の色
Table_GetEqDrRightColor:
	.db $20, $10, $36

