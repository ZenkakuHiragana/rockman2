
;8015
;ステージセレクト画面開始
;___Bank0D_BeginStageSelect:
	lda #%00010000
	sta <z2000
	sta $2000
	lda #%00000110
	sta <z2001
	sta $2001
	jsr ResetScrollPosition1A
	jsr LoadNameTable843C
;ボス撃破状況に応じ黒塗りつぶし
	ldx #$00
	lda <zClearFlags
	sta <$01
.loop_black_boss
	stx <$00
	lsr <$01
	bcc .dontpaint
	lda Table_SelectBoss_BlackPtrhi,x
	sta <zPtrhi
	lda Table_SelectBoss_BlackPtrlo,x
	sta <zPtrlo
	ldx #$04
	lda #$00
.loop_black_line
	lda <zPtrhi
	sta $2006
	lda <zPtrlo
	sta $2006
	ldy #$04
	lda #$00
.loop_black_tile
	sta $2007
	dey
	bne .loop_black_tile
	clc
	lda <zPtrlo
	adc #$20
	sta <zPtrlo
	dex
	bne .loop_black_line
.dontpaint
	ldx <$00
	inx
	cpx #$08
	bne .loop_black_boss
	ldx #$1F
	jsr WritePaletteX_1A
	jsr ClearSprite1A
;8070
;スプライト情報セット
	ldx #$00
	lda <zClearFlags
	sta <$02
	ldy #$00
.loop_sprite_boss
	stx <$01
	lsr <$02
	bcs .dontsetup
	lda Table_SelectBoss_Sprite_Size,x
	sta <$00
	lda Table_SelectBoss_Sprite_StartPtr,x
	tax
.loop_sprite
	lda Table_SelectBoss_Sprite_Data,x
	sta aSprite,y
	iny
	inx
	dec <$00
	bne .loop_sprite
.dontsetup
	ldx <$01
	inx
	cpx #$08
	bne .loop_sprite_boss
;809A
;ステージセレクト画面ループ開始
	jsr EnableScreen1A
	mPLAYTRACK #$0C
	lda #$00
	sta <zStage
	sta <$FD
	jsr FrameAdvance1A
.loop_select
	lda <zKeyPress
	and #$08
	bne .decided
	lda <zKeyPress
	and #$F0
	beq .skip_select
	mPLAYTRACK #$2F
	jsr SelectBossFocus
.skip_select
	jsr SelectBoss_SetFocusSprite
	jsr FrameAdvance1A
	jmp .loop_select
;80C8
.decided
	ldx <zStage
	bne .8bosses
	lda <zClearFlags
	cmp #$FF
	bne .skip_select
	lda #$08
	sta <zStage
	jmp .end_selectboss
.8bosses
	ldy Table_ClearStages,x
	lda <zClearFlags
	and Table_ClearMask,y
	bne .skip_select
	sty <zStage
	mPLAYTRACK #$3A
	lda <zStage
	asl a
	sta <$00
	asl a
	adc <$00
	tax
	ldy #$00
.loop_intro_setup
	lda Table_SelectBoss_BossSprAddrhi,x
	sta aObjX,y
	lda Table_SelectBoss_BossSprAddrBank,x
	sta aObjRoom,y
	lda #$00
	sta aObjXlo,y
	inx
	iny
	cpy #$06
	bne .loop_intro_setup
	lda #$0A
	sta aObjY
	lda #$00
	sta aObjYlo
	sta aObjWait
	lda #$30
	sta <$FD
.loop_setup_pattern
	ldx #$3F
	lda <$FD
	and #$04
	bne .isnotwhite
	ldx #$1F
.isnotwhite
	jsr WritePaletteX_1A
	ldx aObjWait
	clc
	lda aObjXlo,x
	sta <$08
	adc #$20
	sta aObjXlo,x
	php
	lda aObjX,x
	sta <$09
	adc #$00
	sta aObjX,x
	plp
	bne .inc_0680
	inc aObjWait
.inc_0680
	lda aObjRoom,x
	jsr WritePPUData
	clc
	lda aObjYlo
	sta aPPULinearlo
	adc #$20
	sta aObjYlo
	lda aObjY
	sta aPPULinearhi
	adc #$00
	sta aObjY
	dec <$FD
	beq .end_setup_pattern
	jsr FrameAdvance1A
	jmp .loop_setup_pattern
