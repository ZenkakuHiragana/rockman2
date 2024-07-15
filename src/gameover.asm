
;B01A
;ゲームオーバー画面処理開始
;___Bank0D_BeginGameOver:
	lda #$03
	jsr LoadGraphicsSet
	lda <zStage
	pha
	mMOV #$05, <zStage
	lda #$F2
	jsr WriteMapAddressOffScreen1A
	lda #$F3
	jsr WriteMapAddressOffScreen1A
	mMOV #$21, $2006
	mMOV #$CC, $2006
	ldx #$00
.loop_word_gameover
	mMOV Table_GameOverChar,x, $2007
	inx
	cpx #$09
	bne .loop_word_gameover
	mPLAYTRACK #$0F
	jsr ResetScrollPosition1A
	lda #$00
	jsr Password_SetScreenPalette
	mMOV #$04, <$FE
	mMOV #$7D, <$FD
.loop_word
	ldx <$FE
	cpx #$07
	beq .skip
	jsr WriteKeyword1A
	inc <$FE
.skip
	jsr FrameAdvance1A
	dec <$FD
	bne .loop_word
	jsr FadeoutPalette_BG2_Spr
	jsr Password_ScrollRight
	lda #$F0
	jsr WriteMapAddressOnScreen1A
	mPLAYTRACK #$10
.start_3
	jsr FadeinPaletteA896
	mSTZ <$FD
;ゲームオーバーの後の選択肢3つのループ
.loop_3
	lda <zKeyPress
	and #$3C
	beq .wait_3
	and #$08
	bne .decided
	mPLAYTRACK #$2F
	lda <zKeyPress
	and #$24
	bne .godown
;goup
	dec <$FD
	bpl .wait_3
	mMOV #$02, <$FD
	bne .wait_3
.godown
	inc <$FD
	lda <$FD
	cmp #$03
	bne .wait_3
	mSTZ <$FD
.wait_3
	ldx #$03
.loop_cur_spr
	mMOV Table_GameOverCurSprite,x, aSprite,x
	dex
	bpl .loop_cur_spr
	lda <zFrameCounter
	and #$08
	bne .hide
	ldx <$FD
	mMOV Table_GameOverCursorY,x, aSprite
.hide
	jsr FrameAdvance1A
	jmp .loop_3
;決定時
.decided
	lda <$FD
	cmp #$02
	beq .showpassword
	jmp .gotostage
.showpassword
	jsr ShowPassword
	jmp .start_3
.gotostage
	jsr DisableScreen1A
	pla
	sta <zStage
	mMOV #$03, <zLives
	rts

;B0F9
;GAME OVERの文字列
Table_GameOverChar:
	.db $47, $41, $4D, $45, $40, $4F, $56, $45, $52

;B102
;GAME OVERのカーソルスプライトデータ
Table_GameOverCurSprite:
	.db $F8, $22, $00, $48

;B106
;GAME OVER後のカーソルY位置3つ
Table_GameOverCursorY:
	.db $60, $70, $80

;B109
;ゲームオーバーの後、パスワード表示時のカーソル
Table_ShowPasswordCursor:
	.db $98, $22, $00, $28
;B10D
;ゲームオーバーの後、パスワード表示時の右の武器欄のスプライト
Table_ShowPasswordWeaponSprites:
	.db $68, $2F, $00, $C8, $88, $1F, $00, $C8, $78, $1B, $00, $C8, $88, $19, $00, $D8
	.db $68, $1D, $00, $D8, $78, $1C, $00, $D8, $98, $1A, $00, $D8, $98, $1E, $00, $C8
	.db $A8, $20, $00, $C8, $A8, $25, $00, $D8, $B8, $26, $00, $C8, $B8, $27, $00, $D8

;B13D
;ゲームオーバーの後、パスワード表示
ShowPassword:
.stones = $420
	jsr FadeoutPalette_BG2_Spr
	jsr ClearSprite1A
	jsr Password_ScrollRight
	lda #$00
	ldx #$18
.loop_initstones
	sta .stones,x
	dex
	bpl .loop_initstones
	mMOV <zClearFlags, <$00
	eor #$FF
	sta <$01
	clc
	lda <zETanks
	tax
	adc #$05
	sta <$03
	inc .stones,x
	ldx #$00
.loop_place_stones
	ldy Table_Password_Process2,x
	lda $00,y
	ldy <$03
	and Table_Password_Process1,x
	beq .notcleared
	lda #$01
.notcleared
	sta .stones,y
	iny
	cpy #$19
	bne .isrightdown
	ldy #$05
.isrightdown
	sty <$03
	inx
	cpx #$14
	bne .loop_place_stones
	jsr Password_InitStones
	jsr Password_DrawCursorStones
	lda #$F8
	sta aSprite + $30
	sta aSprite + $34
	sta aSprite + $38
	sta aSprite + $3C
	ldx #$27
.loop_init_ui
	mMOV Table_Password_UISprites,x, aSprite,x
	dex
	bpl .loop_init_ui
	ldx #$03
.loop_curspr
	mMOV Table_ShowPasswordCursor,x, aSprite + $28,x
	dex
	bpl .loop_curspr
	lda <zClearFlags
	asl a
	ora #$01
	sta <$00
	lda <zItemFlags
	rol a
	sta <$01
	ldx #$00
	mMOV #$0C, <$02
.loop_stages
	lsr <$01
	ror <$00
	bcc .skip
	ldy #$04
.loop_spr
	mMOV Table_ShowPasswordWeaponSprites,x, aSprite + $A4,x
	inx
	dey
	bne .loop_spr
	beq .done
.skip
	inx
	inx
	inx
	inx
.done
	dec <$02
	bne .loop_stages
	ldx #$07
	jsr WriteKeyword1A
	jsr FadeinPaletteA896
.loop_wait_a
	ldx #$F8
	lda <zFrameCounter
	and #$08
	bne .hide
	ldx #$98
.hide
	stx aSprite + $28
	jsr FrameAdvance1A
	lda <zKeyPress
	and #$01
	beq .loop_wait_a
	mPLAYTRACK #$42
	jsr FadeoutPalette_BG2_Spr
	jsr ClearSprite1A
	mJSR_NORTS Password_ScrollLeft
