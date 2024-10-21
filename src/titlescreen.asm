
;9EE7
;タイトル画面の処理
;___Bank0D_BeginTitleScreen:
	mMOV #$10, <z2000, $2000
	mMOV #$06, <z2001, $2001
	lda #$0F
	jsr Write_Reg0_A
	jsr ResetScrollPosition1A
	mSTZ <zRestartTitle
	lda #$02
	jsr LoadGraphicsSet
	mMOV #$20, $2006
	ldx #$00
	stx $2006
	txa
	ldy #$04
.loop_initscreen
	sta $2007
	inx
	bne .loop_initscreen
	dey
	bne .loop_initscreen
	lda #$0F
	ldx #$1F
.loop_initpalette
	sta aPalette,x
	dex
	bpl .loop_initpalette
	jsr ClearSprite1A
	jsr EnableScreen1A
	mMOV #$06, <zPPULinear
	mMOVWB #$21CD, aPPULinearhi
	ldx #$05
.loop_write_1988
	mMOV Table_Opening_1988,x, aPPULinearData,x ;1988 char table
	dex
	bpl .loop_write_1988
	mPLAYTRACK #$FE
	mPLAYTRACK #$FF
	mMOV #$01, <$FD
.loop_capcom
	mMOV #$12, <$FE
.loop_1988_2
	mMOV #$08, <$FF
.loop_1988
	ldx <$FE
	mMOV Table_1988_Fadein,x, aPalette + 1 ;1988 fade-in palette table
	jsr FrameAdvance1A
	lda <zKeyPress
	and #$08
	beq .continue_opening
	jmp Opening_Skipped ;begin title screen
.continue_opening
	dec <$FF
	bne .loop_1988
	dec <$FE
	bpl .loop_1988_2
	ldx #$05
.loop_write_capcom
	mMOV Table_Opening_CAPCOM,x, aPPULinearData,x ;CAPCOM char table
	dex
	bpl .loop_write_capcom
	mMOV #$06, <zPPULinear
	dec <$FD
	bpl .loop_capcom
	mSTZ <zPPULinear
	jsr DisableScreen1A
	mSTZ <zScreenMod
	mMOV #$07, <zStage
;タイトル画面ネームテーブル読み込み
	lda #$F2
	jsr WriteMapAddressOffScreen1A
	lda #$F3
	jsr WriteMapAddressOffScreen1A
	jsr ResetScrollPosition1A

	ldx #$1F
	lda #$0F
.loop_palette_reset
	sta aPalette,x
	dex
	bpl .loop_palette_reset
	jsr ClearSprite1A
	jsr EnableScreen1A
	ldx #$0F
	lda #$00
Bank0D_Opening_InitObj:
	sta aObjRoom,x
	sta aObjAnim,x
	;********************************************************
;	mBEGINRAW $1B, $A000
	;********************************************************
Bank0E_Start:
	dex
	bpl Bank0D_Opening_InitObj
	lda #$80
	sta aObjYlo
	lda #$00
	sta aObjY
	lda #$28
	sta aObjY + 1
	lda #$00
	sta aObjYlo + 1
	.ifndef ___OPTIMIZE
	lda #$00
	.endif
	sta aObjY + 2
	lda #$47
	sta aObjY + 3
	lda #$02
	sta aObjAnim + 2
	sta aObjAnim + 3
	lda #$27
	sta aObjY + 5
	lda #$6F
	sta aObjY + 6
	lda #$01
	sta aObjAnim + 5
	sta aObjAnim + 6
	lda #$80
	sta aObjVYlo
	lda #$00
	sta aObjVY
	lda #$00
	sta <zScreenMod
	lda #$00
	sta <zVScroll
	lda #$00
	sta <$FD
	lda #$08
	sta <$FE
.loop_fadein
	dec <$FE
	bne .wait_fadein
	lda #$08
	sta <$FE
	ldx <$FD
	ldy #$00
