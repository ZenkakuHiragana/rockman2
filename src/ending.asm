
;B60A
;エンディングの処理
;___Bank0D_BeginEnding:
	jsr ResetScrollPosition1A
	inc <zRoom
	lda #$04
	jsr LoadGraphicsSet
	mMOV #$05, <zStage
	mMOVW $8EC0, <zPtr
	jsr WriteMapAddressOffScreen1A
	mMOVW $8F00, <zPtr
	jsr WriteMapAddressOffScreen1A
	lda #$00
	sta aObjFrame
	sta aObjWait
	sta aObjWait + 1
	sta aObjAnim
	sta aObjAnim + 1
	sta aObjY + 1
	lda #$0F
	ldx #$1F
.loop_init_palette
	sta aPalette,x
	dex
	bpl .loop_init_palette
	mPLAYTRACK #$FF
	jsr ClearSprite1A
	jsr EnableScreen1A
	mMOV #$BB, <$FD
.wait_init
	jsr FrameAdvance1A
	dec <$FD
	bne .wait_init
	mPLAYTRACK #$13
	mMOV #$04, <$FD
	mMOV #$3F, <$FE
.loop_fadein
	dec <$FE
	bne .waitfadein
	mMOV #$3F, <$FE
	ldx #$1B
	ldy #$3B
	lda #$0F
	jsr FadeinPaletteSpecified
	dec <$FD
	beq .loop_walk
.waitfadein
	jsr Ending_ShowRockman1A
	jsr FrameAdvance1A
	jmp .loop_fadein
.loop_walk
	ldx aObjFrame
	mMOV Table_EndingWaitslo,x, <$FD
	mMOV Table_EndingWaitshi,x, <$FE
	mMOV #$3F, <$FF
.loop_changecolor
	lda <$FF
	beq .skip
	dec <$FF
.skip
	lda aObjFrame
	cmp #$05
	bne .1
	lda <$FF
	and #$01
	sta <zRoom
	jmp .2
.1
	jsr Ending_SetRockmanPalette
	jsr Ending_SetPalette
.2
	lda aObjFrame
	bne .3
	lda <zFrameCounter
	and #$07
	bne .3
	ldx #$1F
	ldy #$3F
	lda #$FF
	jsr FadeinPaletteSpecified
.3
	jsr Ending_ShowRockman1A
	jsr FrameAdvance1A
	sec
	lda <$FD
	sbc #$01
	sta <$FD
	lda <$FE
	sbc #$00
	sta <$FE
	bcs .loop_changecolor
	inc aObjFrame
	lda aObjFrame
	cmp #$06
	bne .loop_walk
;スタッフロール開始
	jsr DisableScreen1A
	jsr LoadNameTable843C
	lda #$05
	jsr LoadGraphicsSet
	mMOV #$20, $2006
	mSTZ $2006
	ldy #$04
.loop_screen2
	ldx #$00
.loop_screen1
	sta $2007
	inx
	bne .loop_screen1
	dey
	bne .loop_screen2
	sta aObjFlags
	ldx #$1F
	jsr WritePaletteX_1A
	inc <zRoom
	jsr ClearSprite1A
	mMOV #$30, aPaletteSpr + 3
	mPLAYTRACK #$0D
	jsr EnableScreen1A
	jsr SelectBoss_ResetObjX
	mMOVWB $25AC, aPPULinearhi
	mMOV #$A2, <$FD
	lda #$00
	sta <$FE
	sta aObjFrame
.loop_staff_bossname
	lda <$FD
	and #$03
	bne .wait_letter_boss
	ldx <$FE
	cpx #$05
	beq .wait_letter_boss
	mMOV Table_EndingString_STAFF,x, aPPULinearData
	inc <zPPULinear
	inc <$FE
	inc aPPULinearlo
.wait_letter_boss
	jsr SelectBoss_MoveIntroStar
	jsr FrameAdvance1A
	dec <$FD
	bne .loop_staff_bossname
	mMOV #$A0, aPPULinearlo
	lda #$20
	jsr Ending_PPUDrawLine
.loop_staffroll2
	mMOV #$49, <$FD
	mMOV #$01, <$FE
	mSTZ aObjWait
	mMOVWB $2583, aPPULinearhi