;8170
.end_setup_pattern
	ldx #$1F
	jsr WritePaletteX_1A
	lda #$2C
	sta aPalette + 2
	lda #$11
	sta aPalette + 3
	ldy #$07
.loop_palette
	lda Table_SelectBoss_SprPalette,y
	sta aPaletteSpr,y
	dey
	bpl .loop_palette
	lda <zStage
	asl a
	asl a
	asl a
	tax
	ldy #$00
.loop_palette_boss
	lda Table_SelectBoss_SprPalette_Boss,x
	sta aPaletteSpr + 8,y
	inx
	iny
	cpy #$08
	bne .loop_palette_boss
	lda #$01
	sta <zRoom
	.ifndef ___DISABLE_INTRO_PIPI
		jsr SelectStage_LoadPipiGraphics ;ピピの画像を読み込む専用ルーチン
	.endif
	lda #$18
	sta <$FD
	mPLAYTRACK #$0A
;ボス紹介・ボス落下
.loop_wait_boss
	jsr ClearSprite1A
	jsr FrameAdvance1A
	dec <$FD
	bne .loop_wait_boss
	jsr SelectBoss_ResetObjX
	lda #$80
	sta aObjX
	lda #$20
	sta aObjY
	lda #$00
	sta aObjWait
	sta aObjFrame
.loop_fall_boss
	lda #$00
	sta aObjWait
	clc
	lda aObjY
	adc #$08
	sta aObjY
	cmp #$78
	beq .land_boss
	jsr ClearSprite1A
	jsr SelectBoss_AnimateBossIntro
	jsr SelectBoss_MoveIntroStar
	jsr FrameAdvance1A
	jmp .loop_fall_boss
;81EE
;ボス紹介・ボス着地→星フェードイン
.land_boss
	inc aObjFrame
	.ifndef ___DISABLE_INTRO_PIPI
	lda <zKeyDown
	and #$01
	sta aObjFlags
	.endif
	lda #$00
	sta <$FD
	lda #$08
	sta <$FE
.loop_intro_star_fade
	lda #$00
	sta aObjWait
	dec <$FE
	bne .wait_intro_star_fade
	lda #$08
	sta <$FE
	ldx <$FD
	lda Table_SelectBoss_Palette_IntroStar,x
	sta aPaletteSpr + 2
	lda Table_SelectBoss_Palette_IntroStar + 1,x
	sta aPaletteSpr + 3
	inx
	inx
	cpx #$10
	beq .end_intro_star_fade
	stx <$FD
.wait_intro_star_fade
	jsr ClearSprite1A
	jsr SelectBoss_AnimateBossIntro
	jsr SelectBoss_MoveIntroStar
	jsr FrameAdvance1A
	jmp .loop_intro_star_fade

;8232
;ボス紹介・アニメーション開始
.end_intro_star_fade
	lda #$50
	sta <$FD
.loop_wait_animate_boss
	jsr ClearSprite1A
	jsr SelectBoss_AnimateBossIntro
	jsr SelectBoss_MoveIntroStar
	jsr FrameAdvance1A
	dec <$FD
	bne .loop_wait_animate_boss
;ボス紹介・文字表示
	lda #$28
	sta <$FD
	lda #$26
	sta aPPULinearhi
	lda #$0A
	sta aPPULinearlo
	lda <zStage
	asl a
	sta <$FE
	asl a
	asl a
	adc <$FE
	sta <$FE
.loop_write_letter_boss
	lda <$FD
	and #$03
	bne .skip_write_letter_boss
	ldx <$FE
	lda Table_String_BossName,x
	sta aPPULinearData
	lda #$01
	sta <zPPULinear
	inc <$FE
	inc aPPULinearlo
.skip_write_letter_boss
	jsr ClearSprite1A
	jsr SelectBoss_AnimateBossIntro
	jsr SelectBoss_MoveIntroStar
	jsr FrameAdvance1A
	dec <$FD
	bne .loop_write_letter_boss
;8286
;ボス紹介・ウェイト
	lda #$BB
	sta <$FD
.loop_wait_bossintro_end
	jsr ClearSprite1A
	jsr SelectBoss_AnimateBossIntro
	jsr SelectBoss_MoveIntroStar
	jsr FrameAdvance1A
	dec <$FD
	bne .loop_wait_bossintro_end
;829A
.end_selectboss
	mJSR_NORTS DisableScreen1A