.loop_palette_fadein
	lda Table_Opening_PaletteFadein,x ;opening screen fade-in table
	sta aPalette,y
	inx
	iny
	cpy #$20
	bne .loop_palette_fadein
	cpx #$60
	beq .end_fadein
	stx <$FD
.wait_fadein
	jsr Opening_DrawBuildingSprites
	jsr FrameAdvance1A
	lda <zKeyPress
	and #$08
	beq .loop_fadein
	jmp Opening_Skipped
.end_fadein
	mPLAYTRACK #$0E
	lda #$00
	sta <$FD
.loop_opening_quotes
	jsr WriteOpeningQuotes
	lda #$23
	sta aPPULinearhi
	lda #$06
	sta aPPULinearlo
	jsr FrameAdvance1A
	lda <zKeyPress
	and #$08
	beq .continue_opening2
	jmp Opening_Skipped
.continue_opening2
	jsr WriteOpeningQuotes
	lda #$23
	sta aPPULinearhi
	lda #$46
	sta aPPULinearlo
	lda #$26
	sta <$FE
	lda #$0A
	sta <$FF
.loop_appear_quotes
	dec <$FF
	bne .wait_appear_quotes
	lda #$0A
	sta <$FF
	ldx <$FE
	lda Table_Opening_QuotesColor,x ;quotes fade-in table
	sta aPalette + 5
	dec <$FE
	bmi .end_appear_quotes
.wait_appear_quotes
	jsr FrameAdvance1A
	lda <zKeyPress
	and #$08
	beq .loop_appear_quotes
	jmp Opening_Skipped
.end_appear_quotes
	lda <$FD
	cmp #$A8
	bne .loop_opening_quotes
;A0DF
;上昇開始
	mMOV #$02, <zScreenMod
	mMOV #$F0, <zVScroll
.loop_goup
	sec
	lda <zVScrolllo
	sbc #$80
	sta <zVScrolllo
	lda <zVScroll
	sbc #$00
	sta <zVScroll
	bcc .continue_goup
	cmp #$40
	bcs .wait_goup
	jsr Opening_WriteTitleScreenByScroll
.wait_goup
	jsr Opening_MoveBuildingSprites
	jsr Opening_DrawBuildingSprites
	jsr FrameAdvance1A
	lda <zKeyPress
	and #$08
	beq .loop_goup
	jmp Opening_Skipped
.continue_goup
	lda #$F0
	sta <zVScroll
	lda #$00
	sta <zVScrolllo
	sta <zScreenMod
.loop_goup2
	sec
	lda <zVScrolllo
	sbc #$80
	sta <zVScrolllo
	lda <zVScroll
	sbc #$00
	sta <zVScroll
	cmp #$B0
	beq .begin_writetitle
	jsr Opening_MoveBuildingSprites
	jsr Opening_DrawBuildingSprites
	jsr FrameAdvance1A
	lda <zKeyPress
	and #$08
	beq .loop_goup2
	jmp Opening_Skipped
.begin_writetitle
	ldx #$0F
.loop_palette_title
	lda Table_Opening_PaletteBuilding,x
	sta aPalette,x
	dex
	bpl .loop_palette_title
	lda #$00
	sta aObjAnim10
	lda #$08
	sta aObjWait10
	lda #$FF
	sta aObjRoom10
	lda #$B7
	sta aObjY10
.loop_goup3
	sec
	lda <zVScroll
	sbc #$02
	sta <zVScroll
	jsr Opening_MoveBuildingSprites
	lda <zVScroll
	beq .begin_title
	jsr Opening_DrawBuildingSprites
	jsr Opening_DoRockmanAnimationHair
	jsr Opening_DrawRockman
	jsr FrameAdvance1A
	lda <zKeyPress
	and #$08
	beq .loop_goup3
	jmp Opening_Skipped
.begin_title
	lda #$50
	sta <$FD
	lda #$00
	sta aPPULinearlo
	sta <$FE
	lda #$10
	sta aPPULinearhi
	lda #$B0
	sta <$FF