.loop_staffroll
	jsr DrawStaffRollBossName
	jsr SelectBoss_MoveIntroStar
	jsr FrameAdvance1A
	sec
	lda <$FD
	sbc #$01
	sta <$FD
	lda <$FE
	sbc #$00
	sta <$FE
	bne .loop_staffroll
	lda <$FD
	beq .continue_staff
	cmp #$D0
	bne .loop_staffroll
	lda aObjFrame
	cmp #$0E
	bcc .loop_staffroll
	mPLAYTRACK #$14
	jmp .loop_staffroll
;B7B4
.continue_staff
	mMOVWB $2580, aPPULinearhi
	lda #$20
	jsr Ending_PPUDrawLine
	mMOVWB $25C0, aPPULinearhi
	lda #$20
	jsr Ending_PPUDrawLine
	inc aObjFrame
	lda aObjFrame
	cmp #$10
	bne .loop_staffroll2
	lda #$0F
	sta aPalette + 2
	sta aPalette + 3
	lda #$00
	sta aObjFrame
	sta <zRoom
	jsr DrawStaffRollText
.loop_staffroll3
	jsr Unknown_D64A
	jsr SelectBoss_MoveIntroStar
	jsr FrameAdvance1A
	lda aObjFrame
	cmp #$3C
	bne .loop_staffroll3
	lda <zVScroll
	bne .loop_staffroll3
.loop_reset
	jsr SelectBoss_MoveIntroStar
	jsr FrameAdvance1A
	lda <zKeyPress
	and #$08
	beq .loop_reset
	mJSR_NORTS DisableScreen1A

;B812
;エンディングの歩くロックマンと落ちるあれを表示する
Ending_ShowRockman1A:
	jsr ClearSprite1A
	lda aObjFrame
	cmp #$05
	bne .isnotmet
;showhelmet
	ldy #$04
	ldx #$30
	lda <$FF
	and #$01
	bne .helmetpalette
		ldy #$05
		ldx #$0F
.helmetpalette
	stx aPaletteSpr + 1
	txa
	and #$0F
	sta aPaletteSpr + 9
	mJSR_NORTS ChangeBank_ShowEndingRockmanY

.isnotmet
	lda #$00
	sta aObjX
	sta aObjY
	sta aObjRoom
	sta <$00
	inc aObjWait
	lda aObjWait
	cmp #$10
	bne .wait
		mSTZ aObjWait
		inc aObjAnim
		lda aObjAnim
		cmp #$04
		bne .wait
			mSTZ aObjAnim
.wait
	lda aObjFrame
	cmp #$04
	bcc .walking
	ldy aObjAnim
	lda <$FF
	and #$01
	bne .lookup
		ldy #$04
.lookup
	mJSR_NORTS ChangeBank_ShowEndingRockmanY
.walking
	jsr ChangeBank_ShowEndingRockman
;ここから落ちるあれ
	ldx aObjFrame
	clc
	lda aObjYlo + 1
	adc Table_EndingFallingVYlo,x
	sta aObjYlo + 1
	lda aObjY + 1
	adc Table_EndingFallingVYhi,x
	sta aObjY + 1
	lda <zFrameCounter
	and #$07
	bne .skip
		inc aObjWait + 1
		lda aObjWait + 1
		cmp #$04
		bne .skip
			mSTZ aObjWait + 1
.skip
	lda aObjFrame
	asl a
	asl a
	adc aObjWait + 1
	tax
	mMOV Table_EndingFallingAnimation,x, <$02
	lda <$FF
	beq .blink
		ldx aObjFrame
		beq .blink
			dex
			lda <$FF
			beq .blink
				lsr a
				lsr a
				lsr a
				lsr a
				sta <$02
				txa
				asl a
				asl a
				adc <$02
				tax
				mMOV Table_EndingFallingAnimation2,x, <$02
.blink
	ldy <$00
	ldx #$15
.loop
	clc
	lda Table_EndingFallingY,x
	adc aObjY + 1
	sta aSprite,y
	iny
	mMOV <$02, aSprite,y
	iny
	mMOV #$03, aSprite,y
	iny
	mMOV Table_EndingFallingX,x, aSprite,y
	iny
	dex
	bpl .loop
	rts