.loop_write_titlelogo
	jsr Opening_DoRockmanAnimationHair
	jsr Opening_DrawBuildingSprites
	jsr Opening_DrawRockman
	jsr WriteTableToPPULinear
	jsr FrameAdvance1A
	clc
	lda aPPULinearlo
	adc #$20
	sta aPPULinearlo
	lda aPPULinearhi
	adc #$00
	sta aPPULinearhi
	clc
	lda <$FE
	adc #$20
	sta <$FE
	lda <$FF
	adc #$00
	sta <$FF
	dec <$FD
	bne .loop_write_titlelogo
	lda #$24
	sta <$FD
.loop_wait_titlelogo
	jsr FrameAdvance1A
	dec <$FD
	bne .loop_wait_titlelogo
	ldx #$0F
.loop_write_palette_title
	lda Table_Title_Palette,x ;title palette table
	sta aPalette,x
	dex
	bpl .loop_write_palette_title
;A1D9
BeginTitleScreenSkipped:
	jsr Titlelogo_ShowSprites
	mPLAYTRACK #$0D
	lda #$0B
	sta <zTitleScreenWaithi
	lda #$00
	sta <zTitleScreenWaitlo
.loop_wait_titlescreen
	lda <zKeyPress
	and #$08
	bne .begingame
	jsr Opening_DrawBuildingSprites
	jsr Opening_DoRockmanAnimationHair
	jsr Opening_DrawRockman
	jsr Titlelogo_ShowSprites
	jsr FrameAdvance1A
	sec
	mSUB <zTitleScreenWaitlo, #$01
	mSUB <zTitleScreenWaithi
	bcs .loop_wait_titlescreen
	inc <zRestartTitle
.begingame
	mPLAYTRACK #$FF
	lda #$19
	sta <$FD
.loop_animate_rockman
	lda <zFrameCounter
	and #$01
	bne .wait_animate_rockman
	lda <$FD
	cmp #$04
	bne .playsound
	mPLAYTRACK #$3A
.playsound
	dec <$FD
	bmi .beginwarp
.wait_animate_rockman
	ldx <$FD
	lda Table_Title_RockmanAnimation,x
	sta aObjAnim10
	jsr Opening_DrawBuildingSprites
	jsr Opening_DrawRockman
	jsr Titlelogo_ShowSprites
	jsr FrameAdvance1A
	jmp .loop_animate_rockman
;A244
;メットを被った後、ロックマンワープ
.beginwarp
	lda #$0A
	sta aObjAnim10
	sec
	lda aObjY10
	sbc #$08
	sta aObjY10
	lda aObjRoom10
	sbc #$00
	sta aObjRoom10
	beq .continue_warp
	lda aObjY10
	cmp #$F0
	bcc .wait_reset
.continue_warp
	jsr Opening_DrawBuildingSprites
	jsr Opening_DrawRockman
	jsr Titlelogo_ShowSprites
	jsr FrameAdvance1A
	jmp .beginwarp
;A272
;フェードアウトまでの間
.wait_reset
	jsr Opening_DrawBuildingSprites
	jsr Titlelogo_ShowSprites
	lda #$3E
	sta <$FD
.loop_wait_reset
	jsr FrameAdvance1A
	dec <$FD
	bne .loop_wait_reset
	jsr DisableScreen1A
	
;A286
;ゲームメニューへ
	lda #$00
	sta <zScreenMod
	lda #$0E
	jsr Write_Reg0_A
	lda <zRestartTitle
	beq .notreset
	rts
;A294
;ゲームメニュー
.notreset
	lda #$03
	jsr LoadGraphicsSet
	lda #$05
	sta <zStage
	lda #$F4
	jsr WriteMapAddressOffScreen1A
	lda #$F5
	jsr WriteMapAddressOffScreen1A
	ldx #$00
;START, PASS WORDの文字を書く
.loop_write_word
	lda Table_Keywords,x
	sta $2006
	lda Table_Keywords + 1,x
	sta $2006
	inx
	inx
	ldy Table_Keywords,x
	inx
.loop_write_letter
	lda Table_Keywords,x
	sta $2007
	inx
	dey
	bne .loop_write_letter
	cpx #$19
	bne .loop_write_word
	mPLAYTRACK #$10
	lda #$01
	jsr Password_SetScreenPalette
.begin_gamemenu
	lda #$00
	sta <$FD
	sta <zClearFlags
	sta <zItemFlags
;どっちか選ぶまでループ
.loop_wait_selectstage
	ldx #$03
.loop_sprite_cursor
	lda Table_Password_CursorSprite,x
	sta aSprite,x
	dex
	bpl .loop_sprite_cursor

	lda <zFrameCounter
	and #$08
	bne .skip_sety_cursor
	ldx #$60 ;$FD = 0, Y = #$60 | $FD = 1, Y = #$70
	lda <$FD
	beq .sety_cursor
	ldx #$70
.sety_cursor
	stx aSprite
.skip_sety_cursor
	lda <zKeyPress
	and #$3C
	beq .wait_selectstage
	and #$08
	bne .start_selectstage
	mPLAYTRACK #$2F
	lda <$FD
	eor #$01
	sta <$FD
.wait_selectstage
	jsr FrameAdvance1A
	jmp .loop_wait_selectstage
;選択した($FD = 0ならステージセレクトへ)
.start_selectstage
	lda <$FD
	bne .enterpassword
	jmp .start_stage_select
;A325
;パスワード入力画面開始
.enterpassword
	jsr FadeoutPalette_BG2_Spr
	jsr ClearSprite1A
	jsr Password_ScrollRight
	ldx #$2F
;パスワード入力画面の、12345, ABCDE, ●と数字の部分
.curwait = $FE ;カーソル連続移動のカウンタ
.curptr = $6A0 ;カーソル位置(x, y) = ($6A0 mod 5, $6A0 / 5)
.numstones = $680 ;赤玉残り数
.stoneplacement = $420 ;マス目ごとに赤玉が置かれているフラグ
.loop_spr_password_ui
	lda Table_Password_UISprites,x
	sta aSprite,x
	dex
	bpl .loop_spr_password_ui
	lda #$00
	ldx #$18
.loop_init_password_placement
	sta .stoneplacement,x
	dex
	bpl .loop_init_password_placement
	jsr Password_InitStones
	jsr FadeinPaletteA896
	lda #$00
	sta .curptr
	lda #$09
	sta .numstones
	lda #$00
	sta <.curwait
;パスワード入力画面のループ
.loop_enter_password
	lda <zKeyPress
	and #$F0
	bne .movecursor
	lda <zKeyDown
	and #$F0
	beq .wait_password
	lda <zKeyDownPrev
	cmp <zKeyDown
	bne .wait_password
	inc <.curwait
	lda <.curwait
	cmp #$18
	bcc .cursor_moved
	lda #$08
	sta <.curwait
;カーソル移動
.movecursor
	mPLAYTRACK #$2F
	ldx .curptr
	lda <zKeyDown
	and #$C0
	beq .move_horizontal
	and #$80
	beq .moveleft
;moveright
	lda Table_PasswordCursorMoveTo_Right,x
	jmp .movecursor_merge
.moveleft
	lda Table_PasswordCursorMoveTo_Left,x
	jmp .movecursor_merge
.move_horizontal
	lda <zKeyDown
	and #$10
	beq .movedown
;moveup
	lda Table_PasswordCursorMoveTo_Up,x
	jmp .movecursor_merge
.movedown
	lda Table_PasswordCursorMoveTo_Down,x
;A3A2
.movecursor_merge
	sta .curptr
	jmp .cursor_moved
.wait_password
	lda #$00
	sta <.curwait
.cursor_moved
	lda <zKeyPress
	and #$03
	beq .done_password
	lda <zKeyPress
	ldx .curptr
	and #$01
	beq .delstone
;赤玉を置く
	lda .stoneplacement,x
	bne .done_password
	mPLAYTRACK #$42
	inc .stoneplacement,x
	dec .numstones
	beq .end_placement
	bne .done_password
;赤玉を取る
.delstone
	lda .stoneplacement,x
	beq .done_password
	dec .stoneplacement,x
	inc .numstones