;B8F9
;エンディングの歩くロックマンの色を指定
Ending_SetRockmanPalette:
	ldx aObjFrame
	lda <$FF
	and #$01
	bne .forward
		inx
.forward
	txa
	asl a
	tax
	ldy #$00
.loop
	lda Table_EndingRockmanPalette,x
	sta aPaletteSpr + $02,y
	sta aPaletteSpr + $0A,y
	inx
	iny
	cpy #$02
	bne .loop
	rts

;B918
;エンディングの景色の色を指定
Ending_SetPalette:
	ldx aObjFrame
	beq .rts
	lda <$FF
	and #$01
	beq .trans
		dex
.trans
	txa
	asl a
	asl a
	sta <$00
	clc
	asl a
	adc <$00
	tax
	ldy #$00
.loop
	mMOV Table_EndingViewPalette,x, aPalette,y
	inx
	iny
	cpy #$0C
	bne .loop
.rts
	rts

;B93D
;Aを#$20バイト連続させたデータをPPUへ転送
Ending_PPUDrawLine:
	ldx #$20
	stx <zPPULinear
	dex
.loop
	sta aPPULinearData,x
	dex
	bpl .loop
	mJSR_NORTS FrameAdvance1A

;B94C
;エンディングの背景のパレット
Table_EndingViewPalette:
	.db $0F, $26, $26, $27, $0F, $17, $28, $05, $0F, $17, $27, $18
	.db $0F, $11, $11, $20, $0F, $10, $28, $20, $0F, $10, $20, $18
	.db $0F, $21, $21, $35, $0F, $25, $37, $16, $0F, $25, $35, $17
	.db $0F, $10, $10, $00, $0F, $00, $18, $05, $0F, $00, $10, $00
	.db $0F, $30, $21, $1C, $0F, $19, $37, $16, $0F, $19, $2A, $18

;B988
;エンディングの歩くロックマンのパレット
Table_EndingRockmanPalette:
	.db $2C, $11
	.db $28, $15
	.db $30, $00
	.db $34, $24
	.db $30, $11
	.db $2C, $11

;B994
;エンディングの景色が切り替わるまでの時間
wait1 = $32C
wait2 = $232
wait3 = $290
Table_EndingWaitslo:
	.db LOW(wait1), LOW(wait2), LOW(wait2), LOW(wait2), LOW(wait2), LOW(wait3)
;B99A
Table_EndingWaitshi:
	.db HIGH(wait1), HIGH(wait2), HIGH(wait2), HIGH(wait2), HIGH(wait2), HIGH(wait3)

;B9A0
;降ってくるもののY座標
Table_EndingFallingY:
	.db $00, $08, $10, $20, $28, $30, $40, $48, $50, $58, $68, $78, $80, $88, $90, $A8
	.db $B8, $C0, $D0, $D8, $E0, $E8

;B9B6
;降ってくるもののX座標
Table_EndingFallingX:
	.db $D8, $70, $18, $B0, $88, $40, $A0, $F8, $20, $58, $C8, $08, $88, $38, $B0, $D8
	.db $70, $28, $B8, $08, $98, $48

;B9CC
;降ってくるもののアニメーション定義
Table_EndingFallingAnimation:
	.db $0C, $0D, $0E, $0D
	.db $1B, $1C, $1B, $1C
	.db $2C, $2D, $2E, $2D
	.db $3B, $3B, $3B, $3B

;B9DC
;降ってくるものの移り変わる方のアニメーション定義
Table_EndingFallingAnimation2:
	.db $1B, $1A, $19, $0F
	.db $2C, $1F, $1E, $1D
	.db $3C, $3A, $39, $2F
	.db $3D, $3D, $3D, $3C

;B9EC
;降ってくるもののY速度下位
endingfallvy1 = $0080
endingfallvy2 = $0080
endingfallvy3 = $00E5
endingfallvy4 = $0800
Table_EndingFallingVYlo:
	.db $80, $80, $E5, $00
;B9F0
;降ってくるもののY速度上位
Table_EndingFallingVYhi:
	.db 0, 0, 0, 8

;B9F4
;STAFFの文字列
Table_EndingString_STAFF:
	.db $13, $14, $01, $06, $06