;処理合流
.done_password
	jsr Password_DrawCursorStones
	jsr FrameAdvance1A
	jmp .loop_enter_password

;A3E3
;パスワード入力終了
.end_placement
.numetanks = $04
	jsr Password_DrawCursorStones
	lda #$0F
	sta aPaletteSpr + 6
	ldx #$00
.loop_countetanks
	lda .stoneplacement,x
	bne .stone_placed_row_a
	inx
	cpx #$04
	bne .loop_countetanks
.stone_placed_row_a
	stx <.numetanks
	txa
	clc
	adc #$05
	tax
	lda #$00
	sta <$01
	sta <$02
	sta <$03
.loop_process_stones      ;Y = #$00～#$13
	lda .stoneplacement,x ;X = NumETanks + 5 → (#$05～#$09)～#$18
	beq .not_placed
	ldy <$01
	lda Table_Password_Process1,y
	pha
	lda Table_Password_Process2,y
	tay
	pla
	ora $02,y ;Y = 0, 1
	sta $02,y ;A = 0, 1, 2, 4, 8, 10, 20, 40, 80
.not_placed
	inx
	cpx #$19
	bne .isrightdown
	ldx #$05 ;始点がB1～B5で変化するので、E5に行ったらB1に向かう
.isrightdown
	inc <$01
	lda <$01
	cmp #$14
	bne .loop_process_stones
	lda <$02
	ora <$03
	cmp #$FF
	bne .invalid_password
	jmp .valid_password
.invalid_password
	ldx #$02
	jsr WriteKeyword1A
	lda #$7D
	sta <$FD
.loop_wait_invalid_password_before
	jsr FrameAdvance1A
	dec <$FD
	bne .loop_wait_invalid_password_before
	ldx #$03
	jsr WriteKeyword1A
	jsr FadeoutPalette_BG2_Spr
	jsr ClearSprite1A
	jsr Password_ScrollLeft
	jsr FadeinPaletteA896
	lda #$7D
	sta <$FD
.loop_wait_invalid_password_after
	jsr FrameAdvance1A
	dec <$FD
	bne .loop_wait_invalid_password_after
	jsr FadeoutPalette_BG2_Spr
	ldx #$00
	jsr WriteKeyword1A
	jsr FrameAdvance1A
	ldx #$01
	jsr WriteKeyword1A
	jsr FrameAdvance1A
	jsr FadeinPaletteA896
	jmp .begin_gamemenu

.valid_password
	lda <$02
	sta <zClearFlags
	and #$03
	sta <zItemFlags
	lda <zClearFlags
	and #$20
	lsr a
	lsr a
	lsr a
	ora <zItemFlags
	sta <zItemFlags
	lda <.numetanks
	sta <zETanks
	jsr FrameAdvance1A
	lda #$E5
	jsr WriteMapAddressOnScreen1A
	lda #$3C
	sta <$FD
.loop_wait_valid_password
	jsr FrameAdvance1A
	dec <$FD
	bne .loop_wait_valid_password
	jsr FadeoutPalette_BG2_Spr
	jsr ClearSprite1A
	jsr Password_ScrollRight
	lda <zClearFlags
	sta <$01
	lda <zItemFlags
	sta <$02
	ldx #$00
	beq .display_cleared_stage
.loop_display_stage
	lsr <$02
	ror <$01
	bcs .display_cleared_stage
	inx
	inx
	inx
	inx
	bne .skip_display
.display_cleared_stage
	ldy #$04
.loop_display_stage_sprite
	lda Table_Password_ResultSprite,x
	sta aSprite,x
	inx
	dey
	bne .loop_display_stage_sprite
.skip_display
	cpx #$30
	bne .loop_display_stage
	jsr FadeinPaletteA896
	lda #$7D
	sta <$FD
.loop_wait_valid_password_2
	jsr FrameAdvance1A
	dec <$FD
	bne .loop_wait_valid_password_2
.start_stage_select
	mJSR_NORTS DisableScreen1A


